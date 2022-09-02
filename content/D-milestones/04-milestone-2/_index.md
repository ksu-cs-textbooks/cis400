+++
title = "Milestone 2 Requirements"
pre = "4. "
weight = 40
date = 2018-08-24T10:53:26-05:00
+++

{{% notice noiframe %}}
This textbook was authored for the **CIS 400 - Object-Oriented Design, Implementation, and Testing** course at Kansas State University.  This section describes assignments specific to the **Fall 2022** offering of that course.  Prior semester offerings can be found [here](old). If you are not enrolled in the course, please disregard this section.
{{% /notice %}}


For this milestone, you will be creating classes to represent the offerings of the "Dino Diner" - a prehistoric-themed fast-food franchise.  These will be created within the _Data_ project of the solution you accepted from GitHub classroom.

### General requirements:

* You need to follow the style laid out in the [C# Coding Conventions](https://docs.microsoft.com/en-us/dotnet/csharp/programming-guide/inside-a-program/coding-conventions)

* You need to document your code using [XML-style comments](https://docs.microsoft.com/en-us/dotnet/csharp/language-reference/xmldoc/recommended-tags), with a minimum of `<summary>` tags, plus `<param>`, `<returns>`, and `<exception>` as appropriate.  

### Assignment requirements:

You will need to create

* Enums (4) representing:
    * The serving sizes available

* Classes (4) representing entrees:
    * Brontowurst (Bratwurst with peppers and onions in a bun)
    * DinoNuggets (Six crispy fried breaded chicken nuggets)
    * Pterodactyl Wings (Chicken wings glazed with a signature hot sauce)
    * Veloci-Wrap (A chicken cesar wrap) 

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

All enums should reside in the `DinoDiner.Data.Enums` namespace and be placed in an _Enums_ folder within the Data project in your solution.  Each should be placed in a file named according to the enum, i.e. `ServingSize` should be defined in _ServingSize.cs_.

The needed enumerations are:

* `WingSauce` - Sauces available for wings 
  * Buffalo
  * Teriyaki 
  * Honey Glaze

* `ServingSize` - The size of the menu item
  * Small
  * Medium
  * Large

To get you started, here's the `ServingSize` enum defined:

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

## Entree Menu Item Classes

All Entree menu item classes should reside in the `DinoDiner.Data.Entrees` namespace and be placed in the _Entrees_ folder within the Data project in your solution. One entree, Prehistoric PB&J, has been provided for you as an example.

The needed classes are:

#### Brontowurst
You will need to define a class to represent a Brontowurst (a brautwurst with fried peppers and onions served in a bun), which can be customized after creation.  You should name this class `Brontowurst` and declare it in the file _Brontowurst.cs_.  It should have the following properties:

`Name`: A `string` that is always "Brontowurst".

`Price`: A getter-only property (i.e. it has only a `get` and no `set`) of type `decimal` with a value of $5.86.

`Calories`: A getter-only property of type `uint` with a value of 512.

`Onions`: A boolean property indicating if the Brontowurst is served with onions defaulting to `true`.

`Peppers`: A boolean property indicating if the Brontowurst is served with peppers defaulting to `true`.

#### Dino Nuggets
You will need to define a class to represent a serving of Dino Nuggets (chicken nuggets), which can be customized after creation.  You should name this class `DinoNuggets` and declare it in the file _DinoNuggets.cs_.  It should have the following properties:

`Name`: A `string` that is "[count] Dino Nuggets", where [count] is the number of nuggets.

`Count`: A `uint` property indicating the number of dino nuggets (defaults to 6).

`Price`: A getter-only property (i.e. it has only a `get` and no `set`) of type `decimal` with a value of $0.25 per nugget.

`Calories`: A getter-only property with type `uint` and a value of 61 per nugget.

#### Pterodactyl Wings
You will need to define a class to represent a serving of Pterodactyl Wings (Chicken Wings), which can be customized after creation.  You should name this class `PterodactylWings` and declare it in the file _PterodactylWings.cs_.  It should have the following properties:

`Name`: A `string` that is "[wing sauce] Pterodactyl Wings", where [wing sauce] is one of "Buffalo", "Teriyaki", or "Honey Glaze", corresponding to the `Sauce` property value.

`Sauce`: A property with the `Sauce` enum type, indicating the sauce to use on the wings (default `WingSauce.Buffalo`).

`Price`: A getter-only property (i.e. it has only a `get` and no `set`) of type `decimal` with a value of $8.95.

`Calories`: A getter-only property with type `uint` and a value of 360 for Buffalo wings, 342 for Teriyaki wings, or 359 for Honey Glaze wings.

#### Veloci-Wraptor
You will need to define a class to represent a Veloci-Wraptor (a Caesar chicken wrap), which can be customized after creation.  You should name this class `VelociWraptor` and declare it in the file _VelociWraptor.cs_.  It should have the following properties:

`Name`: A `string` that is always "Veloci-Wraptor".

`Price`: A getter-only property (i.e. it has only a `get` and no `set`) of type `decimal` with a value of $6.25.

`Calories`: A getter-only property with type `uint` and a value of 732. If served without dressing, this is reduced by 94 calories. If served without cheese, this is reduced by 22 calories.

`Dressing`: A boolean property indicating if the wrap is served with Caesar dressing (defaults to `true`).

`Cheese`: A boolean property indicating if the wrap is served with parmesan cheese (defaults to `true`).


## Side Menu Item Classes

All side menu item classes should reside in the `DinoDiner.Data.Sides` namespace and be placed in the _Sides_ folder within the Data project in your solution. Side menu items all come in three sizes - small, medium, or large, and the price and calories vary based on the size. 

The needed classes are:

#### Fryceritops
You will need to define a class to represent Fryceritops (French fries), which can be customized after creation.  You should name this class `Fryceritops` and declare it in the file _Fryceritops.cs_.  It should have the following properties:

`Name`: A `string` that is "[Size] Fryceritops" where [Size] is the serving size of the item, i.e. "Small Fryceritops" for when the `Size` property is small.

`Salt`: A boolean property indicating that the fries should be served with salt, defaults to `true`.

`Sauce`: A boolean property indicating that the fries should be served with fry sauce, defaults to `false`.

`Size`: A property of type `ServingSize`.

`Price`: A getter-only property (i.e. it has only a `get` and no `set`) of type `decimal` with a value of $3.50 for small, $4.00 for medium, and $5.00 for large.

`Calories`: A readonly property of type `uint` with a value of 365 for small, 465 for medium, or 510 for large, _plus_ an additional 80 calories if `Sauce` is true.

#### Meteor Mac & Cheeese
You will need to define a class to represent Meteor Mac & Cheese (Mac and Cheese with sausage bites), which can be customized after creation.  You should name this class `MeteorMacAndCheese` and declare it in the file _MeteorMacAndCheese.cs_.  It should have the following properties:

`Name`: A `string` that is "[Size] Meteor Mac & Cheese" where [Size] is the serving size of the item, i.e. "Small Meteor Mac & Cheese" for when the `Size` property is small.

`Size`: A property of type `ServingSize`.

`Price`: A getter-only property (i.e. it has only a `get` and no `set`) of type `decimal` with a value of $3.50 for small, $4.00 for medium, and $5.25 for large.

`Calories`: A readonly property of type `uint` with a value of 425 for small, 510 for medium, or 700 for large.

#### Mezzorealla Sticks
You will need to define a class to represent Mezzorella Sticks (breaded and deep-fried mozzarella cheese sticks), which can be customized after creation.  You should name this class `MezzorellaSticks` and declare it in the file _MezzorellaSticks.cs_.  It should have the following properties:

`Name`: A `string` that is "[Size] Mezzorella Sticks" where [Size] is the serving size of the item, i.e. "Small Mezzorella Sticks" for when the `Size` property is small.

`Size`: A property of type `ServingSize`.

`Price`: A readonly property (i.e. it has only a `get` and no `set`) of type `decimal` with a value of $3.50 for small, $4.00 for medium, and $5.25 for large.

`Calories`: A readonly property of type `uint` with a value of 530 for small, 620 for medium, or 730 for large.

#### Triceritots 
You will need to define a class to represent Triceritots (tater tots), which can be customized after creation.  You should name this class `Triceritots` and define it in a file named _Triceritots.cs_.  It should have the following properties:

`Name`: A `string` that is "[Size] Triceritots" where [Size] is the serving size of the item, i.e. "Small Triceritots" for when the `Size` property is small.

`Size`: A property of type `ServingSize`.

`Price`: A getter-only property (i.e. it has only a `get` and no `set`) of type `decimal` with a value of $3.50 for small, $4.00 for medium, and $5.25 for large.

`Calories`: A readonly property of type `uint` with a value of 351 for small, 409 for medium, or 583 for large.

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