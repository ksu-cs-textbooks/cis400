---
title: "Class Library Milestone #3 - Assignment Description"
pre: "6. "
weight: 60
date: 2018-08-24T10:53:26-05:00
---

{{% notice noiframe %}}
This textbook was authored for the **CIS 400 - Object-Oriented Design, Implementation, and Testing** course at Kansas State University.  This section describes assignments specific to that course.  If you are not enrolled in the course, please disregard this section.
{{% /notice %}}

### General requirements:

* You will need to follow the style laid out in the [C# Coding Conventions](https://docs.microsoft.com/en-us/dotnet/csharp/programming-guide/inside-a-program/coding-conventions)

* You will need to document your code using [XML comments](https://docs.microsoft.com/en-us/dotnet/csharp/codedoc)

* Refactor menu item classes to implement their categories abstract classes and implement the `IOrderItem` interface

* Build a static `Menu` class

* Modify or create a UML diagram reflecting your program design

### Assignment requirements:

* Refactor any code that needs corrected from Milestone #2

* Author new classes

    * Create enum for juice flavors (1)

    * Create base class for drinks (1)

    * Create drink classes (?)

* Implement an `IOrderItem` interface according to the details below

* Create a static `Menu` class according to the details below

* Write tests for all of the modified and added code

* Create or update your UML diagram to reflect the changes to your design

### Purpose:

This assignment is to further explore polymorphism through the use of interfaces and demonstrate the usefulness of polymorphism in allowing us to treat objects as different types. It also brings us more practice writing classes and explores some less-than object oriented aspects of C#.  Note too that the specifications you are supplied with are getting less specific, and leaving more for you to interpret.  This also reflects real-world practice.

### Recommendations:

Read the entire assignment before you start to code. Make sure you understand what is being asked of you. Start early, these assignments are going to start taking more and more time to complete.

### Assignment Details

## Enum Classes

All enums should reside in the `TheFlyingSaucer.Data.Enums` namespace

There is one additional enum needed:

* `JuiceFlavor` - Includes the following attributes:
  * Orange
  * Cranberry
  * Grape
  * Apple
  * Tomato

## Base Classes

Define abstract base classes for your drinks, called `Drink`. All drinks should inherit from `Drink`.  The `Drink` base classes should be defined in the `TheFlyingSaucer.Data.Drinks` namespace.

All properties that are shared by derived `Drink` classes should be pushed to the base class (generalization).  Examine the drink class requirements below to determine what should be generalized.

## Drink Classes

All sides should reside in the `FlyingSaucer.Data.Drink` namespace.

The Flying Saucer offers six drinks:

* Liquified Vegetation

* Saucer Fuel

* Water


Each drink should implement a property for: `Name` (a `string`), `Description` (a `string`), `Size` (a `Size` enumeration), `Price` (a `decimal`), `Calories` (a `uint`), and `SpecialInstructions` (a `List<String>`), containing any special instructions needed to prepare the dish for a specific customer (or empty if there are none).

<hr/>

#### Liquified Vegetation (Juice)
Liquified Vegetation should be named _[Size] Liquified Vegetation_ where _[Size]_ is _Small_, _Medium_, or _Large_, and bear the description _Fresh juice extracted from the finest fruits and vegetables._  It can be small, medium, or large, and should have one of the flavors from the `JuiceFlavor` enum.  Its price is $1.00 (small), $1.50 (medium), and $2.00 (large).  Its calories vary according to the type of juice:

<table>
  <tr>
    <th>Flavor</th>
    <th>Calories (small)</th>
    <th>Calories (medium)</th>
    <th>Calories (large)</th>
  </tr>
  <tr>
    <td>Orange</td>
    <td>111</td>
    <td>222</td>
    <td>333</td>
  </tr>
  <tr>
    <td>Cranberry</td>
    <td>117</td>
    <td>234</td>
    <td>481</td>
  </tr>
  <tr>
    <td>Grape</td>
    <td>152</td>
    <td>304</td>
    <td>456</td>
  </tr>  
  <tr>
    <td>Apple</td>
    <td>113</td>
    <td>226</td>
    <td>339</td>
  </tr>
  <tr>
    <td>Tomato</td>
    <td>42</td>
    <td>84</td>
    <td>126</td>
  </tr>
</table>

Its special instructions should indicate the type of juice (i.e. "Apple").

#### Saucer Fuel (Coffee)
Saucer Fuel should be named _[Size] Decaf Saucer Fuel_ when the coffee is decaffeinated, or _[Size] Saucer Fuel_ for regular coffee.  In both cases _[Size]_ is _Small_, _Medium_, or _Large_.  The description should be _Beamed directly from the best coffee plantations of South America, our rich brew is bound to put a bounce in your spacewalk._  Its price should be $1.00 (small), $1.20 (medium), or $1.40 (large).  Its calories should be 1 (small), 2, (medium), or 3 (large). It should have boolean properties for `RoomForCream` (default `false`), and `Decaf` (also default `false`).  Special instructions should either be empty or specify "Room for Cream".

#### Water (Water)
Water should be named _[Size] Water_ with _[Size]_ being _Small_, _Medium_, or _Large_. Its description should be _Watch out if you come from a planet where pure H2O is deadly, because that's all this is!_  Its price should be $0 regardless of size, and calories are 0 regardless of size.  It should have a boolean property for `Ice` which is `true` by default.  If `Ice` is `false`, then the special instructions should include "No Ice", otherwise the should be empty.

#### IOrderItem Interface

Create an interface named IOrderItem.cs which contains the following properties:

* Price - a getter of type `decimal`

* Calories - A getter of type `uint`

* SpecialInstructions - A getter of type `List<string>`

All entrees, drinks, and sides will need to implement this interface.

#### Inheritance and Interfaces
With your new interface adn base classes, you will need to refactor your existing classes to ensure:

* All entrees inherit `Entree`
* All sides inherit `Side`
* All drinks inherit `Drink`
* All menu items (entrees, sides, and drinks) implement `IOrderItem`

#### Create a static Menu class
You should also create a static class named `Menu` declared in the file _Menu.cs_ which contains the following `static` properties:

* `Entrees` which returns an `IEnumerable<IOrderItem>` containing an instance of all available entrees.  For entrees with choices, i.e. egg style or syrup flavors, you only need to show the default choice.  However, you should include half-stack options.
* `Sides` which returns an `IEnumerable<IOrderItem>` containing an instance of all available sides.  As each side has 3 different sizes, this collection should contain a small, medium, and large instance of each. Again, you do not need to supply all the egg styles.
* `Drinks` which returns an `IEnumerable<IOrderItem>` containing all available drinks.  As each drink has 3 different sizes, this collection should contain a small, medium, and large instance of each.  Similarly, it should contain one of every size and flavor of `LiquifiedVegetation`, and six instances of `SaucerFuel` to represent both regular and decaf small, medium, and large.
* `FullMenu` should return an `IEnumerable<IOrderItem>` containing all of the items on the menu.

Note that you cannot create an `IEnumerable<IOrderItem>` directly - rather it is an interface that most collections implement.  So use a collection of your choice that has the interface.

#### Testing

You will need to add unit test classes for all your new drink classes.  These should be named and organized much like the tests you implemented for the sides - but this time you will need to create the entire class from scratch.

You will also need to expand your tests of all menu items to ensure that they each implement the `IOrderItem` interface.  This can be done with the `Assert.IsAssignableFrom<T>(object obj)` assertion, which checks that `obj` can be cast to be of type `T`, i.e.:

```csharp
[Fact]
public void ShouldBeAssignableToAbstractFooClass()
{
    var bar = new bar();
    Assert.IsAssignableFrom<Foo>(bar);
}
```

Additionally, you should test that all items on the menu can be cast to their respective base classes (`Entree`, `Side`, or `Drink`). This, and the interface test, should be placed in the corresponding unit test class.

You should also test the properties in the `Menu` class to ensure they return a correct list of items. This can be done with the `Assert.Collection()` assertion or a series of `Assert.Contains()`.  If you are unsure on how to do this please visit office hours for directions. Try this yourself first don’t come to us unless you have spent some time trying to figure it out. You should be able to reach 100% code coverage on the `Menu` class.

#### Update or Create the UML Class Diagram
You will also need to create (or update) a UML Class Diagram to correspond to the Data project _as you have implemented it_.  You may choose to use the diagram from Milestone #1 as a starting point.  It is saved in Microsoft Visio format in the _documentation_ folder of your project.  

Microsoft Visio is available to CS students for free through the Azure Student Portal, see [this support page](https://support.cs.ksu.edu/CISDocs/wiki/FAQ#MSDNAA) for details.  It can also be found on the remote desktop machines.  Alternatively, you may create your UML with a tool of your choice.

Your finished UML diagram should be included in a _documentation_ folder in a format that the UTAs can access (i.e. `pdf` or `png` with the name _data-milestone-3-uml_).  You may also place your source file in the project, but the image or pdf file is what will be graded.  **Be sure you actually include the file itself, not just a link to a location on your computer!  See [these instructions]({{<ref "b-git-workflows/11-adding-documentation-files.md">}}) for details.**

#### Milestone 3 Rubric

Every assignment begins with 100 points, from which points are deducted using the following rubric.  If the total score is reduced to 0, then the assignment is assigned a grade of 0.

Comments
* -1 point for every public member (other than test methods) not commented using XML-Style comments, as is discussed in the [documentation chapter]({{<ref "1-object-orientation/03-documentation">}}).
* -1 point for every file not containing a header describing the file purpose and author(s).

Enums
* -2 points for every missing or incorrect attribute

Entree, Side, and Drink Classes
* -2 points for every missing or incorrect property
* -2 points for every missing or incorrect method

Test Classes
* -2 points for every missing or incorrect test method

UML Diagram
* -2 points for every missing or incorrect class
* -2 points for every missing or incorrect association

### Submissions

* Create a new release tag - Submit the release URL

  * If you do not remember how to do this, please revisit the [Git Workflows]({{<ref "b-git-workflows/01-introduction">}})

  * Keep in mind the version!!!

### Review of the week

[UML Class Diagram Creation](https://support.microsoft.com/en-us/office/create-a-uml-class-diagram-de6be927-8a7b-4a79-ae63-90da8f1a8a6b)
