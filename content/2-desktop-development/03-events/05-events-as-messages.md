---
title: "Events as Messages"
pre: "5. "
weight: 5
date: 2018-08-24T10:53:26-05:00
---

It might be coming clear that in many ways, events are another form of _message passing_, much like methods are.  In fact, they are processed much the same way: the `Invoke()` method of the event handler _calls_ each attached event listener in turn. 

{{% notice tip %}}
Event invocation in C# is _synchronous_, just as is method calling - invoking an event listener passes execution to that method the same way calling a method hands program execution to the method.  Once they have finished executing, program execution continues back in the code that invoked the handler.  Let's see a practical example based on our discussion of the Hatch event.  If we were to give our chick a name:

```csharp
private void StartHatching(object source, ElapsedEventArgs e) 
{
    var chick = new Chick();
    var args = new HatchEventArgs(chick);
    Hatch?.Invoke(this, args);
    chick.Name = "Cluckzilla";
}
```

And in our event listener, we tried to print that name:

```csharp
private void OnHatch(object sender, HatchEventArgs e)
{
    Console.WriteLine($"Welcome to the world, {e.Chick.Name}!");
}
```

The `OnHatch` event listener would be triggered by the `Hatch?.Invoke()` line _before_ the name was set, so the `Chick.Name` property would be null!  We would need to move the name assignment to _before_ the `Invoke()` call for it to be available.
{{% /notice %}}

The `EventArgs` define what the message contains, the `sender` specifies which object is sending the event, and the objects defining the event listener are the ones receiving it.

That last bit is the biggest difference between using an event to pass a message and using a method to pass the same message.  With a method, we always have one object sending and one object receiving.  In contrast, an event can have _no_ objects receiving, one object receiving, or _many_ objects receiving.  

An event is therefore a bit more flexible and open-ended.  We can determine which object(s) should receive the message at any point - even at runtime.  In contrast, with a method we need to know what object we are sending the message to (i.e invoking the method of) as we write the code to do so.

Let's look at a concrete example of where this can come into play.
