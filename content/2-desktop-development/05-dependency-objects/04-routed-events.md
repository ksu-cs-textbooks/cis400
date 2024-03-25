---
title: "Routed Events"
pre: "4. "
weight: 4
date: 2018-08-24T10:53:26-05:00
---

Another aspect of WPF elements are _routed events_.  Just as _dependency properties_ are similar to regular C# properties, but add additional functionality, _routed events_ are similar to regular C# events, but provide additional functionality.  One of the most important of these is the ability of the routed event to "bubble" up the [elements tree]({{<ref "2-desktop-development/02-element-tree">}}).  Essentially, the event will be passed up each successive WPF element until one chooses to "handle" it, or the top of the tree is reached (in which case the event is ignored).  This routed event functionality is managed by the [`UIElement`](https://docs.microsoft.com/en-us/dotnet/api/system.windows.uielement?view=netcore-3.1) base class, a third base class shared by all WPF elements.

Let's consider the two buttons we declared in our `<NumberBox>`.  When clicked, these each trigger a `Click` routed event.  We could attach a handler to each button, but it is also possible to instead attach it to any other element up the tree; for example, our `<Grid>`:

```xml
<UserControl x:Class="CustomDependencyObjectExample.NumberBox"
             xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
             xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
             xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"
             xmlns:d="http://schemas.microsoft.com/expression/blend/2008"
             xmlns:local="clr-namespace:CustomDependencyObjectExample"
             mc:Ignorable="d"
             d:DesignHeight="50" d:DesignWidth="200">
    <Grid Button.Click="HandleButtonClick">
        <Grid.ColumnDefinitions>
            <ColumnDefinition/>
            <ColumnDefinition Width="2*"/>
            <ColumnDefinition/>
        </Grid.ColumnDefinitions>
        <Button Grid.Column="0" Name="Increment">+</Button>
        <TextBox Grid.Column="1" Text="{Binding Path=Value, RelativeSource={RelativeSource Mode=FindAncestor, AncestorType=local:NumberBox}}"/>
        <Button Grid.Column="2" Name="Decrement">-</Button>
    </Grid>
</UserControl>
```

We'd need to define `HandleButtonClick` in our codebehind:

```csharp
/// <summary>
/// Handles the click of the increment or decrement button
/// </summary>
/// <param name="sender">The button clicked</param>
/// <param name="e">The event arguments</param>
void HandleButtonClick(object sender, RoutedEventArgs e)
{
    if(sender is Button button)
    {
        switch(button.Name)
        {
            case "Increment":
                Value += Step;
                break;
            case "Decrement":
                Value -= Step;
                break;
        }
    }
    e.Handled = true;
}
```

When either button is clicked, it creates a `Button.Click` event.  As the buttons don't handle it, the event bubbles to the next element in the elements tree - in this case, the `<Grid>`.  As the `<Grid>` _does_ attach a `Button.Click` listener, the event is passed to `HandleButtonClick`.  In this method we use the button's `Name` property to decide the correct action to take.  Also, note that we set the `RoutedEventArgs.Handled` property to `true`.  This lets WPF know that we've taken care of the event, and it does not need to bubble up any farther (if we didn't, we could process the event _again_ further up the elements tree).

Much like dependency properties, we can declare our own routed events.  These also use a `Register()` method, but for events this is a static method of the `EventHandler` class:  `EventManager.Register(string eventName, RoutingStrategy routing, Type eventHandlerType, Type controlType)`.  The first argument is a string, which is the name of the event, the second is one of the values from the `RoutingStrategy` enum, the third is the type of event handler, and the fourth is the type of the control it is declared in.  This `Register()` method returns a `RoutedEvent` that is used as a key when registering event listeners, which we typically store in a `public static readonly RoutedEvent` field.

The `RoutingStrategy` options are

* `RoutingStrategy.Bubble` - which travels up the elements tree through ancestor nodes
* `RoutingStrategy.Tunnel` - which travels down the elements tree through descendant nodes
* `RoutingStrategy.Direct` - which can only be handled by the source element

Let's create an example routed event for our `NumberBox`.  Let's assume we define two more routed properties `MinValue` and `MaxValue`, and that any time we change the value of our `NumberBox` it must fall within this range, or be clamped to one of those values.  To make it easer for UI designers to provide user feedback, we'll create a `NumberBox.ValueClamped` event that will trigger in these circumstances.  We need to register our new routed event:

```csharp
/// <summary>
/// Identifies the NumberBox.ValueClamped event
/// </summary>
public static readonly RoutedEvent ValueClampedEvent = EventManager.RegisterRoutedEvent(nameof(ValueClamped), RoutingStrategy.Bubble, typeof(RoutedEventHandler), typeof(NumberBox));
```

Also like dependency properties also need to declare a corresponding C# property, routed events need to declare a corresponding C# event:

```csharp
/// <summary>
/// Event that is triggered when the value of this NumberBox changes
/// </summary>
public event RoutedEventHandler ValueClamped
{
    add { AddHandler(ValueClampedEvent, value); }
    remove { RemoveHandler(ValueClampedEvent, value); }
}
```

Finally, we would want to raise this event whenever the value is clamped.  This can be done with the `RaiseEvent(RoutedEventArgs)` method defined on the `UIElement` base class that we inherit in our custom controls.  But where should we place this call?


You might think we would do this in the `HandleButtonClick()` method, and we could, but that misses when a user types a number _directly into the textbox_, as well as when `Value` is updated through a two-way binding.  Instead, we'll utilize the callback functionality available in the `FrameworkPropertyMetadata` for the `Value` property.  Since the dependency property and its metadata are both `static`, our callback also needs to be declared `static`:

```csharp
/// <summary>
/// Callback for the ValueProperty, which clamps the Value to the range
/// defined by MinValue and MaxValue
/// </summary>
/// <param name="sender">The NumberBox whose value is changing</param>
/// <param name="e">The event args</param>
static void HandleValueChanged(DependencyObject sender, DependencyPropertyChangedEventArgs e)
{
    if(e.Property.Name == "Value" && sender is NumberBox box)
    {
        if(box.Value < box.MinValue)
        {
            box.Value = box.MinValue;
            box.RaiseEvent(new RoutedEventArgs(ValueClampedEvent));
        }
        if(box.Value > box.MaxValue)
        {
            box.Value = box.MaxValue;
            box.RaiseEvent(new RoutedEventArgs(ValueClampedEvent));
        }
    }
}
```

Note that since this method is static, we must get the instance of the `NumberBox` by casting the `sender`.  We also double-check the property name, though this is not strictly necessary as the method is private and only we should be invoking it from within this class.  

Now we need to refactor our `Value` dependency property registration to use this callback:

```csharp
/// <summary>
/// Identifies the NumberBox.Value XAML attached property
/// </summary>
public static readonly DependencyProperty ValueProperty = DependencyProperty.Register("Value", typeof(double), typeof(NumberBox), new FrameworkPropertyMetadata(0, FrameworkPropertyMetadataOptions.AffectsRender | FrameworkPropertyMetadataOptions.BindsTwoWayByDefault, HandleValueChanged));
```

By adding the callback to the dependency property, we ensure that _any time it changes_, regardless of the method the change occurs by, we will ensure the value is clamped to the specified range.  

There are additional options for dependency property callbacks, including validation callbacks and the ability to coerce values.  See [the documentation](https://docs.microsoft.com/en-us/dotnet/desktop/wpf/advanced/dependency-property-callbacks-and-validation?view=netframeworkdesktop-4.8) for details.
