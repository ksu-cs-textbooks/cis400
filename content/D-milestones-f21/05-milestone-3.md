---
title: "Milestone 3 Requirements"
pre: "5. "
weight: 50
date: 2018-08-24T10:53:26-05:00
---

For this milestone, you will be creating base classes for entrées, sides, treats, and drinks served at GyroScope. This will involve refactoring some already written classes, as well as adding some new ones.  

### General requirements:

* You need to follow the style laid out in the [C# Coding Conventions](https://docs.microsoft.com/en-us/dotnet/csharp/programming-guide/inside-a-program/coding-conventions)

### Assignment requirements:

You will need to:

* Address the spelling errors found in Milestone 2
* Create base classes for:
    * Sides
    * Entrees
    * Treats
    * Drinks
* Create a base class for Gyros
* Create new enum for:
    * SodaFlavors
* Create new classes for:
    * Cancer Helvah Cake
    * Libra Libation
    * Capricorn Mountain Tea
* Refactor existing classes to use inhertance

### Purpose:

This milestone serves to introduce and utilize aspects of polymorphism including base classes, abstract base classes, abstract methods, virtual methods, and method overriding.  While the actual programming invovled is straightforward, the concepts invovled can be challenging to master. If you have any confusion after you have read the entire assignment please do not hesitate to reach out to a Professor Bean, the TAs, or your classmates over Discord.

### Spelling Errors

GyroScope HQ is upset that a number of spelling errors were found in signature GyroScope dishes.  These must be addressed in this new milestone.  Specifically:

* "Ares" should be "Aries"
* "Pices" should be "Pisces"

You will need to correct these misspellings in all class names, file names, and comments.

{{% notice tip %}}
In Visual Studio, you can right-click on a symbol like a class or variable name and choose **Rename** from the context menu.  Then, type the correction and hit enter, and it will update the symbol everywhere it appears in your code.  You can also mark the checkbox to update it in comments.
{{% /notice %}}

### Abstract Base Classes
You will need to create a base class for each of the kinds of items served at GyroScope: _Entrees_, _Sides_, _Treats_, and _Drinks_. Becuase you will never instanicate one of these classes directly i.e. you would never write:

```csharp
Side side = new Side();
```

But rather:

```csharp 
Side side = new TaurusTabuleh();
```

You will want to declare these base classes `abstract`.

As you create these base classes, carefully consider what properties all items in that category have in common.  These properties should then be implemented in the base class, which will be one of the following:
* **A regular property** if the exact same functionality will be used in the derived classes and should never need to change,
* **A `virtual` property** if the exact same functionality will be used in almost all derived classes, but at least one is a special case, or
* **An `abstract` property** if the derived classes all have the same property but the returned values are different for each one.

Each abstract base class should be placed in the corresponding file and namespace, i.e. the class `Side` should be declared in the `GyroScope.Data.Sides` namespace and in a file named _Side.cs_.  The classes you need to implement are `Entree`, `Side`, `Treat`, and `Drink`.

To give you a head start, your `Treat` base class should look like:

```csharp
namespace GyroScope.Data.Treats
{
    /// <summary>
    /// A base class for all treats sold at GyroScope
    /// </summary>
    public abstract class Treat
    {
        /// <summary>
        /// The price of the treat
        /// </summary>
        public abstract decimal Price { get; }

        /// <summary>
        /// The calories of the treat
        /// </summary>
        public abstract uint Calories { get; }
    }
}
```

### Create a Gyro Base Class
Another issue GyroScope HQ has identified with the milestone 2 design is that customers expect to and routinely do completely customize a Gyro - substituting ingredients normally found in one Gyro into another one (such as adding wing sauce and peppers to a LeoLambGyro).  The GyroScope software will need to support this.

The solution that you will be adopting is to create a base Gyro class that contains _all_ the possible ingredient properties from the different Gyros available at GyroScope.  This base class should be named `Gyro`.  This `Gyro` class should inherit from the `Entree` class.  The other Gyro classes (`VirgoClassicGyro`, `LeoLambGyro`, and `ScorpioSpicyGyro`) should inherit from this class, and set the appropriate default values for the boolean and enumeration properties through a parameterless constructor.

### Create new Enum 
You will need to create a new enum in the `GyroScope.Data.Enums` namespace to represent the soda flavors offered at GryoScope which should be named `LibraLibationFlavor` and contain:
* `Orangeade`
* `SourCherry`
* `Biral`
* `PinkLemonada`

### Create new Classes
You will need to create three new classes, `CancerHalvehCake`, `LibraLibation`, and `CapricornMountainTea`.

#### CancerHalvehCake
The class `CancerHalvehCake` should be declared in the `GyroScope.Data.Treats` namespace.  It should inherit from the `Treat` base class.  It's price is $3.00 and it has 272 calories.

#### LibraLibation
The class `LibraLibation` should be declared in the `GyroScope.Data.Drinks` namespace.  It represents a Greek soda.  It should have a `Flavor` property of type `LibraLibationFlavor` with getters and setters. It should also have a `bool` property for `Sparkling` (carbonated) which should default to `true`.  It should have a `Calories` get-only property of type `uint` and a `Price` property of type `decimal` using the values laid out in the table below.  It should also have a `Name` get-only property, which should return a `string` in the form `"[Still or Sparkling] [Flavor] Libra Libation"` where `[Still or Sparkling]` is _Still_ if the `Sparkling` property is `false`, and _Sparkling_ if it is `true`, and `[Flavor]` is _Orangeade_, _Sour Cherry_, _Biral_, or _Pink Lemonada_ (based on the `Flavor` property).  **Note the use of spaces in the flavor.**

<table>
  <tr>
    <th>Flavor</th>
    <th>Price</th>
    <th>Calories</th>
  </tr>
  <tr>
    <td>Orangeade</td>
    <td>$1.00</td>
    <td>180</td>
  </tr>
  <tr>
    <td>Sour Cherry</td>
    <td>$1.00</td>
    <td>100</td>
  </tr>
  <tr>
    <td>Biral</td>
    <td>$1.00</td>
    <td>120</td>
  </tr>
  <tr>
    <td>Pink Lemonada</td>
    <td>$1.00</td>
    <td>41</td>
  </tr>
</table>

#### CapricornMountainTea
The class `CapricornMountainTea` should alsobe declared in the `GryoScope.Data.Drinks` namespace.  It represents a tea brewed from the ironwort plant.  It should have a `Price` property of type `Decimal` that returns $2.50, and a `Calories` property of type `uint` that returns 0 calories.  It should also have a boolean property `Honey` indicating the tea is sweetened with honey that defaults to `false`.  If it is `true`, the `Calories` property should instead return 64.

### Refactor Existing Classes to use Inheritance
Once you have the `Side` base class, refactor your existing side classes (`TaurusTabuleh`, `GeminiStuffedGrapeLeaves`, `SagittariusGreekSalad`, and `AriesFries`) to inherit from it.  You will also want to refactor their existing properties as they should now inherit many of them from the base class; some may be deleted, others will need to be refactored as overridden methods by adding the `override` keyword.  

Likewise you will want to refactor the exisiting entree base classes (`VirgoClassicGyro`,
`ScorpioSpicyGyro`, `LeoLambGyro`, and `PiscesFishDish`) to inherit from the `Entree` base class.  You will want to refactor thier properties as well.

Finally, you will want to refactor the exisiting treat class `AquariusIce` to inherit from the `Treat` base class and also refactor its properties as needed.

## The Milestone Feature Branch 

You will want to [create a feature branch and push it to GitHub]({{<ref "D-milestones-f21/02-feature-branches">}}) for your validations to be generated on https://pendant.cs.ksu.edu.  For this milestone, your feature branch should be named `ms3`.  

## Submitting the Assignment

Once your project is complete, merge your feature branch back into the `main` branch and [create a release]({{<ref "B-git-and-github/11-release">}}) tagged `v0.3.0` with name `"Milestone 3"`.  Copy the URL for the release page and submit it to the Canvas assignment.

## Grading Rubric

The grading rubric for this assignment will be:

**25% Structure** Did you implement the structure as laid out in the specification?  Are the correct names used for classes, enums, properties, methods, events, etc?  Do classes inherit from expected base classes?

**25% Documentation** Does every class, method, property, and field use the correct XML-style documentation?  Does every XML comment tag contain explainitory text?

**25% Design** Are you appropriately using C# to create reasonably efficient, secure, and usable software?  Does your code contain bugs that will cause issues at runtime?

**25% Functionality** Does the program do what the assignment asks?  Do properties return the expected values?  Do methods perform the expected actions?

{{% notice warning %}}
Projects that do not compile will recieve an automatic grade of 0.
{{% /notice %}}