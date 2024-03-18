---
title: "Framework Elements"
pre: "3. "
weight: 3
date: 2018-08-24T10:53:26-05:00
---

WPF controls are built on the foundation of dependency objects - the `DependencyObject` is at the bottom of their inheritance chain.  But they also add additional functionality on top of that through another common base class, `FrameworkElement`.  The `FrameworkElement` is involved in the layout algorithm, as well as helping to define the [elements tree]({{<ref "2-desktop-development/02-element-tree">}}).  Let's add a _second_ dependency property to our `<NumberBox>`, a `Value` property that will represent the value the `<NumberBox>` currently represents, which will be displayed in the `<TextBox>`.

We register this dependency property in much the same way as our `Step`.  But instead of supplying the `DependencyProperty.Register()` method a `PropertyMetadata`, we'll instead supply a `FrameworkPropertyMetadata`, which extends `PropertyMetadata` to include additional data about how the property interacts with the WPF rendering and layout algorithms.  This additional data is in the form of a bitmask defined in [FrameworkPropertyMetadataOptions](https://docs.microsoft.com/en-us/dotnet/api/system.windows.frameworkpropertymetadataoptions?view=netcore-3.1) enumeration.

Some of the possible options are:

* `FrameworkPropertyMetadataOptions.AffectsMeasure` - changes to the property may affect the size of the control
* `FrameworkPropertyMetadataOptions.AffectsArrange` - changes to the property may affect the layout of the control
* `FrameworkPropertyMetadataOptions.AffectsRender` - changes to the property may affect the appearance of the control
* `FrameworkPropertyMetadataOptions.BindsTwoWayByDefault` - This property uses two-way bindings by default (i.e. the control is an editable control)
* `FrameworkPropertyMetadataOptions.NotDataBindable` - This property does not allow data binding

In this case, we want a two-way binding by default, so we'll include that flag, and also we'll note that it affects the rendering process.  Multiple flags can be combined with a [bitwise OR](https://docs.microsoft.com/en-us/dotnet/csharp/language-reference/operators/bitwise-and-shift-operators#logical-or-operator-).  Constructing our `FrameworkPropertyMetadata` object would then look like:

```csharp
new FrameworkPropertyMetadata(0, FrameworkPropertyMetadataOptions.AffectsRender | FrameworkPropertyMetadataOptions.BindsTwoWayByDefault)
```

And registering the dependency property would be:

```csharp
/// <summary>
/// Identifies the NumberBox.Value XAML attached property
/// </summary>
public static readonly DependencyProperty ValueProperty = DependencyProperty.Register(nameof(Value), typeof(double), typeof(NumberBox), new FrameworkPropertyMetadata(0, FrameworkPropertyMetadataOptions.AffectsRender | FrameworkPropertyMetadataOptions.BindsTwoWayByDefault));
```

As with the `Step`, we also want to declare a traditional property with the name "Value".  But instead of declaring a backing field, we will use the key/value pair stored in our `DependencyObject` using `GetValue()` and `SetValue()`:

```csharp
/// <summary>
/// The NumberBox's displayed value
/// </summary>
public double Value {
    get { return (double)GetValue(ValueProperty); }
    set { SetValue(ValueProperty, value); }
}
```

If we want to display the current value of `Value` in the textbox of our `NumberBox` control, we'll need to bind the `<TextBox>` element's `Text` property.  This is accomplished in a similar fashion to the other bindings we've done previously, only we need to specify a `RelativeSource`.  This is a source relative to the control in the [elements tree]({{<ref "2-desktop-development/02-element-tree">}}).  We'll specify two properties on the `RelativeSource`: the `Mode` which we set to `FindAncestor` to search up the tree, and the `AncestorType` which we set to our `NumberBox`.  Thus, instead of binding to the `DataContext`, we'll bind to the `NumberBox` the `<TextBox>` is located within.  The full declaration would be:

```xml
<TextBox Grid.Column="1" Text="{Binding Path=Value, RelativeSource={RelativeSource Mode=FindAncestor, AncestorType=local:NumberBox}}"/>
```

Now a two-way binding exists between the `Value` of the `<NumberBox>` and the `Text` value of the textbox.  Updating either one will update the other.  We've in effect made an editable control!
