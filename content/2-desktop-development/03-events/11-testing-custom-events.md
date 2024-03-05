---
title: "Testing Custom Events"
pre: "11. "
weight: 11
date: 2018-08-24T10:53:26-05:00
---

In the previous section, we discussed using XUnit's `Assert.Raises<T>` to test generic events (events declared with the `EventHandler<T>` generic).  However, this approach does not work with non-generic events, like `PropertyChanged` and `CollectionChanged`.  That is why XUnit provides an `Assert.PropertyChanged()` method.  Unfortunately, it does not offer a corresponding test for `CollectionChanged`.  So to test for this expectation we will need to write our own assertions.

To do that, we need to understand how assertions in the XUnit framework work.  Essentially, they test the truthfulness of what is being asserted (i.e. two values are equal, a collection contains an item, etc.).  If the assertion is not true, then the code raises an exception - specifically, a `XunitException` or a class derived from it. This class provides a `UserMessage` (the message you get when the test fails) and a `StackTrace` (the lines describing where the error was thrown). With this in mind, we can write our own assertion method.  Let's start with a simple example that asserts the value of a string is "Hello World":

```csharp
public static class MyAssert
{
  public class HelloWorldAssertionException: XunitException 
  {
      public HelloWorldAssertionException(string actual) : base($"Expected \"Hello World\" but instead saw \"{actual}\"") {}
  }

  public static void HelloWorld(string phrase)
  {
    if(phrase != "Hello World") throw new HelloWorldAssertionException(phrase);
  }
}
```

Note that we use the `base` keyword to execute the `XunitException` constructor as part of the `HelloWorldAssertionException`, and pass along the `string` parameter `actual`.  Then the body of the `XunitException` constructor does all the work of setting values, so the body of our constructor is empty.

Now we can use this assertion in our own tests:

```csharp
[Theory]
[InlineData("Hello World")]
[InlineData("Hello Bob")]
public void ShouldBeHelloWorld(string phrase)
{
  MyAssert.HelloWorld(phrase);
}
```

The first `InlineData` will pass, and the second will fail with the report `Expected "Hello World" but instead saw "Hello Bob"`.

This was of course, a silly example, but it shows the basic concepts.  We would probably never use this in our own work, as `Assert.Equal()` can do the same thing.  Now let's look at a more complex example that we _would_ use.

## Assertions for CollectionChanged

As we discussed previously, the `CollectionChanged` event cannot be tested with the Xunit `Assert.Throws`.  So this is a great candidate for custom assertions.  To be thorough, we should test _all_ the possible actions (and we would do this if expanding the Xunit library).  But for how we plan to use it, we really only need two actions covered - adding and removing items _one at a time_ from the collection.  Let's start with our exception definitions:

```csharp
public static class MyAssert
{
  public class NotifyCollectionChangedNotTriggeredException: XunitException 
  {
      public NotifyCollectionChangedNotTriggeredException(NotifyCollectionChangedAction expectedAction) : base($"Expected a NotifyCollectionChanged event with an action of {expectedAction} to be invoked, but saw none.") {}
  }

  public class NotifyCollectionChangedWrongActionException: XunitException 
  {
      public NotifyCollectionChangedWrongActionException(NotifyCollectionChangedAction expectedAction, NotifyCollectionChangedAction actualAction) : base($"Expected a NotifyCollectionChanged event with an action of {expectedAction} to be invoked, but saw {actualAction}") {}
  }

  public class NotifyCollectionChangedAddException: XunitException 
  {
      public NotifyCollectionChangedAddException(object expected, object actual) : base($"Expected a NotifyCollectionChanged event with an action of Add and object {expected} but instead saw {actual}") {}
  }

  public class NotifyCollectionChangedRemoveException : XunitException
  {
    public NotifyCollectionChangedRemoveException(object expectedItem, int expectedIndex, object actualItem, int actualIndex) : base($"Expected a NotifyCollectionChanged event with an action of Remove and object {expectedItem} at index {expectedIndex} but instead saw {actualItem} at index  {actualIndex}") {}
  }
}
```

