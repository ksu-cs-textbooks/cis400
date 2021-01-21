---
title: "Class Library Milestone #2"
pre: "4. "
weight: 40
date: 2018-08-24T10:53:26-05:00
---

{{% notice noiframe %}}
This textbook was authored for the **CIS 400 - Object-Oriented Design, Implementation, and Testing** course at Kansas State University.  This section describes assignments specific to that course.  If you are not enrolled in the course, please disregard this section.
{{% /notice %}}

### General requirements:

* You need to follow the style laid out in the [C# Coding Conventions](https://docs.microsoft.com/en-us/dotnet/csharp/programming-guide/inside-a-program/coding-conventions)

* Document your code from Assignment #1 using [XML comments](https://docs.microsoft.com/en-us/dotnet/csharp/codedoc)

* Write tests for code coverage

### Assignment requirements:

* Refactor any code that needs corrected from Milestone #1

* Author new classes

    * Create base classes for entree and side

    * Create side classes 

* Refactor entree classes to inherit from Entree base class

* Write the body of all side test methods 

* When all tests are written your code should have a minimum code coverage of 92%


### Purpose:

This assignment is designed to explore inheritance and as an introduction to testing. Inheritance allows disparate but related objects to be treated as instances of the same base class, and also allows the base class to define shared structure for the derived classes.  Testing helps ensure that your code does what it is intended to do.

In a professional environment you will be required to write tests for the code you write. Many companies require all application code to be tested before allowing the project to be put into production. You will be expected to be able to write tests this semester so please ensure you understand this assignment and do not just go through the motions of doing it.

### Recommendations:

Read the entire assignment before you start to code. Make sure you understand what is being asked of you.

Ask Professor Bean or any of the TA’s about any questions you might have. Get the full value of your education, we are here to help you!

## Base Classes

Define abstract base classes for your entrées and sides, called `Entree` and `Side`, respectively. All entrées should inherit from `Entree`, and all sides should inherit from `Side`.  You should push what property definitions you can into these base classes. These base classes should be defined in their corresponding namespaces.

All properties that are shared by derived classes should be pushed to the base class (generalization).  For example, as all entrées have a `Name`, `Description`, `Price`, `Calories`, and `SpecialInstructions`, so these should be implemented in the base class as either `abstract` or `virtual` methods.  That said, you may need to override some or all in derived classes to provide the necessary functionality.

Note that sides all also have a `Size` property, so this should be defined in the `Side` base class as well.

## Side Classes 

All sides should reside in the `FlyingSaucer.Data.Sides` namespace.

The Flying Saucer offers six sides:

* Crop Circle Oats

* Glowing Haystack

* Taken Bacon

* Missing Links

* Eviscerated Eggs 

* You're Toast!

Each side should implement a property for: `Name` (a `string`), `Description` (a `string`), `Size` (a `Size` enumeration), `Price` (a `decimal`), `Calories` (a `uint`), and `SpecialInstructions` (a `List<String>`), containing any special instructions needed to prepare the dish for a specific customer (or empty if there are none). 

<hr/>

#### Crop Circle Oats (A bowl of oatmeal)
Implement a class to represent the Crop Circle Oats, named `CropCircleOats` in the file _CropCircleOats.cs_.  It should have the following properties:

`Name`: _[Size] Crop Circle Oats_ where _[Size]_ is the size of the side.

`Description`: _A hearty oatmeal doused in butter and your choice of syrup._

`Calories`: _158_ (small), _316_ (medium), _484_ (large)

`Price`: _$1.50_ (small), _$2.00_ (medium), _$2.50_ (large)

In addition to the normal side properties, it should have a boolean property for `Butter` (indicating the oatmeal should be served with butter, default `true`), a boolean property for `Syrup` (indicating the oatmeal should be served with syrup default `true`), and a `SyrupFlavor` property `Syrup` indicating what syrup it should be served with (default Maple).  

If the `Butter` property is `false`, the string `"Hold Butter"` should appear in the `SpecialInstructions` list.  Similarly, if the `Syrup` property is `true`, the name of the selected syrup should appear in the `SpecialInstructions` along with the word "Syrup". I.e. when the selected syrup is maple, the `SpecialInstructions` should include `"Maple Syrup"`.

#### Glowing Haystack (Smothered Hashbrowns)
Implement a class to represent the Glowing Haystack, named `GlowingHaystack` in the file _GlowingHaystack.cs_.  It should have the following properties:

`Name`: _[Size] Glowing Haystack_ where _[Size]_ is the size of the side.

`Description`: _A dense pile of crisp hash browns, smothered in roasted green pepper sauce._

`Calories`: _470_ (small), _610_ (medium), _785_ (large)

`Price`: _$1.50_ (small), _$2.00_ (medium), _$2.50_ (large)

In addition to the normal side properties, it should have a boolean property for `Sauced` (indicating the hash browns should be served with pepper sauce, default `true`).  

If the `Sauced` property is `false`, the string `"Hold Sauce"` should appear in the `SpecialInstructions` list.

#### Taken Bacon
Implement a class to represent the Taken Bacon, named `TakenBacon` in the file _TakenBacon.cs_.  It should have the following properties:

`Name`: _[Size] Taken Bacon_ where _[Size]_ is the size of the side.

`Description`: _Crispy thick-sliced strips of hickory-smoked bacon._

`Calories`: _43_ (small), _86_ (medium), _129_ (large)

`Price`: _$1.50_ (small), _$2.00_ (medium), _$2.50_ (large)

The `SpecialInstructions` should always be an empty list.

#### Missing Links (sausage links)
Implement a class to represent the Missing Links, named `MissingLinks` in the file _MissingLinks.cs_.  It should have the following properties:

`Name`: _[Size] Missing Links_ where _[Size]_ is the size of the side.

`Description`: _Rich sage sausage links cooked to perfection._

`Calories`: _391_ (small), _782_ (medium), _1173_ (large)

`Price`: _$1.50_ (small), _$2.00_ (medium), _$2.50_ (large)

The `SpecialInstructions` should always be an empty list.

#### Eviscerated Eggs
Implement a class to represent the Eviscerated Eggs, named `EvisceratedEggs` in the file _EvisceratedEggs.cs_.  It should have the following properties:

`Name`: _[Size] Eviscerated Eggs_ where _[Size]_ is the size of the side.

`Description`: _Farm-fresh eggs, served as you like!_

`Calories`: _78_ (small), _156_ (medium), _234_ (large)

`Price`: _$1.50_ (small), _$2.00_ (medium), _$2.50_ (large)

Also, it should have a property for `EggStyle` with type `EggStyle`.  The selected `EggStyle` should appear in the special instructions.  I.e. if `OverEasy` is selected, the `SpecialInstructions` should include `"Eggs Over Easy"` (note that all words should be capitalized and spaced in the special instructions).

#### You're Toast!
Implement a class to represent the You're Toast!, named `YoureToast` in the file _YourToast.cs_.  It should have the following properties:

`Name`: _[Size] You're Toast!_ where _[Size]_ is the size of the side.

`Description`: _Thick, crusty slabs of Texas Toast._

`Calories`: _100_ (small), _200_ (medium), _300_ (large)

`Price`: _$1.50_ (small), _$2.00_ (medium), _$2.50_ (large)

The `SpecialInstructions` should always be an empty list.

## Refactoring Entree Classes
All of your entree classes will need to be refactored (edited) to inherit from the `Entree` base class.

## Side Tests 
You will need to write unit tests for each of your `Side` methods.  These should be defined in the _DataTest_ project, in the `TheFlyingSaucer.DataTests.Sides` namespace.  The unit tests should be provided with assertions to verify the behavior specified for the sides above.  Refer back to the discussion of [writing tests]({{<ref "1-object-orientation/04-testing/04-writing-tests">}}) and [XUnit assertions]({{<ref "1-object-orientation/04-testing/05-xunit-assertions">}}), as well as the entree class for ideas.  Note that you will need to supply appropriate `[InlineData]` attributes for any theory test methods.

<hr/>

#### Crop Circle Oats Tests
Implement a class to test the Crop Circle Oats, named `CropCircleOatsTests` in the file _CropCircleOatsTests.cs_.  It should implement the following test methods:
* `NameIsCorrectForSize(Size size)`
* `DescriptionIsCorrect()`
* `CaloriesAreCorrectForSize(Size size)`
* `PriceIsCorrectForSize(Size size)`
* `ShouldBeAbleToSetButter()`
* `ShouldBeAbleToSetSyrupFlavor(SyrupFlavor flavor)`
* `ShouldProvideCurrentSpecialInstructions(bool butter, SyrupFlavor flavor, string[] instructions)`

#### Glowing Haystack Tests
Implement a class to test the Glowing Haystack, named `GlowingHaystackTests` in the file _GlowingHaystackTests.cs_.  It should implement the following test methods:
* `NameIsCorrectForSize(Size size)`
* `DescriptionIsCorrect()`
* `CaloriesAreCorrectForSize(Size size)`
* `PriceIsCorrectForSize(Size size)`
* `ShouldBeAbleToSetSauced(bool sauced)`
* `ShouldProvideCurrentSpecialInstructions(bool sauced, string[] instructions)`

#### Taken Bacon Tests
Implement a class to test the Taken Bacon, named `TakenBaconTests` in the file _TakenBaconTests.cs_.  It should have the following properties:
* `NameIsCorrectForSize(Size size)`
* `DescriptionIsCorrect()`
* `CaloriesAreCorrectForSize(Size size)`
* `PriceIsCorrectForSize(Size size)`
* `SpecialInstructionsShouldBeEmpty()`

#### Missing Links Tests
Implement a class to test the Missing Links, named `MissingLinksTests` in the file _MissingLinksTests.cs_.  It should implement the following test methods:
* `NameIsCorrectForSize(Size size)`
* `DescriptionIsCorrect()`
* `CaloriesAreCorrectForSize(Size size)`
* `PriceIsCorrectForSize(Size size)`
* `SpecialInstructionsShouldBeEmpty()`

#### Eviscerated Eggs Tests
Implement a class to test the Eviscerated Eggs, named `EvisceratedEggsTests` in the file _EvisceratedEggsTests.cs_.  It should implement the following test methods:
* `NameIsCorrectForSize(Size size)`
* `DescriptionIsCorrect()`
* `CaloriesAreCorrectForSize(Size size)`
* `PriceIsCorrectForSize(Size size)`
* `ShouldBeAbleToSetEggStyle(EggStyle style)`
* `ShouldProvideCurrentSpecialInstructions(EggStyle style, string[] instructions)`

#### You're Toast!
Implement a class to test the You're Toast!, named `YoureToastTests` in the file _YourToastTests.cs_.  It should have the following properties:
* `NameIsCorrectForSize(Size size)`
* `DescriptionIsCorrect()`
* `CaloriesAreCorrectForSize(Size size)`
* `PriceIsCorrectForSize(Size size)`
* `SpecialInstructionsShouldBeEmpty()`

### Submissions

* Create a new release tag - Submit the release URL

  * If you do not remember how to do this, please revisit the [Git Workflows]({{<ref "b-git-workflows/01-introduction">}})

  * Keep in mind the version!!!

### Review of the week

[C# Testing Fundamentals](https://docs.microsoft.com/en-us/visualstudio/test/walkthrough-creating-and-running-unit-tests-for-managed-code?view=vs-2019)

[UML Class Diagram Creation](https://support.microsoft.com/en-us/office/create-a-uml-class-diagram-de6be927-8a7b-4a79-ae63-90da8f1a8a6b)

