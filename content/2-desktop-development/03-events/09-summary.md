---
title: "Summary"
pre: "9. "
weight: 9
date: 2018-08-24T10:53:26-05:00
---

In this chapter we discussed the Windows Message Loop and Queue, and how messages provided to this loop are transformed into C# events by the `Application` class.  We examined C#'s approach to events, which is a more flexible form of message passing.  We learned how to write both C# event listeners and handlers, and how to invoke event handlers with `Invoke()`.  We also learned how to create and trigger our own custom events with custom event arguments.  

In addition, we learned about the `INotifyPropertyChanged` interface, and how it can be used to notify listeners that one of an Object's properties have changed through a `NotifyPropertyChanged` event handler.  We also saw how to test our implementations of `INotifyPropertyChanged` using xUnit.  In our next chapter on [Data Binding]({{<ref "2-desktop-development/04-data-binding">}}), we will see how this interface is used by Windows Presentation Foundation to update user interfaces automatically when bound data objects change.

Finally, we saw that Windows Presentation Foundation also uses Routed Events, which can bubble up the elements tree and be handled by any ancestor element.  This approach replaces many of the familiar UI events from Windows Forms.  We'll take a deeper look at this approach, including defining our own Routed Events and alternative behaviors like "tunnelling" down the elements tree in the upcoming [Dependency Objects]({{<ref "2-desktop-development/05-dependency-objects">}}) chapter.