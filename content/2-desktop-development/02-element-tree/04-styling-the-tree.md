---
title: "Styling the Tree"
pre: "4. "
weight: 40
date: 2018-08-24T10:53:26-05:00
---

Windows Presentation Foundation takes advantage of the elements tree in other ways.  One of the big ones is for styling related elements.  Let's say we are creating a calculator GUI:

```xml
<UserControl x:Class="Calculator.Calculator"
        xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        xmlns:d="http://schemas.microsoft.com/expression/blend/2008"
        xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"
        xmlns:local="clr-namespace:Calculator"
        mc:Ignorable="d"
        d:DesignWidth="450" d:DesignHeight="450">
    <Grid>
        <Grid.ColumnDefinitions>
            <ColumnDefinition/>
            <ColumnDefinition/>
            <ColumnDefinition/>
            <ColumnDefinition/>
        </Grid.ColumnDefinitions>
        <Grid.RowDefinitions>
            <RowDefinition/>
            <RowDefinition/>
            <RowDefinition/>
            <RowDefinition/>
            <RowDefinition/>
        </Grid.RowDefinitions>
        
        <Button Grid.Column="0" Grid.Row="1">7</Button>
        <Button Grid.Column="1" Grid.Row="1">8</Button>
        <Button Grid.Column="2" Grid.Row="1">9</Button>
        <Button Grid.Column="0" Grid.Row="2">4</Button>
        <Button Grid.Column="1" Grid.Row="2">5</Button>
        <Button Grid.Column="2" Grid.Row="2">6</Button>
        <Button Grid.Column="0" Grid.Row="3">7</Button>
        <Button Grid.Column="1" Grid.Row="3">8</Button>
        <Button Grid.Column="2" Grid.Row="3">8</Button>
        <Button Grid.Column="0" Grid.Row="4" Grid.ColumnSpan="3">0</Button>
        <Button Grid.Column="3" Grid.Row="1">-</Button>
        <Button Grid.Column="3" Grid.Row="2">-</Button>
        <Button Grid.Column="3" Grid.Row="3">*</Button>
        <Button Grid.Column="3" Grid.Row="4">/</Button>
    </Grid>
</Window>
``` 

Once we have the elements laid out, we realize the text of the buttons is too small.  Fixing this would mean setting the `FontSize` property of each `<Button>`.  That's a lot of repetitive coding. 

Thankfully, the XAML developers anticipated this kind of situation, and allow us to attach a `<Style>` resource to the control. We typically would do this above the controls we want to style - in this case, either on the `<Grid>` or the `<UserControl>`.  If we were to attach it to the `<Grid>`, we'd declare a `<Grid.Resources>` property, and inside it, a `<Style>`:

```xml
<Grid.Resources>
    <Style>
    </Style>
</Grid.Resources>
```

The `<Style>` element allows us to specify a `TargetType` property, which is the Type we want the style to apply to - in this case `"Button"`.  Inside the `<Style>` element, we declare `<Setter>` elements, which need `Property` and `Value` attribute.  As you might guess from the names, the `<Setter>` will set the specified property to the specified value on each element of the target type.  

Therefore, if we use:

```xml
<Grid.Resources>
    <Style TargetType="Button">
        <Setter Property="FontSize" Value="40"/>
    </Style>
</Grid.Resources>
```

The result will be that all buttons that are children of the `<Grid>` will have their `FontSize` set to `40` device-independent pixels.  We don't need to add a separate `FontSize="40"` to each one!  However, if we add `FontSize="50"` to a single button, that button alone will have a slightly larger font. 

We can declare as many `<Setters>` as we want in a `<Style>` element, and as many `<Style>` elements as we want in a `<.Resources>` element.  Moreover, styles apply to all children in the elements tree.  Closer setters override those farther up the tree, and setting the property directly on an element always gives the final say.

Thus, we might put application-wide styles directly in our `MainWindow` using `<Window.Resources>`, and override those further down the elements tree when we want a different behavior.

{{% notice info %}}
You may notice some similarities between `<Style>` elements and the _cascading style sheets (css)_ of web technologies. This is not surprising, as the styling approach used in WPF was inspired by CSS, much as XAML drew inspiration from HTML.  However, the implementation details are necessarily different, as XAML is effectively declaring C# objects.  Hence, the use of 'setters' to set 'properties' to a specific 'value'.
{{% /notice %}}