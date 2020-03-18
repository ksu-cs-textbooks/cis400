---
title: "Manual Data Binding"
pre: "2. "
weight: 2
date: 2018-08-24T10:53:26-05:00
---
To better understand the process of data binding, we will first explore the concept by building a data binding from scratch, instead of adopting the tools provided by WPF.  This can give us a far more thorough understanding of just how data binding works.

## Initial Project
We'll start with a simple WPF note-taking app.  This app consists of a data class `Note` which represents the note that is being taken, and a user interface class `NoteEditor`, which allows the note to be viewed and edited.

You can clone the starting project from the GitHub Classroom url provided in the Canvas Assignment (for students in the CIS 400 course), or directly from the GitHub [repo](https://github.com/ksu-cis/manual-data-binding.git) (for other readers).

### Note Class
Here is the starting point for our Note class:

```csharp
using System;

namespace ManualDataBinding.Data
{
    /// <summary>
    /// A class representing a note
    /// </summary>
    public class Note
    {
        /// <summary>
        /// The title of the Note
        /// </summary>
        public string Title { get; set; } = DateTime.Now.ToString();

        /// <summary>
        /// The text of the note
        /// </summary>
        public string Body { get; set; } = "";
    }
}
```

It is a very simple implementation, with two public properties `Title` and `Text`.  We take advantage of the [auto-implemented property notation](https://docs.microsoft.com/en-us/dotnet/csharp/programming-guide/classes-and-structs/auto-implemented-properties) to keep this code simple to write.

### NoteEditor Class
The `NoteEditor` is derived from the `UserControl` class, and is therefore a WPF component.  Here is the XAML code for the editor:

```xml
<UserControl x:Class="ManualDataBinding.UI.NoteEditor"
             xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
             xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
             xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006" 
             xmlns:d="http://schemas.microsoft.com/expression/blend/2008" 
             xmlns:local="clr-namespace:ManualDataBinding.UI"
             mc:Ignorable="d" 
             d:DesignHeight="450" d:DesignWidth="400">
    <Grid>
        <Grid.RowDefinitions>
            <RowDefinition Height="1*"/>
            <RowDefinition Height="10*"/>
        </Grid.RowDefinitions>
        <TextBox x:Name="Title" FontSize="30" TextAlignment="Center"/>
        <TextBox x:Name="Body" Grid.Row="1"/>
    </Grid>
</UserControl>
```
Our control is split into two rows using a grid.  The first row is relatively small, and contains a single `TextBox` where our note's title will be displayed.  The second row contains a second `TextBox` where the notes will be displayed.

### MainWindow Class
Finally, we have our `MainWindow` class, which contains an instance of our `NoteEditor` control with a name of "Editor" and three additional buttons, which we will use later to manipulate our data object.  Here is the XAML for the main window:

```XML
<Window x:Class="ManualDataBinding.MainWindow"
        xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        xmlns:d="http://schemas.microsoft.com/expression/blend/2008"
        xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"
        xmlns:local="clr-namespace:ManualDataBinding"
        xmlns:ui="clr-namespace:ManualDataBinding.UI"
        mc:Ignorable="d"
        Title="MainWindow" Height="500" Width="400">
    <Grid>
        <Grid.RowDefinitions>
            <RowDefinition/>
            <RowDefinition Height="50"/>
        </Grid.RowDefinitions>
        <Grid.ColumnDefinitions>
            <ColumnDefinition/>
            <ColumnDefinition/>
            <ColumnDefinition/>
        </Grid.ColumnDefinitions>
        <ui:NoteEditor x:Name="Editor" Grid.ColumnSpan="3"/>
        <Button Grid.Row="1">New Note</Button>
        <Button Grid.Row="1" Grid.Column="1">Mutate Note</Button>
        <Button Grid.Row="1" Grid.Column="2">Clear Note</Button>
    </Grid>
</Window>
```

**Note:** Because our `NoteEditor` control is defined in a different namespace than our `MainWindow` (ManualDataBinding.UI vs. ManualDataBinding); we must bring the namespace in with the `Window` namespace attribute:

```XML
xmlns:ui="clr-namespace:ManualDataBinding.UI"
```

And prefix the control's name with the corresponding namespace:

```XML
<ui:NoteEditor/>
```

## Making the Note available to the NoteEditor

In order to display a `Note` object in our `NoteEditor`, we must make it available to it.  One easy method for doing so is to add a property of type `Note` to the `NoteEditor` class.  In your _NoteEditor.xaml.cs_ (the backend file), add the new property (**Note:** As the `Note` class is defined in the `ManualDataBinding.Data` namespace, you'll need to add a `using ManaulDataBinding.Data;` statement to the top of the file):

```CSharp
    /// <summary>
    /// Interaction logic for NoteEditor.xaml
    /// </summary>
    public partial class NoteEditor : UserControl
    {
        /// <summary>
        /// The Note that will be edited
        /// </summary>
        public Note Note { get; set; }

    ...
```

Then we can jump to the component that creates our `NoteEditor` instance, the `MainWindow` class, and have it assign a `Note` instance to this new property.  We'll declare a private `Note` property at the top of our class:

```csharp
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        // Create the note to add to our Editor
        Note note = new Note();

    ...
```

Then assign it to `NoteEditor` in the constructor, just after the `InitializeComponent()` invocation.  It is critical that it is placed _after_ this method call, as the `InitializeComponent()` applies all of the layout supplied in the XAML code; before that point the `NoteEditor` we specified in the XAML _does not exist!_  We can access the `NoteEditor` by the name we gave it in the XAML, _Editor_.  

```csharp
        public MainWindow()
        {
            InitializeComponent();
            Editor.Note = note;
        }
```

To see our binding in action, we also want to create a couple of event listeners to respond to the `MainWindow`'s buttons, which will respectively switch to a new note, mutate the existing note, or clear the existing note.  Let's add these now:

```csharp
        /// <summary>
        /// Event handler to create a new note and apply it to the editor
        /// </summary>
        /// <param name="sender">The button clicked</param>
        /// <param name="e">The event arguments</param>
        public void OnNewNote(object sender, RoutedEventArgs e)
        {
            note = new Note();
            Editor.Note = note;
        }
```

Just as we did in the  `InitializeComponent()`, we create a new `Note` instance and assign it to our private `note` variable and the `Note` property of our `NoteEditor`.  This ensures that the buttons in `MainWindow` and the `NoteEditor` are both modifying the _same instance_ of `Note`.

```csharp
        /// <summary>
        /// Event handler to clear (erase) the text of the current note
        /// </summary>
        /// <param name="sender">The button clicked</param>
        /// <param name="e">The event arguements</param>
        public void OnClearNote(object sender, RoutedEventArgs e)
        {
            note.Body = "";
        }
```

This event handler is pretty simple; it just erases any body text in the underlying `Note` object.

```csharp
        /// <summary>
        /// Event handler to mutate the current note
        /// </summary>
        /// <param name="sender">The button clicked</param>
        /// <param name="e">The event arguements</param>
        public void OnMutateNote(object sender, RoutedEventArgs e)
        {
            note.Title = "Master Splinter:";
            note.Body = "There is no monster more dangerous than a lack of compassion.";
        }
```

Finally, the mutate button will replace the text and title with a quote from Master Splinter.

The last step here is to hook up these event handlers.  This can either be done in the XAML:

```XML
        <Button Click="OnNewNote"  Grid.Row="1">New Note</Button>
        <Button Click="OnMutateNote" Grid.Row="1" Grid.Column="1">Mutate Note</Button>
        <Button Click="OnClearNote" Grid.Row="1" Grid.Column="2">Clear Note</Button>
```

Or in the constructor.  In order to bind the event handler in the constructor, you must also give each button a `Name` attribute in the XAML so you can access it in the codebehind.

## Knowing when the Note Changes
As you might have guessed from the event handlers we just wrote, we will be changing the `Note` object _outside_ the `NoteEditor`.  When we do so, we want the `NoteEditor` to automatically update what it is displaying.  In other words, we need to send messages to the `NoteEditor` from the `Note` as it changes.

The key word _messages_ may have sparked an idea from our earlier discussion of _dispatch_ - after all, if a method is a form of message passing, can't we just create a method in our `NoteEditor` to take the change?  Something like:

```csharp
public void OnNoteChange(string title, string body)
{
    Title.Text = tile;
    Body.Text = body;
}
```

Then invoke the method from our event handlers with a line like:

```csharp 
    Editor.OnNoteChange("new title", "new body");
```

The short answer is "Yes, we can."  However, doing so is _brittle_, in the sense that if we want to make any changes to either class, it will likely require changing both.  And we won't be able to re-use our method with a new UI control; instead we'll have to write a brand-new method for it.  So it isn't a very reusable approach either.  

Instead, we want to adopt a more flexible approach.  A more generic message makes sense - one that says the Note is changing, without being coupled to the structure of the `Note` class.  And one that we can share with as many interested parties exist (including none).  C# already has a messaging pattern built-in that meets this need - _events!_  We can re-write our `OnNoteChange()` method as an event listener:

```csharp
        /// <summary>
        /// Event handler for when the Note changes
        /// </summary>
        /// <param name="sender">The Note instance that is changing</param>
        /// <param name="e">The event arguments describing the event</param>
        public void OnNoteChanged(object sender, EventArgs e)
        {
            if (Note == null) return; // Can't update a non-existant note
            Title.Text = Note.Title;
            Body.Text = Note.Body;
        }
```

Remember, we already have a reference to the `Note` object that is changing - so when we're notified it is changing, we can just update our `TextBox`es to reflect the new values. But beware, if the `Note` is null this will cause errors, so prevent that from happening with a null check.

Of course, we need to attach this event listener to an event handler.  Currently, the `Note` doesn't define one, so we'll need to add it.  We'll tackle that next.

### Adding an Event Hander to Note
Switching to our `Note` class, we'll add an event handler.  This is defined much like a field, but with the additon of an _event_ keyword:

```csharp
        /// <summary>
        /// An event handler triggered when this note changes
        /// </summary>
        public event EventHandler NoteChanged;
```

Just like fields and properties, event handers can have an access modifier (_public_, _protected_, or _private_) applied.  

It has a type.  In this case, we're using the generic [EventHandler](https://docs.microsoft.com/en-us/dotnet/api/system.eventhandler?view=netframework-4.8) type, but we could also use the templated [EventHandler<TEventArgs>](https://docs.microsoft.com/en-us/dotnet/api/system.eventhandler-1?view=netframework-4.8) to couple our event handler to a specific kind of event arguments.  

And finally, it has a name.  We're using the name `NoteChanged` here.

### Invoking the Event Handler
Now we need to trigger (invoke) this event handler whenever a change is made to our `Note` class.  Think about our `Note` class.  When does it change?

If you said _when we set the `Title` or `Text` property_ you're right.  This happens in the set method of the property.  So we would want to add our event handler invocation there.  Unfortunately, this means we can no longer use the auto-implemented properties, so we'll have to switch to using a private backing variable.

Let's start with the `Title` property.  We create a private backing variable named `title` and move our initialization to it:

```csharp
        private string title = DateTime.Now.ToString();
```

Then we rewrite our `Title` property:

```csharp
        /// <summary>
        /// The title of the Note
        /// </summary>
        public string Title 
        {
            get { return title; } 
            set
            {
                if (value == title) return;
                title = value;
                NoteChanged?.Invoke(this, new EventArgs());
            } 
        } 

```
The `get` should be familiar, we're just returning the value of the private backing variable.  But the `set` has some new ideas in it.  Let's break down what we are doing line-by-line.  

```csharp
if(value == title) return;
```
First, we're seeing if our change is _really_ a change, or if our title is being set to its current value.  If the two are the same, then we really don't need to do anything, so we use a `return` to stop execution of the `set` method, skipping the rest of the lines.  This is a little optimization, as we won't trigger any event handlers for what is really a non-existent change.  If we omitted this line, everything would still work.  But our program would be just a little bit slower.

```csharp
title = value;
```
This line is clearly important, it's what actually changes our property, by assigning the `value` argument to our private backing variable.  We also want to make sure this is done _before_ we invoke our events.

```csharp
NoteChanged?.Invoke(this, new EventArgs());
```
This last line actually creates and sends the event to any event listeners that are attached to the event handler `NoteChanged`.  If no event listeners are attached, then `NoteChanged` will have a value of `null`, and calling the `Invoke()` method will cause an error.  The [null-conditional operator](https://docs.microsoft.com/en-us/dotnet/csharp/language-reference/operators/member-access-operators#null-conditional-operators--and-) syntax `?.` combines a null check with the calling of the `Invoke` method, and it's effectively the same as the code:

```csharp
if(NoteChanged != null)
{
    NoteChanged.Invoke(this, new EventArgs());
}
```
but is clearyly more concise.  Finally, the `Invoke()` method will trigger each attached event listener, one at a time.  Its arguments are passed as the parameters to those listeners.  We use `this` (our `Note` instance) as the `object sender`, as it is the one changing.  And we create a new `EventArgs` object to pass as the `EventArgs e` parameter.  

We'll need to make similar changes to the `Body` property:

```csharp
        private string body = "";
        /// <summary>
        /// The text of the note
        /// </summary>
        public string Body 
        {
            get { return body; } 
            set
            {
                if (value == body) return;
                body = value;
                NoteChanged?.Invoke(this, new EventArgs());
            }
        }
```

Now our `Note` class is ready to let other objects know when it changes.  We'll need to hook up the corresponding event listener, which we'll tackle next.

### Attaching the Event Listener
We need to switch back to our `NoteEditor` and hook up its event listener to our newly-created event handler.  We'll want to attach the event listener whenever a new Note is provided to the `NoteEditor`, and remove it when it is replaced.  The appropriate place is therefore the `NoteEditor.Note` property.  Once again, we'll need to replace the auto-initialied property syntax so we an do some custom logic:

```csharp
        private Note note;
        /// <summary>
        /// The Note that will be edited
        /// </summary>
        public Note Note
        {
            get { return note; }
            set
            {
                if (note == value) return;
                if(note != null) note.NoteChanged -= OnNoteChanged;
                note = value;
                if (note != null) note.NoteChanged += OnNoteChanged;
            }
        }
```

The private backing variable and `get` implementation should be familiar.  Let's walk through the `set` to make sure we understand what we're doing:

```csharp
if(note == value) return;
```
Much like we did with the properties in `Note`, we check to see if the new `Note` object is the one we already have.  If it is, we exit the `set` method with a `return`, skipping the rest of the code.

```csharp
if(note != null) note.NoteChanged -= OnNoteChanged;
```
Here we see if we already have a `Note` object stored in our private backing variable `note`.  If we do, we remove the event listener from it.  This is an important step, because if we don't remove the event listener from the old `Note` instance, the C# garbage collector will assume we're still using it, and keep it in memory.  We call this issue a [meomory leak](https://en.wikipedia.org/wiki/Memory_leak), and over time it can cause our program to run out of avaiable memory and crash.

Note that the _only_ way to change the private backing variable _note_ is through this _set_ method (at least, as we are writing it now).  So we can assume that if the `note` is not null, we have previously attached the event listener.

```csharp
note = value;
```
And here's the actual assignment of the private backing variable, followed by:

```csharp
if (note != null) 
{
```

A null check to see if our new note actually exists - remember, `null` is a valid value for our property.  If it does exist, we'll go ahead and

```csharp
    note.NoteChanged += OnNoteChanged;
```
attaching of the event handler.  This needs to be inside a null check as if we try to attach the event listener to the `null` object, we will cause an exception.

```csharp
    OnNoteChanged(note, new EventArgs());
```
We'll also _manually_ invoke the event listener, in order to upate the `NoteEditor`'s controls to display the current note's data.  Remember, attaching the event listener listens for _future_ changes; but we are attaching a new note _now_, which will probably have a different title and body.

Go ahead an run your program.  You should see the note update when you click the three buttons.

Congratulations - you've successfully created a one-way data binding from scratch!

## Two-Way Data Binding
Of course, our editor is not much use if it isn't changing the underlying data class when we update it.  We'll need to add event listeners to our `TextBlock`'s `TextChanged` event handler, and use these to update our `Note`:

```csharp
        /// <summary>
        /// Event handler for when the title changes
        /// </summary>
        /// <param name="sender">The TextBox that changed</param>
        /// <param name="e">The event args</param>
        public void OnTitleChanged(object sender, TextChangedEventArgs e)
        {
            Note.Title = Title.Text;
        }

        /// <summary>
        /// Event handler for when the body changes
        /// </summary>
        /// <param name="sender">The TextBox that changed</param>
        /// <param name="e">The event args</param>
        public void OnBodyChanged(object sender, TextChangedEventArgs e)
        {
            Note.Body = Body.Text;
        }
```

And, of course, we'll need to bind these in the XAML or in the `NoteEditor` constructor.

Try placing a breakpoint in your `Note.Body` property's `set` method and run your program.  Try editing the note body, and use the _step into_ command to follow your program's execution line-by-line.  When you edit the note, you should see:

1. The check for if `value == body`, which will be false
2. The setting of the `body` private backing variable
3. The invoking of the `NoteChanged` event handler

The last triggers the `OnNoteChanged()` event listener in the `NoteEditor` class, where we see:

4. The check for `Note == null`, which is false
5. The setting of the `Title.Text` property
6. The setting of the `Body.Text` property

These in turn trigger the `OnBodyChanged` and `OnTitleChanged` event handlers attached to the `Title` and `Body` `TextBoxes`, which seek to set the `Note.Body` and `Note.Title` again...

Because those properties haven't changed, our `value == body` checks return `true` this time, and exit those methods early, avoiding invoking the event handler again.  If we didn't have those in place, we might end up repeating steps 1-6 an infinite number of times!

Actually, we won't as there is a similar check built into the `TextBox` in that it doesn't trigger its `TextChanged` event handler if the new text value is the same as the old.  But it is easy to see how we could get ourselves into trouble if we aren't careful.

But at this point, you've set up manual two-way data binding from scratch!  Congratulations!