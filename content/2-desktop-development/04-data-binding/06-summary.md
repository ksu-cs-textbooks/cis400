---
title: "Summary"
pre: "6. "
weight: 6
date: 2018-08-24T10:53:26-05:00
---

In this chapter we explored the concept of data binding and how it is employed in Windows Presentation Foundation.  We saw how bound classes need to implement the `INotifyPropertyChanged` interface for bound properties to automatically synchronize. We saw how the binding is managed by a `Binding` class instance, and how we can customize its `Path`, `Mode`, and `Source` properties in XAML to modify the binding behavior.  We bound simple controls like `<TextBlock>` and `<CheckBox>` and more complex elements like `<ListView>` and `<ListBox>`.  We also explored how to bind enumerations to controls. And we explored the use of templates like `DataTemplate` and `ControlTemplate` to modify WPF controls.

The full example project discussed in this chapter can be found at [https://github.com/ksu-cis/DataBindingExample](https://github.com/ksu-cis/DataBindingExample).