---
title: "Declaring Events"
pre: "4. "
weight: 4
date: 2018-08-24T10:53:26-05:00
---

Up to this point, you've probably only used events that were defined on library objects, like the Button's Click event.  However, you can also declare events in your own classes, and even create new event types.

In order to attach an event handler to an object in C#, we must first declare that that object has the corresponding event.  To do so, we need both a _name_ for the event, and a _delegate_.

In C# a [Delegate](https://learn.microsoft.com/en-us/dotnet/csharp/programming-guide/delegates/) is a special type that represents a method with a specific method signature and return type. A delegate allows us to associate the delegate with any method that matches that signature and return type. For example, the `Click` event handler we discussed earlier is a delegate which matches a method that takes two arguments: an `object` and an `EventArgs`, and returns void.  Any event listener that we write that matches this specification can be attached to the `button.Click`.  In a way, a `Delegate` is like an `Interface`, only for methods instead of objects.

Consider a class representing an egg.  What if we wanted to define an event to represent when it hatched?  We'd need a delegate for that event, which can be declared a couple of ways.  The traditional method would be:

```csharp
public delegate void HatchHandler(object sender, EventArgs args);
```

And then in our class we'd declare the corresponding event. In C#, these are written much like a field, but with the addition of the `event` keyword:

```csharp 
public event HatchHandler Hatch;
```

Like a field declaration, an event declaration can have an access modifier (`public`, `private`, or `protected`), a name (in this case `Hatch`), and a type (the delegate).  It also gets marked with the `event` keyword.

When C# introduced generics, it became possible to use a generic delegate as well, `EventHandler<T>`, where the `T` is the type for the event arguments.  This simplifies writing an event, because we no longer need to define the delegate ourselves.  So instead of the two lines above, we can just use:

```csharp
public event EventHandler<EventArgs> Hatch;
```

The second form is increasingly preferred, as it makes testing our code much easier (we'll see this soon), and it's less code to write.  

### Custom EventArgs

We might also want to create our own custom event arguments to accompany the event.  Perhaps we want to provide a reference to an object representing the baby chick that hatched.  To do so we can create a new class that inherits from `EventArgs`:

```csharp
/// <summary>
/// A class representing the hatching of a chick 
/// </summary>
public class HatchEventArgs : EventArgs 
{
    /// <summary>
    /// The chick that hatched 
    /// </summary>
    public Chick Chick { get; protected set; }

    /// <summary>
    /// Constructs a new HatchEventArgs 
    /// </summary>
    /// <param name="chick">The chick that hatched</param>
    public HatchEventArgs(Chick chick) 
    {
        this.Chick = chick;
    }
}
```

And we use this custom event args in our event declaration as the type for the generic `EventHandler<T>` generic:

```csharp
public event EventHandler<HatchEventArgs> Hatch;
```

Now let's say we set up our `Egg` constructor to start a timer to determine when the egg will hatch:

```csharp
public Egg() 
{
    // Set a timer to go off in 20 days 
    // (ms = 20 days * 24 hours/day * 60 minutes/hour * 60 seconds/minute * 1000 milliseconds/seconds)
    var timer = new System.Timers.Timer(20 * 24 * 60 * 60 * 1000);
    timer.Elapsed += StartHatching;
}
```

In the event handler `StartHatching`, we'll want to create our new baby chick, and then trigger the `Hatch` event.  To do this, we need to _raise_ the event to pass to any attached handlers with `Hatch.Invoke()`, passing in both the event arguments and the source of the event (our egg):

```csharp
private void StartHatching(object source, ElapsedEventArgs e) 
{
    var chick = new Chick();
    var args = new HatchEventArgs(chick);
    Hatch.Invoke(this, args);
}
```

However we might have the case where there are no registered event handlers, in which case `Hatch` evaluates to `null`, and attempting to call `Invoke()` will cause an error.  We can prevent this by wrapping our `Invoke()` within a conditional:

```csharp
if(Hatch != null) {
    Hatch.Invoke(this, args);
}
```

However, there is a handy shorthand form for doing this (more syntactic sugar):

```csharp 
Hatch?.Invoke(this, args);
```

Using the question mark (`?`) before the method invocation is known as the [Null-condition operator](https://docs.microsoft.com/en-us/dotnet/csharp/language-reference/operators/member-access-operators#null-conditional-operators--and-). We use this to avoid calling the `Invoke()` method if `PropertyChanged` is null (which is the case if no event handlers have been assigned to it). It tests the object to see if it is null.  If it is null, the method is not invoked. 

{{% notice info %}}
You might be wondering why an event with no assigned event handlers is `Null` instead of some form of empty collection. The answer is rooted in efficiency - remember that each object (even empty collection) requires a certain amount of memory to hold its details.  Now think about all the possible events we might want to listen for in a GUI.  The [System.Windows.Controls.Control](https://docs.microsoft.com/en-us/dotnet/api/system.windows.controls.control?view=netcore-3.1#events) Class (a base class for all WPF controls) defines around 100 events.  Now multiply that by all the controls used in a single GUI, and you'll see that small amount of memory consumption adds up quickly.  By leaving unused events null, C# saves significant memory!
{{% /notice %}}

Thus, our complete egg class would be:

```csharp
/// <summary>
/// A class representing an egg 
/// </summary>
public class Egg 
{
    /// <summary>
    /// An event triggered when the egg hatches 
    /// </summary>
    public event EventHandler<HatchEventArgs> Hatch;

    /// <summary>
    /// Constructs a new Egg instance 
    /// </summary>
    public Egg() 
    {
        // Set a timer to go off in 20 days 
        // (ms = 20 days * 24 hours/day * 60 minutes/hour * 60 seconds/minute * 1000 milliseconds/seconds)
        var timer = new System.Timers.Timer(20 * 24 * 60 * 60 * 1000);
        timer.Elapsed += StartHatching;
    }

    /// <summary>
    /// Handles the end of the incubation period 
    /// by triggering a Hatch event 
    /// </summary>
    private void StartHatching(object source, ElapsedEventArgs e) 
    {
        var chick = new Chick();
        var args = new HatchEventArgs(chick);
        Hatch?.Invoke(this, args);
    }
}
```
