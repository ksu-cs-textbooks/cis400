---
title: "Message Loops"
pre: "2. "
weight: 2
date: 2018-08-24T10:53:26-05:00
---

At the heart of every Windows program (and most operating systems), is an infinitely repeating loop we call the _message loop_ and a data structure we call a _message queue_ (some languages/operating systems use the term _event_ instead of _message_).  The message queue is managed by the operating system - it adds new events that the GUI needs to know about (i.e. a mouse click that occurred within the GUI) to this queue.  The message loop is often embedded in the main function of the program, and continuously checks for new messages in the queue.  When it finds one, it processes the message.  Once the message is processed, the message loop again checks for a new message.  The basic code for such a loop looks something like this:

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

In a WPF or Windows Forms application, this loop is buried in the [`Application`](https://docs.microsoft.com/en-us/dotnet/api/system.windows.application?view=netcore-3.1) class that the `App` inherits from.  Instead of writing the code to process these system messages directly, this class converts these messages into C# _events_, which are then consumed by the event listeners the programmer provides.  We'll look at these next.
