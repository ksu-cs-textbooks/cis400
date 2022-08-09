---
title: "Binding Lists"
pre: "4. "
weight: 4
date: 2018-08-24T10:53:26-05:00
---


For list controls, i.e. `ListView` and `ListBox`, the appropriate binding is a collection implementing `IEnumerable`, and we bind it to the `ItemsSource` property.  Let's say we want to create a directory that displays information for a `List<Person>`.  We might write a custom `DirectoryControl` like:

```xml
<UserControl x:Class="DataBindingExample.DirectoryControl"
             xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
             xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
             xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006" 
             xmlns:d="http://schemas.microsoft.com/expression/blend/2008" 
             xmlns:local="clr-namespace:DataBindingExample"
             mc:Ignorable="d" 
             d:DesignHeight="450" d:DesignWidth="800">
    <Grid>
        <ListBox ItemsSource="{Binding}"/>
    </Grid>
</UserControl>
```

Notice that we didn't supply a `Path` with our binding.  In this case, we'll be binding directly to the `DataContext`, which is a list of `People` objects drawn from the 1996 classic "Space Jam", i.e.:

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
        <local:DirectoryControl x:Name="directory"/>
    </Grid>
</Window>
```
```csharp
/// <summary>
/// Interaction logic for MainWindow.xaml
/// </summary>
public partial class MainWindow : Window
{
    public MainWindow()
    {
        InitializeComponent();
        ObservableCollection<Person> people = new ObservableCollection<Person>()
        {
            new Person("Bugs", "Bunny", true),
            new Person("Daffy", "Duck", true),
            new Person("Elmer", "Fudd", true),
            new Person("Tazmanian", "Devil", true),
            new Person("Tweety", "Bird", true),
            new Person("Marvin", "Martian", true),
            new Person("Michael", "Jordan"),
            new Person("Charles", "Barkely"),
            new Person("Patrick", "Ewing"),
            new Person("Larry", "Johnson")
        };
        DataContext = people;
    }
}
```

Instead of a `List<Person>`, we'll use an `ObservableCollection<Person>` which is essentially a list that implements the `INotifyPropertyChanged` interface.

When we run this code, our results will be:

![The ListView in the running application](/images/2.4.4.1.png)

This is because the `ListBox` (and the `ListView`) by default are composed of `<TextBlock>` elements, so each `Person` in the list is being bound to a `<TextBlock>`'s `Text` property.  This invokes the `ToString()` method on the `Person` object, hence the `DataBindingExample.Person` displayed for each entry.

We could, of course, override the `ToString()` method on person.  But we can also overwrite the `DataTemplate` the list uses to display its contents.  Instead of using the default `<TextView>`, the list will use the `DataContext`, and the bindings, we supply.  For example, we could re-write the `DirectoryControl` control as:

```xml
<UserControl x:Class="DataBindingExample.DirectoryControl"
             xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
             xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
             xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006" 
             xmlns:d="http://schemas.microsoft.com/expression/blend/2008" 
             xmlns:local="clr-namespace:DataBindingExample"
             mc:Ignorable="d" 
             d:DesignHeight="450" d:DesignWidth="800">
    <Grid>
        <ListBox ItemsSource="{Binding}">
            <ListBox.ItemTemplate>
                <DataTemplate>
                    <Border BorderBrush="Black" BorderThickness="2">
                        <StackPanel>
                            <TextBlock Text="{Binding Path=FullName}"/>
                            <CheckBox IsChecked="{Binding Path=IsCartoon}" IsEnabled="False">
                                Is a Looney Toon
                            </CheckBox>
                        </StackPanel>
                    </Border>
                </DataTemplate>
            </ListBox.ItemTemplate>
        </ListBox>
    </Grid>
</UserControl>
```

And the resulting application would display:

![The updated ListView in the running application](/images/2.4.4.2.png)

Note that in our `DataTemplate`, we can bind to properties in the `Person` object.  This works because as the `ListBox` processes its `ItemsSource` property, it creates a new instance of its `ItemTemplate` (in this case, our custom `DataTemplate`) and assigns the item from the `ItemSource` to its `DataContext`.

Using custom `DataTemplates` for XAML controls is a powerful feature to customize the appearance and behavior of your GUI.

Lists also can interact with other elements through bindings.  Let's refactor our window so that we have a `<PersonRegistry>` side-by-side with our `<PersonControl>`:

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
        <Grid.ColumnDefinitions>
            <ColumnDefinition/>
            <ColumnDefinition/>
        </Grid.ColumnDefinitions>
        <local:PersonControl Grid.Column="0" DataContext="{Binding Path=CurrentItem}"/>
        <local:DirectoryControl Grid.Column="1"/>
    </Grid>
</Window>
```

Note how we bind the `<PersonControl>`'s `DataContext` to the `CurrentItem` of the `ObservableCollection<Person>`.  In our `<RegistryControl>`'s `ListBox`, we'll also set its `IsSynchronizedWithCurrentItem` property to true:

```xml
<UserControl x:Class="DataBindingExample.DirectoryControl"
             xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
             xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
             xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006" 
             xmlns:d="http://schemas.microsoft.com/expression/blend/2008" 
             xmlns:local="clr-namespace:DataBindingExample"
             mc:Ignorable="d" 
             d:DesignHeight="450" d:DesignWidth="800">
    <Grid>
        <ListBox ItemsSource="{Binding}" HorizontalContentAlignment="Stretch" IsSynchronizedWithCurrentItem="True">
            <ListBox.ItemTemplate>
                <DataTemplate>
                    <Border BorderBrush="Black" BorderThickness="1">
                        <StackPanel>
                            <TextBlock Text="{Binding Path=FullName}"/>
                            <CheckBox IsChecked="{Binding Path=IsCartoon, Mode=OneWay}" IsEnabled="False">Cartoon</CheckBox>
                        </StackPanel>
                    </Border>
                </DataTemplate>
            </ListBox.ItemTemplate>
        </ListBox>
    </Grid>
</UserControl>
```

With these changes, when we select a person in the `<RegistryControl>`, their information will appear in the `<PersonControl>`:

![The bound controls](/images/2.4.4.3.png)