We have four different exceptions, each with a very specific message conveying what the failure was due to - no event being triggered, an event with the wrong action being triggered, or an event with the wrong information being triggered.  We could also handle this with one exception class using multiple constructors (much like the `NotifyCollectionChangedEventArgs` does).

Then we need to write our assertions, which are more involved than our previous example as 1) the event uses a generic type, so our assertion also must be a generic, and 2) we need to handle an event - so we need to attach an event handler, and trigger code that should make that event occur.  Let's start with defining the signature of the `Add` method:

```csharp
public static class MyAssert {

  public static void NotifyCollectionChangedAdd<T>(INotifyCollectionChanged collection, T item, Action testCode) 
  {
    // Assertion tests here.
  }
}
```

We use the generic type `T` to allow our assertion to be used with any kind of collection - and the second parameter `item` is _also_ this type.  That is the object we are trying to add to the `collection`.  Finally, the `Action` is the code the test will execute that would, in theory, add `item` to `collection`.  Let's flesh out the method body now:

```csharp
public static class MyAssert
{
  public static void NotifyCollectionChangedAdd<T>(INotifyCollectionChanged collection, T newItem, Action testCode)
  {
    // A flag to indicate if the event triggered successfully
    bool notifySucceeded = false;

    // An event handler to attach to the INotifyCollectionChanged and be 
    // notified when the Add event occurs.
    NotifyCollectionChangedEventHandler handler = (sender, args) =>
    {
      // Make sure the event is an Add event
      if (args.Action != NotifyCollectionChangedAction.Add)
      {
        throw new NotifyCollectionChangedWrongActionException(NotifyCollectionChangedAction.Add, args.Action);
      }

      // Make sure we added just one item
      if (args.NewItems?.Count != 1)
      {
        // We'll use the collection of added items as the second argument
        throw new NotifyCollectionChangedAddException(newItem, args.NewItems);
      }

      // Make sure the added item is what we expected
      if (!args.NewItems[0].Equals(newItem))
      {
        // Here we only have one item in the changed collection, so we'll report it directly
        throw new NotifyCollectionChangedAddException(newItem, args.NewItems[0]);
      } 

      // If we reach this point, the NotifyCollectionChanged event was triggered successfully
      // and contains the correct item! We'll set the flag to true so we know.
      notifySucceeded = true;
    };

    // Now we connect the event handler 
    collection.CollectionChanged += handler;

    // And attempt to trigger the event by running the actionCode
    // We place this in a try/catch to be able to utilize the finally 
    // clause, but don't actually catch any exceptions
    try
    {
      testCode();
      // After this code has been run, our handler should have 
      // triggered, and if all went well, the notifySucceed is true
      if (!notifySucceeded)
      {
        // If notifySucceed is false, the event was not triggered
        // We throw an exception denoting that
        throw new NotifyCollectionChangedNotTriggeredException(NotifyCollectionChangedAction.Add);
      }
    }
    // We don't actually want to catch an exception - we want it to 
    // bubble up and be reported as a failing test.  So we don't 
    // have a catch () {} clause to this try/catch.
    finally
    {
      // However, we *do* want to remove the event handler. We do 
      // this in a finally block so it will happen even if we do 
      // have an exception occur. 
      collection.CollectionChanged -= handler;
    }
  }
}
```

Now we can test this in our code.  For example, if we had a collection of `ShoppingList` objects named `shoppingLists` that implemented `INotifyCollectionChanged`, we could test adding a new shopping list, `shoppingList`, to it with:

```csharp
var newList = new ShoppingList();
MyAssert.NotifyCollectionChangedAdd(shoppingLists, newList, () => {
  shoppingLists.Add(newList);
});
```

Note that we didn't need to explicitly state `T` in this case is `ShoppingList` - the compiler infers this from the arguments supplied to the method.

Our assertion method handles adding a _single_ item. We can use method _overloading_ providing another method of the same name with different arguments to handle when _multiple_ items are added. For that case, the signature might look like:

```csharp
public static void NotifyCollectionChangedAdd<T>(INotifyCollectionChanged collection, ICollection<T> items, Action testCode) 
{
  // Assertion tests here.
}
```

We'd also want to write assertion methods for handling removing items, and any other actions we might need to test.  I'll leave these as exercises for the reader.