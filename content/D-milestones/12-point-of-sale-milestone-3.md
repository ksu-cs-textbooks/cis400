---
title: "Point of Sale Milestone #3 - Assignment Description"
pre: "12. "
weight: 120
date: 2018-08-24T10:53:26-05:00
---

{{% notice noiframe %}}
This textbook was authored for the **CIS 400 - Object-Oriented Design, Implementation, and Testing** course at Kansas State University.  This section describes assignments specific to that course.  If you are not enrolled in the course, please disregard this section.
{{% /notice %}}

### General requirements:

* You will need to follow the style laid out in the C# Coding Conventions

* Implement functionality for creating combos, Implement functionality for a concurrent receipt

### Assignment requirements:

* Implement functionality for creating a combo

* Implement functionality for building the order

* Write tests for added code to the data library

* Update UMLs

### Purpose:

This assignment is intended to help you gain a greater grasp of creating complex objects and collections, data binding, customizing controls, and more complex relationships between objects.

#### Implement functionality for creating a combo

Create a class in the Data project to represent a combination of `Drink`, `Side`, and `Entree`.  Any combination of items drawn from the three categories (and any customizations of those items) is possible.  The combo will also need to implement the `IOrderItem` interface. The `Calories` of the combo should be the sum of the calories of its constituent IOrderItems.  Similarly, the `Price` should be the sum of the prices of the items in the combo, with a $1.00 discount.  For the `SpecialInstructions` you should display the name of each part in the combo, and then its special instructions, i.e.:

`["BriarheartBurger", "Hold ketchup", "Hold cheese", "Large Fried Miraak", "Medium Decaf Candlehearth Coffee", "Add cream"]`

If you like, you can add indentation, a bullet, or other indicator to help provide context between what is an item and what is customization instructions.

And, like your other `IOrder` items, this class should implement the `INotifyPropertyChanged` interface, and correctly notify when one of the properties (`Drink`, `Side`, `Entree`, `Price`, or `Calories` changes).  I.e.:

* Adding a `Drink` to the order should trigger a `PropertyChanged` event for the `Drink`, `Price`, `Calories`, and `SpecialInstructions` properties
* Adding a `Side` to the order should trigger a `PropertyChanged` event for the `Side`, `Price`, `Calories`, and `SpecialInstructions` properties
* Adding a `Entree` to the order should trigger a `PropertyChanged` event for the `Entree`, `Price`, `Calories`, and `SpecialInstructions` properties
* If the `Price` property of an `IOrderItem` assigned to the `Drink`, `Side`, or `Entree` property changes, this should trigger a `PropertyChanged` event for the  combo's `Price` property
* If the `Calories` property of an `IOrderItem` assigned to the `Drink`, `Side`, or `Entree` property changes, this should trigger a `PropertyChanged` event for the  combo's `Price` property
* If the `SpecialInstructions` property of an `IOrderItem` assigned to the `Drink`, `Side`, or `Entree` property changes, this should trigger a `PropertyChanged` event for the  combo's `SpecialInstructions` property

Hint: as `Price` and `Calories` will change when the items added to combo change, it makes sense to add an event listener to these objects when they are assigned to the `Drink`, `Side`, and `Entree` properties.  This listener can be used to determine when they change, and then trigger the corresponding event for the combo.  Remember to _unassign_ that event listener when the `Drink`, `Side`, or `Entree` are changed for a different item, or you will create a memory leak!

As always, you should provide XML comments for the class as well as its events, properties, and methods.

Additionally, you will need to write a unit test for your combo class that should test all the functinality described above.  You will want to provide mock implementations for a `Drink`, `Side`, and `Entree` to use to ensure your unit test is truly isolated from your other code.

#### Implement functionality for the Order class

Also in the Data project, create an `Order` class to represent an order, which is a collection of `IOrderItems`.  You will need to create public `Add(IOrderItem item)` and `Remove(IOrderItem item)` methods, which add or remove `IOrderItems` respectively.  Additionally, you should implement a getter and setter for `SalesTaxRate` (a double, default 0.12) and getter-only properties for `Subtotal` (a double), `Tax` (a double), and `Total` (a double).  The `Subtotal` is the total price for all items in the order, the `Tax` is the `Subtotal` multiplied by the `SalesTaxRate`, and `Total` is the sum of the `Subtotal` and `Tax`.  It should also provide a property `Calories` which is a unsigned integer, and the sum of all the calories of the item sin the order.

Additionally, the `Order` should have an identifying `Number` getter property, which is unique to each order.  An easy way to ensure uniqueness is to have a private static field, i.e. `nextOrderNumber`, which is initalized to 1.  In the `Order` constructor, set this order's `Number` property to `nextOrderNumber` and then increment `nextOrderNumber`.  When your next order is created, it will use the incremented value, and increment it again. Technically this only ensures a single Point of Sale terminal is using uinque order numbers (as multiple terminals will have duplicate values), but it is sufficient for now.

