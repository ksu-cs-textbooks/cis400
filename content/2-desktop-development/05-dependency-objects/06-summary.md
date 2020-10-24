---
title: "Summary"
pre: "6. "
weight: 6
date: 2018-08-24T10:53:26-05:00
---

In this chapter we examined how dependency properties and routed events are implemented in WPF.  The `DependencyObject`, which serves as a base class for WPF elements, provides a collection of key/value pairs, where the key is a `DependencyProperty` and the value is the object it is set to.  This collection can be accessed through the `GetValue()` and `SetValue()` methods, and is also used as a backing store for regular C# properties.  We also saw that we can register callbacks on dependency properties to execute logic when the property is changed.  The `UIElement`, which also serves as a base class for WPF elements, provided similar functionality for registering routed event listeners, whose key is `RoutedEvent`.  We saw how these routed events could "bubble" up the elements tree, or "tunnel" down it, and how marking the event `Handled` property would stop it.  Finally, we discussed the MVVM architecture, which works well with WPF applications to keep our code managable.

We also created an example control using these ideas.  The full project can be found [here](https://github.com/ksu-cis/CustomDependencyObjectExample).
