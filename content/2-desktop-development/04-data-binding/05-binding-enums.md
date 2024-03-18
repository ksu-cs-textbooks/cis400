---
title: "Binding Enumerations"
pre: "5. "
weight: 5
date: 2018-08-24T10:53:26-05:00
---

Now let's delve into a more complex data binding examples - binding enumerations.  For this discussion, we'll use a simple enumeration of fruits:

```csharp
/// <summary>
/// Possible fruits
/// </summary>
public enum Fruit
{
    Apple,
    Orange,
    Peach,
    Pear
}
```

And add a `FavoriteFruit` property to our `Person` class:

```csharp
private Fruit favoriteFruit;
/// <summary>
/// The person' favorite fruit
/// </summary>
public Fruit FavoriteFruit
{
    get { return favoriteFruit; }
    set
    {
        favoriteFruit = value;
        PropertyChanged?.Invoke(this, new PropertyChangedEventArgs("FavoriteFruit"));
    }
}
```

For example, what if we wanted to use a `ListView`  to select an item out of this enumeration?  We'd actually need to bind _two_ properties, the `ItemSource` to get the enumeration values, and the `SelectedItem` to mark the item being used.  To accomplish this binding, we'd need to first make the fruits available for binding by creating a static resource to hold them using an `ObjectDataProvider`:

```xml
<ObjectDataProvider x:Key="fruits" ObjectType="system:Enum" MethodName="GetValues">
    <ObjectDataProvider.MethodParameters>
        <x:Type TypeName="local:Fruit"/>
    </ObjectDataProvider.MethodParameters>
</ObjectDataProvider>
```

The [`ObjectDataProvider`](https://docs.microsoft.com/en-us/dotnet/api/system.windows.data.objectdataprovider?view=netcore-3.1) is an object that can be used as a data source for WPF bindings, and wraps around an object and invokes a method to get the data - in this case the `Enum` class, and its static method `GetValues()`, which takes one parameter, the `Type` of the enum we want to pull the values of (provided as the nested element, `<x:Type>`).  

Also, note that because the `Enum` class is defined in the System namespace, we need to bring it into the XAML with an xml namespace mapped to it, with the attribute `xmlns` defined on the UserControl, i.e.: `xmlns:system="clr-namespace:System;assembly=mscorlib"`.

Now we can use the `fruits` key as part of a data source for a listview: `<ListView ItemsSource="{Binding Source={StaticResource fruits}}" SelectedItem="{Binding Path=FavoriteFruit}"/>`

Notice that we use the `Source` property of the `Binding` class to bind the `ItemsSource` to the enumeration values exposed in the static resource `fruits`.  Then we bind the `SelectedItem` to the person's `FavoriteFruit` property.  The entire control would be:

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
    <UserControl.Resources>
        <ObjectDataProvider x:Key="fruits" MethodName="GetValues" ObjectType="{x:Type system:Enum}">
            <ObjectDataProvider.MethodParameters>
                <x:Type TypeName="local:Fruit"/>
            </ObjectDataProvider.MethodParameters>
        </ObjectDataProvider>
    </UserControl.Resources>
    <StackPanel>
        <TextBlock Text="{Binding Path=FullName}"/>
        <Label>First</Label>
        <TextBox Text="{Binding Path=First}"/>
        <Label>Last</Label>
        <TextBox Text="{Binding Path=Last}"/>
        <CheckBox IsChecked="{Binding Path=IsCartoon}">
            Is a Looney Toon
        </CheckBox>
        <ListView ItemsSource="{Binding Source={StaticResource fruits}}" SelectedItem="{Binding Path=FavoriteFruit}"/>
    </StackPanel>
</UserControl>
```

### Binding a ComboBox to an Enum

Binding a `<ComboBox>` is almost identical to the `ListView` example; we just swap a `ComboBox` for a `ListView`:

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
    <UserControl.Resources>
        <ObjectDataProvider x:Key="fruits" MethodName="GetValues" ObjectType="{x:Type system:Enum}">
            <ObjectDataProvider.MethodParameters>
                <x:Type TypeName="local:Fruit"/>
            </ObjectDataProvider.MethodParameters>
        </ObjectDataProvider>
    </UserControl.Resources>
    <StackPanel>
        <TextBlock Text="{Binding Path=FullName}"/>
        <Label>First</Label>
        <TextBox Text="{Binding Path=First}"/>
        <Label>Last</Label>
        <TextBox Text="{Binding Path=Last}"/>
        <CheckBox IsChecked="{Binding Path=IsCartoon}">
            Is a Looney Toon
        </CheckBox>
        <ComboBox ItemsSource="{Binding Source={StaticResource fruits}}" SelectedItem="{Binding Path=FavoriteFruit}"/>
    </StackPanel>
</UserControl>
```

#### Binding RadioButtons to an Enum

Binding a `<RadioButton>` requires a very different approach, as a radio button exposes an `IsChecked` boolean property that determines if it is checked, much like a `<CheckBox>`, but we want it bound to an enumeration property.  There are a lot of attempts to do this by creating a custom content converter, but ultimately they all have flaws.

Instead, we can restyle a `ListView` to _look_ like radio buttons, but still provide the same functionality by adding a `<Style>` that applies to the `ListViewItem` contents of the `ListView`:

```xml
<Style TargetType="{x:Type ListViewItem}">
    <Setter Property="Template">
        <Setter.Value>
            <ControlTemplate>
                <RadioButton Content="{TemplateBinding ContentPresenter.Content}" IsChecked="{Binding Path=IsSelected, RelativeSource={RelativeSource TemplatedParent}, Mode=TwoWay}"/>
            </ControlTemplate>
        </Setter.Value>
    </Setter>
</Style>
```

This style can be used in conjunction with a `ListView` declared as we did above:

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
    <UserControl.Resources>
        <ObjectDataProvider x:Key="fruits" MethodName="GetValues" ObjectType="{x:Type system:Enum}">
            <ObjectDataProvider.MethodParameters>
                <x:Type TypeName="local:Fruit"/>
            </ObjectDataProvider.MethodParameters>
        </ObjectDataProvider>
        <Style TargetType="{x:Type ListViewItem}">
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate>
                        <RadioButton Content="{TemplateBinding ContentPresenter.Content}" IsChecked="{Binding Path=IsSelected, RelativeSource={RelativeSource TemplatedParent}, Mode=TwoWay}"/>
                    </ControlTemplate>
                </Setter.Value>
            </Setter>
        </Style>
    </UserControl.Resources>
    <StackPanel>
        <TextBlock Text="{Binding Path=FullName}"/>
        <Label>First</Label>
        <TextBox Text="{Binding Path=First}"/>
        <Label>Last</Label>
        <TextBox Text="{Binding Path=Last}"/>
        <CheckBox IsChecked="{Binding Path=IsCartoon}">
            Is a Looney Toon
        </CheckBox>
        <ListView ItemsSource="{Binding Source={StaticResource fruits}}" SelectedItem="{Binding Path=FavoriteFruit}"/>
    </StackPanel>
</UserControl>
```