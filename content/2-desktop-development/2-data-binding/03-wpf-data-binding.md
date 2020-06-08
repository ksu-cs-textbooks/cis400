---
title: "WPF Data Binding"
pre: "3. "
weight: 3
date: 2018-08-24T10:53:26-05:00
---

Now that we've manually implemented data binding, we'll turn our attention to using the data binding functionality built into Windows Presentation Foundation.  

## Initial Project
We'll start with a simple WPF university registry app.  This application consists of:
* The enum `Role` that contains roles of UndergraduateStudent, GraduateStudent, Faculty, and Staff.
* A data class `Person` which represents a single person in the university system.  
* A `PersonController` that has controls for editing a person 
* A `PersonList` that will list all people associated with the university, and allow us to add new ones
* A `RegistryControl` that contains an instance of `PersonController` and `PersonList`

You can clone the starting project from the GitHub Classroom url provided in the Canvas Assignment (for students in the CIS 400 course), or directly from the GitHub [repo](https://github.com/ksu-cis/wpf-data-binding.git) (for other readers).

### Role Enumeration

Here is the starting point for the Role enum:

```csharp
/// <summary>
/// The role of a person in relation to the university
/// </summary>
public enum Role
{
    UndergraduateStudent,
    GraduateStudent,
    Faculty,
    Staff
}
```

It's a very straightforward enumeration.

### Person Class

And here is the starting point for the `Person` class:

```csharp
/// <summary>
    /// A class representing a person associated with the university
    /// </summary>
    public class Person
    {
        /// <summary>
        /// The next ID to assign to a newly-created person
        /// </summary>
        public static uint NextID = 80000000;

        /// <summary>
        /// The uinque identifier of this person
        /// </summary>
        public uint ID { get; private set; }

        /// <summary>
        /// The person's first name
        /// </summary>
        public string FirstName { get; set; }

        /// <summary>
        /// The person's last name
        /// </summary>
        public string LastName { get; set; }

        /// <summary>
        /// The person's date of birth
        /// </summary>
        public DateTime DateOfBirth { get; set; }

        /// <summary>
        /// If this person is active in the university (currently a part of the university)
        /// </summary>
        public bool Active { get; set; }

        /// <summary>
        /// The person's role
        /// </summary>
        public Role Role { get; set; }
        
        /// <summary>
        /// Creates a new user, assigning them an ID
        /// </summary>
        public Person()
        {
            ID = NextID++;
        }
    }
```

It's currently just a data class, using the  [auto-implemented property notation](https://docs.microsoft.com/en-us/dotnet/csharp/programming-guide/classes-and-structs/auto-implemented-properties) to minimize the amount of typing required.  However, we are doing something interesting to generate our `ID`s.  We have a static variable `NextID`, which is initialized to 80000000.  In the constructor, we set the `ID` of the `Person` object to the current value of `NextID`, and then increment `NextID`.  The next time we create a person, they will use the _new_ value of `NextID`, and increment it again (remember, all instances share the same static variables).  Finally, the `ID` property has a private setter.  This way, the ID is always assigned when the `Person` instance is created, and cannot be changed.

### PersonControl Class 
The XAML for the `PersonControl` class is:

```xml
<UserControl x:Class="UniversityRegistry.UI.PersonControl"
             xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
             xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
             xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006" 
             xmlns:d="http://schemas.microsoft.com/expression/blend/2008" 
             xmlns:local="clr-namespace:UniversityRegistry.UI"
             mc:Ignorable="d" 
             d:DesignHeight="450" d:DesignWidth="400">
    <Border Padding="10" BorderBrush="Gray">
        <StackPanel>
            <TextBlock FontSize="18">Personal Details</TextBlock>
            
            <Label Content="First Name"/>
            <TextBox Name="txtFirstName"/>
            
            <Label Content="Last Name"/>
            <TextBox Name="txtLastName"/>
            
            <Label Content="Date of Birth"/>
            <DatePicker Name="dpDateOfBirth"/>
            
            <CheckBox Name="cbActive" Margin="0 10 0 0">Active</CheckBox>
            
            <Label Content="Role"/>
            <TextBox Name="txtRole"/>

        </StackPanel>
    </Border>
</UserControl>
```

It's a simple stack of labels and editing controls (`TextBoxe`s, a `DatePicker`, and a `CheckBox`).  We use a `Border` with its `Padding` property set to provide some whitespace around these controls.  Similarily, we have set a `Margin` on the checkbox the space between it and the control beneath it is similar to the `TextBox`s.

### PersonList Class 
And the XAML for the `PersonList` control is:

```xml
<UserControl x:Class="UniversityRegistry.UI.PersonList"
             xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
             xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
             xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006" 
             xmlns:d="http://schemas.microsoft.com/expression/blend/2008" 
             xmlns:local="clr-namespace:UniversityRegistry.UI"
             mc:Ignorable="d" 
             d:DesignHeight="450" d:DesignWidth="400">
    <Border Padding="10">
        <Grid>
            <Grid.RowDefinitions>
                <RowDefinition Height="30"/>
                <RowDefinition Height="1*"/>
                <RowDefinition Height="30"/>
            </Grid.RowDefinitions>

            <TextBlock FontSize="18">University Directory</TextBlock>

            <ListView Grid.Row="1"/>

            <Button Grid.Row="2">Add New Person</Button>
        </Grid>
    </Border>

</UserControl>
```

Here we use a `Grid` to split the screen vertically - the top row holds a `TextBlock` with a title, the middle row holds a `ListBox` for displaying people, and the bottom row contains a `Button` for adding new people to the list.  The top and bottom rows have a `Height` of 30 pixels, while the middle row is allowed to expand and fill the available space.

### RegistryControl Class 
Finally, the `RegistryControl` XAML:

```xml 
<UserControl x:Class="UniversityRegistry.UI.RegistryControl"
             xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
             xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
             xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006" 
             xmlns:d="http://schemas.microsoft.com/expression/blend/2008" 
             xmlns:local="clr-namespace:UniversityRegistry.UI"
             mc:Ignorable="d" 
             d:DesignHeight="450" d:DesignWidth="800">
    <Grid>
        <Grid.ColumnDefinitions>
            <ColumnDefinition/>
            <ColumnDefinition/>
        </Grid.ColumnDefinitions>
        <local:PersonList Grid.Column="0"/>
        <local:PersonControl Grid.Column="1"/>
    </Grid>
</UserControl>
```

It's pretty simple - just displays a `PersonList` and `PersonControl`.  However, we're doing a bit more in its codebehind:

```csharp 
/// <summary>
/// Interaction logic for RegistryControl.xaml
/// </summary>
public partial class RegistryControl : UserControl
{
    public RegistryControl()
    {
        InitializeComponent();

        // Initializes the list of university people
        var people = new List<Person>()
        {
            new Person(){FirstName="Mother", LastName="Goose", DateOfBirth=new DateTime(1843, 10, 20), Role=Role.Faculty, Active=false},
            new Person(){FirstName="Peter", LastName="Pumpkineater", DateOfBirth=new DateTime(1966, 3, 15), Role=Role.Faculty, Active=true},
            new Person(){FirstName="Mary", LastName="Contrary", DateOfBirth=new DateTime(1965, 3, 8), Role=Role.Faculty, Active=true},
            new Person(){FirstName="Jack", LastName="Spratt", DateOfBirth=new DateTime(1976, 8, 17), Role=Role.Staff, Active=true},
            new Person(){FirstName="Jayne", LastName="Spratt", DateOfBirth=new DateTime(1980, 9, 12), Role=Role.Staff, Active=true},
            new Person(){FirstName="Liz", LastName="Savannah", DateOfBirth=new DateTime(1994, 9, 10), Role=Role.GraduateStudent, Active=true},
            new Person(){FirstName="Barney", LastName="Dinosaur", DateOfBirth=new DateTime(1992, 4, 6), Role=Role.GraduateStudent, Active=true},
            new Person(){FirstName="Arthur", LastName="Read", DateOfBirth=new DateTime(1996, 10, 7), Role=Role.UndergraduateStudent, Active=true},
            new Person(){FirstName="Joe", LastName="Blue", DateOfBirth=new DateTime(1996, 9, 8), Role=Role.UndergraduateStudent, Active=true},
            new Person(){FirstName="Dora", LastName="Explorer", DateOfBirth=new DateTime(1999, 6, 12), Role=Role.UndergraduateStudent, Active=true},
            new Person(){FirstName="Caillou", LastName="Pine", DateOfBirth=new DateTime(1997, 9, 15), Role=Role.UndergraduateStudent, Active=true}
        };
    }
}
```

Namely, creating a list of `People` associated with the university.  If you set a breakpoint at this initialization and run the program, you will see that Mother Goose is assigned an ID of 80000000, Peter Pumpkineater an ID of 80000001, and so on.

## Displaying the List of People 

The first thing we want to do is to display the list of people in our `PeopleList`.  Currently, our list exists in the `RegistryControl`, which contains an instance of `PeopleList`, which is where we will be displaying the list.  So we need some way of sharing the list between these two objects.  We could pass a reference to the list through the constructor or a property of the `PeopleList`, but WPF has a built-in mechanism that we can take advantage of - the `DataContext` property.

### Assigning the DataContext

All WPF framework elements have this `DataContext` property, and its type is an `object` (the base class of all objects in C#), so we can assign it anything we like.  What is different about this property is that when we assign it to a framework element, all of the descendants of that element in the visual tree (i.e. all framework elements _nested in that element_) will _also_ have the same object assigned as thier `DataContext`, unless they have been assigned separately.  So if we assign the list of people to the `DataContext` property of our `RegistryControl`, its contained `PeopleList` will also have its `DataContext` property set to the same object, automatically!  Let's refactor our `RegistryControl` constructor to use this strategy:

```csharp 
    public RegistryControl()
    {
        InitializeComponent();

        // Initializes the list of university people
        var people = new List<Person>()
        {
            new Person(){FirstName="Mother", LastName="Goose", DateOfBirth=new DateTime(1843, 10, 20), Role=Role.Faculty, Active=false},
            new Person(){FirstName="Peter", LastName="Pumpkineater", DateOfBirth=new DateTime(1966, 3, 15), Role=Role.Faculty, Active=true},
            new Person(){FirstName="Mary", LastName="Contrary", DateOfBirth=new DateTime(1965, 3, 8), Role=Role.Faculty, Active=true},
            new Person(){FirstName="Jack", LastName="Spratt", DateOfBirth=new DateTime(1976, 8, 17), Role=Role.Staff, Active=true},
            new Person(){FirstName="Jayne", LastName="Spratt", DateOfBirth=new DateTime(1980, 9, 12), Role=Role.Staff, Active=true},
            new Person(){FirstName="Liz", LastName="Savannah", DateOfBirth=new DateTime(1994, 9, 10), Role=Role.GraduateStudent, Active=true},
            new Person(){FirstName="Barney", LastName="Dinosaur", DateOfBirth=new DateTime(1992, 4, 6), Role=Role.GraduateStudent, Active=true},
            new Person(){FirstName="Arthur", LastName="Read", DateOfBirth=new DateTime(1996, 10, 7), Role=Role.UndergraduateStudent, Active=true},
            new Person(){FirstName="Joe", LastName="Blue", DateOfBirth=new DateTime(1996, 9, 8), Role=Role.UndergraduateStudent, Active=true},
            new Person(){FirstName="Dora", LastName="Explorer", DateOfBirth=new DateTime(1999, 6, 12), Role=Role.UndergraduateStudent, Active=true},
            new Person(){FirstName="Caillou", LastName="Pine", DateOfBirth=new DateTime(1997, 9, 15), Role=Role.UndergraduateStudent, Active=true}
        };
        
        // Assign the list as the DataContext 
        DataContext = people;
    }
```

### Binding Controls to the DataContext

The `DataContext` plays another role in WPF beyond its ability to pass an object down the visual tree.  It is the primary mechanism of WPF data binding.  Any object assigned to the `DataContext` can be bound to a WPF control in the XAML.  

In this case, we want the `ListView` in our `PeopleList` to display the list of people assigned to the `DataContext` property.  We accomplish this binding by setting the `ItemsSource` of the `ListView` to a special string, `"{Binding}"`.  The word Binding in curly braces serves to inform the compiler that we will use the `DataContext` object as the source for this property.  We'll also want to add a name property so we can access it in our codebehind, later.

The edited `ListView` in your _PersonList.xaml_ should now look like:

```xml 
<ListView Grid.Row="1" ItemsSource="{Binding}" />
```

Try running the program now.

The `ListView` should now be populated with a bunch of strings that each read "UniversityRegistry.Data.Person".  This is becuase the `ListView` now is bound to a `List<Person>` object, and is invoking each person's `ToString()` to render the object.  By default `ToString()` returns the fully-quantified name of the class (i.e. it includes the namespace).  We can make this a bit more useful by overriding the `ToString()` method of the `Person` class.  Add this method to _Person.cs_:

```csharp
    /// <summary>
    /// Returns a string identifying the person
    /// </summary>
    /// <returns>A string consisting of last name, first name, and ID</returns>
    public override string ToString()
    {
        return $"{LastName}, {FirstName} [{ID}]";
    }
```

Now try running the program again.  This time, you should see a list of names & IDs.

## Displaying a Person's Details 

The next step we'll want to take is having a person's details appear in the `PersonControl` when we select them in the directory list.  To accomplish this task, we need to know which person is selected, and set that person as the `DataContext` of the `PersonControl`.  Our `PersonList` doesn't have direct access to the `PersonControl`, so we'll need to accomplish this one step up the visual tree - in the `RegistryControl`.

Let's start in _RegistryControl.xaml_ by adding a `Name` attribute to our `PersonControl` element:

```xml
<local:PersonControl x:Name="pcDetails" Grid.Column="1"/>
```

We prefix the `Name` property with an `x` as it is defined in a different assembly.  We use the naming convention of lowercase initails of the control class (PersonControl = pc), plus a descriptive name of what the control shows (Details).  By giving the control a name, we can now access it in the codebehind.  

### Setting up SelectionChanged Events

Now, whenever a person is selected in our `ListView`, we want to set that person as the `DataContext` of the `pcDetails`.  Making a selection in the `ListView` triggers a _selection changed event_.  Thus, we could accomplish the task of setting the selection with an event handler that consumes that event.  Let's add this event listener to our `RegistryControl` (in the file _RegistryControl.xaml.cs_):

```csharp 
    /// <summary>
    /// Updates the DataContext of the PersonControl to the item selected in
    /// the PersonList
    /// </summary>
    /// <param name="sender">The list of people</param>
    /// <param name="e">The selection details</param>
    private void OnSelectionChanged(object sender, SelectionChangedEventArgs e)
    {
        if (e.AddedItems.Count == 0)
        {
            pcDetails.DataContext = null;
        }
        else
        {
            pcDetails.DataContext = e.AddedItems[0];
        }
    }
```

The [SelectionChangedEventArgs](https://docs.microsoft.com/en-us/dotnet/api/system.windows.controls.selectionchangedeventargs?view=netframework-4.8) provides us a list of items selected from the list (if multiselect is enabled, this might be multiple items).  We'll assume that that only single selection is allowed, and use the first item in the list.  An if it doesn't exist, we'll instead clear the `UserControl` by setting its selection to `null`.

Now we need to hook this event listener to the appropriate event handler.  Unfortunately, these are in two different classes - the listener is in `RegistryControl`, and the listener is in a `ListView` in the `PersonList`.  One work-around is to can define a separate event handler in the `PersonList`, which proxies (passes the event on) to the `ListView`'s event handler.  It should have the same method signature as the `ListView`.  Let's add it to the `PersonList`:

```csharp 
    /// <summary>
    /// A proxy event handler
    /// </summary>
    public event SelectionChangedEventHandler SelectionChanged;
```

Then we'll write an event listener that will invoke this new event handler:

```csharp 
    /// <summary>
    /// A proxy event listener that passes on SelectionChanged events
    /// </summary>
    /// <param name="sender">The ListView that had its selection changed</param>
    /// <param name="e">The event arguments</param>
    private void OnSelectionChanged(object sender, SelectionChangedEventArgs e)
    {
        SelectionChanged?.Invoke(this, e);
    }
```

Finally, we'll hook up our proxy event listener to the `ListView`.  We can do this in the codebehind or in the XAML.  Let's make the change in the XAML, and we can also limit the `ListView` to allow only single item selection with the `SelectionMode` property.  The refactored `ListView` (in _PersonList.xaml_) should then look like:

```xml 
<ListView Grid.Row="1" ItemsSource="{Binding}" SelectionChanged="OnSelectionChanged" SelectionMode="Single"/>
```

We'll need to make a similar change in our `RegistryControl` XAML to hook up our proxy event handler to the event listener we wrote there.  Your revised `PersonControl` element in the _RegistryControl.xaml_ should look like:

```xml
<local:PersonList Grid.Column="0" SelectionChanged="OnSelectionChanged"/>
```

A this point selecting an item in the list will cause it to become the data context of our `PersonControl`.  The control won't show any data yet though, as we have not yet bound the various controls to properties.  However, you can verify the behavior using breakpoints.

### Binding the DataContext to Controls

However, we'd really like to see our person's details appear in the `PersonControl`, so let's add bindings to the controls defined in its XAML (we'll make these changes in _PersonControl.xaml_).

First, we want to bind the first name textbox to the `FirstName` property of the `Person` (our `DataContext`).  We do this by setting its `Text` property to a special string, `"{Binding Path=FirstName}"`.  Notice again the use of curly braces and the `Binding` keyword.  This binds the control to the `DataContext` (which is a `Person` object).  Then the `Path` shifts that binding to the `Person.FirstName` property.

The revised `TextArea` element should look like:

```xml
<TextBox Name="txtFirstName" Text="{Binding Path=FirstName}"/>
```

If we run our code now, we'll see the first name appear in our form.

Now we'll want to bind the remaining elements.  The last name is almost identical:

```xml
<TextBox Name="txtLastName" Text="{Binding Path=LastName}"/>
```

The `DatePicker` is similar, except the property we'll set is `SelectedDate`, and we'll bind it to the `DateOfBirth` property:

```xml 
<DatePicker Name="dpDateOfBirth" SelectedDate="{Binding Path=DateOfBirth}"/>
```

The `CheckBox` also has a different property to bind, `IsChecked`, which takes a boolean as a value.  We'll bind it to the `Active` property:

```xml 
<CheckBox Name="cbActive" Margin="0 10 0 0" IsChecked="{Binding Path=Active}">Active</CheckBox>
```

Finally, we'll bind our `Role` property to the last `TextBlock` element:

```xml 
<TextBox Name="txtRole" Text="{Binding Path=Role}"/>
```

Now when we click a person from the list, their details appear automatically!

## Editing Person Details

Showing the details is only part of what we want to accomplish - we also want to update them.  Run the program and try to change one of the people's names.  If you select a different person, and then return, notice your change has stuck!  But the name _doesn't_ change in the list.

### Implementing INotifyPropertyChanged

The situation is much like the one we faced in our manual data binding exercise - the `ListView` does not know that the underlying data it is displaying has changed.  In that project we used an event to notify of the change.  We'll do the same thing here, but this time, we'll use an event already defined for us - a property change event.  We can indicate that a class supports this event by implementing the `INotifyPropertyChanged` interface, found in the `System.ComponentModel` namespace.  Add this to our data class, `Person`:

```csharp 
    /// <summary>
    /// A class representing a person associated with the university
    /// </summary>
    public class Person : INotifyPropertyChanged
    {
        ...
```csharp

The interface requires us to implement an event handler of type `PropertyChangedEventHandler` named `PropertyChanged` - so let's do so:

```csharp 
    /// <summary>
    /// Event triggered when properties of Person change
    /// </summary>
    public event PropertyChangedEventHandler PropertyChanged;
```

That's all we have to do to implement the interface from a syntax standpoint.  But this particular interface also comes with the expectation that the `PropertyChanged` event handler will be invoked _any time a public property of the class changes_.

Thus, we need to invoke it from each of our properties.  This also means we can no longer use the auto-imlemented properties; we must refacor the propreties to use a private backing variable so we can place the invocation call into the setter (which is what changes the property).  Let's tackle `FirstName` first:

```csharp 
    private string firstName;
    /// <summary>
    /// The person's first name
    /// </summary>
    public string FirstName {
        get { return firstName; }
        set
        {
            if (firstName == value) return;
            firstName = value;
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs("FirstName"));
        }
    }
```

This should be familiar to you already, but let's walk through the setter line-by-line.  First, we check to see if the value is _really_ changing with `if (firstName == value) return;`.  If we are actually setting the `firstName` to the value it already has, we end execution with a `return` statement.  If we get past that, the value is new, and we assign it to the private backing variable with `firstName = value;`.  Finally, we invoke our event handler with `PropertyChanged?.Invoke(this, new PropertyChangedEventArgs("FirstName"));`.  Remember, the `?.` operator keeps us from calling `Invoke()` if the `PropertyChanged` event handler has no event listener is attached.  We use `this` to indicate the source of the event is _this class_, and finally, we create a `PropertyChangedEventArgs` object, passing in the name of the property that is changing.  It is _critical_ that this name matches the property _exactly_.

Go ahead and refactor all remaining public properties in the same way _except_ the `ID` property, as the `ID` property will not change once it is set.

### Switching from List<T> to ObservableCollection<T>

The next refactoring we'll do is replacing our `List<People>` in `RegistryControl` with an `ObservableCollection<People>`.  The `ObservableCollection<T>` is defined in the `System.Collections.ObjectModel` namespace and implements all the same methods as `List<T>`, but also implements the `INotifyPropertyChanged` interface, so it has a `PropertyChanged` event handler that will trigger any time an item is added or removed.  

Since the `List<T>` and `ObservableCollection<T>` implement the same methods, it's a simple matter of swapping what constructor we call in our `RegistryControl()` constructor.  Replace the line:

```csharp 
people = new List<Person>()
```

With the line:

```csharp 
people = new ObservableCollection<Person>()
```

While the `ObservableCollection<T>` notifies when it changes itself, it does not pass on notifications of its own children changing.  So if we run our program now and change a first name... we still won't find the list changing.  

There are two ways we can get around this issue: 1) Write our own data structure that _does_ listen for children's changes (this could be a wrapper around a `List<T>` or `ObservableCollection<T>`), or 2) make our list items bind to the `Person` object properties directly.

### Writing an ItemTemplate

This second approach has the benefit of allowing us a greater deal of customization of how our list of people appears, so let's go that route.  When a `ListView` displays its collection, it iterates through each item and applies its `ItemTemplate` to that item. This `ItemTemplate` is an instance of the `DataTemplate` class, and is essentially a XAML control.  The default implementation is something like this:

```xml
<DataTemplate>
    <TextBlock Text="{Binding}"/>
</DataTemplate>
```

It essentially transforms the item into a string and displays it.  We can replace this default `DataTemplate` with one of our own creation.  Let's say we want three columns, with values of last name, first name, and ID.  Such a template would look something like:

```xml
<DataTemplate>
    <Grid>
        <Grid.ColumnDefinitions>
            <ColumnDefinition/>
            <ColumnDefinition/>
            <ColumnDefinition/>
        </Grid.ColumnDefinitions>
        <TextBlock Text="{Binding Path=FirstName}" Grid.Column="0"/>
        <TextBlock Text="{Binding Path=LastName}" Grid.Column="1"/>
        <TextBlock Text="{Binding Path=ID}" Grid.Column="2"/>
    </Grid> 
</DataTemplate>
```

We need to assign this to our `ListView.ItemTemplate` property.  We also need to set the `ListView.HorizontalContentAlignment` property to `"Stretch"` so our `Grid` will fill the available space. Our revised `ListView` in _PersonList.xaml_ would then be:

```xml
    <ListView Grid.Row="1" ItemsSource="{Binding}" SelectionChanged="OnSelectionChanged" SelectionMode="Single" HorizontalContentAlignment="Stretch">
        <ListView.ItemTemplate>
            <DataTemplate>
                <Grid>
                    <Grid.ColumnDefinitions>
                        <ColumnDefinition/>
                        <ColumnDefinition/>
                        <ColumnDefinition/>
                    </Grid.ColumnDefinitions>
                    <TextBlock Text="{Binding Path=FirstName}" Grid.Column="0"/>
                    <TextBlock Text="{Binding Path=LastName}" Grid.Column="1"/>
                    <TextBlock Text="{Binding Path=ID}" Grid.Column="2"/>
                </Grid>                        
            </DataTemplate>
        </ListView.ItemTemplate>
    </ListView>
```

Now when we run our program, our list of people has a bit nicer of formatting, and - more importantly - updates with the changes we make in the person details!

## Using Appropriate Controls
Our application now works, but there are a few things we might do to make it more useful and user-friendly.  

### One-Way vs Two-Way Binding

First, we might add the `ID` property to the personal details.  You might think we should add it as a `TextBlock`, like this:

```xml
<Label Content="ID"/>
<TextBox Text="{Binding Path=ID}"/>
```

But if we try that, we'll get a warning that "A Two-Way binding cannot work for readonly property ID".  To understand this message, we need to understand the difference between a one-way and two-way data binding.  A control using one-way data binding only _displays_ the value, while a control using two-way binding allows _editing_ the value.  

Remember, our `Person.ID` property has a private setter, so it is effectively read-only.  Thus, it can only be used for one-way bindings, not two-way ones.  And a `TextBox` is an editable control that uses two-way bindings.  Instead, we'll need to use a `TextBlock`, which employs a one-way binding.  Most WPF controls come in pairs - one that only displays a value (and uses one-way bindings), and one that allows editing the value (and uses two-way bindings).  

So to properly display (but not edit) our `ID`, we'd want to use:

```xml
<Label Content="ID"/>
<TextBlock Text="{Binding Path=ID}"/>
```

### Editing the Role 

The second control I'll direct your attention to is the `TextBox` we are using for the `Person.Role`.  Try running your program and changing the role.  It will work if you _exactly_ match one of the possible names from the `Role` enum.  But if you misspell it in the slightest, the change will not be applied.  The program also won't warn us that the change wasn't applied.  This is poor user interface design, and will cause a lot of frustration for our users.  To avoid this problem, we should pick a more appropriate control.

Two options that make sense are radio buttons (mutually exclusive checkboxes), and a drop-down selection box.  We'll look at how each of these is implemented, in turn.

### Radio Buttons 
Radio Buttons work much like the `CheckBox` we are using for the `Active` property, in that we would bind to the `IsChecked` property.  However, the `IsChecked` property is a boolean, and our `Role` is an enum.  We therefore can't bind the `Role` directly to the `IsChecked` property.  There are few different solutions we can employ

#### Solution 1: Additional Properties on the Person Class 

One solution is to add some new boolean properties to our person class.  For example, `IsFaculty` that would be true if the person's role is Faculty, and false otherwise.  However, we don't want to duplicate the information already stored in our `Role` property.  So instead, we'll have `IsFaculty` derive its value from `Role`, i.e.:

```csharp 
public bool IsFaculty 
{
    get {return Role == Role.Faculty;}
}
```

In order to allow the `IsFaculty` to be used for two-way binding, we also need a setter, which will change the `Role` property:

```csharp 
public bool IsFaculty 
{
    get {return Role == Role.Faculty;}
    set {Role = Role.Faculty;}
}
```

We would create similar properties for the remaining roles: `IsUndergraduateStudent`, `IsGraduateStudent`, and `IsStaff`.  

These properties also change when the `Role` property changes, so we'll need to add additional `PropertyChanged` invocations to our `Role` setter:

```csharp 
    private Role role;
    /// <summary>
    /// The person's role
    /// </summary>
    public Role Role { 
        get => role; 
        set
        {
            if (role == value) return;
            role = value;
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs("Role"));
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs("Role"));
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs("IsUndergraduateStudent"));
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs("IsGraduateStudent"));
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs("IsFaculty"));
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs("IsStaff"));
        } 
    }
```

Then we can swap the role `TextBox` for `RadioButton`s in _PersonControl.xaml_:

```xml
    <RadioButton GroupName="Role" IsChecked="{Binding Path=IsUndergraduateStudent}">Undergraduate Student</RadioButton>
    <RadioButton GroupName="Role" IsChecked="{Binding Path=IsGraduateStudent}">Graduate Student</RadioButton>
    <RadioButton GroupName="Role" IsChecked="{Binding Path=IsFaculty}">Faculty</RadioButton>
    <RadioButton GroupName="Role" IsChecked="{Binding Path=IsStaff}">Staff</RadioButton>
```

Now if we check one of the radio buttons, it will swap the `Person.Role` property to match the selected role.  

#### Solution 2: Create a Converter Class

The second option invovles creating a class that converts an enum value to a boolean.  This class needs to impelment the [IValueConverter](https://docs.microsoft.com/en-us/dotnet/api/system.windows.data.ivalueconverter?view=netframework-4.8) interface from the `System.Windows.Data` namespace.  Let's create our class in the file _EnumToBooleanConverter.cs_:

```csharp 
/// <summary>
/// A class for converting enum values to booleans
/// for use in data binding
/// </summary>
public class EnumToBooleanConverter : IValueConverter
{
}
```

This interface requires us to implement a `Convert()` and `ConvertBack()` method.  Let's define the `Convert()` method first:

```csharp 
    /// <summary>
    /// Converts an enum value into a boolean by comparing it to the supplied parameter.  
    /// If the value and parameter are the same, the method returns true; otherwise false
    /// </summary>
    /// <param name="value">The enum value to convert</param>
    /// <param name="targetType">The type to convert to (should be a boolean)</param>
    /// <param name="param">The enum value to compare to</param>
    /// <param name="culture">The culture info</param>
    /// <returns>True if the enum matches the param, false otherwise</returns>
    public object Convert(object value, Type targetType, object param, CultureInfo culture)
    {
        return value.Equals(param);
    }
```

The interface method is intended to be very generic, and also deal with conversions due to cultural differences, so the methods are not very specific.  Basically, the `value` parameter is what we are seeking to convert, the `targetType` is what we want to convert it to, the `param` gives us the ability specify some kind of parameter (here we use it to say which possible enum value we expect), and the `culture` tells us what culture we are converting it for (we basically ignore this, in this case).  Also, note that `CultureInfo` is defined in the `System.Globalization` namespace.

We also need to define our `ConvertBack()` method:

```csharp
    /// <summary>
    /// Converts a boolean into an enum value.  If the boolean is true, the parameter is returned,
    /// otherwise DependencyProperty.UnsetValue is returned (which unsets the control)
    /// </summary>
    /// <param name="value">The boolean to convert</param>
    /// <param name="targetType">The type to convert (should be an enum)</param>
    /// <param name="param">The enumeration value to check</param>
    /// <param name="culture">The culture info</param>
    /// <returns></returns>
    public object ConvertBack(object value, Type targetType, object param, CultureInfo culture)
    {
        if ((bool)value) return param;
        else return DependencyProperty.UnsetValue;
    }
```

This reverses the conversion.  If the boolean is true, it returns the supplied enumeration value.  And if it is false, it returns `DependencyProperty.UnsetValue` which should uncheck the radio button.

Next we need to make this converter available to our XAML.  We can do this by adding it to our `UserControl.Resources` in the _PersonControl.xaml_:

```xml
    <UserControl.Resources>
        <local:EnumToBooleanConverter x:Key="enumToBooleanConverter"/>
    </UserControl.Resources>
```

By giving it a `Key` property, we can reference it from our `<RadioButton>` elements.  We specify it as a `Converter` as part of our binding:

```xml
    <RadioButton GroupName="Role" IsChecked="{Binding Path=Role, Converter={StaticResource enumToBooleanConverter}, ConverterParameter={x:Static data:Role.UndergraduateStudent}}">Undergraduate Student</RadioButton>
    <RadioButton GroupName="Role" IsChecked="{Binding Path=Role, Converter={StaticResource enumToBooleanConverter}, ConverterParameter={x:Static data:Role.GraduateStudent}}">Graduate Student</RadioButton>
    <RadioButton GroupName="Role" IsChecked="{Binding Path=Role, Converter={StaticResource enumToBooleanConverter}, ConverterParameter={x:Static data:Role.Faculty}}">Faculty</RadioButton>
    <RadioButton GroupName="Role" IsChecked="{Binding Path=Role, Converter={StaticResource enumToBooleanConverter}, ConverterParameter={x:Static data:Role.Staff}}">Staff</RadioButton>
```
The `ConverterParameter` supplies the `param` argument for the converter, which associates the `RadioButton` with one of the possible enum values.  The actual enum to use is inferred by the compiler from the bound parameter, `Role`.

### Solution 3: Use a Combo Box 

The third option is to use a `ComboBox` control, which offers a drop-down selection.  This is a great solution for desktop apps, or selections with a lot of options.  For controls with only a few options or intended for use on a touchscreen, a RadioButton might be a better approach.

The first step is to make the `Role` enumeration available to our `ComboBox` in the XAML.  The `Role` is defined in a different namespace than our control, `UniversityRegistry`, so we need to add this namespace to the `UserControl` element with an `xmlns` tag, i.e. `xmlns:data=clr-namespace:UniversityRegistry.Data`.  Similarily, the Enum type is defined in the namespace `System`, so we need to make that available too: `xmlns:system=namespace:System;assembly=mscorlib"`.  This is the equivalent of the `using` statements in the codebehind.  Our revised XAML `<UserControl>` element should look like:

```csharp
<UserControl x:Class="UniversityRegistry.UI.PersonControl"
             xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
             xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
             xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006" 
             xmlns:d="http://schemas.microsoft.com/expression/blend/2008" 
             xmlns:local="clr-namespace:UniversityRegistry.UI"
             xmlns:data="clr-namespace:UniversityRegistry.Data"
             xmlns:system="clr-namespace:System;assembly=mscorlib" 
             mc:Ignorable="d" 
             d:DesignHeight="450" d:DesignWidth="400">
```

Now we need to define an `ObjectDataProvider` to make the enum values available in the XAML.  This is added to the `UserControl.Resources`, and is the XAML version of `var roles = Enum.GetValues(typeof(Data.Roles))`.  It is written:

```csharp 
<UserControl.Resources>
    <ObjectDataProvider MethodName="GetValues"
                ObjectType="{x:Type system:Enum}"
                x:Key="roles">
        <ObjectDataProvider.MethodParameters>
            <x:Type TypeName="data:Role" />
        </ObjectDataProvider.MethodParameters>
    </ObjectDataProvider>
</UserControl.Resources>
```

We can now bind our `ObjectDataProvider` roles to the `ItemsSource` property of a `ComboBox` as a `StaticResource`:

```csharp 
<ComboBox SelectedItem="{Binding Path=Role}" ItemsSource="{Binding Source={StaticResource roles}}"/>
```

Note that we also bind the `Person.Role` to the `SelectedItem` property.  This establishes the two-way binding betweeen the `Person` object and the role selected in the `ComboBox`.  The `Role` enum values are bound to the `ComboBox` with a one-way binding, which means it will always have the option of every role in the enum.  Even if we add new roles in the future, they will automatically appear in the `ComboBox`.


## Bonus Binding: Memonics

Before we wrap up this lesson, let's see one more example of using binding _mnemonics_.  In windows user interfaces, attaching a mnemonic to a control allows you to shift focus to that control by pressing the [alt] key + a key specified by the mnemonic.  The specific key is indicated by underlining that character in the character's label.

In a WPF label, this relationship can be set up by 1) putting an underscore before the character to use as a mnemonic in the label content, and 2) specifing a `Target` property for that mnemonic (in this case, the control that should gain focus).  Thus, for our first name `TextBox` (in _PersonControl.cs_) we would refactor it to read:

```xml 
    <Label Content="_First Name" Target="{Binding ElementName=txtFirstName}"/>
    <TextBox Name="txtFirstName" Text="{Binding Path=FirstName}"/>        
```

This will tie the memonic to the [F] key.  If you run the program and press the [alt] key, the character "F" in the label will have the underline appear, and if you press the [F] key while holding the [alt] key down, focus will jump to the targeted text box.  Experienced data entry personnel will often use these key shortcuts to quickly fill out forms, so it is a good idea to set up mnemonics for any Windows desktop applications you build.