---
title: "Milestone 2 Requirements"
pre: "4. "
weight: 40
date: 2018-08-24T10:53:26-05:00
---


For this milestone, you will be creating classes to represent the entrées and sides served at "GyroScope" - a fast-food franchise focused on gyros with an astrology theme.  These will be created within the _Data_ project of the solution you accepted from GitHub classroom.

### General requirements:

* You need to follow the style laid out in the [C# Coding Conventions](https://docs.microsoft.com/en-us/dotnet/csharp/programming-guide/inside-a-program/coding-conventions)

### Assignment requirements:

You will need to create

* Enums (1) representing:
    * The various Doner meats available

* Side classes (4) representing:
    * Taurus Tabouleh
    * Gemini Stuffed Grape Leaves
    * Sagittarius Greek Salad
    * Aries Fries

* Entree classes (4) representing:
    * Virgo Classic Gyro
    * Scorpio Spicy Gyro
    * Leo Lamb Gyro
    * Pisces Fish Dish



### Purpose:

This milestone serves as a review of how to create classes and sets the stage for the rest of the semester. Everything included in this assignment you should have been exposed to before in CIS200 and CIS300. This assignment should be relatively straightforward, though it will take some time to complete. If you have any confusion after you have read the entire assignment please do not hesitate to reach out to a Professor Bean, the TAs, or your classmates over Discord.

### Recommendations:

* Get in the habit of reading the entire assignment before you start to code. Make sure you understand what is being asked of you. Please do not get ahead of yourself and have to redo work because you did not read the entire assignment.

* Accuracy is _important_.  Your class, property, enumeration and other names, along with the descriptions _must match the specification given here_.  Otherwise, your code is **not correct**.  While typos may be a small issue in writing intended for human consumption, in computer code _it is a big problem!_ 

* Remember that you must document your classes.  This was covered in prior courses and also discussed in [chapter 3]({{% ref "1-object-orientation/03-documentation" %}}) of your textbook.

* The Pendant web app can help verify the structure and functionality of your application if you push your feature branch to GitHub.

## Enum Classes 

All enums should reside in the `GyroScope.Data.Enums` namespace

There is one additional enum needed:

* `DonerMeat` - The various kinds of spiced meat prepared on a spit
  * Beef
  * Pork
  * Chicken
  * Lamb


#### Side Classes
GyroScope offers 4 sides:

* Ares Fries
* Gemini Stuffed Grape Leaves
* Sagittarius Greek Salad
* Taurus Tabuleh

Each should have a class declared for it, in its own file.  All sides should default to the small size.  All sides should be declared in the `GyroScope.Data.Sides` namespace and coresponding files placed in a _Sides_ folder of the `Data` project.

#### Ares Fries
You will need to define a class to represent a side of Ares Fries, which can be customized after creation.  You should name this class `AresFries` and declare it in the file _AresFries.cs_.  It should have the following properties:

`Size`: A property with the `Size` enum type, indicating how large the serving of fries is

`Price`: A readonly property (i.e. it has only a `get` and no `set`) of type `decimal` which is 1.50 for small, 2.00 for medium, and 2.50 for large.

`Calories`: A readonly property of type `uint` which is 304 calories for small, 456 for medium, and 608 calories for large.

#### Gemini Stuffed Grape Leaves
You will need to define a class to represent a side of Gemini Stuffed Grape Leaves, which can be customized after creation.  You should name this class `GeminiStuffedGrapeLeaves` and declare it in the file _GeminiStuffedGrapeLeaves.cs_ in the `GyroScope.Data.Sides` namespace.  It should have the following properties:

`Size`: A property with the `Size` enum type, indicating how large the serving of stuffed grape leaves is.

`Price`: A readonly property (i.e. it has only a `get` and no `set`) of type `decimal` which is 1.50 for small, 2.00 for medium, and 2.50 for large.

`Calories`: A readonly property of type `uint` which is 360 calories for small, 540 for medium, and 720 calories for large.

#### Sagittarius Greek Salad
You will need to define a class to represent a side of sagittarius greek salad, which can be customized after creation.  You should name this class `SagittariusGreekSalad` and declare it in the file _SagittariusGreekSalad.cs_.  It should have the following properties:

`Size`: A property with the `Size` enum type, indicating how large the serving of greek salad is.

`Price`: A readonly property (i.e. it has only a `get` and no `set`) of type `decimal` which is 2.00 for small, 2.50 for medium, and 3.00 for large.

`Calories`: A readonly property of type `uint` which is 180 calories for small, 270 for medium, and 360 calories for large.

#### Taurus Tabuleh
You will need to define a class to represent a side of Tarus tabuleh, which can be customized after creation.  You should name this class `TaurusTabuleh` and declare it in the file _TarusTabuleh.cs_.  It should have the following properties:

`Size`: A property with the `Size` enum type, indicating how large the serving of tabuleh is.

`Price`: A readonly property (i.e. it has only a `get` and no `set`) of type `decimal` which is 1.50 for small, 2.00 for medium, and 2.50 for large.

`Calories`: A readonly property of type `uint` which is 124 calories for small, 186 for medium, and 248 calories for large.


## Entree Classes
GyroScope offers 4 entrees:

* Virgo Classic Gyro
* Leo Lamb Gyro
* Scorpio Spicy Gyro
* Pices Fish Dish

Each should have a class declared for it, in its own file.  All entrees should be declared in the `GyroScope.Data.Entrees` namespace and coresponding files placed in a _Entrees_ folder of the `Data` project.

#### Virgo Classic Gyro
You will need to define a class to represent the Virgo Classic Gyro, which can be customized after creation.  You should name this class `VirgoClassicGyro` and declare it in the file _VirgoClassicGyro.cs_.  It should have the following properties:

`Meat`: A property with the `DonerMeat` enum type, indicating what kind of meat this Gyro is prepared with.  It should default to Pork.

`Pita`: A property with the `bool` type, indicating if this gyro should be served with a pita bread wrap.  It should default to true.

`Tomato`: A property with the `bool` type, indicating this gyro should be served with tomato.  It should default to true.

`Onion`: A property with the `bool` type, indicating this gyro should be served with onion.  It should default to true.

`Lettuce`: A property with the `bool` type, indicating this gyro should be served with lettuce.  It should default to true.

`Tzatziki`: A property with the `bool` type, indicating this gyro should be served with tzatziki sauce.  It should default to true.

`Price`: A readonly property with the `decimal` type, it should return $5.50.

`Calories`: A readonly property with the `uint` type, it should return the calories for this gyro, calculated using the calories table below based on what ingredients the gyro contains (i.e. if tomatoes are left out, the overall calories of the gyro would be 30 calories less).

`SpecialInstructions`: A readonly property with the `IEnumerable<string>` type, it should contain a string `"Hold [ingredient]"` for any ingredient indicated by a `bool` that is false, i.e. if the `Tomato` property is false, it should contain a string `"Hold Tomato"`.  Additionally, if the meat selected is not the default, it should contain a string `"Use [meat]"` indicating the type of meat to use, i.e. `"Use Lamb"` if the `Meat` property is set to `DonerMeat.Lamb`.

{{% notice tip %}}
The type `IEnumerable<T>` is an interface, so you can't create one directly.  intead, create an instance of one of the classes that implement this interface, like any of the familiar C# generic collections: `List<T>`, `Queue<T>`, `Stack<T>`, `HashSet<T>`, or `LinkedList<T>`.  You can return one of these from the `SpecialInstructions` property.
{{% /notice %}}

#### Scorpio Spicy Gyro
You will need to define a class to represent the Scorpio Spicy Gyro, which can be customized after creation.  You should name this class `ScorpioSpicyGyro` and declare it in the file _ScorpioSpicyGyro.cs_.  It should have the following properties:

`Meat`: A property with the `DonerMeat` enum type, indicating what kind of meat this Gyro is prepared with.  It should default to Chicken.

`Pita`: A property with the `bool` type, indicating if this gyro should be served with a pita bread wrap.  It should default to true.

`Peppers`: A property with the `bool` type, indicating this gyro should be served with peppers.  It should default to true.

`Onion`: A property with the `bool` type, indicating this gyro should be served with onion.  It should default to true.

`Lettuce`: A property with the `bool` type, indicating this gyro should be served with lettuce.  It should default to true.

`WingSauce`: A property with the `bool` type, indicating this gyro should be served with wing sauce.  It should default to true.

`Price`: A readonly property with the `decimal` type, it should return $6.20.

`Calories`: A readonly property with the `uint` type, it should return the calories for this gyro, calculated using the calories table below based on what ingredients the gyro contains (i.e. if tomatoes are left out, the overall calories of the gyro would be 30 calories less).

`SpecialInstructions`: A readonly property with the `IEnumerable<string>` type, it should contain a string `"Hold [ingredient]"` for any ingredient indicated by a `bool` that is false, i.e. if the `Onion` property is false, it should contain a string `"Hold Onion"`.  Additionally, if the meat selected is not the default, it should contain a string `"Use [meat]"` indicating the type of meat to use, i.e. `"Use Lamb"` if the `Meat` property is set to `DonerMeat.Lamb`.

#### Leo Lamb Gyro
You will need to define a class to represent the Leo Lamb Gyro, which can be customized after creation.  You should name this class `LeoLambGyro` and declare it in the file _LeoLambGyro.cs_.  It should have the following properties:

`Meat`: A property with the `DonerMeat` enum type, indicating what kind of meat this Gyro is prepared with.  It should default to Lamb.

`Pita`: A property with the `bool` type, indicating if this gyro should be served with a pita bread wrap.  It should default to true.

`Tomato`: A property with the `bool` type, indicating this gyro should be served with tomato.  It should default to true.

`Onion`: A property with the `bool` type, indicating this gyro should be served with onion.  It should default to true.

`EggPlant`: A property with the `bool` type, indicating this gyro should be served with eggplant.  It should default to true.

`Lettuce`: A property with the `bool` type, indicating this gyro should be served with lettuce.  It should default to true.

`MintChutney`: A property with the `bool` type, indicating this gyro should be served with mint chutney sauce.  It should default to true.

`Price`: A readonly property with the `decimal` type, it should return $5.75.

`Calories`: A readonly property with the `uint` type, it should return the calories for this gyro, calculated using the calories table below based on what ingredients the gyro contains (i.e. if tomato is left out, the overall calories of the gyro would be 30 calories less).

`SpecialInstructions`: A readonly property with the `IEnumerable<string>` type, it should contain a string `"Hold [ingredient]"` for any ingredient indicated by a `bool` that is false, i.e. if the `Tomato` property is false, it should contain a string `"Hold Tomato"`.  Additionally, if the meat selected is not the default, it should contain a string `"Use [meat]"` indicating the type of meat to use, i.e. `"Use Beef"` if the `Meat` property is set to `DonerMeat.Beef`.

#### Pisces Fish Dish
You will need to define a class to represent the Pisces Fish Dish, which can be customized after creation.  You should name this class `PiscesFishDish` and declare it in the file _PiscesFishDish.cs_.  It should have the following properties:

`Price`: A readonly property with the `decimal` type, it should return $5.99.

`Calories`: A readonly property with the `uint` type, it should return 726.

`SpecialInstructions`: A readonly property with the `IEnumerable<string>` type, it should always be empty.

### Calories Table
The calories for each ingredient is:

<table>
  <tr>
    <th>Ingredient</th>
    <th>Calories</th>
  </tr>
  <tr>
    <td>Pork</td>
    <td>187</td>
  </tr>
  <tr>
    <td>Lamb</td>
    <td>151</td>
  </tr>
  <tr>
    <td>Chicken</td>
    <td>113</td>
  </tr>
  <tr>
    <td>Beef</td>
    <td>181</td>
  </tr>
  <tr>
    <td>Pita</td>
    <td>262</td>
  </tr>
  <tr>
    <td>Tomato</td>
    <td>30</td>
  </tr>
  <tr>
    <td>Onion</td>
    <td>30</td>
  </tr>
  <tr>
    <td>Lettuce</td>
    <td>54</td>
  </tr>
  <tr>
    <td>Tzatziki</td>
    <td>30</td>
  </tr>
  <tr>
    <td>Peppers</td>
    <td>33</td>
  </tr>
  <tr>
    <td>Wing Sauce</td>
    <td>15</td>
  </tr>
  <tr>
    <td>Eggplant</td>
    <td>47</td>
  </tr>
  <tr>
    <td>Mint Chutney</td>
    <td>10</td>
  </tr>
</table>


## The Milestone Feature Branch 
You will want to [create a feature branch and push it to GitHub]({{% ref "D-milestones-f21/02-feature-branches" %}}) for your validations to be generated on https://pendant.cs.ksu.edu.  For this milestone, your feature branch should be named `ms2`.  

## Submitting the Assignment
Once your project is complete, merge your feature branch back into the `main` branch and [create a release]({{% ref "B-git-and-github/12-release" %}}) tagged `v0.2.0` with name `"Milestone 2"`.  Copy the URL for the release page and submit it to the Canvas assignment.

## Grading Rubric
The grading rubric for this assignment will be:

**25% Structure** Did you implement the structure as laid out in the specification?  Are the correct names used for classes, enums, properties, methods, events, etc?  Do classes inherit from expected base classes?

**25% Documentation** Does every class, method, property, and field use the correct XML-style documentation?  Does every XML comment tag contain explainitory text?

**25% Design** Are you appropriately using C# to create reasonably efficient, secure, and usable software?  Does your code contain bugs that will cause issues at runtime?

**25% Functionality** Does the program do what the assignment asks?  Do properties return the expected values?  Do methods perform the expected actions?

{{% notice warning %}}
Projects that do not compile will recieve an automatic grade of 0.
{{% /notice %}}