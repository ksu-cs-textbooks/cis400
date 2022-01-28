---
title: "Milestone 2 Requirements"
pre: "4. "
weight: 40
date: 2018-08-24T10:53:26-05:00
---

{{% notice noiframe %}}
This textbook was authored for the **CIS 400 - Object-Oriented Design, Implementation, and Testing** course at Kansas State University.  This section describes assignments specific to the **Fall 2022** offering of that course.  If you are not enrolled in the course, please disregard this section.
{{% /notice %}}

For this milestone, you will be creating classes to represent the offerings of the "Fried Piper" - a fast-food franchise focused on fried desserts.  These will be created within the _Data_ project of the solution you accepted from GitHub classroom.

### General requirements:

* You need to follow the style laid out in the [C# Coding Conventions](https://docs.microsoft.com/en-us/dotnet/csharp/programming-guide/inside-a-program/coding-conventions)

* You need to document your code using [XML-style comments](https://docs.microsoft.com/en-us/dotnet/csharp/language-reference/xmldoc/recommended-tags), with a minimum of `<summary>` tags, plus `<param>`, `<returns>`, and `<exception>` as appropriate.  

### Assignment requirements:

You will need to create

* Enums (4) representing:
    * The various pie fillings available
    * The various ice cream flavors available
    * The various candy bars available
    * The serving sizes available

* Classes (4) representing regular menu items:
    * Fried Pies
    * Fried Ice Cream
    * Fried Candy Bars
    * Fried Twinkies    

* Classes (4) representing _poppers_ - bite-sized fried treats    
    * Fried Cheesecake
    * Fried Oreos
    * Fried Bananas
    * Apple Fritters

### Purpose:

This milestone serves as a review of how to create classes and sets the stage for the rest of the semester. Everything included in this assignment you should have been exposed to before in CIS200 and CIS300. This assignment should be relatively straightforward, though it will take some time to complete. If you have any confusion after you have read the entire assignment please do not hesitate to reach out to a Professor Bean, the TAs, or your classmates over Discord.

### Recommendations:

* Get in the habit of reading the entire assignment before you start to code. Make sure you understand what is being asked of you. Please do not get ahead of yourself and have to redo work because you did not read the entire assignment.

* Accuracy is _important_.  Your class, property, enumeration and other names, along with the descriptions _must match the specification given here_.  Otherwise, your code is **not correct**.  While typos may be a small issue in writing intended for human consumption, in computer code _it is a big problem!_ 

* Remember that you must document your classes.  This was covered in prior courses and also discussed in [chapter 3]({{<ref "1-object-orientation/03-documentation">}}) of your textbook.

* The KSU.CS.CodeAnalyzers NuGet package installed in your project will automatically flag issues with for naming and commenting conventions in your code with warnings.  Be sure to address these!

## Enum Classes 

All enums should reside in the `FriedPiper.Data.Enums` namespace and be placed in an _Enums_ folder within the Data project in your solution.

The needed enumerations are:

* `PieFilling` - The various fillings for fried pies at Fried Piper
  * Cherry
  * Peach
  * Apricot
  * Pineapple
  * Blueberry
  * Apple
  * Pecan

* `IceCreamFlavor` - The ice cream flavors available at Fried Piper
  * Vanilla
  * Chocolate
  * Strawberry

* `CandyBar` - The candy bars available at Fried Piper
  * Snickers
  * MilkyWay
  * Twix
  * ThreeMusketeers
  * ButterFingers

* `ServingSize` - The size of the popper menu item
  * Small
  * Medium
  * Large

To get you started, here's the last enum defined:

```csharp
/// <summary>
/// The size of a menu item
/// </summary>
public enum ServingSize 
{
  Small,
  Medium,
  Large
}
```

## Regular Menu Item Classes

All menu item classes should reside in the `FriedPiper.Data.MenuItems` namespace and be placed in the _MenuItems_ folder within the Data project in your solution.

The needed classes are:

#### Fried Pie
You will need to define a class to represent a fried pie (a deep-fried pastry containing a fruit filling), which can be customized after creation.  You should name this class `FriedPie` and declare it in the file _FriedPie.cs_.  It should have the following properties:

`Name`: A `string` that is "Fried [Filling] Pie", where [Filling] is the kind of filling used, i.e. "Fried Cherry Pie" for a fried cherry pie.

`Flavor`: A property with the `PieFilling` enum type, indicating the filling of the pie.

`Price`: A readonly property (i.e. it has only a `get` and no `set`) of type `decimal` with a value of $3.50.

`Calories`: A readonly property with a value of 287 for cherry, 304 for peach, 314 for apricot, 302 for pineapple, 314 for blueberry, 289 for apple, or 314 for pecan.

#### Fried Ice Cream
You will need to define a class to represent a serving of fried ice cream (frozen ice cream dipped in breading and deep-fried), which can be customized after creation.  You should name this class `FriedIceCream` and declare it in the file _FriedIceCream.cs_.  It should have the following properties:

`Name`: A `string` that is "Fried [Flavor] Ice Cream", where [Flavor] is the kind of ice cream, i.e. "Fried Strawberry Ice Cream" for strawberry ice cream.

`Flavor`: A property with the `IceCreamFlavor` enum type, indicating the flavor of the ice cream.

`Price`: A readonly property (i.e. it has only a `get` and no `set`) of type `decimal` with a value of $3.50.

`Calories`: A readonly property with type `uint` and a value of 355 for vanilla, 353 for chocolate, or 321 for strawberry.

#### Fried Candy Bar
You will need to define a class to represent a serving of fried candy bar (a candy bar dipped in breading and deep-fried), which can be customized after creation.  You should name this class `FriedCandyBar` and declare it in the file _FriedCandyBar.cs_.  It should have the following properties:

`Name`: A `string` that is "Fried [Candy Bar]", where [Candy Bar] is the kind of fried candy bar, i.e. "Fried Three Musketeers" for a Three Musketeers candy bar.

`CandyBar`: A property with the `CandyBar` enum type, indicating the candy bar to fry.

`Price`: A readonly property (i.e. it has only a `get` and no `set`) of type `decimal` with a value of $2.50.

`Calories`: A readonly property with type `uint` and a value of 
325 for Snickers, 213 for MilkyWay, 396 for Twix, 350 for ThreeMusketeers, or 385 ButterFingers.

#### Fried Twinkie
You will need to define a class to represent a serving of fried twinkie (a twinkie dipped in breading and deep-fried), which can be customized after creation.  You should name this class `FriedTwinkie` and declare it in the file _FriedCandyBar.cs_.  It should have the following properties:

`Name`: A `string` that is always "Fried Twinkie".

`Price`: A readonly property (i.e. it has only a `get` and no `set`) of type `decimal` with a value of $2.25.

`Calories`: A readonly property with type `uint` and a value of 420.

## Popper Menu Item Classes

All popper menu item classes should reside in the `FriedPiper.Data.MenuItems` namespace and be placed in the _MenuItems_ folder within the Data project in your solution. Popper menu items all come in three sizes - small, medium, or large, and the price and calories vary based on the size. The all can also be glazed with frosting, which adds additional calories.

The needed classes are:

#### Fried Cheesecake
You will need to define a class to represent fried cheesecake (bite-size cheesecake squares dipped in batter and deep-fried), which can be customized after creation.  You should name this class `FriedCheesecake` and declare it in the file _FriedCheesecake.cs_.  It should have the following properties:

`Name`: A `string` that is "[Size] Fried Cheesecake" where [Size] is the serving size of the item, i.e. "Small Fried Cheesecake" for when the `Size` property is small.

`Glazed`: A boolean property indicating that the cheesecake should be glazed with frosting, defaults to `true`.

`Size`: A property of type `ServingSize`.

`Price`: A readonly property (i.e. it has only a `get` and no `set`) of type `decimal` with a value of $3.75 for small, $4.50 for medium, and $5.25 for large.

`Calories`: A readonly property of type `uint` with a value of 310 for small, 425 for medium, or 620 for large, _plus_ an additional 130 calories if `Glazed` is true.

#### Fried Oreos
You will need to define a class to represent fried Oreos (Oreo cookies dipped in batter and deep-fried), which can be customized after creation.  You should name this class `FriedOreos` and declare it in the file _FriedOreos.cs_.  It should have the following properties:

`Name`: A `string` that is "[Size] Fried Oreos" where [Size] is the serving size of the item, i.e. "Small Fried Oreos" for when the `Size` property is small.

`Glazed`: A boolean property indicating that the fried Oreos should be glazed with frosting, defaults to `true`.

`Size`: A property of type `ServingSize`.

`Price`: A readonly property (i.e. it has only a `get` and no `set`) of type `decimal` with a value of $3.75 for small, $4.50 for medium, and $5.25 for large.

`Calories`: A readonly property of type `uint` with a value of 500 for small, 750 for medium, or 1000 for large, _plus_ an additional 130 calories if `Glazed` is true.

#### Fried Bananas
You will need to define a class to represent fried bananas (Banana slices dipped in batter and deep-fried), which can be customized after creation.  You should name this class `FriedBananas` and declare it in the file _FriedBananas.cs_.  It should have the following properties:

`Name`: A `string` that is "[Size] Fried Bananas" where [Size] is the serving size of the item, i.e. "Small Fried Bananas" for when the `Size` property is small.

`Size`: A property of type `ServingSize`.

`Glazed`: A boolean property indicating that the fried bananas should be glazed with frosting, defaults to `true`.

`Price`: A readonly property (i.e. it has only a `get` and no `set`) of type `decimal` with a value of $3.75 for small, $4.50 for medium, and $5.25 for large.

`Calories`: A readonly property of type `uint` with a value of 160 for small, 240 for medium, or 320 for large, _plus_ an additional 130 calories if `Glazed` is true.

#### Apple Fritters
You will need to refactor (change) the existing `AppleFritters` class to representing apple fritters (Apple slices dipped in batter and deep-fried), which can be customized after creation.  It should have the following properties:

`Name`: A `string` that is "[Size] Apple Fritters" where [Size] is the serving size of the item, i.e. "Small Apple Fritters" for when the `Size` property is small.

`Size`: A property of type `ServingSize`.

`Glazed`: A boolean property indicating that the fritters should be glazed with frosting, defaults to `true`.

`Price`: A readonly property (i.e. it has only a `get` and no `set`) of type `decimal` with a value of $3.00 for small, $4.00 for medium, and $5.00 for large.

`Calories`: A readonly property of type `uint` with a value of 240 for small, 360 for medium, or 480 for large, _plus_ an additional 130 calories if `Glazed` is true.

## Submitting the Assignment
Once your project is complete, merge your feature branch back into the `main` branch and [create a release]({{<ref "B-git-and-github/11-release">}}) tagged `v0.2.0` with name `"Milestone 2"`.  Copy the URL for the release page and submit it to the Canvas assignment.

## Grading Rubric
The grading rubric for this assignment will be:

**25% Structure** Did you implement the structure as laid out in the specification?  Are the correct names used for classes, enums, properties, methods, events, etc?  Do classes inherit from expected base classes?

**25% Documentation** Does every class, method, property, and field use the correct XML-style documentation?  Does every XML comment tag contain explanatory text?

**25% Design** Are you appropriately using C# to create reasonably efficient, secure, and usable software?  Does your code contain bugs that will cause issues at runtime?

**25% Functionality** Does the program do what the assignment asks?  Do properties return the expected values?  Do methods perform the expected actions?

{{% notice warning %}}
Projects that do not compile will receive an automatic grade of 0.
{{% /notice %}}