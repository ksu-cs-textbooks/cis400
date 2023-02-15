---
title: "Event Listeners"
pre: "3. "
weight: 3
date: 2018-08-24T10:53:26-05:00
---

In C#, we use _event handlers_ (sometimes called _event listeners_ in other languages) to register the behavior we want to happen in response to specific events.  You've probably already used these, i.e. declaring a handler:

```csharp
private void OnEvent(object sender, EventArgs e) {
    // TODO: Respond to the event
}
```

Most event handlers follow the same pattern.  They do not have a return value (their return type is `void`), and take two parameters.  The first is always an `object`, and it is the source of the event (hence "sender").  The second is an `EventArgs` object, or a class _descended_ from `EventArgs`, which provides details about the event.

For example, the various events dealing with mouse input (`MouseMove`, `MouseDown`, `MouseUp`) supply a [`MouseEventArgs`](https://docs.microsoft.com/en-us/dotnet/api/system.windows.forms.mouseeventargs?view=netcore-3.1) object.  This object includes properties defining the mouse location, number of clicks, mouse wheel rotations, and which button was involved in the event.

You've probably attached event handlers using the **"Properties"** panel in Visual Studio, but you can also attach them in code:

```csharp
Button button = new Button();
button.Click += OnClick;
```

Note you _don't include parenthesis_ after the name of the event handler.  You aren't _invoking_ the event handler, you're _attaching_ it (so it can be invoked in the future when the event happens).  Also, note that we use the `+=` operator to signify attaching an event handler.

This syntax is a deliberate choice to help reinforce the idea that we can attach _multiple_ event handlers in C#, i.e.:

```csharp
Button button = new Button();
button.Click += onClick1;
button.Click += onClick2;
```

In this case, _both_ `onClick1` and `onClick2` will be invoked when the button is clicked.  This is also one reason to attach event handlers programmatically rather than through the **"Properties"** window (it can only attach one).

We can also _remove_ an event handler if we no longer want it to be invoked when the event happens.  We do this with the `-=` operator:

```csharp
button.Click -= onClick1;
```

Again, note we use the handler's name without parenthesis.
