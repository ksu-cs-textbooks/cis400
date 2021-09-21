---
title: "Milestone 4 Requirements"
pre: "6. "
weight: 60
date: 2018-08-24T10:53:26-05:00
---

For this milestone, you will be creating unit tests for the entrée, side, treat, and drink classes you have defined in the `Data` project. If these tests expose issues in your existing code, you will also want to fix them.  Finally, you will be creating a UML diagram for your `Data` project.

### General requirements:

* You need to follow the style laid out in the [C# Coding Conventions](https://docs.microsoft.com/en-us/dotnet/csharp/programming-guide/inside-a-program/coding-conventions)

### Assignment requirements:

You will need to:

* Create unit test classes for:
    * VirgoClassicGyro
    * LeoLambGyro
    * ScorpioSpicyGyro
    * PiscesFishDish
    * AriesFries
    * GeminiStuffedGrapeLeaves
    * SagittariusGreekSalad
    * TaurusTabuleh
    * CancerHelvahCake
    * LibraLibation
    * CapricornMountainTea
* Create a UML diagram for the entire `GyroScope.Data` project.

### Purpose:

This milestone serves to introduce the writing of unit tests.  The real challenge of writing a unit test is not the programming involved, but rather, identifying _what_ you need to test for.  You should make sure that methods and properties behave as expected when used as expected. But you must also account for _edge cases_, where the objects are manipulated in unexpected ways.  If you have any confusion after you have read the entire assignment please do not hesitate to reach out to a Professor Bean, the TAs, or your classmates over Discord.

### Writing Tests
You will need to create an XUnit unit test class in your `DataTests` project for each Entree, Side, Drink, and Treat class in the `Data` project.  These test classes must contain (at a minimum) the test methods described below.  You may add additional methods.

In addition, when a test method takes parameters, you will need to provide corresponding `[InlineData()]` attributes to be used by the test runner as arguments for those parameters.  You should supply enough attributes to either 1) be exhaustive (cover all possibilities), or 2) cover a number of expected cases and any edge cases.  As a rule of thumb for this course, use at least 8 `[InlineData()]` options if there are more than 8 possible permutations.

The _AquariusIceTests.cs_ contains unit tests for the `AquariusIce` class, which you can use as a reference.  You will also want to add these tests to that class:

```csharp
[Theory]
[InlineData(Size.Small)]
[InlineData(Size.Medium)]
[InlineData(Size.Large)]
public void ShouldBeAbleToSetSize(Size size)
{
    var ice = new AquariusIce() { Size = size };
    Assert.Equal(size, ice.Size);
}

[Theory]
[InlineData(Size.Small, AquariusIceFlavor.BlueRaspberry, "Small BlueRaspberry Aquarius Ice")]
[InlineData(Size.Small, AquariusIceFlavor.Lemon, "Small Lemon Aquarius Ice")]
[InlineData(Size.Small, AquariusIceFlavor.Mango, "Small Mango Aquarius Ice")]
[InlineData(Size.Small, AquariusIceFlavor.Orange, "Small Orange Aquarius Ice")]
[InlineData(Size.Small, AquariusIceFlavor.Strawberry, "Small Strawberry Aquarius Ice")]
[InlineData(Size.Small, AquariusIceFlavor.Watermellon, "Small Watermellon Aquarius Ice")]
[InlineData(Size.Medium, AquariusIceFlavor.BlueRaspberry, "Medium BlueRaspberry Aquarius Ice")]
[InlineData(Size.Medium, AquariusIceFlavor.Lemon, "Medium Lemon Aquarius Ice")]
[InlineData(Size.Medium, AquariusIceFlavor.Mango, "Medium Mango Aquarius Ice")]
[InlineData(Size.Medium, AquariusIceFlavor.Orange, "Medium Orange Aquarius Ice")]
[InlineData(Size.Medium, AquariusIceFlavor.Strawberry, "Medium Strawberry Aquarius Ice")]
[InlineData(Size.Medium, AquariusIceFlavor.Watermellon, "Medium Watermellon Aquarius Ice")]
[InlineData(Size.Large, AquariusIceFlavor.BlueRaspberry, "Large BlueRaspberry Aquarius Ice")]
[InlineData(Size.Large, AquariusIceFlavor.Lemon, "Large Lemon Aquarius Ice")]
[InlineData(Size.Large, AquariusIceFlavor.Mango, "Large Mango Aquarius Ice")]
[InlineData(Size.Large, AquariusIceFlavor.Orange, "Large Orange Aquarius Ice")]
[InlineData(Size.Large, AquariusIceFlavor.Strawberry, "Large Strawberry Aquarius Ice")]
[InlineData(Size.Large, AquariusIceFlavor.Watermellon, "Large Watermellon Aquarius Ice")]
public void ShouldHaveTheRightNameForSizeAndFlavor(Size size, AquariusIceFlavor flavor, string name)
{
    var ice = new AquariusIce()
    {
        Size = size,
        Flavor = flavor
    };
    Assert.Equal(name, ice.Name);
}
```

