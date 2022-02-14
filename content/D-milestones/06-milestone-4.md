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
As a rule of thumb for this course, use at least 8 `[InlineData()]` options if there are more than 8 possible permutations. Good practice is to select these 8 largely at random (i.e. roll dice, use a random number generator, etc).
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
public void NameShouldBeCorrect(ServingSize size, string name)
{
    var fritters = new AppleFritters();
    fritters.Size = size;
    Assert.Equal(name, fritters.Name);
}
```

Note that we now need to include a using statement for the `FriedPiper.Data.Enums` namespace (`using FriedPiper.Data.Enums`) or else use the fully qualified name for `ServingSize` (`FriedPiper.Data.Enums.ServingSize`).

Likewise our `Calories` and `Price` properties need to change to reflect the new sizes available.  These tests can be written as a `[Theory]` as well, again supplying a `ServingSize` and the expected values for `Calories` and `Price`.

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

Finally, we want to add some tests to verify that the AppleFritters implements the `IMenuItem` interface and extends the `Popper` base class. This can be done with xUnit's `Assert.IsAssignableFrom<T>()` assertion:

```csharp
[Fact]
public void ShouldImplementIMenuItem()
{
    var fritters = new AppleFritters();
    Assert.IsAssignableFrom<IMenuItem>(fritters);
}
```

This tests that the `fritter` variable can be casted as a `IMenuItem`.  You'll also want to write a `ShouldExtendPopper()` test in the same way.

#### Write New Unit Tests

You need to write additional unit tests for the rest of the menu item classes.  These should be placed in the `DataTests` project in the _UnitTests_ folder, and named after the class they are testing, i.e. put the fried pie tests in _FriedPieUnitTests.cs_. This makes it easy to determine what class the test belongs to.

In the following sections is a list of _minimum_ test methods you should add (you get to decide if they should be a `[Fact]` or `[Theory]`). Please use the names as written - that makes grading much faster. And remember, you can always add additional tests!

##### FriedPieUnitTests

* ShouldImplementIMenuItem
* ShouldBeAbleToSetPieFilling
* ShouldBeNamedCorrectly
* ShouldHaveCorrectPrice
* ShouldHaveCorrectCalories

##### FriedIceCreamUnitTests

* ShouldImplementIMenuItem
* ShouldBeAbleToSetIceCreamFlavor
* ShouldBeNamedCorrectly
* ShouldHaveCorrectPrice
* ShouldHaveCorrectCalories

##### FriedCandyBarUnitTests

* ShouldImplementIMenuItem
* ShouldBeAbleToSetCandyBar
* ShouldBeNamedCorrectly
* ShouldHaveCorrectPrice
* ShouldHaveCorrectCalories

##### FriedTwinkieUnitTests

* ShouldImplementIMenuItem
* ShouldBeNamedCorrectly
* ShouldHaveCorrectPrice
* ShouldHaveCorrectCalories

##### FriedBananasUnitTests

* ShouldImplementIMenuItem
* ShouldExtendPopper
* ShouldBeAbleToSetGlazed
* ShouldBeNamedCorrectly
* ShouldHaveCorrectPrice
* ShouldHaveCorrectCalories

##### FriedCheesecakeUnitTests

* ShouldImplementIMenuItem
* ShouldExtendPopper
* ShouldBeAbleToSetGlazed
* ShouldBeNamedCorrectly
* ShouldHaveCorrectPrice
* ShouldHaveCorrectCalories

##### FriedOreosUnitTests

* ShouldImplementIMenuItem
* ShouldExtendPopper
* ShouldBeAbleToSetGlazed
* ShouldBeNamedCorrectly
* ShouldHaveCorrectPrice
* ShouldHaveCorrectCalories

##### PiperPlatterUnitTests

* ShouldImplementIMenuItem
* ShouldBeAbleToSetLeftPieFilling
* ShouldBeAbleToSetRightPieFilling
* ShouldBeAbleToSetLeftIceCreamFlavor
* ShouldBeAbleToSetRightIceCreamFlavor
* ShouldBeNamedCorrectly
* ShouldHaveCorrectPrice
* ShouldHaveCorrectCalories

##### PopperPlatterUnitTests

* ShouldImplementIMenuItem
* ShouldBeAbleToSetSize
* SettingSizeShouldAlsoSetPopperSize
* ShouldBeAbleToSetGlazed
* SettingGlazedShouldAlsoSetPopperGlazed
* ShouldBeNamedCorrectly
* ShouldHaveCorrectPrice
* ShouldHaveCorrectCalories

## Refactoring Menu Item Classes

You may find in the process of writing your tests that your implementation of a particular menu item is not working correctly.  If this is the case, congratulations! Your tests are doing their job!

At this point, you'll want to refactor the corresponding class to fix any of these problems.  If this involves making changes to the structure of the class, be sure to update your UML diagram as well!

## Submitting the Assignment
Once your project is complete, merge your feature branch back into the `main` branch and [create a release]({{<ref "B-git-and-github/11-release">}}) tagged `v0.4.0` with name `"Milestone 4"`.  Copy the URL for the release page and submit it to the Canvas assignment.

## Grading Rubric
The grading rubric for this assignment will be:

**25% Structure** Did you implement the structure as laid out in the specification?  Are the correct names used for classes, enums, properties, methods, events, etc?  Do classes inherit from expected base classes?

**25% Documentation** Does every class, method, property, and field use the correct XML-style documentation?  Does every XML comment tag contain explanatory text?

**25% Design** Are you appropriately using C# to create reasonably efficient, secure, and usable software?  Does your code contain bugs that will cause issues at runtime?

**25% Functionality** Does the program do what the assignment asks?  Do properties return the expected values?  Do methods perform the expected actions?

{{% notice warning %}}
Projects that do not compile will receive an automatic grade of 0.
{{% /notice %}}