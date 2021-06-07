---
title: "Milestone 2 Requirements"
pre: "4. "
weight: 40
date: 2018-08-24T10:53:26-05:00
---

For this milestone, you will be creating additional classes to represent the entrées, and drinks served at "Dogs 'N Such", and refactoring some of your existing classes to take advantage of polymorphism.  These will be created within the _Data_ project of the solution you accepted from GitHub classroom.

### General requirements:

* You need to follow the style laid out in the [C# Coding Conventions](https://docs.microsoft.com/en-us/dotnet/csharp/programming-guide/inside-a-program/coding-conventions)

* Create classes that reflect the given UML (in the projects' _Documentation_ folder.)

  * Create enum classes

  * Create entrée classes

* All classes should be declared in their respective namespace (see below)

* All files should have 

### Assignment requirements:

* Refactored Dog class (1)
* Specialty Dog classes (7)
* Side Base class (1)
* Refactored side classes (4)
* Drink Enum (1)
* Drink class (1)

### Purpose:

Exploration of how object-oriented polymorphism can reduce the amount of code you need to write and increase the maintainability of the code you do.  We are also practicing _refactoring_ (re-writing existing, functional code to be more legible, efficient, and maintainable). Also, more practice writing methods and properties and using enumerations.

### Recommendations:

* Get in the habit of reading the entire assignment before you start to code. Make sure you understand what is being asked of you. Please do not stub your toe and have to redo work because you did not read the entire assignment.

* Accuracy is _important_.  Your class, property, enumeration and other names, along with the descriptions _must match the specification given here_.  Otherwise, your code is **not correct**.  While typos may be a small issue in writing intended for human consumption, in computer code _it is a big problem!_ 

* Remember that you must document your classes.  This includes a general identity comment at the top of your files, i.e.:

```csharp
/*
* Author: Nathan Bean
* Edited by: (Only include if you are not the original author)
* File name: Something.cs
* Purpose: To inform the students of the requirements for this milestone
*/
```

## Dog Classes
While Dogs 'N Such prides itself on its customizable hot dog, it also offers a selection of regional specialty hot dogs that are pre-configured with certain ingredients.  As these are still hot dogs, it makes sense to _extend_ the `Dog` class and create a derived class for each specialty dog.  

These additional classes should also be declared in the `DogsNSuch.Data` namespace.

### Refactor Dog Base Class
Because the specialty dogs will be listed on a menu, we need to add two additional properties to _all_ dogs to support this: a `Name` and `Description` (both strings).  These read-only properties needs to be added to `Dog` and be available with different return values in the derived classes.  For the `Dog` class their values will be:  

`Name`: The string `"Custom Dog"`

`Description`: The string `"Made to order."`

### Specialty Dog Classes

For each specialty dog, you will need to create a new class that derives from the `Dog` class.  All of these specialty dog classes should reside in the `DogsNSuch.Data.Data` namespace

The Dogs N' Such offers seven specialty dogs:

* Chicago Dog
* Kansas City Dog
* Polish Boy
* Seattle Dog
* Italian Dog
* Chili Dog
* Corn Dog

<hr/>

#### Chicago Dog 
Implement a class to represent the Chicago Dog, named `ChicagoDog` in the file _ChicagoDog.cs_.  It should have the following properties:

`Name`: _Chicago Dog_

`Description`: _A kosher all-beef dog on a poppy-seed bun, topped with yellow mustard, chopped white onions, tomato slices, relish, a dill pickle spear, and a dash of celery salt._

It should have its `Sausage` property set to `Sausage.Beef`, its `Bun` property set to `Bun.SesameSeed`, and the boolean properties for `YellowMustard`, `ChoppedOnions`, `TomatoSlices`, `SweetRelish`, `DillSpear`, `CelerySalt` all set to true.  Other boolean properties should be false.

#### Kansas City Dog 
Implement a class to represent the Kansas City Dog, named `KansasCityDog` in the file _KansasCityDog.cs_.  It should have the following properties:

`Name`: _Kansas City Dog_

`Description`: _A pork sausage in a sesame seed bun topped with brown mustard, sauerkraut, and melted swiss cheese._

It should have its `Sausage` property set to `Sausage.Pork`, its `Bun` property set to `Bun.SesameSeed`, and the boolean properties for `BrownMustard`, `Sauerkraut`, `SwissCheese` all set to true.  Other boolean properties should be false.

#### Polish Boy
Implement a class to represent the Polish Boy, named `PolishBoy` in the file _PolishBoy.cs_.  It should have the following properties:

`Name`: _Polish Boy_

`Description`: _A kielbasa sausage in hoagie bun topped french fries and BBQ Sauce._

It should have its `Sausage` property set to `Sausage.Kielbasa`, its `Bun` property set to `Bun.Hoagie`, and the boolean properties for `FrenchFries`, `BBQSauce`, `Coleslaw` all set to true.  Other boolean properties should be false.

#### Seattle Dog
Implement a class to represent the Polish Boy, named `SeattleDog` in the file _SeattleDog.cs_.  It should have the following properties:

`Name`: _SeattleDog_

`Description`: _A kielbasa sausage in hoagie bun topped with cream cheese and sauteed onions._

It should have its `Sausage` property set to `Sausage.Kielbasa`, its `Bun` property set to `Bun.Hoagie`, and the boolean properties for `CreamCheese` and `SauteedOnions` all set to true.  Other boolean properties should be false.

#### Italian Dog
Implement a class to represent the Italian Dog, named `ItalianDog` in the file _ItalianDog.cs_.  It should have the following properties:

`Name`: _Italian Dog_

`Description`: _A pork frank fried in pizza bread and topped with fried bell peppers, onions, and potatoes._

It should have its `Sausage` property set to `Sausage.Pork`, its `Bun` property set to `Bun.PizzaDough`, and the boolean properties for `FriedPepper`, `FriedOnion`, and `FriedPotatoes` all set to true.  Other boolean properties should be false.

#### Chili Dog
Implement a class to represent the Cincinnati Dog, named `ChiliDog` in the file _ChiliDog.cs_.  It should have the following properties:

`Name`: _Chili Dog_

`Description`: _A beef frank on a white bun toped with chili, cheddar cheese, and diced onion._

It should have its `Sausage` property set to `Sausage.Beef`, its `Bun` property set to `Bun.Hoagie`, and the boolean properties for `Chili`, `CheddarCheese`, and `ChoppedOnion` all set to true.  Other boolean properties should be false.

#### Corn Dog
Implement a class to represent the Corn Dog, named `CornDog` in the file _CornDog.cs_.  It should have the following properties:

`Name`: _Corn Dog_

`Description`: _A beef frank fried in corn breading, and served with yellow mustard._

It should have its `Sausage` property set to `Sausage.Beef`, its `Bun` property set to `Bun.CornBreading`, and the boolean property for `YellowMustard` set to true.  Other boolean properties should be false.

### Hints
* Remember that the derived classes inherit _all_ properties and methods of the base class.  This means you don't need to re-create properties!
* Specialty Dog customizations are most easily accomplished by creating a constructor in each of your derived classes, though there are other possible approaches.
* `Name` and `Description` should be read-only, but need to have different values in the derived classes than the base class.  What mechanism(s) can be used for this?

## Side Classes
Armed with our new understanding of inheritance, we can see that the Side classes each share properties (for example, they each have a `Size` property and the prices are the same across all sides). We could move these properties to a base class, much like we use the `Dog` class for our hot dogs.  However, there is no generic "side" the same way there is a classic "hot dog", so we'll want to make this one _abstract_.

### Side Base class
Create a new class, `Side` to serve as a base class for each of your sides in the _Side.cs_ file.  It should be declared `abstract`, and have `abstract` read-only properties for `Name` and `Description` (both strings).  It should also have properties for `Calories` (a `uint`), `Price` (a `decimal`), and `Size` (a `Size`).  

### Refactor Side classes
Refactor your four side classes to inherit from `Side`.  This may allow you to remove duplicate code from the derived classes!

### Hints
* Remember the `override` keyword is used to replace the implementation of properties and methods in derived classes, but it can only be used in conjunction with properties or methods declared `virtual`, `abstract`, or `override`.
* The `virtual` keyword allows you to declare an implementation in the base class that can be overridden
* The `abstract` keyword allows you to declare a method or property that is not implemented in an `abstract` base class, but _must_ be overridden in the derived class.

## Drink Class and Enum
Finally, you will need to create a class to represent the drinks available at Franks 'N Such.  Franks 'N Such only carries 8.1oz cans, so the class is straightforward.  Instead of using derived classes like we did with the dog classes, we'll use an enumeration to represent the possible flavors.  

### DrinkFlavor Enum
Declare an enumeration to list the flavors of drink available.  These are:
* RCCola
* CherryRCCola
* 7UP
* BigRed
* DrPepper

### Drink Class
Declare a  implement a class `Drink` in the file _Drink.cs_ in the `FranksNSuch.Data` namespace that represents the drinks available at Franks 'N Such.  It should have the following properties:

`Flavor`: An property with the `DrinkFlavor` enum type.  It should default to `DrinkFlavor.RCCola`.

`Name`: A read-only `string` property that is a string representing the name of the drink, i.e. `"RC Cola"` for `DrinkFlavor.RCCola`.  It should be in human-readable form (i.e. not _camel case_ or _Pascal case_).  The exact spelling is found in the table below.

`Description`: A read-only `string` property which is `"8.1oz can"` followed by the name of the drink, i.e. `"8.1oz can RC Cola"`

`Price`: A read-only `decimal` representing the price of the drink.  All drinks are $1.50.

`Calories`: A read-only `uint` representing the calories in the drink, which varies according to the flavor. The various values can be found in the table below:

<table>
  <tr>
    <th>DrinkFlavor</th>
    <th>Name</th>
    <th>Calories</th>
  </tr>
  <tr>
    <td>RCCola</td>
    <td>RC Cola</td>
    <td>160</td>
  </td>
  <tr>
    <td>CherryRCCola</td>
    <td>Cherry RC Cola</td>
    <td>110</td>
  </td>  
  <tr>
    <td>7UP</td>
    <td>7UP</td>
    <td>140</td>
  </td>  
  <tr>
    <td>BigRed</td>
    <td>Big Red</td>
    <td>100</td>
  </td>
  <tr>
    <td>DrPepper</td>
    <td>Dr Pepper</td>
    <td>93</td>
  </td>
</table>

### Submissions

* Create a new release tag - Submit the release URL

  * If you do not remember how to do this, please revisit the [Create a Release page]({{<ref "b-git-and-github/11-release">}})

  * Keep in mind the version!!!

### Review of the week

* [C# Inheritance](https://docs.microsoft.com/en-us/dotnet/csharp/fundamentals/object-oriented/inheritance)