---
title: "Writing Tests"
pre: "4. "
weight: 4
date: 2018-08-24T10:53:26-05:00
---

Writing tests is in many ways just as challenging and creative an endeavor as writing programs.  Tests usually consist of invoking some portion of program code, and then using _assertions_ to determine that the actual results match the expected results.  The results of these assertions are typically reported on a per-test basis, which makes it easy to see where your program is not behaving as expected.  

Consider a class that is a software control system for a kitchen stove.  It might have properties for four burners, which correspond to what heat output they are currently set to.  Let's assume this is as an integer between 0 (off) and 5 (high).  When we first construct this class, we'd probably expect them all to be off!  A test to verify that expectation would be:

```csharp 
public class StoveTests {

    [Fact]
    public void BurnersShouldBeOffAtInitialization() {
        Stove stove = new Stove();
        Assert.Equal(0, stove.BurnerOne);
        Assert.Equal(0, stove.BurnerTwo);
        Assert.Equal(0, stove.BurnerThree);
        Assert.Equal(0, stove.BurnerFour);
    }
}
```

Here we've written the test using the C# [xUnit](https://xunit.net/) test framework, which is being adopted by Microsoft as their preferred framework, replacing the [nUnit](https://nunit.org/) test framework (there are many other C# test frameworks, but these two are the most used).

Notice that the test is simply a method, defined in a class.  This is very common for test frameworks, which tend to be written using the same programming language the programs they test are written in (which makes it easier for one programmer to write both the code unit and the code to test it).  Above the class appears an [attribute](https://docs.microsoft.com/en-us/dotnet/csharp/programming-guide/concepts/attributes/) - `[Fact]`.  Attributes are a way of supplying metadata within C# code.  This metadata can be used by the compiler and other programs to determine how it works with your code.  In this case, it indicates to the xUnit test runner that this method is a test.

Inside the method, we create an instance of stove, and then use the `Assert.Equal<T>(T expected, T actual)` method to determine that the actual and expected values match.  If they do, the assertion is marked as passing, and the test runner will display this pass.  If it fails, the test runner will report the failure, along with details to help find and fix the problem (what value was expected, what it actually was, and which test contained the assertion).

The xUnit framework provides for two kinds of tests, _Facts_, which are written as functions that have no parameters, and _Theories_, which do have parameters.  The values for these parameters are supplied with another attribute, typically `[InlineData]`.  For example, we might test that when we set a burner to a setting within the valid 0-5 range, it is set to that value:

```csharp
[Theory]
[InlineData(0)]
[InlineData(1)]
[InlineData(2)]
[InlineData(3)]
[InlineData(4)]
[InlineData(5)]
public void ShouldBeAbleToSetBurnerOneToValidRange(int setting) {
    Stove stove = new Stove();
    stove.BurnerOne = setting;
    Assert.Equal(setting, stove.BurnerOne);
}
```

The values in the parentheses of the `InlineData` are the values supplied to the parameter list of the theory method.  Thus, this test is actually _six_ tests; each test makes sure that one of the settings is working.  We could have done all six as separate assignments and assertions within a single fact, but using a theory means that if only one of these settings doesn't work, we will see that one test fail while the others pass.  This level of specificity can be very helpful in finding errors.

So far our tests cover the expected behavior of our stove.  But where tests really prove their worth is with the _edge cases_ - those things we as programmers don't anticipate.  For example, what happens if we try setting our range to a setting above 5?  Should it simply clamp at 5?  Should it not change from its current setting?  Or should it shut itself off entirely because its user is clearly a pyromaniac bent on burning down their house? If the specification for our program doesn't say, it is up to us to decide.  Let's say we expect it to be clamped at 5:

```csharp 
[Theory]
[InlineData(6)]
[InlineData(18)]
[InlineData(1000000)]
public void BurnerOneShouldNotExceedASettingOfFive(int setting) {
    Stove stove = new Stove();
    stove.BurnerOne = setting;
    Assert.Equal(5, stove.BurnerOne);
}
```

Note that we don't need to exhaustively test all numbers above 5 - it is sufficient to provide a representative sample, ideally the first value past 5 (6), and a few others.  Also, now that we have defined our expected behavior, we should make sure the documentation of our BurnerOne property matches it:

```csharp
/// <summary>
/// The setting of burner one 
/// </summary>
/// <value>
/// An integer between 0 (off) and 5 (high)
/// </value>
/// <remarks>
/// If a value higher than 5 is attempted, the burner will be set to 5
/// </remarks>
public int BurnerOne {get; set;}
```

This way, other programmers (and ourselves, if we visit this code years later) will know what the expected behavior is.  We'd also want to test the other edge cases: i.e. when the burner is set to a negative number.

{{% notice warning %}}
Recognizing and testing for edge cases is a critical aspect of test writing. But it is also a difficult skill to develop, as we have a tendency to focus on expected values and expected use-cases for our software. But most serious errors occur when values outside these expectations are introduced.  Also, remember special values, like `double.PositiveInfinity`, `double.NegativeInfinity`, and `double.NaN`.
{{% /notice %}}

