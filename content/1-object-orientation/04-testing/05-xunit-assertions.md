---
title: "xUnit Assertions"
pre: "5. "
weight: 5
date: 2018-08-24T10:53:26-05:00
---

Like most testing frameworks, the xUnit framework provides a host of specialized assertions.  

## Boolean Assertions
For example, xUnit provides two boolean assertions:

* `Assert.True(bool actual)`, asserts that the value supplied to the `actual` parameter is `true`.
* `Assert.False(bool actual)`, asserts that the value supplied to the `actual` parameter is `false`.

While it may be tempting to use `Assert.True()` for all tests, i.e. `Assert.True(stove.BurnerOne == 0)`, it is better practice to use the specialized assertion that best matches the situation, in this case `Assert.Equal<T>(T expected, T actual)` as a failing test will supply more details. 

## Equality Assertions
The `Assert.Equal<T>(T expected, T actual)` is the workhorse of the assertion library. Notice it is a template method, so it can be used with any type that is comparable (which is pretty much everything possible in C#).  It also has an override, `Assert.Equal<T>(T expected, T actual, int precision)` which allows you to specify the precision for floating-point numbers.  Remember that floating point error can cause two calculated values to be slightly different than one another; specifying a precision allows you to say just how close the expected an actual value needs to be to be considered 'equal' for the purposes of the test.

Like most assertions, it is paired with an opposite, `Assert.NotEqual<T>(T expected, T actual)`, which also has an override for suppling precision.

## Numeric Assertions
With numeric values, it can be handy to determine if the value falls within a range:
* `Assert.InRange<T>(T actual, T low, T high)` asserts `actual` falls between `low` and `high` (inclusive), and 
* `Assert.NotInRange<T>(T actual, T low, T high)` asserts `actual` does not fall beween `low` and `high` (inclusive)

## Reference Assertions
There are special assertions to deal with null references:
* `Assert.Null(object object)` asserts the supplied `object` is null, and 
* `Assert.NotNull(object object)` asserts the supplied `object` is _not_ null

In addition, two objects may be considered equal, but may or may not the same object (i.e. not referencing the same memory).  This can be asserted with:
* `Assert.Same(object expected, object actual)` asserts the `expected` and `actual` object references are to the same object, while
* `Assert.NotSame(object expected, object actual)` asserts the `expected` and `actual` object references are _not_ the same object

## Type Assertions 
At times, you may want to assure it is possible to cast an object to a specific type.  This can be done with:
* `Assert.IsAssignableFrom<T>(object obj)`
Where `T` is the type to cast into.

At other times, you may want to assert that the object is _exactly_ the type you expect (.e. `T` is not an interface or base class of `obj`).  That can be done with:
* `Assert.IsType<T>(object obj)` 

## Collection Assertions
There are a host of assertions for working with collections:

* `Assert.Empty(IEnumerable collection)` asserts that the collection is empty, while 
* `Assert.NotEmpty(IEnumerable collection)` asserts that it is _not_ empty
* `Assert.Contains<T>(T expected, IEnumerable<T> collection)` asserts that the `expected` item is found in the `collection`, while 
* `Assert.DoesNotContain<T>(T expected, IEnumerable<T> collection)` asserts the `expected` item is _not_ found in the `collection`

Finally, `Assert.Collection<T>(IEnumerable<T> collection, Action<T>[] inspectors)` can apply specific inspectors against each item in a collection.  This bears a bit of explaination by way of a demonstration:

```csharp 
List<int> nums = new List<int>() {1, 2, 3};
Assert.Collection(nums, 
    item => Assert.Equal(1, item),
    item => Assert.Equal(2, item),
    item => Assert.Equal(3, item)
    );
```

Here we use an [Action<T> delegate](https://docs.microsoft.com/en-us/dotnet/api/system.action-1?view=netcore-3.1) to map each item in the collection to an assertion.  These actions are written using [lambda expressions], which are conceptually _functions_.  

The number of actions should correspond to the expected size of the collection, and the items supplied to the actions are in the order they appear in the collection.

## Exception Assertions
Error assertions _also_ use [Action<T> delegate](https://docs.microsoft.com/en-us/dotnet/api/system.action-1?view=netcore-3.1), in this case to execute code that is expected to throw an exception, i.e. we could test for `System.DivideByZeroException` with:

```csharp 
[Fact]
public void DivisionByZeroShouldThrowException() {
    Assert.Throws(System.DivideByZeroException, () => {
        var tmp = 10.0/0.0;
    });
}
```

Note how we place the code that is expected to throw the exception _inside_ the body of the Action?  This allows the assertion to wrap it in a `try/catch` internally.  The exception-related assertions are:

* `Assert.Throws(System.Exception expectedException, Action testCode)` asserts the supplied `expectedException` is thrown when `testCode` is executed 
* `Assert.Throws<T>(Action testCode) where T : System.Exception` the templated version of the above
* `Assert.ThrowsAny<T>(Action testCode) where T: System.Exception` asserts that _any_ exception will be thrown by the `testCode` when executed

There are also similar assertions for exceptions being thrown in _asynchronous_ code. These operate nearly identically, except instead of supplying an Action, we supply a [Task](https://docs.microsoft.com/en-us/dotnet/api/system.threading.tasks.task?view=netcore-3.1):
 
* `Assert.ThrowsAsync<T>(Task testCode) where T : System.Exception` asserts the supplied exception type `T` is thrown when `testCode` is executed 
* `Assert.ThrowsAnyAsync<T>(Task testCode) where T: System.Exception` is the asynchronous version

## Events Assertions 
Asserting that events will be thrown also invovles [Action<T> delegate](https://docs.microsoft.com/en-us/dotnet/api/system.action-1?view=netcore-3.1), and is a bit more involved as it requires _three_.  The first delegate is for attaching the assertion-supplied event handler to the listener, the second for detaching it, and the third is for triggering the event with the actual code involved.

For example, assume we have a class, `Emailer`, with a method `SendEmail(string address, string body)` that should have an event handler `EmailSent` whose event args are `EmailSentEventArgs`.  We could test that this class was actually raising this event with:

```csharp
[Fact]
public void EmailerShouldRaiseEmailSentWhenSendingEmails()
{
    string address = "test@test.com";
    string body = "this is a test";
    Emailer emailer = new Emailer();
    Assert.Raises<EmailSentEventArgs>(
        listener => emailer += listener, // This action attaches the listener
        listener => emailer -= listener, // This action detatches the listener 
        () => {
            emailer.SendEmail(address, body);
        }
    )
}
```

The various event assertions are:
* `Assert.Raises<T>(Action attach, Action detach, Action testCode)`
* `Assert.RaisesAny<T>(Action attach, Action detach, Action testCode)`

There are also similar assertions for events being raised by _asynchronous_ code.  These operate nearly identically, except instead of supplying an Action, we supply a [Task](https://docs.microsoft.com/en-us/dotnet/api/system.threading.tasks.task?view=netcore-3.1):
* `Assert.RaisesAsync<T>(Action attach, Action detach, Task testCode)`
* `Assert.RaisesAnyAsync<T>(Action attach, Action detach, Task testCode)`

## Property Change Assertions

Becuase C# has deeply integrated the idea of 'Property Change' notifications as part of its GUI frameworks (which we'll cover in a later chapter), it makes sense to have a special assertion to deal with this notification.  Hence, the `Assert.PropertyChanged(INotifyPropertyChanged @object, string propertyName, Action testCode)`.  Using it is simple - supply the object that implements the `INotifyPropertyChanged` interface as the first argument, the name of the property that will be changing as the second, and the Action delegate that will trigger the change as the third.  

For example, if we had a `Profile` object with a `StatusMessage` property that we knew should trigger a notification when it changes, we could write our test as:

```csharp 
[Fact]
public void ProfileShouldNotifyOfStatusMessageChanges() {
    Profile testProfile = new Profile();
    Assert.PropertyChanged(testProfile, "StatusMessage", () => testProfile.StatusMessage = "Hard at work");
}
```

There is also a similar assertion for testing if a property is changed in _asyncrhonous_ code. This operates nearly identically, except instead of supplying an Action, we supply a [Task](https://docs.microsoft.com/en-us/dotnet/api/system.threading.tasks.task?view=netcore-3.1):
* `Assert.PropertyChangedAsync(InotifyPropertyChanged @object, string propertyName, Task testCode)`
