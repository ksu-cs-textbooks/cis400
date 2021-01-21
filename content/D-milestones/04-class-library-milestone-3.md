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

* Implement abstract `Entree`, `Side`, and `Drink` classes according to the details below

* Implement an `IOrderItem` interface according to the details below

* Create a static `Menu` class according to the details below

* Write tests for all of the modified and added code

* Update your UML diagram to refect the changes to your design

### Purpose:

This assignment is ment to introduce the concepts of abstract, virtual, and interface classes while showing you how powerful they can be. This assignment will challenge you to continue to write tests for logic-based method instead of simple accessor methods. This is the last data milestone before we move to user interface in the form of a point of sale (POS) system.

### Time requirement:

3 - 5 hours (Zach's Estimate); 5 - 8 hours (Nathan's estimate)

### Recommendations:

Read the entire assignment before you start to code. Make sure you understand what is being asked of you. Start early, these assignments are going to start taking more and more time to complete. If you put in a hour and a half a day until you are done you will have no problem completing these assignments early and having the weekend to relax!


### Assignment Details

#### IOrderItem Interface

Create an interface named IOrderItem.cs which contains the following properties:

* Price - a getter of type `double`

* Calories - A getter of type `uint`

* SpecialInstructions - A getter of type `List<string>`

All entrees, drinks, and sides will need to implement this interface.

#### Entree Base Class
Create an abstract class named `Entree` in the file _Entree.cs_ with at least the following properties:

* `Price` - a getter of type `double`
* `Calories` - A getter of type `uint`
* `SpecialInstructions` - A getter of type `List<string>`

All entrees should be refactored to derive from this base class.

#### Drink Base Class
Create an abstract class named `Drink` in _Drink.cs_ with at least the following properties:

* `Size` - a getter adn setter of type `Size`
* `Price` - a getter of type `double`
* `Calories` - A getter of type `uint`
* `SpecialInstructions` - A getter of type `List<string>`

All drinks will need to be refactored to derive from this base class

#### Side Base Class
Create an abstract class named `Side` in _Side.cs_ with at least the following properties:

* `Size` - a getter and setter of type `Size`
* `Price` - a getter of type `double`
* `Calories` - A getter of type `uint`
* `SpecialInstructions` - A getter of type `List<string>`

All sides should be refactored to derive from this base class.

#### Inheritance and Interfaces
With your new base classes, you will need to refactor your existing classes so that:

* All entrees inherit `Entree`
* All sides inherit `Side`
* All drinks inherit `Drink`
* All menu items (entrees, sides, and drinks) implement `IOrderItem`

#### Create a static Menu class
You should also create a static class named `Menu` declared in the file _Menu.cs_ which contains the following `static` methods:

* `Entrees()` which returns an `IEnumerable<IOrderItem>` containing an instance of all available entrees offered by Bleakwind Buffet
* `Sides()` which returns an `IEnumerable<IOrderItem>` containing an instance of all available sides offered by Bleakwind Buffet.  As each side has 3 different sizes, this collection should contain a small, medium, and large instance of each. 
* `Drinks()` which returns an `IEnumerable<IOrderItem>` containing all available drinks offered by BleakwindBuffet.  As each drink has 3 different sizes, this collection should contain a small, medium, and large instance of each.  Similarly, it should contain three of each flavor of `SailorSoda`: one large, one medium, and one small.
* `FullMenu()` should return an `IEnumerable<IOrderItem>` containing all of the items on the menu

#### Testing

You will need to expand your tests of all menu items to ensure that they each implement the `IOrderItem` interface.  This can be done with the `Assert.IsAssignableFrom<T>(object obj)` assertion, which checks that `obj` can be cast to be of type `T`, i.e.:

```csharp
[Fact]
public void ShouldBeAssignableToAbstractFooClass()
{
    var bar = new bar();
    Assert.IsAssignableFrom<Foo>(bar);
}
```

Additionally, you should test that all items on the menu can be cast to their respective base classes (`Entree`, `Side`, or `Drink`) as well as the `IOrderItem` interface.

You should also test the methods in the `Menu` class to ensure they return a correct list of items. This can be done with the `Assert.Collection()` assertion.  If you are unsure on how to do this please visit office hours for directions. Try this yourself first don’t come to us unless you have struggled a little bit. You should be able to reach 100% code coverage on the `Menu` class.

#### Update or Create the UML Class Diagram
You will also need to create (or update) a UML Class Diagram to correspond to the BleakwindBuffet Data project _as you have implemented it_.  You may choose to use the diagram from Milestone #1 as a starting point.  It is available in Microsoft Visio format [here]({{<static "files/BleakwindBuffetClassUML.vsdx">}}).  

Microsoft Visio is available to CS students for free through the Azure Student Portal, see [this support page](https://support.cs.ksu.edu/CISDocs/wiki/FAQ#MSDNAA) for details.  It can also be found on the remote desktop machines.  Alternatively, you may create your UML with a tool of your choice.

Your finished UML diagram should be included in a _documentation_ folder in a format that the UTAs can access (i.e. `pdf` or `png` with the name _data-milestone-3-uml_).  You may also place your source file in the project, but the image or pdf file is what will be graded.  **Be sure you actually include the file itself, not just a link to a location on your computer!  See [these instructions]({{<ref "b-git-workflows/11-adding-documentation-files.md">}}) for details.**

### Sneak peek at next time!!!!

[XAML](https://docs.microsoft.com/en-us/dotnet/framework/wpf/advanced/xaml-syntax-in-detail "XAML")

Good luck on your exams this week if you have any.