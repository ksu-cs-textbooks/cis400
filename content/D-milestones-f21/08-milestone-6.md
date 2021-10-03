---
title: "Milestone 6 Requirements"
pre: "8. "
weight: 80
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

* Implement the `INotifyPropertyChanged` interface on all Entrees, Sides, Drinks, and Treats

* Override the default `ToString()` method on all Entrees, Sides, Drinks, and Treats to supply a descriptive name for the item

* Write tests for all additions to the `Data` project

* Implement event listeners for the "Add to Order" buttons in the `MenuItemSelectionControl` and the  "Return to Menu" button in the `MainWindow`

* Use data binding to modify the object you are customizing through the controls you have added to your customization screen

* Update your UML Class Diagrams for:
  * Data Library
  * Point of Sale

(You don't need to create a UML of your test project, though you can if you like)

### Purpose:

This assignment is intended to familiarize you with the concept of data binding, especially:
1. How it depends on `PropertyChanged` events to work. 
2. How data binding is expressed in XAML (the Binding syntax)
3. How the `DataContext` property in WPF controls can be used to share a bound object

It also challenges you to make use of Routed Events to handle `Button.Click` events happening elsewhere in the elements tree.

Additionally, this assignment should give you plenty of practice making WPF controls functional. This is also where your projects will really start to diverge from each other depending on the implementation route you choose to follow.

### Assignment Details

#### Implementing INotifyPropertyChanged
Most of this assignment is centered around the implementation of the `INotifyPropertyChanged` interface.  This needs to be implemented on each Side, Entree, and Drink.  Implementing the interface requires you to declare an event of type `PropertyChangedEventHandler` named `PropertyChanged`.  Doing this much satisfies the _letter_ of the `INotifyPropertyChanged` interface, but not the _intent_.

To satisfy the intent, you should also _invoke_ any event listeners registered with your `PropertyChanged` event handler _when one of the properties of the object changes_, with the details about that change.  You must do this for **ALL** properties that can change in your menu item classes (Hint: you can skip properties like the `LibraLibation.Price`, which cannot change).

{{% notice warning %}}
Think carefully about the requirement of invoking `PropertyChanged` _when and where the property changes_.  Consider the `Price` property of a `Side`.  Where does it change?  It has no setter!  Remember, it is a _calculated_ value, and its value is dependent on the `Size` property.  So when the `Size` property changes, so does the `Price` property!  You must account for **all** the possible places in your class' code that trigger a property might change when you implement `INotifyPropertyChanged`.
{{% /notice %}}

#### Testing your INotifyPropertyChanged Implementation
To verify that you have correctly implemented these properties, you need to write additional tests to check that the property does, indeed change. The [PropertyChange Assertion]({{<ref "/1-object-orientation/04-testing/05-xunit-assertions#property-change-assertions">}}) we discussed in the testing chapter is used for this purpose.  These tests should be placed in the unit test class corresponding to the menu item being tested.

{{% notice info %}}
Remember that calculated properties will change _based on the property they are calculated from_, and you must also test for these.  I.e. on the sides, you might have a test method `PricePropertyChangedWhenSizeChanges(Size size)`.  Alternatively, you could combine multiple property checks into one test, i.e. `ShouldNotifyOfPropertyChangedWhenSizeChanges(Size size, string propertyName)` and supply the names of the separate properties through `[InlineData]`.
{{% /notice %}}

Additionally, it is a good idea to test that the menu item classes implements the `INotifyPropertyChanged` interface.  This can be accomplished with the `IsAssignableFrom<T>(object obj)` [Type Assertion]({{<ref "/1-object-orientation/04-testing/05-xunit-assertions#type-assertions">}}).

#### Override ToString()
Every C# object has a `ToString()` method that gives a textual representation of the object.  This is also used by WPF when you bind an object to a text control, like a `TextBox`.  The default behavior of `ToString()` is to give the fully-qualified name of the class, i.e. for a `VirgoClassicGyro` it would return `"GyroScope.Data.VirgoClassicGyro"`.  It is therefore a good idea to _override_ this behavior in our data classes to use a more human-readable name, i.e. `"Virgo Classic Gyro"`.  

Add an override method to each of your Entrees, Sides, Drinks, and Treats that matches the requirements in the table:

<table>
  <tr>
    <th>Class</th>
    <th>String</th>
    <th>Special</th>
  </tr>
  <tr>
    <td>VirgoClassicGyro</td>
    <td>Virgo Classic Gyro</td>
    <td></td>
  </tr>
  <tr>
    <td>LeoLambGyro</td>
    <td>Leo Lamb Gyro</td>
    <td></td>
  </tr>
  <tr>
    <td>ScorpioSpicyGyro</td>
    <td>Scorpio Spicy Gyro</td>
    <td></td>
  </tr>  
  <tr>
    <td>PiscesFishDish</td>
    <td>Pisces Fish Dish</td>
    <td></td>
  </tr>

  <tr>
    <td>TaurusTabouleh</td>
    <td>[Size] Taurus Tabouleh</td>
    <td>[Size] should be Small, Medium, or Large, to match the corresponding property value</td>
  </tr>
  <tr>
    <td>GeminiStuffedGrapeLeaves</td>
    <td>[Size] Gemini Stuffed Grape Leaves</td>
    <td>[Size] should be Small, Medium, or Large, to match the corresponding property value</td>
  </tr>
  <tr>
    <td>SagittariusGreekSalad</td>
    <td>[Size] Sagittarius Greek Salad</td>
    <td>[Size] should be Small, Medium, or Large, to match the corresponding property value</td>
  </tr>
  <tr>
    <td>AriesFries</td>
    <td>[Size] Aries Fries</td>
    <td>[Size] should be Small, Medium, or Large, to match the corresponding property value</td>
  </tr>
  
  <tr>
    <td>LibraLibation</td>
    <td>[Flavor] Libra Libation</td>
    <td>[Flavor] should be Orangeade, Sour Cherry, Biral, or Pink Lemonada to match the corresponding property value</td>
  </tr>
  <tr>
    <td>CapricornMountainTea</td>
    <td>Capricorn Mountain Tea</td>
    <td></td>
  </tr>

  
  <tr>
    <td>AquariusIce</td>
    <td>[Size] [Flavor] Aquarius Ice</td>
    <td>[Size] should be Small, Medium, or Large, to match the corresponding property value; [Flavor] should be the flavor name matching the corresponding property value</td>
  </tr>
  <tr>
    <td>CancerHalvaCake</td>
    <td>Cancer Halva Cake</td>
    <td></td>
  </tr>
</table>

#### Testing ToString() Implementation
You should add a test method named `ToStringShouldReturnExpectedValue()` to each of your Entree, Side, Drink, and Treat unit test classes to verify your `ToString()` implementation returns the expected value.  It may or may not need parameters (i.e. `size`, `flavor`), depending on the class in question.

#### Implement Event Listeners

You should implement one or more event listeners to handle when the user clicks on one of the buttons in your `MenuItemSelectionControl`.  This event listener should:

1. Create an instance of the appropriate Entree, Side, Drink, or Treat (based on which button was clicked)
2. Bind that instance as the `DataContext` of the corresponding customization control instance
3. Display that customization control instance in the `MainWindow`, replacing or covering up the `MenuItemSelectionControl`

Since the event you are listening for happens in the `MenuItemSelectionControl` but the displaying must happen in the `MainWindow`, you must decide which of these two locations you want to host the event listener.  If you choose the `MainWindow` you will be using a [Routed Event]({{<ref "2-desktop-development/03-events/07-routed-events">}}), i.e. `Button.Click`.  If you choose the `MenuItemsSelectionControl` you will need to climb the [Elements tree]({{<ref "2-desktop-development/02-element-tree/03-navigating-the-tree">}}) to reach the `MainWindow`.

#### Binding Customization Controls
Once you know you have your menu item classes (your entrees, sides, drinks, and treats) ready, you can bind their properties to the controls you have created in your customization screens.  Since you have set the screen's `DataContext` to be a new instance of that item (in the previous requirement), these controls will now directly modify the bound menu item object.

With many controls, verifying your binding is working correctly may be difficult (as the control behaves the same either way).  Using breakpoints, or supplying an initialized object with properties changed from their default to the binding are two ways of verifying. Alternatively, you can bind the same property to a display-only `<TextBlock>` in a summary section. This verification will become much easier when we add order tracking in the next milestone.

#### Updating your UML
Finally, update your UML to reflect the current state of your `Data` and `PointOfSale` projects.  

The `INotifyPropertyInterface` can be added like so:

![INotifyPropertyChanged UML]({{<static "images/d.7.1.png">}})

Because this is a _realization_ relationship, you will also need to add the event to your class boxes.  It should be placed in the second box (with your properties) and use the `event` stereotype, i.e.:

```
+PropertyChanged:PropertyChangedEventHandler <<event>>
```

Also, remember that any event listeners you have defined in your code behind in the `PointOfSale` project must be represented in your UML.  Also, any properties you have given a `x:Name` attribute in your XAML, i.e.:

```xml
<MainWindow>
  <Border x:Name="SwitchBorder">
  </Border>
</MainWindow>
```

Are _public properties_ and should therefore show up in your UML, i.e.:

```
+SwitchBorder:Border <<get, set>>
```

You do not need to show components defined in the XAML that do not have a `x:Name` property.

**Note: You do not need to create a UML diagram of your `DataTest` project, though you can if you want.**

## The Milestone Feature Branch 

You will want to [create a feature branch and push it to GitHub]({{<ref "D-milestones-f21/02-feature-branches">}}) for your validations to be generated on https://pendant.cs.ksu.edu.  For this milestone, your feature branch should be named `ms6`.  

## Submitting the Assignment

Once your project is complete, merge your feature branch back into the `main` branch and [create a release]({{<ref "B-git-and-github/11-release">}}) tagged `v0.6.0` with name `"Milestone 6"`.  Copy the URL for the release page and submit it to the Canvas assignment.

## Grading Rubric

The grading rubric for this assignment will be:

**20% Structure** Did you implement the structure as laid out in the specification?  Are the correct names used for classes, enums, properties, methods, events, etc?  Do classes inherit from expected base classes?

**20% Documentation** Does every class, method, property, and field use the correct XML-style documentation?  Does every XML comment tag contain explanatory text?

**20% Design** Are you appropriately using C# to create reasonably efficient, secure, and usable software?  Does your code contain bugs that will cause issues at runtime?

**20% Functionality** Does the program do what the assignment asks?  Do properties return the expected values?  Do methods perform the expected actions?

**20% UML Diagrams** Does your UML diagram reflect the code actually in your release?  Are all classes, enums, etc. included?  Are associations correctly identified?
