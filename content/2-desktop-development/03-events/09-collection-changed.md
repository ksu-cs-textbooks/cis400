---
title: "CollectionChanged"
pre: "9. "
weight: 9
date: 2018-08-24T10:53:26-05:00
---

The `PropertyChanged` event notifies us when a _property_ of an object changes, which covers most of our GUI notification needs.  However, there are some concepts that aren't covered by it - specifically, when an item is added or removed from a collection.  We use a different event, `NotifyCollectionChanged` to convey when this occurs.

### The INotifyCollectionChanged Interface

The `INotifyCollectionChanged` interface defined in the `System.Collections.Specialized` namespace indicates the collection implements the `NotifyCollectionChangedEventHandler`, i.e.:

```csharp 
public event NotifyCollectionChangedEventHandler? NotifyCollectionChanged;
```

And, as you would expect, this event is triggered any time the collection's contents change, much like the `PropertyChanged` event we discussed earlier was triggered when a property changed.  However, the `NotifyCollectionChangedEventArgs` provides a _lot_ more information than we saw with the `PropertyChangedEventArgs`,as you can see in the UML diagram below:

![UML or NotifyCollectionChangedEventArgs and PropertyChangedEventArgs](/images/2.3.9.1.png)  

With `PropertyChangedEventArgs` we simply provide the name of the property that is changing.  But with `NotifyCollectionChangedEventArgs`, we are describing both _what_ the change is (i.e. an Add, Remove, Replace, Move, or Reset), and what item(s) we affected.  So if the action was adding an item, the `NotifyCollectionChangedEventArgs` will let us know what item was added to the collection, and possibly at what position it was added at.

When implementing the `INotifyCollectionChanged` interface, you must supply a <a href="https://docs.microsoft.com/en-us/dotnet/api/system.collections.specialized.notifycollectionchangedeventargs?view=net-5.0" target="_blank">`NotifyCollectionChangedEventArgs` object</a> that describes the change to the collection.  This class has multiple constructors, and you must select the correct one, or your code will cause a runtime error when the event is invoked.

{{% notice info %}}
You might be wondering why `PropertyChangedEventArgs` contains so little information compared to `NotifyCollectionChangedEventArgs`.  Most notably, the _old_ and _new_ values of the property could have been included. I suspect the reason they were not is that there are many times where you don't actually need to know what the property value is - just that it changed, and you can always retrieve that value once you know you need to. 

In contrast, there are situations where a GUI displaying a collection may have hundreds of entries. Identifying _exactly_ which ones have changed means that only those entries need to be modified in the GUI.  If we didn't have that information, we'd have to retrieve the _entire_ collection and re-render it, which can be a very computationally expensive process.

But ultimately, the two interfaces were developed by different teams at different times, which probably accounts for most of the differences.
{{% /notice %}}

#### NotifyCollectionChangedAction

The only property of the `NotifyCollectionChangedArgs` that will _always_ be populated is the `Action` property.  The type of This property is the `NotifyCollectionChangedAction` enumeration, and its values (and what they represent) are:
* `NotifyCollectionChangedAction.Add` - one or more items were added to the collection
* `NotifyCollectionChangedAction.Move` - an item was moved in the collection
* `NotifyCollectionChangedAction.Remove` - one or more items were removed from the collection
* `NotifyCollectionChangedAction.Replace` - an item was replaced in the collection
* `NotifyCollectionChangedAction.Reset` - drastic changes were made to the collection

#### NotifyCollectionChangedEventArgs Constructors

A second feature you probably noticed from the UML is that there are a _lot_ of constructors for the `NotifyCollectionChangedEventArgs`.  Each represents a different situation, and you must pick the appropriate one.

For example, the `NotifyCollectionChangedEventArgs(NotifyCollectionChangedAction)` constructor represents a `NotifyCollectionChangedAction.Reset` change. This indicates the collection's content changed _dramatically_, and the best recourse for a GUI is to ask for the full collection again and rebuild the display.  You should _only_ use this one-argument constructor for a Reset action.

{{% notice warning %}}
In C#, there is no mechanism for limiting a constructor to specific argument values. So you actually _can_ call the above constructor for a different kind of event, i.e.:

```csharp
new NotifyCollectionChangedEventArgs(NotifyCollectionChangedAction.Add);
```

However, doing so will throw a `InvalidArgumentException` when the code is actually executed. 
{{% /notice %}}

In general, if you are adding or removing an `object`, you need to provide the `object` to the constructor. If you are adding or removing multiple objects, you will need to provide an `IList` of the affected objects.  And you may also need to provide the object's index in the collection. You can read more about the available constructors and their uses in the [Microsoft Documentation](https://learn.microsoft.com/en-us/dotnet/api/system.collections.specialized.notifycollectionchangedeventargs.-ctor?view=net-6.0#system-collections-specialized-notifycollectionchangedeventargs-ctor(system-collections-specialized-notifycollectionchangedaction-system-object)).