#### VirgoClassicGyroTests
Create an XUnit test class, `VirgoClassicGyroTests` with the following test methods:
* `public void DefaultIngredientsShouldBeCorrect()` - verifies the boolean & enum properties of a newly constructed `VirgoClassicGyro` match the defaults set out in [Milestone 2]{{<ref "D-Milestones-f21/04-milestone-2">}}. 
* `public void PriceShouldBeCorrect()` - verifies the price matches the value set out in [Milestone 2]{{<ref "D-Milestones-f21/04-milestone-2">}}.
* `public void CaloriesShouldBeCorrect(DonerMeat meat, bool pita, bool tomato, bool peppers, bool eggplant, bool onion, bool lettuce, bool tzatziki, bool wingSauce, bool mintChutney, uint calories)` - verifies the calories match the values set out in [Milestone 2]{{<ref "D-Milestones-f21/04-milestone-2">}}.
* `public void SpecialInstructionsShouldReflectIngredients(DonerMeat meat, bool pita, bool tomato, bool peppers, bool eggplant, bool onion, bool lettuce, bool tzatziki, bool wingSauce, bool mintChutney, string[] expected)` - verifies the special instructions match the expectation set out in [Milestone 2]{{<ref "D-Milestones-f21/04-milestone-2">}}.

#### LeoLambGyroTests
Create an XUnit test class, `LeoLambGyroTests` with the following test methods:
* `public void DefaultIngredientsShouldBeCorrect()` - verifies the boolean & enum properties of a newly constructed `LeoLambGyro` match the defaults set out in [Milestone 2]{{<ref "D-Milestones-f21/04-milestone-2">}}. 
* `public void PriceShouldBeCorrect()` - verifies the price matches the value set out in [Milestone 2]{{<ref "D-Milestones-f21/04-milestone-2">}}.
* `public void CaloriesShouldBeCorrect(DonerMeat meat, bool pita, bool tomato, bool peppers, bool eggplant, bool onion, bool lettuce, bool tzatziki, bool wingSauce, bool mintChutney, uint calories)` - verifies the calories match the values set out in [Milestone 2]{{<ref "D-Milestones-f21/04-milestone-2">}}.
* `public void SpecialInstructionsShouldReflectIngredientsDonerMeat meat, bool pita, bool tomato, bool peppers, bool eggplant, bool onion, bool lettuce, bool tzatziki, bool wingSauce, bool mintChutney, string[] expected)` - verifies the special instructions match the expectation set out in [Milestone 2]{{<ref "D-Milestones-f21/04-milestone-2">}}.
        
#### SpicyScorpioGyroTests
Create an XUnit test class, `SpicyScorpioGyroTests` with the following test methods:
* `public void DefaultIngredientsShouldBeCorrect()` - verifies the boolean & enum properties of a newly constructed `SpicyScorpioGyro` match the defaults set out in [Milestone 2]{{<ref "D-Milestones-f21/04-milestone-2">}}. 
* `public void PriceShouldBeCorrect()` - verifies the price matches the value set out in [Milestone 2]{{<ref "D-Milestones-f21/04-milestone-2">}}.
* `public void CaloriesShouldBeCorrect(DonerMeat meat, bool pita, bool tomato, bool peppers, bool eggplant, bool onion, bool lettuce, bool tzatziki, bool wingSauce, bool mintChutney, uint calories)` - verifies the calories match the values set out in [Milestone 2]{{<ref "D-Milestones-f21/04-milestone-2">}}.
* `public void SpecialInstructionsShouldReflectIngredientsDonerMeat meat, bool pita, bool tomato, bool peppers, bool eggplant, bool onion, bool lettuce, bool tzatziki, bool wingSauce, bool mintChutney, string[] expected)` - verifies the special instructions match the expectation set out in [Milestone 2]{{<ref "D-Milestones-f21/04-milestone-2">}}.
        
