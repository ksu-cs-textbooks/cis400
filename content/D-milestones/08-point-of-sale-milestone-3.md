---
title: "Point of Sale Milestone #3 - Assignment Description"
pre: "8. "
weight: 80
date: 2018-08-24T10:53:26-05:00
---

{{% notice noiframe %}}
This textbook was authored for the **CIS 400 - Object-Oriented Design, Implementation, and Testing** course at Kansas State University.  This section describes assignments specific to that course.  If you are not enrolled in the course, please disregard this section.
{{% /notice %}}

### General requirements:

* You will need to follow the style laid out in the C# Coding Conventions

* Implement functionality for a creating and updating an order

### Assignment requirements:

<!--* Implement functionality for creating a combo-->

* Implement a class representing an order

* Write unit tests for the order

* Add the functionality for creating, updating, and displaying the order to the point of sale

* Create a testing plan for your GUI

* Update UML Diagrams

### Purpose:

This assignment is intended to help you gain a greater grasp of creating complex objects and collections, data binding, customizing controls, and more complex relationships between objects.

#### Implement functionality for the Order class

In the Data project, create an `Order` class to represent an order, which is a collection of `IOrderItems`.  You will need to create public `Add(IOrderItem item)` and `Remove(IOrderItem item)` methods, which add or remove `IOrderItems` respectively.  Additionally, you should implement a getter and setter for `SalesTaxRate` (a double, default 0.12) and getter-only properties for `Subtotal` (a double), `Tax` (a double), and `Total` (a double).  The `Subtotal` is the total price for all items in the order, the `Tax` is the `Subtotal` multiplied by the `SalesTaxRate`, and `Total` is the sum of the `Subtotal` and `Tax`.  It should also provide a property `Calories` which is a unsigned integer, and the sum of all the calories of the item sin the order.

Additionally, the `Order` should have an identifying `Number` getter property, which is unique to each order.  An easy way to ensure uniqueness is to have a private static field, i.e. `nextOrderNumber`, which is initialized to 1.  In the `Order` constructor, set this order's `Number` property to `nextOrderNumber` and then increment `nextOrderNumber`.  When your next order is created, it will use the incremented value, and increment it again. Technically this only ensures a single Point of Sale terminal is using unique order numbers (as multiple terminals will have duplicate values), but it is sufficient for now.

Also, the `Order` should have a `DateTime` property `PlacedAt` identifying the date and time the order was placed.

Finally, this class should implement the `ICollection`, `INotifyCollectionChanged`, and `INotifyPropertyChanged` interfaces.  Each of these requires you to add specific properties and methods to the `Order` class.  This also means triggering a host of events when specific actions are taken, i.e.:

* Adding an `IOrderItem` to the `Order` should trigger:
    1. A `CollectionChanged` event noting the addition of a new item 
    2. A `PropertyChanged` event noting the `Subtotal` property has changed 
    3. A `PropertyChanged` event noting the `Tax` property has changed
    4. A `PropertyChanged` event noting the `Total` property has changed
    5. A `PropertyChanged` event noting the `Calories` property has changed 
* Removing an `IOrderItem` from the `Order` should trigger:
    1. A `CollectionChanged` event noting the addition of a new item 
    2. A `PropertyChanged` event noting the `Subtotal` property has changed 
    3. A `PropertyChanged` event noting the `Tax` property has changed
    4. A `PropertyChanged` event noting the `Total` property has changed
    5. A `PropertyChanged` event noting the `Calories` property has changed 
* Changing an item already in the order should trigger:
    1. `PropertyChanged` events for `Subtotal`, `Tax`, and `Total` when the item's `Price` changes 
    2. A `PropertyChanged` event for `Calories` when the item's `Calories` changes

You may either write your collection class from scratch, or inherit from one of the existing collections and provide the extra functionality (such as `ObservableCollection`).  

#### Order Unit Tests

Additionally, you should write unit tests to verify all of the expected functionality:
* Adding an item to the `Order` results in that item being included in the order
* Removing an item from the `Order` results in that item being removed from the order
* The order implements the `INotifyCollectionChanged` and `INotifyPropertyChanged` interfaces
* That adding an an item triggers a `CollectionChanged` event
* That removing an item triggers a `CollectionChanged` event
* That 
, and that each of the `CollectionChanged` and `PropertyChanged` events described above occur in the described circumstances.

#### Integrate the Order into the Point of Sale Project

The Point of Sale GUI's primary role is to build `Order` objects to match the customers' requests.  Thus, you will want to integrate your new `Order` class into the GUI to provide this functionality.  The easiest way to accomplish this is to set your `Order` as the `DataContext` of one of your WPF elements - ideally towards the top of the tree. Then, all of the descendant elements will _also_ have it as their `DataContext`.

You should replace this `Order` object any time the "New Order" or "Cancel Order" button (depending on your implementation) are clicked.

Clicking on one of the "Add to Order" buttons you implemented should add an instance of the associated order item to the current `Order` object.

The contents of the current `Order` should be displayed prominently in your GUI, for example, by using a `<ListView>`.  You will want to display:
* The `IOrderItem`'s name (what you get when you invoke `ToString()` upon it)
* The `IOrderItem`'s price
* The `IOrderItem`'s special instructions

