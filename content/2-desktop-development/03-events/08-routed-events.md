---
title: "Routed Events"
pre: "8. "
weight: 8
date: 2018-08-24T10:53:26-05:00
---

While events exist in Windows Forms, Windows Presentation Foundation adds a twist with their concept of _routed events_.  Routed events are similar to regular C# events, but provide additional functionality.  One of the most important of these is the ability of the routed event to "bubble" up the [elements tree]({{<ref "2-desktop-development/02-element-tree">}}).  Essentially, the event will be passed up each successive WPF element until one chooses to "handle" it, or the top of the tree is reached (in which case the event is ignored). 

Consider a Click event handler for a button.  In Windows Forms, we have to attach our listener _directly to the button_, i.e:

```csharp
namespace WindowsFormsApp1
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
            IncrementButton.Click += HandleClick;
        }

        private void HandleClick(object sender, EventArgs e)
        {
            // TODO: Handle our click
        }
    }
}
```

With WPF we can also attach an event listener directly to the button, but we can _also_ attach an event listener to an _ancestor_ of the button (a component further up the element tree).  The click event will "bubble" up the element tree, and each successive parent will have the opportunity to handle it.  I.e. we can define a button in the `ChildControl`:

```xml
<UserControl x:Class="WpfApp1.ChildControl"
             xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
             xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
             xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006" 
             xmlns:d="http://schemas.microsoft.com/expression/blend/2008" 
             xmlns:local="clr-namespace:WpfApp1"
             mc:Ignorable="d" 
             d:DesignHeight="450" d:DesignWidth="800">
    <Grid>
        <Button Name="IncrementButton">Count</Button>
    </Grid>
</UserControl>
```

And add an instance of `ChildControl` to our `MainWindow`:

```csharp
<Window x:Class="WpfApp1.MainWindow"
        xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        xmlns:d="http://schemas.microsoft.com/expression/blend/2008"
        xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"
        xmlns:local="clr-namespace:WpfApp1"
        mc:Ignorable="d"
        Title="MainWindow" Height="450" Width="800">
    <Grid Button.Click="HandleClick">
        <local:ChildControl/>        
    </Grid>
</Window>
```

Note that in our `<Grid>` we attached a `Button.Click` handler?  The attached listener, `HandleClick`, will be invoked for _all_ `Click` events arising from `Buttons` that are nested under the `<Grid>` in the elements tree.  We can then write this event handler in the codebehind of our `MainWindow`:

```csharp
namespace WpfApp1
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();
        }

        private void HandleClick(Object sender, RoutedEventArgs e)
        {
            if(e.OriginalSource is Button button && button.Name == "IncrementButton")
            {
                // TODO: Handle increment;

                e.Handled = true;
            }
        }
    }
}
```

Note that because this event listener will be triggered for _all_ buttons, we need to make sure it's a button we care about - so we cast the `OriginalSource` of the event to be a button and check its `Name` property.  We use the `RoutedEventArgs.OriginalSource` because the `sender` won't necessarily be the specific control the event originated in - in this case it actually is the `Grid` containing the button.  Also, note that we mark `e.Handled` as `true`.  This tells WPF it can stop "bubbling" the event, as we have taken care of it.

We'll cover routed events in more detail in the upcoming [Dependency Objects]({{<ref "2-desktop-development/05-dependency-objects">}}) chapter, but for now you need to know that the GUI events you know from Windows Forms (Click, Select, Focus, Blur), are all routed events in WPF, and therefore take a `RoutedEventArgs` object instead of the event arguments you may be used to. 