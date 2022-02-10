---
title: "Milestone 4 Requirements"
pre: "6. "
weight: 60
date: 2018-08-24T10:53:26-05:00
---

{{% notice noiframe %}}
This textbook was authored for the **CIS 400 - Object-Oriented Design, Implementation, and Testing** course at Kansas State University.  This section describes assignments specific to the **Fall 2022** offering of that course.  If you are not enrolled in the course, please disregard this section.
{{% /notice %}}

For this milestone, you will be creating unit tests for the menu item classes you have defined in the `Data` project. If these tests expose issues in your existing code, you will also want to fix them.  

### General requirements:

* You need to follow the style laid out in the [C# Coding Conventions](https://docs.microsoft.com/en-us/dotnet/csharp/programming-guide/inside-a-program/coding-conventions)

* You will need to update your UML diagram to reflect any changes you make to the `Data` project.

### Assignment requirements:

You will need to:

* Refactor unit test class for AppleFritters to match its new specification

* Create unit test classes for:
    * FriedPie
    * FriedIceCream
    * FriedCandyBar
    * FriedTwinkie
    * FriedBananas
    * FriedCheesecake
    * FriedOreos
    * Piper Platter
    * Popper Platter

### Purpose:

This milestone serves to introduce the writing of unit tests.  The real challenge of writing a unit test is not the programming involved, but rather, identifying _what_ you need to test for.  You should make sure that methods and properties behave as expected when used as expected. But you must also account for _edge cases_, where the objects are manipulated in unexpected ways.  If you have any confusion after you have read the entire assignment please do not hesitate to reach out to a Professor Bean, the TAs, or your classmates over Discord.

### Writing Tests
You will need to create an XUnit unit test class in your `DataTests` project for each men item class in the `Data` project.  These test classes must contain (at a minimum) the test methods described below.  You may add additional methods.

In addition, when a test method takes parameters, you will need to provide corresponding `[InlineData()]` attributes to be used by the test runner as arguments for those parameters.  You should supply enough attributes to either 1) be exhaustive (cover all possibilities), or 2) cover a number of expected cases and any edge cases.  

{{% notice info %}}
As a rule of thumb for this course, use at least 8 `[InlineData()]` options if there are more than 8 possible permutations.
{{% /notice %}}

#### Refactor AppleFrittersUnitTests

The _UnitTests/AppleFrittersTests.cs_ already contains unit tests for the `AppleFritters` class, but these tests were for the original specification, not the refactoring you did for Milestone 3. As a result, some of these tests are not passing, and need to be refactored to meet the new specification.

For example, the value of the `Name` property is no longer always "AppleFritters".  

 which you can use as a reference.  You will also want to add these tests to that class:

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