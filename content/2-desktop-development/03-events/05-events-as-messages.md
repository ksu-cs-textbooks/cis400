---
title: "Events as Messages"
pre: "5. "
weight: 5
date: 2018-08-24T10:53:26-05:00
---

It might be coming clear that in many ways, events are another form of _message passing_, much like methods are.  The `EventArgs` define what the message contains, the `sender` specifies which object is sending the event, and the objects defining the event listener are the ones recieving it.

That last bit is the biggest difference between using an event to pass a message and using a method to pass the same message.  With a method, we always have one object sending and one object receiving.  In contrast, an event can have _no_ objects recieving, one object recieving, or _many_ objects receiving.  

An event is therefore a bit more flexible and open-ended.  We can determine which object(s) should recieve the message at any point - even at runtime.  In contrast, with a method we need to know what object we are sending the message to (i.e invoking the method of) as we write the code to do so.

Let's look at a concrete example of where this can come into play.