_Hint: You can add a `StringFormat` attribute to a binding to display it as currency, i.e.:  `<TextBlock Text={Binding Path=Total, StringFormat={0:c}}>`. This approach can also be used to add bullets or extra text to a bound string before it is displayed.  See [the docs](https://docs.microsoft.com/en-us/dotnet/api/system.windows.data.bindingbase.stringformat?view=net-5.0) for more details._

In addition, you will need to show:
* The `Order`'s `Number` property, formatted for readability, i.e. "Order #2"
* The `Order`'s `PlacedDate` property, formatted for readability, i.e. "3/20/2021 10:32 pm"
* The `Order`'s `Subtotal` property, formatted for readability, i.e. "Subtotal: $10.00"
* The `Order`'s `Tax` property, formatted for readability, i.e. "Tax: $1.20"
* The `Order`'s `Total` property, formatted for readability, i.e. "Total: $11.20"

One possible layout appears below:

![Suggested Order control layout]({{<static "images/d.8.1.png">}})

The displayed order should update all of this displayed information as it changes.  If you use data binding for binding the `Order` properties, and have implemented the `CollectionChanged` and `PropertyChanged` events as described above, this should happen automatically, with no further code required from you.

You should also allow the user to select an item already in the order display to customize, i.e. if they have a Flying Saucer and a Eviscerated Eggs in the Order, and then need to change the syrup for the Flying Saucer, they should be able to do so.  This is most easily accomplished by putting the order items in a `<ListBox>` and using its `OnSelectionChanged` event to swap to the customization screen.  Setting the List's `IsSynchronizedWithCurrentItem` property to true allows you to bind your customization screens to the `CurrentItem` Path of the `Order`, i.e. the item just selected in the `<ListBox>`

Finally, you should provide a means for removing an item from the `Order`.  This is most commonly accomplished by adding a button to the `ListBoxItem` data template displaying the items in the `<ListBox>`, so that there is a delete button for each row in the order.  Another approach would be to have a single "Remove Selected Item from Order" which removes the item currently selected in the `<ListBox>`.  Other approaches are possible, but should be easy for the user to intuit.

#### Writing Tests for your GUI

Graphical user interfaces are notoriously difficult to test in an automated fashion.  For this reason, most software developers fall back on manual testing routines.  To ensure that these have the same rigor as automated tests, a _test plan_ document is written that tells a tester step-by-step what they should do in the interface, and what the expected result should be.  

You will need to write one for your GUI that takes the user through adding _each_ menu item to the order, and changing each of hte the menu item customization options.  At each step, you should call out for the user what the expected values appearing in the various GUI controls should be - especially the information in the order.  The testing plan should be saved in an editable format (Word is recommended) in the documentation folder of your project, and committed to GitHub with your source files.

A second strategy for testing GUIs in WPF is the MVVM (Model-View-ViewModel) architecture encouraged by WPF.  In this architecture, the GUI becomes little more than a thin layer for displaying and updating data-bound values.  If your control is doing significant logic, this instead is pushed to a _ModelView_ class, which can be unit tested like any other.  If your controls contain significant logic (i.e. calculations), you should consider refactoring to adopt this approach. 

#### Update Your UML Diagrams

You will need to update your UML diagrams to reflect the changes you have made to the Data and Point of Sale projects.  Remember to mark the associations between your `Order` and its various `IOrderItem` instances.

### Point of Sale Milestone 3 Rubric

Every assignment begins with 100 points, from which points are deducted using the following rubric.  If the total score is reduced to 0, then the assignment is assigned a grade of 0.

Comments
* -1 point for every public member (other than test methods) not commented using XML-Style comments, as is discussed in the [documentation chapter]({{<ref "1-object-orientation/03-documentation">}}).
* -1 point for every file not containing a header describing the file purpose and author(s). **Note: you do not need to include these in XAML files**

INotifyPropertyChanged implementation
* -10 points if the order class does not implement `INotifyPropertyChanged`
* -2 points for every property of the order that does not invoke `PropertyChanged` when its value changes (remember, this includes changing `Subtotal`, `Tax`, and `Total` when one of the items in the order changes, i.e. a `CrashedSaucer` being changed to half-stack).

DataBinding 
* -10 points if the order class is not bound to the Order Control
* -2 points for every customization screen that does not bind an instance of the corresponding menu item to the `DataContext` (this carries over from POS2, as it is vital to the order customization functionality)

Adding Items to the Order 
* -2 points for every menu item that is not added to the order when its button is clicked.

Removing Items from the Order 
* -2 points for every menu item that is not removable from the order through a button or other obvious mechanism

Customizing Items in the Order
* -2 points for every menu item that, when selected from the order, does not open a customization screen with that _specific_ menu item bound to its `DataContext`.

Order Details 
* -10 points if the subtotal does not update in sync with adding/removing/customizing order items 
* -10 point if the tax does not update in sync with adding/removing/customizing order items
* -10 points if hte total does not update in syn with adding/removing/customizing order items
* -10 points if the order # does not update with new orders or is missing
* -10 points if the order date/time does not update with new orders or is missing
* -2 points for every menu item missing special instructions from the order details

Testing
* -2 points if your order unit test that does not confirm the order implements `INotifyPropertyChanged`
* -2 points if your order unit test that does not confirm the order implements `INotifyCollectionChanged`
* -2 points for every missing test for checking if a property of the order changes
* -5 points if you are missing a test to ensure that if the price property of a menu item bound to the order changes, the `PropertyChanged` event is triggered for each of the appropriate properties (hint: this is an appropriate place to use a mock object)

Test Plan 
* -2 points for each control that does not have a documented or an insufficient manual test routine

UML Diagram
* -2 points for every missing or incorrect class
* -2 points for every missing or incorrect association

### Submissions

* Create a new release tag - Submit the release URL

  * Your release tag for this project should be a new minor version, i.e. if your first Point of Sale milestone was **v.1.0.0**, this release will be **v1.2.0**.

  * If you do not remember how to do this, please revisit the [Git Workflows]({{<ref "b-git-workflows/01-introduction">}})