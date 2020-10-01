---
title: "Navigating the Tree"
pre: "3. "
weight: 30
date: 2018-08-24T10:53:26-05:00
---

When you first learned about trees, you also learned about tree traversal algorithms.  This is one reason that WPF is organized into a tree - the rendering process actually uses a tree traversal algorithm to determine how large to make each control!

You can also traverse the tree yourself, by exploring `Child`, `Children`, or `Parent` properties.  For example, if we needed to gain access to the `ListSwitcher` from the `ShoppingList` in the previous example, you could reach it by invoking:

```csharp
   ListSwitcher switcher = this.Parent.Parent.Parent as ListSwitcher;
```

In this example, `this` is our `ShoppingList`, the first `Parent` is the `Border` containing the `ShoppingList`, the second `Parent` is the `Grid` containing that `Border`, and the third `Parent` is the actual `ListSwitcher`.  We have to cast it to be a `ListSwitcher` because the type of the `Parent` property is a `DependencyObject` (a common base class of all controls).

Of course, this is a rather brittle way of finding an ancestor, because if we add any nodes to the element tree (perhaps move the `Grid` within a `DockPanel`), we'll need to rewrite it.  It would be better to use a loop to iteratively climb the tree until we find the control we're looking for.  This is greatly aided by the [`LogicalTreeHelper`](https://docs.microsoft.com/en-us/dotnet/api/system.windows.logicaltreehelper?view=netcore-3.1) library, which provides standardized static methods for accessing parents and children in the elements tree:

```csharp
// Start climing the tree from this node
DependencyObject parent = this;
do
{
    // Get this node's parent
    parent = LogicalTreeHelper.GetParent(parent);
}
// Invariant: there is a parent element, and it is not a ListSwitcher 
while(!(parent is null || parent is ListSwitcher));
// If we get to this point, parent is either null, or the ListSwitcher we're looking for
```

Searching the ancestors is a relatively easy task, as each node in the tree has only one parent.  Searching the descendants takes more work, as each node may have many children, with children of thier own.

This approach works well for complex applications with complex GUIs, where it is infeasible to keep references around.  However, for our simple application here, it might make more sense to refactor the `ShoppingList` class to keep track of the `ListSwitcher` that created it, i.e.:

```csharp
using System.Windows;
using System.Windows.Controls;

namespace ShopEasy
{
    /// <summary>
    /// Interaction logic for ShoppingList.xaml
    /// </summary>
    public partial class ShoppingList : UserControl
    {
        /// <summary>
        /// The ListSwitcher that created this list
        /// </summary>
        private ListSwitcher listSwitcher;

        /// <summary>
        /// Constructs a new ShoppingList
        /// </summary>
        public ShoppingList(ListSwitcher listSwitcher)
        {
            InitializeComponent();
            this.listSwitcher = listSwitcher;
        }

        /// <summary>
        /// Adds the item in the itemTextBox to the itemsListView
        /// </summary>
        /// <param name="sender">The object sending the event</param>
        /// <param name="e">The events describing the event</param>
        void AddItemToList(object sender, RoutedEventArgs e)
        {
            // Make sure there's an item to add
            if (itemTextBox.Text.Length == 0) return;
            // Add the item to the list
            itemsListView.Items.Add(itemTextBox.Text);
            // Clear the text box
            itemTextBox.Clear();
        }
    }
}
```

However, this approach now tightly couples the `ListSwitcher` and `ShoppingList` - we can no longer use the `ShoppingList` for other contexts without a `ListSwitcher`. 

If we instead employed the the traversal algorithm detailed above:


```csharp
using System.Windows;
using System.Windows.Controls;

namespace ShopEasy
{
    /// <summary>
    /// Interaction logic for ShoppingList.xaml
    /// </summary>
    public partial class ShoppingList : UserControl
    {
        /// <summary>
        /// The ListSwitcher that created this list
        /// </summary>
        private ListSwitcher listSwitcher { 
            get {
                DependencyObject parent = this;
                do
                {
                    // Get this node's parent
                    parent = LogicalTreeHelper.GetParent(parent);
                }
                // Invariant: there is a parent element, and it is not a ListSwitcher 
                while(!(parent is null || parent is ListSwitcher));
                return parent;
            }
        }

        /// <summary>
        /// Constructs a new ShoppingList
        /// </summary>
        public ShoppingList()
        {
            InitializeComponent();
        }

        /// <summary>
        /// Adds the item in the itemTextBox to the itemsListView
        /// </summary>
        /// <param name="sender">The object sending the event</param>
        /// <param name="e">The events describing the event</param>
        void AddItemToList(object sender, RoutedEventArgs e)
        {
            // Make sure there's an item to add
            if (itemTextBox.Text.Length == 0) return;
            // Add the item to the list
            itemsListView.Items.Add(itemTextBox.Text);
            // Clear the text box
            itemTextBox.Clear();
        }
    }
}
```

We could invoke the `listSwitcher` property to get the ancestor `ListSwitcher`.  If this control is being used without one, the value will be `Null`.