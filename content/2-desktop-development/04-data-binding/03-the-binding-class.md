---
title: "The Binding Class"
pre: "3. "
weight: 3
date: 2018-08-24T10:53:26-05:00
---

In Windows Presentation Foundation, data binding is accomplished by a binding object that sits between the _binding target_ (the control) and the _binding source_ (the data object):

![The WPF Data Binding implementation](/images/2.4.3.1.png)

It is this [Binding](https://docs.microsoft.com/en-us/dotnet/api/system.windows.data.binding?view=windowsdesktop-6.0) object that we are defining the properties of in the XAML attribute with `"{Binding}"`.  Hence, `Path` is a property defined on this binding.  

As we mentioned before, bindings can be `OneWay` or `TwoWay` based on the direction the data flows.  The binding mode is specified by the `Binding` object's `Mode` property, which can also be set in XAML. There is actually a two additional options.  The first is a `OneWayToSource` that is basically a reversed one-way binding (the control updates the data object, but the data object does not update the control)   

For example, we actually _could_ use a `<TextEditor>` with a read-only property, if we changed the binding mode:

```xml
<TextEditor Text="{Binding Path=FullName Mode=OneWay}" />
```

Though this might cause your user confusion because they would _seem_ to be able to change the property, but the change would not actually be applied to the bound object.  However, if you _also_ set the `IsEnabled` property to false to prevent the user from making changes:

```xml
<TextEditor Text="{Binding Path=FullName Mode=OneWay}" IsEnabled="False" />
```

The second binding mode is `OneTime` which initializes the control with the property, but does not apply any subsequent changes.  This is similar to the behavior you will see from a data object that does not implement the `INotifyPropertyChanged` interface, as the `Binding` object depends on it to 

Generally, you'll want to use a control meant to be used with the mode you intend to employ - editable controls default to `TwoWay` and display controls to `OneWay`.

One other property of the `Binding` class that's good to know is the `Source` property.  Normally this is determined by the `DataContext` of the control, but you can override it in the XAML.