This class should also implement the `ICollection`, `INotifyCollectionChanged`, and `INotifyPropertyChanged` interfaces.  Each of these requires you to add specific properties and methods to the `Order` class.  This also means triggering a host of events when specific actions are taken, i.e.:

* Adding an `IOrderItem` to the `Order` should trigger:
    1. A `CollectionChanged` event noting the addition of a new item 
    2. A `PropertyChanged` event noting the `Subtotal` property has changed 
    3. A `PropertyChanged` event noting the `Tax` property has changed
    4. A `PropertyChanged` event noting the `Total` property has changed
    5. A `PropertyChagned` event noting the `Calories` property has changed 
* Removing an `IOrderItem` from the `Order` should trigger:
    1. A `CollectionChanged` event noting the addition of a new item 
    2. A `PropertyChanged` event noting the `Subtotal` property has changed 
    3. A `PropertyChanged` event noting the `Tax` property has changed
    4. A `PropertyChanged` event noting the `Total` property has changed
    5. A `PropertyChanged` event noting the `Calories` property has changed 
* Changing an item already in the order should trigger:
    1. `PropertyChanged` events for `Subtotal`, `Tax`, and `Total` when the item's `Price` changes 
    2. A `PropertyChanged` event for `Calories` when the item's `Calories` changes

You may either write your collection class from scratch, or inherit from one of the existing collections and provide the extra functionality.  Additionally, you should write unit tests to verify all of the expected functionality (i.e. adding and removing an item to the `Order` results in that item being included in the order), and that each of the `CollectionChanged` and `PropertyChanged` events described above occur in the described circumstances.

#### Integrate the Order into the Point of Sale Project

The Point of Sale GUI's primary role is to build `Order` objects to match the customers' requests.  Thus, you will want to integrate your new `Order` class into the GUI to provide this fuctionality.  The easiest way to accomplish this is to set your `Order` as the `DataContext` of one of your WPF elements - ideally towards the top of the tree. Then, all of the descendant elements will _also_ have it as thier `DataContext`.

You should replace this `Order` object any time the "New Order" or "Cancel Order" button (depending on your implementation) are clicked.

Clicking on one of the "Add to Order" buttons you implemented should add an instance of the associated order item to the current `Order` object.

The contents of the current `Order` should be displayed prominently in your GUI, for example, by using a `<ListView>`.  You will want to display:
* The `IOrderItem`'s name (what you get when you invoke `ToString()` upon it)
* The `IOrderItem`'s price
* The `IOrderItem`'s special instructions

In addition, you will need to show:
* The `Order`'s `Number` property, formatted for readability, i.e. "Order #2"
* The `Order`'s `Subtotal` property, formatted for readability, i.e. "Subtotal: $10.00"
* The `Order`'s `Tax` property, formatted for readability, i.e. "Tax: $1.20"
* The `Order`'s `Total` property, formatted for readability, i.e. "Total: $11.20"

One possible layout appears below:

![Suggested Order control layout]({{<static "images/d.12.1.png">}})

The displayed order should update all of this displayed information as it changes.  If you use data binding for binding the `Order` properties, and have implemented the `CollectionChanged` and `PropertyChanged` events as described above, this should happen automatically, with no further code required from you.

You should also allow the user to select an item already in the order display to customize, i.e. if they have a Briar Heart Burger and a Sailor Soda in the Order, and then need to remove the cheese from the burger, they should be able to do so.  This is most easily accomplished by putting the order items in a `<ListBox>` and using its `OnSelectionChanged` event to swap to the customization screen.  Setting the List's `IsSynchronizedWithCurrentItem` to true allows you to bind your customization screens to the `CurrentItem` Path of the `Order`, i.e. the item just selected in the `<ListBox>`

Finally, you should provide a means for removing an item from the `Order`.  This is most commonly accomplished by adding a button to the `ListBoxItem` data template displaying the items in the `<ListBox>`, so that there is a delete buttton for each row in the order.  Another appraoch would be to have a single "Remove Selected Item from Order" which removes the item currently selected in the `<ListBox>`.  Other apporaches are possible, but should be easy for the user to intuit.

#### Writing Tests for Added Code

You need to ensure that you've written tests for the combo and order class, as specified in thier descriptions.  Try to reach a minimum of 95% code coverage. If you are having trouble testing some of your code, it is possible that your code can be simplified.  

If you are doing significant logic in your GUI code, this will need to be tested as well.  This is a good reason to take full advantage of data binding - when done well it pushes all the logic into your data classes, and exposes the results of that logic through properties that can be easily bound to your GUI with a minimum of code.  Following this approach means your unit tests focus on the data classes, and your GUI can be tested with simple visual verification (i.e. running the project and clicking through options).

#### Update Your UML Diagrams

You will need to update your UML diagrams to reflect the changes you have made to the Data and Point of Sale projects.  Remember to mark the associations between your `Order` and its various `IOrderItem` instances and your combo class and its various `IOrderItem` instances.  Hint: One of these relationships is _composition_, and the other _aggregation_.

