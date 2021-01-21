---
title: "Point of Sale Milestone #2 - Assignment Description"
pre: "10. "
weight: 100
date: 2018-08-24T10:53:26-05:00
---

{{% notice noiframe %}}
This textbook was authored for the **CIS 400 - Object-Oriented Design, Implementation, and Testing** course at Kansas State University.  This section describes assignments specific to that course.  If you are not enrolled in the course, please disregard this section.
{{% /notice %}}


### General requirements:

* You will need to follow the style laid out in the C# Coding Conventions

* You will need to comment your code using XML comments

* You will need to update your UML to reflect your current code

### Assignment requirements:

* Implement the INotifyPropretyChanged interface on all Entrees, Sides, and Drinks

* Write tests for all additions to the Data Library project

* Finalize the customization screens for Entrees, Sides, and Drinks

* Use databinding to modify the object you are customizing through the controls you have added to your custoization screen

* Update your UML Class Diagrams for:
  * Data Library
  * Point of Sale

(You don't need to create a UML of your test project, though you can if you like)

### Purpose:

This assignment is intended to familiarize you with the concept of databinding, especially:
1. How it depends on `PropertyChanged` events to work. 
2. How data binding is expressed in XAML (the Binding syntax)
3. How the `DataContext` property in WPF controls can be used to share a bound object

Additionally, this assignment should give you plenty of practice making WPF controls functional. This is also where your projects will really start to diverge from each other depending on the implementation route you choose to follow.

### Assignment Details

Most of this assignment is centered around the implementation of the `INotifyPropertyChanged` interface.  This needs to be implemented on each Side, Entree, and Drink.  Implementing the interface requires you to declare an event of type `PropertyChangedEventHandler` named `PropertyChanged`.  Doing this much satisifes the _letter_ of the `INotifyPropertyChanged` interface, but not the _intent_.

To satisfy the intent, you should also _invoke_ any event listeners registered with your `PropertyChanged` event handler _when one of the properties of the object changes_, with the details about that change.  You must do this for **ALL** properties that can change in your menu item classes (Hint: you can skip properties like the `ThugsTBone.Price`, which cannot change).

To verify that you have correctly implemented these properties, you need to write additional tests to check that the property does, indeed change. The [PropertyChange Assertion]({{<ref "/1-object-orientation/04-testing/05-xunit-assertions#property-change-assertions">}}) we discussed in the testing chapter is used for this purpose.  These tests should be placed in the unit test class corresponding to the menu item being tested.

Additionally, it is a good idea to test that the menu class implements the `INotifyPropertyChanged` interface.  This can be accomplished with the `IsAssignableFrom<T>(object obj)` [Type Assertion]({{<ref "/1-object-orientation/04-testing/05-xunit-assertions#type-assertions">}}).

Once you know you have your menu item classes (your entreees, sides, and drinks) ready, you can bind their properties to the controls you have created in your customization screens.  In addition, whenever you display the customization screen for a new item added to the order, you should set the screen's `DataContext` to be a new instance of that item.

With many controls, verifying your binding is working correctly may be difficult (as the control behaves the same either way).  Using breakpoints, or supplying an initialized object with properties changed from thier default to the binding are two ways of verifying.  This verification will become much easier when we add order tracking in the next milestone.

To summarize:

For each Entree, Side, and Drink class (i.e. `DoubleDragur`, `DragonBornWaffleFries`) you should:
* Implement the `INotifyPropertyChanged` interface found in the `System.ComponentModel` namespace.
* For each property of that class that changes (i.e. `Bun`, `Size`, `Flavor`, `Calories`), invoke the `PropertyChanged` event handler with the property name (i.e. `"Bun"`) whenever the property's value changes.
* In the unit test for each Entree, Side, and Drink class, verify that the class implements the `INotifyPropertyChanged` interface _and_ that all changing properties invoke the `PropertyChanged` method.
* In each of your customization screens from POS#1, make sure that you are binding the controls to the appropriate object, i.e. when the button for adding a Briarheart Burger is clicked, you should create a new instance of `BriarheartBurger` and set it as the `DataContext` property of the customization screen.  Further, the checkbox (or other control) representing the Bun should be bound to the `Bun` property of the burger. 