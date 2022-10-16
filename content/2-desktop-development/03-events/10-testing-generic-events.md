---
title: "Testing Generic Events"
pre: "10. "
weight: 10
date: 2018-08-24T10:53:26-05:00
---

In the testing chapter, we introduced the XUnit assertion for testing events, `Assert.Raises<T>`.  Let's imagine a doorbell class that raises a `Ring` event when it is pressed, with information about the door, which can be used to do things like ring a physical bell, or send a text notification:


```csharp
/// <summary>
/// A class representing details of a ring event 
/// </summary>
public class RingEventArgs : EventArgs 
{
    private string _door;

    /// <summary>
    /// The identity of the door for which the doorbell was activated
    public string Door => _door;
    
    /// <summary>
    /// Constructs a new RingEventArgs 
    /// </summary>
    public RingEventArgs(string door) 
    {
      _door = door;
    }
}

/// <summary>
/// A class representing a doorbell
/// </summary>
public class Doorbell
{
    /// <summary>
    /// An event triggered when the doorbell rings 
    /// </summary>
    public event EventHandler<RingEventArgs> Ring;

    /// <summary>
    /// The name of the door where this doorbell is mounted 
    /// </summary>
    public string Identifier {get; set;}

    /// <summary>
    /// Handles the end of the incubation period 
    /// by triggering a Hatch event 
    /// </summary>
    public void Push() 
    {
        Ring?.Invoke(this, new RingEventArgs(Identifier));
    }
}
```

To test this doorbell, we'd want to make sure that the `Ring` event is invoked when the `Push()` method is called.  The `Assert.Raises<T>` does exactly this:

```csharp
[Fact]
public void PressingDoorbellShouldRaiseRingEvent
Doorbell db = new Doorbell();
Assert.Raises<RingEventArgs>(
  handler => db.Ring += handler,
  handler => db.Ring -= handler, 
  () => {
    db.Push();
  });
```

This code may be a bit confusing at first, so let's step through it.  The `<T>` is the type of event arguments we expect to receive, in this case, `RingEventArgs`.  The first argument is a lambda expression that attaches an event handler `handler` (provided by the `Assert.Raises` method) to our object to test, `db`.  The second argument is a lambda expression that removes the event handler `handler`.  The third is an action (also written as a lambda expression) that should trigger the event if the code we are testing is correct.

This approach allows us to test events declared with the generic `EventHandler<T>`, which is one of the reasons we prefer it.  It will not work with custom event handlers though; for those we'll need a different approach.

