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

For example, the value of the `Name` property is no longer always "AppleFritters".  Instead, it contains the size.  So we need to refactor our `NameShouldBeCorrect()` method to respond to this potential change.

A good way to handle this is to switch from using a `[Fact]` to using a `[Theory]`, and pass in the possible sizes as `[InlineData]`.  In addition, it is a good practice to pass in the expected value (in this case, what we expect the name to be). This way, we can quickly visually verify the test expectations.  The refactored method might look like this:

```csharp
[Theory]
[InlineData(ServingSize.Small, "Small Apple Fritters")]
[InlineData(ServingSize.Medium, "Medium Apple Fritters")]
[InlineData(ServingSize.Large, "Large Apple Fritters")]
public void ShouldBeAbleToSetSize(ServingSize size, string name)
{
    var fritters = new AppleFritters();
    fritters.Size = size;
    Assert.Equal(name, fritters.Name);
}
```

Note that we now need to include a using statement for the `FriedPiper.Data.Enums` namespace (`using FriedPiper.Data.Enums`) or else use the fully qualified name for `ServingSize` (`FriedPiper.Data.Enums.ServingSize`).

Likewise our `Calories` and `Price` properties need to change to reflect the new sizes available.  These tests can be written as a `[Theory]` as well, again supping a `ServingSize` and the expected values for `Calories` and `Price`.

But `Calories` is affected by _two_ separate properties - `Size` _and_ `Glazed`. Thus, we need to pass _both_ to our test, along with the expected `Calories` value:

```csharp
[Theory]
[InlineData(ServingSize.Small, true, 370)]
[InlineData(ServingSize.Medium, true, 490)]
[InlineData(ServingSize.Large, true, 610)]
[InlineData(ServingSize.Small, false, 240)]
[InlineData(ServingSize.Medium, false, 360)]
[InlineData(ServingSize.Large, false, 480)]
public void CaloriesShouldBeCorrect(ServingSize size, bool glazed, uint calories)
{
    var appleFritters = new AppleFritters();
    appleFritters.Size = size;
    appleFritters.Glazed = glazed;
    Assert.Equal(calories, appleFritters.Calories);
}
```

{{% notice hint %}}
You can do operations within an `[InlineData()]`, which may be helpful to keeping your numbers accurate.  For example, a large apple fritters has 480 calories, _plus_ an additional 130 if it is glazed.  You can calculate the sum by hand, _or_ express it as a sum in the `[InlineData()]`:

```csharp
[InlineData(ServingSize.Large, true, 480 + 130)]
```
{{% /notice %}}