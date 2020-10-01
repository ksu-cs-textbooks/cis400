---
title: "Event Loops"
pre: "2. "
weight: 2
date: 2018-08-24T10:53:26-05:00
---

At the heart of every event-driven program is an infinitly repeating loop we call the _event loop_ and a data structure we call an _event queue_ (some languages use the term _message_ instead of _event_).  The event queue is managed by the operating system - it adds new events that the GUI needs to know about (i.e. a mouse click that occured within the GUI) to this queue.  The event loop is often embedded in the main function of the program, and continously checks for new events.  When it finds one, it processes the event.  Once the event is processed, the event loop again checks for a new event.  The basic code for such a loop looks something like this:

```
function main
    initialize()
    while message != quit
        message := get_next_message()
        process_message(message)
    end while
end function
```

This approach works well for most GUIs as once the program is drawn initially (during the `initialize()` function), the appearance of the GUI will not change until it responds to some user action. 

In a WPF application, this loop is buried in the [`Application`](https://docs.microsoft.com/en-us/dotnet/api/system.windows.application?view=netcore-3.1) class that the `App` inherits from. 
