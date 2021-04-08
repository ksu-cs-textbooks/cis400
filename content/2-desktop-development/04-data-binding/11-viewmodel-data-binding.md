---
title: "MVVM Data Binding"
pre: "4. "
weight: 4
date: 2018-08-24T10:53:26-05:00
draft: true
---

As Microsoft developed Windows Presentation Framework, they sought to address some of the challenges that had become obvious with Windows Forms.  We've already seen how XAML simplified the design of controls and is more adaptable to varying sizes of displays.  But another major improvement is not found in the code or the technology, but rather in how we put those together.

Specifically, Microsoft architects Ken Cooper and Ted Peters introduced a new software archtectural pattern to leverage when writing WPF controls, [Model-View-ViewModel](https://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93viewmodel).  This approach splits the user interface code into two classes: the View (the XAML + codebehind), and a ViewModel, which converts the actual model objects into a form more easily bound and consumed by the view.

![MVVM Pattern]({{<static "images/MVVMPattern.png">}})

Consider the challenge we had in binding an enum to radio buttons.  Neither of the two solutions we came up with were exactly ideal.  The first added additional, otherwise unneeded properties to the `Person` class, and the other used the rather arcane `IValueConverter` implementation.  Had we used the M-V-VM pattern, we would have placed the responsiblity for conversion on a custom Viewmodel class, which would not have polluted our `Person` class with extra methods and would have bound cleanly to the radio buttons with no messy converters.

The second great benefit of the M-V-VM pattern is that we seperate the UI presentation (the View) from its logic (the ViewModel).  This makes testing much easier, as we can write tests against the ViewModel without needing to work through the user interface.  Thus, writing automated tests becomes far simpler.

But the best way to learn about this pattern is to implement it for ourselves. so let's do so now.

## Initial Project
We'll start with a Model we absolutely can't change - one that comes from a second-party DLL, _CashRegister.dll_.  This DLL file has been included in our starting project, and the Model we'll be working with is the `CashDrawer` class, which represents the contents of a cash drawer in a cash register.  We'll develop a View and a ViewModel to work with an instance of this class.

You can clone the starting project from the GitHub Classroom url provided in the Canvas Assignment (for students in the CIS 400 course), or directly from the GitHub [repo](https://github.com/ksu-cis/mvvm-data-binding.git) (for other readers).

## Connecting the DLL 

Notice the _CashRegister.dll_ file has already been added to the intial project.  But while the file is there, the project is not using it.  To make it available, we first have to add it to the Project's _Dependencies_.  Right-click the _Dependencies_ in the Solution Explorer and choose the _add reference_ option.  This brings up the Reference Manager dialog.  Click the _Browse_ button at the bottom of the dialog, and navigate to the _CashRegister.dll_ file location, select it, and click the _add_ button.  Then click the _Ok_ button to close the dialog.  Now your DLL code will be available in the project.

## Thinking about our UI Design

Before we start writing any code, it is a good idea to think about what we want our user interface to look like.  The `CashDrawer` class we are working with keeps track of every bill and coin currently in the drawer.  When it is constructed, it assumes a standard load-out of bills and coins totaling $150.  We can add additional coins and bills to its inventory with the `AddCoin()` and `AddBill()` method, both of which take the denomination (as an enum value) and a quantity.  So you can only add one type of bill or coin at a time.  Similarly, the `RemoveCoin()` and `RemoveBill()` remove coins and bills, and throw a `DrawerOverdrawException` if more is removed that is available.  The count of each denomination of coin and bill are exposed by readonly properties like `Twenteis` and `Dimes`.  And the total current value of the drawer is calculated by the `TotalValue` readonly property.

Since the `CashDrawer` seperates its data into the different denominations, it makes sense to do the same with the user interface.  I am assuming we will be using a touchscreen interface, so I want the control to be easy to manipulate with touches - which suggests buttons.  And since the quantities of specific denominations we are adding/removing from the drawer won't probably be very large, limiting the buttons to increments of one will probably work well.  And if large amounts are needed, we can supply a text box that displays the quantity, and can be edited directly.  Finally, to make it clear what denomination is being manipulated, we need to display this.  I will also use a colorful bill-looking background for bills, and a coin-looking circle for coins.

Here is a mockup of what I am thinking:

![Currency User Interface]({{<static "images/CurrencyUI.png">}})

## Creating the ModelView Class 

Now we're ready to create our ModelView class.  Let's call it `CashRegisterModelView`, and create it in file _CashRegisterModelView.cs_ (Note this is a regular class, not a WPF UserControl).  To allow for two-way binding, we also need to implement the `INotifyPropertyChanged` interface (found in the `System.ComponentModel` namespace):

```csharp 
/// <summary>
/// The ModelView for a cash register control
/// </summary>
public class CashRegisterModelView : INotifyPropertyChanged 
{
    /// <summary>
    /// Event that notifies when properties change
    /// </summary>
    public event PropertyChangedEventHandler PropertyChanged;
}
```

This class will act as a go-between for a `CashRegister.CashDrawer` class and a user interface control.  So we should probably add a reference for that `CashDrawer` class:

```csharp 
    /// <summary>
    /// The Model class for this ModelView
    /// </summary> 
    CashDrawer drawer = new CashDrawer();
```

Note that the `CashDrawer` is defined in our DLL, so we'll need to make its namespace available with a `using CashRegister;` statement.

### Proxying Properties

The `CashDrawer` class defines a number of properties for each coin and bill it contains, along with the `TotalValue`.  We'll have our `CashRegisterModelView` class proxy these properties.  Let's start with the simplest, the `TotalValue`.  For the `CashRegsiterModelView`, this proeprty will be read-only, so we can pass along the value the `CashDrawer` object stored in our `drawer` provides:

```csharp 
    /// <summary>
    /// The total current value of the drawer
    /// </summary>
    double TotalValue => drawer.TotalValue;
```

Since the `TotalValue` is derived from the bills and coins in the `drawer`, we can't change it directly.  Instead, we would change it by modifying one of the properties responsible for keeping track of the quanitity of a specific denomination bill or coin.  And these quantities we _will_ want to be able to change.  In fact, they are the only properties of the `CashRegisterViewModel` we will want to directly change, so it makes sense to create a helper function to trigger `PropertyChanged` events for them:

```csharp
    /// <summary>
    /// Invokes the PropertyChanged event for denomination properties
    /// and the TotalValue
    /// </summary>
    /// <param name="denomination">The property that is changing</param>
    void InvokePropertyChanged(string denomination)
    {
        PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(denomination));
        PropertyChanged?.Invoke(this, new PropertyChangedEventArgs("TotalValue"));
    }
```

As these properties change, so will the `TotalValue`, so our helper method invokes the `PropertyChanged` event for both.

### Writing Denomination Properties

Now let's write the proxy property for the actual denominations.  Let's start with the smallest, `Pennies`:

```csharp 
    /// <summary>
    /// Gets or sets the number of pennies in the cash register
    /// </summary>
    public int Pennies
    {
        get => drawer.Pennies;

        set
        {
            if (drawer.Pennies == value || value < 0) return;
            int quantity = value - drawer.Pennies;
            if (quantity > 0) drawer.AddCoin(Coins.Penny, quantity);
            else drawer.RemoveCoin(Coins.Penny, -quantity);
            InvokePropertyChanged("Pennies");
        }
    }
```

There's a lot going on here, so let's break it down.

The getter can simply pass along the corresponding property value from the `CashDrawer` instance stored in the field `drawer`.  Hence the line `get => drawer.Pennies;`.  We use the arrow syntax as a short form, it is equivalent to `get { return drawer.Pennies; }` 

We can't have a negative number of bills in the drawer, so we have our property refuse to take a value that is too large, as well as one that isn't really a change, hence the line `if(drawer.Pennies == value || value < 0) return;`. 

The setter needs to change the underlying number of pennies in the drawer.  We can't do this directly - remember `drawer.Pennies` is read-only.  Instead we change the amount of coins by invoking the `AddCoin()` or `RemoveCoin()` method, specifying the denomination and quantity.  So we'll need to calculate the quantity from the incoming value, hence the line `int quantity = value - drawer.Pennies;`

If the result is positive, we are adding bills; hence the line `if(quantity > 0) drawer.AddCoin(Coins.Penny, quantity);`.  

If the quantity is negative, we are removing them. However, we need to invert the sign, as we are removing a _positive_ number of bills:  `else drawer.removeCoin(Coins.penny, -quantity);`.

After the coins have been added or removed, we can invoke the `PropertyChanged` event handler using our helper method, `InvokePropertyChanged("Pennies");`.

The remaining coins and bills are handled the same way.  I'll leave adding those properties as an exercise for the reader.

## Writing a CoinControl 

Now let's turn our attention back to the individual denomination user controls.  We would like this control to be reusable, so one class can be used to cover all the coins, and one all the bills.  Let's start with the coin one.  Remember our mockup - we want the denomination displayed, along with the current quantity of the bills in that denomination, and a plus and minus button.  

Let's create a `UserControl` class named `CoinControl`.  Let's start with the codebehind (_CoinControl.xaml.cs_).  The class created by the template will look like:

```csharp
    /// <summary>
    /// Interaction logic for CoinControl.xaml
    /// </summary>
    public partial class CoinControl : UserControl
    {
        public CoinControl()
        {
            InitializeComponent();
        }
    }
```

### Adding the Denomination Property

We'll need to know what denomination this control is intended to link to, so let's add a property for that.  But we won't use our regular properties, rather we'll use a [DependencyProperty](https://docs.microsoft.com/en-us/dotnet/framework/wpf/advanced/dependency-properties-overview).  The dependency property _takes the place of_ a private backing variable in our property, and has the added benefit of supporting data binding directly.  Let's start with our denomination:

```csharp 
    // Using a DependencyProperty as the backing store for the Denomination Property.  This enables animation, styling, binding, etc...
    public static readonly DependencyProperty DenominationProperty =   
        DependencyProperty.Register(
            "Denomination",                     // The name of the property
            typeof(Coins),                      // The type of the property
            typeof(CoinControl),                // The property's control
            new PropertyMetadata(Coins.Penny)   // The Property Medata
            );
        
```

We use a static readonly variable to define the structure of the dependency property (the actual data for the property is managed internally by WPF).  By convention, we name it after the property it backs, with the word "Property" appended.  Since we will be backing the `Denomination` property, this becomes `DenominationProperty`.  It holds the result of registering the property with WPF using  `DependencyProperty.Register()` - which is an instance of the `DepencencyProperty`, which exposes this structure for our use.  The first argument is the name of the property it will be backing.  The second arguement is the type of the property. The third is the type of control it belongs to.  And the fourth is metadata describing the property - in this case, we just provide the default value, `Coins.Penny`.

Then we write our property that uses this dependency property.  It accesses the memory WPF set aside for the property with `GetValue()` and `SetValue()` respectively:

```csharp 
    /// <summary>
    /// The denomination of the coin
    /// </summary>
    public Coins Denomination
    {
        get { return (Coins)GetValue(DenominationProperty); }
        set { SetValue(DenominationProperty, value); }
    }
```

This looks much like our other properties we've defined in the past.  However, it is important to _not_ include logic within the getter and setter when using a dependency property as a backing store, as code can bypass the getter and setter by calling `SetValue()` directly.  If you need to do logic, use [depencency property callbacks and validation](https://docs.microsoft.com/en-us/dotnet/framework/wpf/advanced/dependency-property-callbacks-and-validation) instead.

### Adding the Quantity Property

The `Quantity` property will also have a dependency property:

```csharp
    /// <summary>
    /// The DependencyProperty backing the Quantity property
    /// </summary>
    public static readonly DependencyProperty QuantityProperty =
            DependencyProperty.Register(
                "Quantity", 
                typeof(int), 
                typeof(CoinControl), 
                new FrameworkPropertyMetadata(
                    0,                 
                    FrameworkPropertyMetadataOptions.BindsTwoWayByDefault
                )
            );
```

This is almost identical to how we set up our `DenominationProperty`, except that we are enabling two-way binding with `FrameworkPropertyMetadataOptions.BindsTwoWayByDefault`.  This will make updates to the `Quantity` property try to update the property bound to it - and make our control editable.

The `Quantity` is pretty straightforward, again using `GetValue()` and `SetValue()`:

```csharp
    /// <summary>
    /// The quantity of the coin denomination
    /// </summary>
    public int Quantity
    {
        get { return (int)GetValue(QuantityProperty); }
        set { SetValue(QuantityProperty, value); }
    }
```

### Adding Event Handlers

We'll also want to add an event handler for the "+" button:

```csharp
    /// <summary>
    /// Increases the quantity of the bound coinage by one
    /// </summary>
    /// <param name="sender">The coinage quanity (as an int)</param>
    /// <param name="args">The event args</param>
    public void OnAddClicked(object sender, RoutedEventArgs args) 
    {
        Quantity++;
    }
```

We can just increment the `Quantity` property.  Doing so passes the update along to the `QuantityProperty`, which will in turn apply it to our bound value, which should be a property of `CashRegisterModelView` class, as we enabled two-way data binding.

The "-" event handler mirrors the approach:

```csharp
    /// <summary>
    /// Decreases the quantity of the bound coinage by one
    /// </summary>
    /// <param name="sender">The coinage quantity (as in int)</param>
    /// <param name="args">The event args</param>
    public void OnRemoveClicked(object sender, RoutedEventArgs args)
    {
        Quantity--;
    }
```

### The XAML

The XAML might look something like:

```xml
<UserControl x:Class="MVVMDataBinding.CoinControl"
             xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
             xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
             xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006" 
             xmlns:d="http://schemas.microsoft.com/expression/blend/2008" 
             xmlns:local="clr-namespace:MVVMDataBinding"
             mc:Ignorable="d" 
             Height="120" Width="120"
             d:DesignHeight="120" d:DesignWidth="120">
    <Border Margin="5" BorderBrush="DarkGray" BorderThickness="1">
        <Grid>
            <Grid.RowDefinitions>
                <RowDefinition Height="4*"/>
                <RowDefinition Height="3*"/>
            </Grid.RowDefinitions>
            <Grid.ColumnDefinitions>
                <ColumnDefinition Width="3*"/>
                <ColumnDefinition Width="4*"/>
                <ColumnDefinition Width="3*"/>
            </Grid.ColumnDefinitions>
            <Border Grid.Column="1" BorderThickness="1" BorderBrush="Goldenrod" CornerRadius="50" Background="Gold" Margin="-8 0">
               <TextBlock Text="{Binding RelativeSource={RelativeSource FindAncestor, AncestorType={x:Type local:CoinControl}}, Path=Denomination}" Foreground="Goldenrod" TextAlignment="Center" VerticalAlignment="Center" FontWeight="Bold"/>
            </Border>
            <Button Grid.Row="1" Grid.Column="0" Click="OnDecreaseClicked">-</Button>
            <TextBlock Grid.Row="1" Grid.Column="1" Text="{Binding RelativeSource={RelativeSource FindAncestor, AncestorType={x:Type local:CoinControl}}, Path=Quantity}" FontSize="30" TextAlignment="Center" VerticalAlignment="Center" Background="White"></TextBlock>            
            <Button Grid.Row="1" Grid.Column="3" Click="OnIncreaseClicked">+</Button>
        </Grid>
    </Border>
</UserControl>
```

A couple of things to note here.  We're setting an actual size for our `UserControl` by defining `Height="120" Width="120"`, so when this control is rendered, it will always be 120 pixels x 120 pixels.  We also set the `DesignWidth` and `DesignHeight` to match, so it appears the same in the designer.

We bind the `TextBlock.Text` values to the `Denomination` and `Quantity` properties of our `CoinControl` by walking up the ancestor tree with `RelativeSource`.  

And finally, we bind our buttons to thier respective event handlers.

## Writing a BillControl

The `BillControl` will follow the same format as the `CoinControl`, substituting a `Bills` type for the denomination property.  I will leave this control as an exercise for the reader.

## Creating a CashRegisterControl

Now we're ready to create a control reprsenting our complete cash register.  Let's call it `CashRegisterControl`.  This just needs to include a `BillControl` and `CoinControl` for every denomination.  The XAML might look like:

```xml 
<UserControl x:Class="MVVMDataBinding.CashRegisterControl"
             xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
             xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
             xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006" 
             xmlns:d="http://schemas.microsoft.com/expression/blend/2008" 
             xmlns:local="clr-namespace:MVVMDataBinding"
             mc:Ignorable="d"  
             d:DesignHeight="450" d:DesignWidth="800">
    <Grid>
        <Grid.RowDefinitions>
            <RowDefinition/>
            <RowDefinition/>
        </Grid.RowDefinitions>
        <StackPanel Orientation="Horizontal" Grid.Row="0" HorizontalAlignment="Center">
            <local:CoinControl Denomination="Penny" Quantity="{Binding Path=Pennies}"/>
            <local:CoinControl Denomination="Dime" Quantity="{Binding Path=Dimes}"/>
            <local:CoinControl Denomination="Nickel" Quantity="{Binding Path=Nickels}"/>
            <local:CoinControl Denomination="Quarter" Quantity="{Binding Path=Quarters}"/>
            <local:CoinControl Denomination="HalfDollar" Quantity="{Binding Path=HalfDollar}"/>
            <local:CoinControl Denomination="Dollar" Quantity="{Binding Path=Dollar}"/>
        </StackPanel>
        <StackPanel Orientation="Horizontal" Grid.Row="1" HorizontalAlignment="Center">
            <local:BillControl Denomination="One" Quantity="{Binding Path=Ones}"/>
            <local:BillControl Denomination="Two" Quantity="{Binding Path=Twos}"/>
            <local:BillControl Denomination="Five" Quantity="{Binding Path=Fives}"/>
            <local:BillControl Denomination="Ten" Quantity="{Binding Path=Tens}"/>
            <local:BillControl Denomination="Twenty" Quantity="{Binding Path=Twenty}"/>
            <local:BillControl Denomination="Fifty" Quantity="{Binding Path=Fifty}"/>
            <local:BillControl Denomination="Hundred" Quantity="{Binding Path=Hundred}"/>
        </StackPanel>    
    </Grid>
</UserControl>
```

## Adding the Control to MainWindow

Now we'll tweak our `MainWindow` class to display our control.  We'll also set its `DataContext` property using XAML:

```csharp
<Window x:Class="MVVMDataBinding.MainWindow"
        xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        xmlns:d="http://schemas.microsoft.com/expression/blend/2008"
        xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"
        xmlns:local="clr-namespace:MVVMDataBinding"
        mc:Ignorable="d"
        Title="MainWindow" Height="450" Width="900">
    <Grid>
        <local:CashRegisterControl>
            <local:CashRegisterControl.DataContext>
                <local:CashRegisterModelView/>
            </local:CashRegisterControl.DataContext>
        </local:CashRegisterControl>
    </Grid>
</Window>
```

Try running your code now - you should see the cash register appear.  And you can change the quantity of bills and coins.
