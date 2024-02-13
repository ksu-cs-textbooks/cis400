---
title: "C# Collections"
pre: "7. "
weight: 7
date: 2018-08-24T10:53:26-05:00
---

Collections in C# are a great example of polymorphism in action.  Many collections utilize [generics]("../1-object-orientation/06-advanced-csharp/05-generics") to allow the collection to hold an arbitrary type.  For example, the `List<T>` can be used to hold strings, integers, or even specific objects:

```csharp
List<string> strings = new List<string>();
List<int> ints = new List<int>();
List<Person> persons = new List<Person>();
```

We can also use an interface as the type, as we did with the `IJumpable` interface as we discussed in the [generics section]("../1-object-orientation/06-advanced-csharp/05-generics"), i.e.:

```csharp
List<IJumpable> jumpables = new List<IJumpable>();
jumpables.Add(new Kangaroo());
jumpables.Add(new Car());
jumpables.Add(new Kangaroo());
```

## Collection Interfaces

The C# language and system libraries also define a number of interfaces that apply to custom collections. Implementing these interfaces allows different kinds of data structures to be utilized in a standardized way.

### The IEnumerable&lt;T&gt; Interface

The first of these is the `IEnumerable<T>` interface, which requires the collection to implement one method:

* `public IEnumerator<T> GetEnumerator()`

Implementing this interface allows the collection to be used in a `foreach` loop.

### The ICollection&lt;T&gt; Interface

C# Collections also typically implement the `ICollection<T>` interface, which _extends_ the `IEnumerable<T>` interface and adds additional methods:

* `public void Add<T>(T item)` adds `item` to the collection
* `public void Clear()` empties the collection
* `public bool Contains(T item)` returns `true` if `item` is in the collection, `false` if not.
* `public void CopyTo(T[] array, int arrayIndex)` copies the collection contents into `array`, starting at `arrayIndex`.
* `public bool Remove(T item)` removes `item` from the collection, returning `true` if item was removed, `false` otherwise

Additionally, the collection must implement the following properties:

* `int Count` the number of items in the collection
* `bool IsReadOnly` the collection is read-only (can't be added to or removed from) 

### The IList&lt;T&gt; Interface

Finally, collections that have an implied order and are intended to be accessed by a specific index should probably implement the `IList<T>` interface, which extends `ICollection<T>` and `IEnumerable<T>`. This interface adds these additional methods:

* `public int IndexOf(T item)` returns the index of `item` in the list, or -1 if not found
* `public void Insert(int index, T item)` Inserts `item` into the list at position `index`
* `public void RemoveAt(int index)` Removes the item from the list at position `index`

The interface also adds the property:

* `Item[int index]` which gets or sets the item at `index`.

## Collection Implementation Strategies

When writing a C# collection, there are three general strategies you can follow to ensure you implement the corresponding interfaces:

1. Write the entire class by scratch
2. Implement the interface methods as a _pass-through_ to a system library collection 
3. Inherit from a system library collection

Writing collections from scratch was the strategy you utilized in CIS 300 - Data Structures and Algorithms.  While this strategy gives you the most control, it is also the most time-consuming.

The pass-through strategy involves creating a system library collection, such as a `List<T>`, as a private field in your collection class.  Then, when you implement the necessary interface methods, you simply _pass through_ the call to the private collection. I.e.:

```csharp
public class PassThroughList<T> : IList<T>
{
  private List<T> _list = new List<T>;

  public IEnumerator<T> GetEnumerator() 
  {
    return _list.GetEnumerator();
  } 

  // TODO: Implement remaining methods and properties...
}
```

Using this approach, you can add whatever additional logic your collection needs into your pass-through methods without needing to re-implement the basic collection functionality.

Using inheritance gives your derived class all of the methods of the base class, so if you extend a class that already implements the collection interfaces, you've already got all the methods!

```csharp
public class InheritedList<T> : List<T>
{
  // All IList<T>, ICollection<T>, and IEnumerable<T> methods 
  // from List<T> are already defined on InheritedList<T>
}
```

However, most system collection class methods are not declared as `virtual`, so you cannot override them to add custom functionality.