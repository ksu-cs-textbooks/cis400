---
title: "Dependency Properties"
pre: "2. "
weight: 2
date: 2018-08-24T10:53:26-05:00
---

Perhaps the most important aspect of the `DependencyObject` is its support for hosting _dependency properties_.  While these appear and can be used much like the C# properties we have previously worked with, internally they are managed very differently.  Consider when we place a `<TextBox>` in a `<Grid>`:

```xml
<Grid>
    <Grid.ColumnDefinitions>
        <ColumnDefinition/>
        <ColumnDefinition/>
    </Grid.ColumnDefinitions>
    <Grid.RowDefinitions>
        <RowDefinition/>
        <RowDefinition/>
    </Grid.RowDefinitions>
    <TextBox Name="textBox" Grid.Column="1" Grid.Row="1"/>
</Grid>
```

Where does the `Column` and `Row` properties come from?  They aren't defined on the `TextBox` class - you can [check the documentation](https://docs.microsoft.com/en-us/dotnet/api/system.windows.controls.textbox?view=netcore-3.1#properties).  The answer is they are made available through the dependency property system.

At the heart of this system is a collection of key/value pairs much like the `Dictonary`.  When the XAML code `Grid.Column="1"` is processed, this key and value are added to the `TextBox`'s dependency properties collection, and is thereafter accessible by the WPF rendering algorithm.

The `DependencyObject` exposes these stored values with the `GetValue(DependencyProperty)` and `SetValue(DependencyProperty, value)` methods.  For example, we can set the `Column` property to `2` with:

```csharp
textBox.SetValue(Grid.ColumnProperty, 2);
```

We can also create _new_ dependency properties on our own custom classes extending the `DependencyObject` (which is also a base class for all WPF controls).  Let's say we are making a custom control for entering number values on a touch screen, which we'll call `NumberBox`.  We can extend a `UserControl` to create a textbox centered between two buttons, one to increase the value, and one to decrease it:

```xml
<UserControl x:Class="CustomDependencyObjectExample.NumberBox"
             xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
             xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
             xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006" 
             xmlns:d="http://schemas.microsoft.com/expression/blend/2008" 
             xmlns:local="clr-namespace:CustomDependencyObjectExample"
             mc:Ignorable="d" 
             d:DesignHeight="50" d:DesignWidth="200">
    <Grid>
        <Grid.ColumnDefinitions>
            <ColumnDefinition/>
            <ColumnDefinition Width="2*"/>
            <ColumnDefinition/>
        </Grid.ColumnDefinitions>
        <Button Grid.Column="0">+</Button>
        <TextBox Grid.Column="1" />
        <Button Grid.Column="2">-</Button>
    </Grid>
</UserControl>
```

Now, let's assume we want to provide a property `Step` of type `double`, which is the amount the number should be incremented when the "+" or "-" button is pressed.

The first step is to _register_ the dependency property by creating a `DependencyProperty` instance.  This will serve as the key to setting and retrieving the dependency property on a dependency object.  We register new dependency properties with `DependencyProperty.Register(string propertyName, Type propertyType, Type dependencyObjectType)`.  The string is the name of the property, the first type is the type of the property, and the second is the class we want to associated this property with.  So our `Step` property would be registered with:

```csharp
DependencyProperty.Register("Step", typeof(double), typeof(NumberBox));
```

There is an optional fourth property to `DependencyProperty.Register()` which is a `PropertyMetadata`.  This is used to set the default value of the property.  We probably should specify a default step, so let's add a `PropertyMetadata` object with a default value of 1:

```csharp
DependencyProperty.Register("Step", typeof(double), typeof(NumberBox), new PropertyMetadata(1.0));
```

The `DependencyProperty.Register()` method returns a registered `DependencyObject` to serve as a key for accessing our new property.  To make sure we can access this key from _other_ classes, we define it as a field that is both `public` and `static`.  The convention is to name this field by appending "Property" to the name of the property.  The complete registration, including saving the result to the public static field is:

```csharp
/// <summary>
/// Identifies the NumberBox.Step XAML attached property
/// </summary>
public static DependencyProperty StepProperty = DependencyProperty.Register("Step", typeof(double), typeof(NumberBox), new PropertyMetadata(1.0)); 
```

We also want to declare a traditional property with the name "Value".  But instead of declaring a backing field, we will use the key/value pair stored in our `DependencyObject` using `GetValue()` and `SetValue()`:

```csharp
/// <summary>
/// The amount each increment or decrement operation should change the value by
/// </summary>
public double Step
{
    get { return (double)GetValue(StepProperty); }
    set { SetValue(StepProperty, value); }
}
```

As dependency property values are stored as an `object`, we need to cast the value to a the appropriate type when it is returned.

One of the great benefits of dependency properties is that they can be set using XAML.  I.e. we could declare an instance of our `<NumberBox>` and set its `Step` using an attribute:

```xml
<StackPanel>
    <NumberBox Step="3.0"/>
</StackPanel>
```
