---
title: "The Elements Tree"
pre: "2. "
weight: 20
date: 2018-08-24T10:53:26-05:00
---

Consider the `ShoppingList` class we developed in the last chapter:

```xml
<UserControl x:Class="ShopEasy.ShoppingList"
             xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
             xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
             xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006" 
             xmlns:d="http://schemas.microsoft.com/expression/blend/2008" 
             xmlns:local="clr-namespace:ShopEasy"
             mc:Ignorable="d" 
             d:DesignHeight="450" d:DesignWidth="200">
    <DockPanel>
        <TextBlock DockPanel.Dock="Top" FontWeight="Bold" TextAlignment="Center">
            Shopping List For:
        </TextBlock>
        <TextBox DockPanel.Dock="Top" FontWeight="Bold" TextAlignment="Center" />
        <Button DockPanel.Dock="Bottom" Click="AddItemToList">Add Item To List</Button>
        <TextBox Name="itemTextBox" DockPanel.Dock="Bottom"/>
        <ListView Name="itemsListView" />
    </DockPanel>
</UserControl>
```

Each element in this XAML corresponds to an object of a specific Type, and the nesting of the elements implies a tree-like structure we call the [_element tree_](https://docs.microsoft.com/en-us/dotnet/desktop/wpf/advanced/trees-in-wpf?view=netframeworkdesktop-4.8).  We can draw this out as an actual tree:

![The elements tree for the ShoppingList component](/images/2.2.2.1.png)

The relationships in the tree are also embodied in the code.  Each element has either a `Child` or `Children` property depending on if it can have just one or multiple children, and these are populated by the elements defined in the XAML.  Thus, because the `<DockPanel>` has nested within it, a `<TextBlock>`, `<TextBox>`, `<Button>`, `<TextBox>`, and `<ListView>`, these are all contained in its `Children` Property.  In turn, the `<Button>` element has text as a child, which is implemented as another `<TextBlock>`.  Also, each component has a `Parent` property, which references the control that is its immediate parent.

In other words, all the WPF controls are effectively _nodes_ in a _tree data structure_.  We can modify this data structure by adding or removing nodes.  This is exactly what happens in the `ListSwitcher` control - when you click the "New List" button, or the "Prior" or "Next" button, you are swapping the subtree that is the child of its `<Border>` element:

![The elements tree for the ListSwitcher component](/images/2.2.2.2.png)

In fact, the entire application is one large tree of elements, with the `<Application>` as its root:

![ShopEasy App element tree](/images/2.2.2.3.png)



