---
title: "Event Handlers"
pre: "4. "
weight: 4
date: 2018-08-24T10:53:26-05:00
---

The _event handler_ is what triggers the event.  You've probably only used existing event handlers defined in GUI controls up to this point, but you can actually write your own as well.

Consider a class representing an egg.  What if we wanted to have an event that would be triggered when it hatched?  We could write our own custom event handler for this event!  In C#, these are written much like a field:

```csharp 
public event EventArgs Hatch;
```

Like a field, an event handler can have an access modifier (`public`, `private`, or `protected`), a name (in this case `Hatch`), and a type (`EventArgs` or one of its descendants).  It also gets marked with the `event` keyword.

We might also want to create our own custom event arguments to accompany the event.  Perhaps we want to provide the baby chick that hatched.  We can create a new class that inherits from `EventArgs`:

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
    /// Constructs a new HachEventArgs 
    /// </summary>
    /// <param name="chick">The chick that hatched</param>
    public HatchEventArgs(Chick chick) 
    {
        this.Chick = chick;
    }
}
```

Now let's say we set up our `Egg` constructor to start a timer to determine when the egg will hatch:

```csharp
public Egg() 
{
    // Set a timer to go off in 20 days 
    // (ms = 20 days * 24 hours/day * 60 minutes/hour * 60 seconds/minute * 1000 milliseconds/seconds)
    var timer = new System.Timers.Timer(20 * 24 * 60 * 60 * 1000);
    timer.Elapsed += startHatching;
}
```

In the event listener `startHatching`, we'll want to create our new baby chick, and then trigger the `Hatch` event.  To do this, we need to _invoke_ it on any attached listeners with `Hatch.Invoke()`, passing in both the event arguments and the source of the event (our egg):

```csharp
private void startHatching(object source, ElapsedEventArgs e) 
{
    var chick = new Chick();
    var args = new HatchEventArgs(chick);
    Hatch.Invoke(this, args);
}
```


However we might have the case where there are no registered event listeners, in which case `Hatch` evaluates to `null`, and attempting to call `Invoke()` will cause an error.  We can prevent this by wrapping our `Invoke()` within a conditional:

```csharp
if(Hatch !== null) {
    Hatch.Invoke(this, args);
}
```

However, there is a handy shorthand form for doing this (more syntatic sugar):

```csharp 
Hatch?.Invoke(this, args);
```

Using the question mark (`?`) before the method invocation is known as the [Null-condition operator](Notice that we use the  null-conditional operator [`?.`](https://docs.microsoft.com/en-us/dotnet/csharp/language-reference/operators/member-access-operators#null-conditional-operators--and-) to avoid calling the `Invoke()` method if `PropertyChanged` is null (which is the case if no event listeners have been assigned).  ).  It tests the object to see if it is null.  If it is null, the method is not invoked. 

{{% notice info %}}
You might be wondering why an event handler with no assigned events is `Null` instead of some form of empty collection. The answer is rooted in efficiency - remember that each object (even empty collection) requires a certain amount of memory to hold its details.  Now think about all the possible events we might want to listen for in a GUI.  The [System.Windows.Controls.Control](https://docs.microsoft.com/en-us/dotnet/api/system.windows.controls.control?view=netcore-3.1#events) Class (a base class for all WPF controls) defines around 100 events.  Now multiply that by all the controls used in a single GUI, and you'll see that small amount of memory consumption adds up quickly.  By leaving unused event handlers as null, .NET saves significant memory!
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
    public event EventArgs Hatch;

    /// <summary>
    /// Constructs a new Egg instance 
    /// </summary>
    public Egg() 
    {
        // Set a timer to go off in 20 days 
        // (ms = 20 days * 24 hours/day * 60 minutes/hour * 60 seconds/minute * 1000 milliseconds/seconds)
        var timer = new System.Timers.Timer(20 * 24 * 60 * 60 * 1000);
        timer.Elapsed += startHatching;
    }

    /// <summary>
    /// Handles the end of the incubation period 
    /// by triggering a Hatch event 
    /// </sumamry>
    private void startHatching(object source, ElapsedEventArgs e) 
    {
        var chick = new Chick();
        var args = new HatchEventArgs(chick);
        Hatch?.Invoke(this, args);
    }
}
```