#### PiscesFishDishTests
Create an XUnit test class, `PiscesFishDishTests` with the following test methods:
* `public void PriceShouldBeCorrect()` - verifies the price matches the expectation set out in [Milestone 2]{{<ref "D-Milestones-f21/04-milestone-2">}}.
* `public void CaloriesShouldBeCorrect()` - verifies the calories matches the expectation set out in [Milestone 2]{{<ref "D-Milestones-f21/04-milestone-2">}}.
* `public void SpecialInstructionsShouldBeEmpty()` - verifies the special instructions is an empty collection.

#### AresFriesTests
Create an XUnit test class, `AriesFriesTests` with the following test methods:
* `public void SizeShouldDefaultToSmall()` - verifies a newly created `AriesFries` is small.
* `public void ShouldBeAbleToSetSize(Size size)` - verifies an `AriesFries` can be set to be small, medium, or large.
* `public void PriceShouldBeCorrectForSize(Size size, decimal price)` - verifies the price for an `AriesFries` set to the specified size matches the expectation set out in [Milestone 2]{{<ref "D-Milestones-f21/04-milestone-2">}}.
* `public void CaloriesShouldBeCorrectForSize(Size size, uint calories)` - verifies the calories for an `AresFries` set to the the specified size the expectation set out in [Milestone 2]{{<ref "D-Milestones-f21/04-milestone-2">}}.

#### GeminiStuffedGrapeLeavesTests
Create an XUnit test class, `GeminiStuffedGrapeLeavesTests` with the following test methods:
* `public void SizeShouldDefaultToSmall()` - verifies a newly created `GeminiStuffedGrapeLeaves` is small.
* `public void ShouldBeAbleToSetSize(Size size)` - verifies an `GeminiStuffedGrapeLeaves` can be set to be small, medium, or large.
* `public void PriceShouldBeCorrectForSize(Size size, decimal price)` - verifies the price for an `GeminiStuffedGrapeLeaves` set to the specified size matches the expectation set out in [Milestone 2]{{<ref "D-Milestones-f21/04-milestone-2">}}.
* `public void CaloriesShouldBeCorrectForSize(Size size, uint calories)` - verifies the calories for an `GeminiStuffedGrapeLeaves` set to the the specified size the expectation set out in [Milestone 2]{{<ref "D-Milestones-f21/04-milestone-2">}}.

#### SagittariusGreekSaladTests
Create an XUnit test class, `SagittariusGreekSaladTests` with the following test methods:
* `public void SizeShouldDefaultToSmall()` - verifies a newly created `SagittariusGreekSalad` is small.
* `public void ShouldBeAbleToSetSize(Size size)` - verifies an `SagittariusGreekSalad` can be set to be small, medium, or large.
* `public void PriceShouldBeCorrectForSize(Size size, decimal price)` - verifies the price for an `SagittariusGreekSalad` set to the specified size matches the expectation set out in [Milestone 2]{{<ref "D-Milestones-f21/04-milestone-2">}}.
* `public void CaloriesShouldBeCorrectForSize(Size size, uint calories)` - verifies the calories for an `SagittariusGreekSalad` set to the the specified size the expectation set out in [Milestone 2]{{<ref "D-Milestones-f21/04-milestone-2">}}.

#### TaurusTabulehTests
Create an XUnit test class, `TaurusTabulehTests` with the following test methods:
* `public void SizeShouldDefaultToSmall()` - verifies a newly created `TaurusTabuleh` is small.
* `public void ShouldBeAbleToSetSize(Size size)` - verifies an `TaurusTabuleh` can be set to be small, medium, or large.
* `public void PriceShouldBeCorrectForSize(Size size, decimal price)` - verifies the price for an `TaurusTabuleh` set to the specified size matches the expectation set out in [Milestone 2]{{<ref "D-Milestones-f21/04-milestone-2">}}.
* `public void CaloriesShouldBeCorrectForSize(Size size, uint calories)` - verifies the calories for an `TaurusTabuleh` set to the the specified size the expectation set out in [Milestone 2]{{<ref "D-Milestones-f21/04-milestone-2">}}.

#### CancerHelvahCakeCakeTests
Create an XUnit test class, `CancerHelvahCakeTests` with the following test methods:
* `public void PriceShouldBeCorrect()` - verifies a newly created `CancerHevlahCake` has the price specified in [Milestone 3]{{<ref "D-Milestones-f21/05-milestone-3">}}
* `public void CaloriesShouldBeCorrect()` - verifies a newly created `CancerHevlahCake` has the calories specified in [Milestone 3]{{<ref "D-Milestones-f21/05-milestone-3">}}

