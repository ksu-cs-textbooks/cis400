---
title: "Milestone 3 Requirements (Spring 2022)"
pre: "5. "
weight: 50
date: 2018-08-24T10:53:26-05:00
---

{{% notice noiframe %}}
This textbook was authored for the **CIS 400 - Object-Oriented Design, Implementation, and Testing** course at Kansas State University.  This section describes assignments specific to the **Fall 2022** offering of that course.  If you are not enrolled in the course, please disregard this section.
{{% /notice %}}

For this milestone, you will be creating some additional menu item classes and refactoring others. This will involve refactoring some already written classes, as well as adding some new ones.  

### General requirements:

* You need to follow the style laid out in the [C# Coding Conventions](https://docs.microsoft.com/en-us/dotnet/csharp/programming-guide/inside-a-program/coding-conventions)

### Assignment requirements:

You will need to:

* Create a base class for `Poppers`
* Refactor existing popper classes to use inheritance
* Create an interface for menu items, `IMenuItem`
* Implement `IMenuItem` on all menu items
* Create platter classes representing specific platters:
  * Piper Platter
  * Popper Platter
* Create a UML diagram representing all the classes, enums, and interfaces in your _Data_ project.

### Purpose:

This milestone serves to introduce and utilize aspects of polymorphism including base classes, abstract base classes, abstract methods, virtual methods, method overriding, and interfaces.  While the actual programming involved is straightforward, the concepts involved can be challenging to master. If you have any confusion after you have read the entire assignment please do not hesitate to reach out to a Professor Bean, the TAs, or your classmates over Discord.

### Recommendations:

* Get in the habit of reading the entire assignment before you start to code. Make sure you understand what is being asked of you. Please do not get ahead of yourself and have to redo work because you did not read the entire assignment.

* Accuracy is _important_.  Your class, property, enumeration and other names, along with the descriptions _must match the specification given here_.  Otherwise, your code is **not correct**.  While typos may be a small issue in writing intended for human consumption, in computer code _it is a big problem!_ 

* Remember that you must document your classes.  This was covered in prior courses and also discussed in [chapter 3]({{% ref "1-object-orientation/03-documentation" %}}) of your textbook.

* The KSU.CS.CodeAnalyzers NuGet package installed in your project will automatically flag issues for naming and commenting conventions in your code with warnings.  Be sure to address these!

## Popper Base Class

You will need to create an abstract base class `Popper` in the File _Popper.cs_ in the `FriedPiper.Data.MenuItems` namespace to represent the properties common to all popper menu items (Apple Fritters, Fried Bananas, Fried Cheesecake, and Fried Oreos). The different inheritance modifiers you might want to use are:
* `virtual` when you want to provide an implementation in the base class that can be overridden in derived class,
* `abstract` when _all_ derived classes need to provide their own implementation, and 
* a regular method (not `virtual` or `abstract`) when _all_ derived classes can use the base property without overriding it.

## Refactoring Poppers

Refactor the popper classes (`AppleFritters`, `FriedBananas`, `FriedCheeseCake`, and `FriedOreos`) to inherit from the `Popper` base class. You should be able to remove properties from these classes that are now provided by the base class.

## IMenuItem Interface

You will need to declare an interface `IMenuItem` representing the common aspects of _all_ menu items in the file _IMenuItem.cs_ in the `FriedPiper.Data.MenuItems` namespace.  The properties included in this interface should be:

* `Name` - a get-only `string`
* `Price` - a get-only `decimal`
* `Calories` - a get-only `uint` 

## Implementing IMenuItem

_Every_ menu item class should be refactored to implement the `IMenuItem` interface (i.e. (`FriedPie`, `FriedIceCream`, `FriedCandyBar`, `FriedTwinkie`, `AppleFritters`, `FriedBananas`, `FriedCheeseCake`, `FriedOreos`, and the new platter classes described below).

## Platter Classes

A platter represents a combination of existing menu items that when ordered together come at a discounted price and are ideal for sharing.  Thus, they need a properties to hold the menu items they consist of.  All platter classes should also implement the `IMenuItem` interface.

### Piper Platter

A Piper Platter is a platter consisting of _two_ fried pies and _two_ fried ice creams. These can be any combination of flavors. The class should be named `PiperPlatter`, defined in the file _PiperPlatter.cs_ and defined in the `FriedPiper.MenuItem` namespace. It should have the following properties:

* `Name` - a get-only `string` that is always "Piper Platter"
* `LeftPie` - a `FriedPie` instance representing the first fried pie
* `RightPie` - a `FriedPie` instance representing the second fried pie
* `LeftIceCream` - a `FriedIceCream` instance representing the first fried ice cream 
* `RightIceCream` - a `FriedIceCream` instance representing the second fried ice cream
* `Calories` - a get-only `uint` that should be the sum of calories for all fried pies and ice creams in the platter 
* `Price` - a get-only `decimal` with a value of $12.00.

Note that the `LeftPie`, `RightPie`, `LeftIceCream`, and `RightIceCream` _must be initialized_ (not be `null`) when the class is first constructed.  You can pick the default instances for each.

### Popper Platter

A Popper Platter is a platter consisting of one of each of the four popper items `AppleFritters`, `FriedBananas`, `FriedCheeseCake`, and `FriedOreos`), an ideal treat for the indecisive.  The class should be named `PopperPlatter`, defined in the file _PopperPlatter.cs_ and defined in the `FriedPiper.MenuItem` namespace. It should have the following properties:

* `Name` - a get-only `string` that is "[size] Popper Platter", where [size] is the `Size` property of the platter
* `Size` - a `ServingSize` property representing the size of the poppers in the order. It should default to `Small`. All poppers in the platter should be the same size, so changing it should also change the size of each of the poppers to match.
* `Glazed` - a boolean property (defaulting to `true`) indicating if the poppers are glazed or not.  As the platter is glazed as a whole, _all_ poppers on platter are either glazed or not glazed.  Thus, changing the `Glazed` property should change the corresponding property of each of the poppers to match.
* `AppleFritters` - a get-only `AppleFritters` instance representing the apple fritters in the platter 
* `FriedBananas` - a get-only `FriedBananas` instance representing the fried bananas in the platter
* `FriedCheesecake` - a get-only `FriedCheesecake` instance representing the fried cheesecake in the platter 
* `FriedOreos` - a get-only `FriedOreos` instance representing the fried Oreos in the platter
* `Calories` - a get-only `uint` that should be the sum of calories for all the poppers in the platter 
* `Price` - a get-only `decimal` with a value of $12.00 for small, $16.00 for medium, and $20.00 for large.

Note that the popper properties _must be initialized_ (not be `null`) when the class is first constructed, and each should start as `Small`.  

## UML Diagram

You will also need to create a UML diagram to represent each of the classes, enumerations, and interfaces defined in your _Data_ project. You will need to include a copy of this diagram as a PDF or image file in a _Documentation_ folder in your project. 

In your UML diagram, be sure you represent the relationships between your classes correctly, i.e. _generalization_ for inheritance, _realization_ for interface implementation, and _aggregation_ or _composition_ for classes that hold instances of other classes. Review the chapter on [UML]({{% ref "05-uml" %}}) if you are hazy on the distinction.

Carefully read the [adding documentation]({{% ref "B-git-and-github/13-adding-documentation-files" %}}) discussion to ensure you are not adding a link to the file rather than the actual file to your project. You can also check the contents of your GitHub repository after you commit to make sure you included your documentation correctly.

If you use Visio to create your UML, it is also a good idea to place your Visio file in the _Documentation_ folder, so you can always have access to it when you work on your project, as you will need to update it as you make changes.

## Submitting the Assignment
Once your project is complete, merge your feature branch back into the `main` branch and [create a release]({{% ref "B-git-and-github/12-release" %}}) tagged `v0.3.0` with name `"Milestone 3"`.  Copy the URL for the release page and submit it to the Canvas assignment.

## Grading Rubric
The grading rubric for this assignment will be:

**25% Structure** Did you implement the structure as laid out in the specification?  Are the correct names used for classes, enums, properties, methods, events, etc?  Do classes inherit from expected base classes?

**25% Documentation** Does every class, method, property, and field use the correct XML-style documentation?  Does every XML comment tag contain explanatory text?

**25% Design** Are you appropriately using C# to create reasonably efficient, secure, and usable software?  Does your code contain bugs that will cause issues at runtime?

**25% Functionality** Does the program do what the assignment asks?  Do properties return the expected values?  Do methods perform the expected actions?

{{% notice warning %}}
Projects that do not compile will receive an automatic grade of 0.
{{% /notice %}}