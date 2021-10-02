---
title: "Data Binding"
pre: "2. "
weight: 2
date: 2018-08-24T10:53:26-05:00
---

Data binding is a technique for synchronizing data between a provider and consumer, so that any time the data changes, the change is reflected in the bound elements.  This strategy is commonly employed in graphical user interfaces (GUIs) to bind controls to data objects.  Both Windows Forms and Windows Presentation Foundation employ data binding.

In WPF, the data object is essentially a normal C# object, which represents some data we want to display in a control. However, this object must implement the `INotifyPropertyChanged` interface in order for changes in the data object to be automatically applied to the WPF control it is bound to.  Implementing this interface comes with two requirements.  First, the class will define a `PropertyDefined` event:

```csharp
public event PropertyChangedEventHandler PropertyChanged;
```

And second, it will invoke that `PropertyChanged` event handler _whenever_ one of its properties changes:

```csharp
PropertyChanged?.Invoke(this, new PropertyChangedEventArgs("ThePropertyName"));
```
The string provided to the `PropertyChangedEventArgs` constructor _must_ match the property name _exactly_, including capitalization.  

For example, this simple person implementation is ready to serve as a data object:


```csharp
/// <summary>
/// A class representing a person 
/// </summary>
public class Person : INotifyPropertyChanged
{
    /// <summary>
    /// An event triggered when a property changes 
    /// </summary>
    public event PropertyChangedEventHandler PropertyChanged;

    private string firstName = "";
    /// <summary>
    /// This person's first name 
    /// </summary>
    public string FirstName
    {
        get { return firstName; }
        set
        {
            firstName = value;
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs("FirstName"));
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs("FullName"));
        }
    }

    private string lastName = "";
    /// <summary>
    /// This person's last name 
    /// </summary>
    public string LastName
    {
        get { return lastName; }
        set
        {
            lastName = value;
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs("LastName"));
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs("FullName"));
        }
    }

    /// <summary>
    /// This persons' full name 
    /// </summary>
    public string FullName
    {
        get { return $"{firstName} {lastName}"; }
    }

    /// <summary>
    /// Constructs a new person 
    /// </summary>
    /// <param Name="first">The person's first name</param>
    /// <param Name="last">The person's last name</param>
    public Person(string first, string last)
    {
        this.firstName = first;
        this.lastName = last;
    }
}
```

There are several details to note here.  As the `FirstName` and `LastName` properties have setters, we must invoke the `PropertyChanged` event within them.  Because of this extra logic, we can no longer use auto-property syntax.  Similarly, as the value of `FullName` is derived from these properties, we must _also_ notify that `"FullName"` changes when one of `FirstName` or `LastName` changes.

To accomplish the binding in XAML, we use a syntax similar to that we used for static resources.  For example, to bind a `<TextBlock>` element to the `FullName` property, we would use:

```xml
<TextBlock Text="{Binding Path=FullName}" />
```

Just as with our static resource, we wrap the entire value in curly braces (`{}`), and declare a `Binding`.  The `Path` in the binding specifies the _property_ we want to bind to - in this case, `FullName`.  This is considered a one-way binding, as the `TextBlock` element only displays text - it is not editable.  The corresponding control for editing a textual property is the `<TextBlock>`.  A two-way binding is declared the same way i.e.:

```xml
<TextBox Text="{Binding Path=FirstName}" />
```

However, we cannot bind a read-only property (one that has no setter) to an editable control - only those with both accessible getters and setters.  The XAML for a complete control for editing a person might look something like:

```xml
<UserControl x:Class="DataBindingExample.PersonControl"
             xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
             xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
             xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006" 
             xmlns:d="http://schemas.microsoft.com/expression/blend/2008"     
             xmlns:local="clr-namespace:DataBindingExample"
             xmlns:system="clr-namespace:System;assembly=mscorlib"
             mc:Ignorable="d" 
             d:DesignHeight="450" d:DesignWidth="400">    
    <StackPanel>
        <TextBlock Text="{Binding Path=FullName}"/>
        <Label>First</Label>
        <TextBox Text="{Binding Path=FirstName}"/>
        <Label>Last</Label>
        <TextBox Text="{Binding Path=LastName}"/>
    </StackPanel>
</UserControl>
```

We also need to set the `DataContext` property of the control.  This property holds the specific data object whose properties are bound in the control.  For example, we could pass a `Person` object into the `PersonControl`'s constructor and set it as the `DataContext` in the codebehind:

```csharp
namespace DataBindingExample
{
    /// <summary>
    /// Interaction logic for PersonControl.xaml
    /// </summary>
    public partial class PersonEntry : UserControl
    {
        /// <summary>
        /// Constructs a new PersonControl control 
        /// </summary>
        /// <param Name="person">The person object to data bind</param>
        public PersonControl(Person person)
        {
            InitializeComponent();
            this.DataContext = person;
        }
    }
}
```

However, this approach means we can no longer declare a `<PersonControl>` in XAML (as objects declared this way must have a parameterless constructor).  An alternative is to bind the `DataContext` in the codebehind of an ancestor control; for example, a window containing the control:

```xml
<Window x:Class="DataContextExample.MainWindow"
        xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        xmlns:d="http://schemas.microsoft.com/expression/blend/2008"
        xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"
        xmlns:local="clr-namespace:DataContextExample"
        mc:Ignorable="d"
        Title="MainWindow" Height="450" Width="800">
    <Grid>
        <local:PersonEntry x:Name="personEntry"/>
    </Grid>
</Window>
```
```csharp
namespace DataContextExample
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {        
        public MainWindow()
        {
            InitializeComponent();
            personControl.DataContext = new Person("Bugs", "Bunny");
        }
    }
}
```

Finally, the `DataContext` has a very interesting relationship with the elements tree.  If a control in this tree does not have its own `DataContext` property directly set, it uses the `DataContext` of the first ancestor where it _has_ been set. I.e. were we to set the `DataContext` of the window to a person:


```csharp
namespace DataContextExample
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {        
        public MainWindow()
        {
            InitializeComponent();
            this.DataContext = new Person("Elmer", "Fudd");
        }
    }
}
```

And have a `PersonElement` nested somewhere further down the elements tree:

```xml
<Window x:Class="DataBindingExample.MainWindow"
        xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        xmlns:d="http://schemas.microsoft.com/expression/blend/2008"
        xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"
        xmlns:local="clr-namespace:DataBindingExample"
        mc:Ignorable="d"
        Title="MainWindow" Height="450" Width="800">
    <Grid>
        <Border>
            <local:PersonEntry/>
        </Border>
    </Grid>
</Window>
```

The bound person (Elmer Fudd)'s information would be displayed in the `<PersonEntry>`!