#### LibraLibationTests
Create an XUnit test class, `LibraLibationTests` with the following test methods:
* `public void ShouldDefaultToSparkling()` - verifies a newly created `LibraLibationTest` defaults to sparkling.
* `public void ShouldBeAbleToSetSparkling(bool sparkling)` verifies that you can set a `LibraLibation` sparkling property to `true` or `false`.
* `public void ShouldBeAbleToSetFlavor(LibraLibationFlavor flavor)` - verifies you can set the `Flavor` property of a `LibraLibation` to any of the `LibraLibationFlavor` enum values.
* `public void PriceShouldBeCorrectForFlavor(LibraLibationFlavor flavor, decimal price)` - verifies the price of a `LibraLibation` set to the specified flavor and sparkling matches the expectation specified in [Milestone 3]{{<ref "D-Milestones-f21/05-milestone-3">}}.
* `public void CaloriesShouldBeCorrectForFlavor(LibraLibationFlavor flavor, uint calories)` - verifies the calories of a `LibraLibation` set to the specified flavor and sparkling matches the expectation specified in [Milestone 3]{{<ref "D-Milestones-f21/05-milestone-3">}}.
* `public void NameShouldBeCorrectForFlavorAndSparkling(LibraLibationFlavor flavor, bool sparkling, string name)` - verifies the name of a `LibraLibation` set to the specified flavor and sparkling matches the expectation specified in [Milestone 3]{{<ref "D-Milestones-f21/05-milestone-3">}}.
                
#### CapricornMountainTeaTests
Create an XUnit test class, `LibraLibationTests` with the following test methods:
* `public void PriceShouldBeCorrectForHoney(bool honey, decimal price)` - verifies the price of a `CapricornMountainTea` with or without honey (as specified) matches the price expectation set out in [Milestone 3]{{<ref "D-Milestones-f21/05-milestone-3">}}.
* `public void CaloriesShouldBeCorrectForHoney(bool honey, uint calories)` - verifies the calories of a `CapricornMountainTea` with or without honey (as specified) matches the price expectation set out in [Milestone 3]{{<ref "D-Milestones-f21/05-milestone-3">}}.
        

### UML Diagram
You will be creating a UML diagram for your `Data` project _based on your project's current structure._  This diagram should include:

* A box for each enum defined in the project, which:
    * Includes the label for each value defined in the enum.
    * These must be correctly labeled them as public or private according to the proper UML notation.
    * Correctly identifies the box as an enum using the `<<enum>>` stereotype.
* A box for each class defined in the project, which:
    * Properly identifies if the class is abstract
    * Includes _all_ defined fields, properties, and methods.
      * These must be correctly labeled them as public or private according to the proper UML notation
      * You should use a stereotype to properties, i.e. using `<<get>>` for a get-only property.
* The appropriate associations connecting any boxes that should show a connection, i.e. a solid arrow connecting derived classes to the base class they are derived from (generalization)
    * These arrows must point the correct direction for the association they represent

You should refer to the [UML]({{<ref "1-object-orientation/05-uml">}}) chapter for guidance

Be sure to include the completed UML diagram in your repository.  The [Adding Documentation Files]({{<ref "B-git-and-github/12-adding-documentation-files">}}) section of the Git and GitHub appendix discusses how to do this.

**Note: You do not need to create a UML diagram of your `DataTest` project, though you can if you want.**

## The Milestone Feature Branch 

You will want to [create a feature branch and push it to GitHub]({{<ref "D-milestones-f21/02-feature-branches">}}) for your validations to be generated on https://pendant.cs.ksu.edu.  For this milestone, your feature branch should be named `ms4`.  

## Submitting the Assignment

Once your project is complete, merge your feature branch back into the `main` branch and [create a release]({{<ref "B-git-and-github/11-release">}}) tagged `v0.4.0` with name `"Milestone 4"`.  Copy the URL for the release page and submit it to the Canvas assignment.

## Grading Rubric

The grading rubric for this assignment will be:

**20% Structure** Did you implement the structure as laid out in the specification?  Are the correct names used for classes, enums, properties, methods, events, etc?  Do classes inherit from expected base classes?

**20% Documentation** Does every class, method, property, and field use the correct XML-style documentation?  Does every XML comment tag contain explanatory text?

**20% Design** Are you appropriately using C# to create reasonably efficient, secure, and usable software?  Does your code contain bugs that will cause issues at runtime?

**20% Functionality** Does the program do what the assignment asks?  Do properties return the expected values?  Do methods perform the expected actions?

**20% UML Diagrams** Does your UML diagram reflect the code actually in your release?  Are all classes, enums, etc. included?  Are associations correctly identified?


{{% notice warning %}}
Projects that do not compile will receive an automatic grade of 0.
{{% /notice %}}
<!-- TESTS & UML -->