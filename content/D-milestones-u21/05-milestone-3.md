---
title: "Milestone 3 Requirements"
pre: "4. "
weight: 40
date: 2018-08-24T10:53:26-05:00
---

For this milestone, you will be creating an additional class to represent an Order, defining an IOrderItem interface to represent items added to an order, and refactoring your existing classes to implement this interface.  You will also be writing unit tests, creating a UML diagram of your Data project, and adding any missing XML-style documentation.

### General requirements:

* You need to follow the style laid out in the [C# Coding Conventions](https://docs.microsoft.com/en-us/dotnet/csharp/programming-guide/inside-a-program/coding-conventions)

* All classes should be declared in their respective namespace (see below)

* Document your classes using XML-Style comments

* Create UML class diagrams to represent your poject

### Assignment requirements:

* Order Class (1)
* IOrderItem Interface (1)
* Refactor existing classes to implement IOrderItem (11-15)

### Purpose:

Implementation of interfaces to allow storing multiple types in a generic collection and perform aggregate operations upon them.  We will also be practicing writing methods for objects.  In addition, we are learning to follow professional documentation practice, both inline and using UML class diagrams.  Finally, we are learning to write good tests to verify our programs' behavior.

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

## Order Class
We now will be creating a class to represent an order.  This will need to keep track of all items in the order, and calculate the subtotal price of everything in the order, the tax that would apply to the subtotal, and a total price that is the subtotal _and_ the tax.  Additionally, we want to be able to get the calories for the order.  Thus, the Order should have the following properties:

`DateTime` - a readonly `DateTime` which is the date and time the order was taken.  This should be set to the current time (i.e. `DateTime.Now`) when the `Order` class is constructed.

`Items` - a readonly array of `IOrderItem`, which should be all the items currently in the order.

`Subtotal` - a readonly `decimal` which is the sum of the prices of all items currently in the order.

`Tax` - a readonly `decimal` that represents the taxes due on the order, which should be 12% of the `Subtotal` 

`Total` - a readonly `decimal` which is the sum of the `Subtotal` and the `Tax`.

`Calories` - a readonly `uint` which is the sum of all the calories of the items in the order.

In addition to the properties, the `Order` class should have the following methods:

`Add(IOrderItem item)` - adds a new item to the order.  Has no return value.

`Remove(IOrderItem item)` - removes the specified item from the order.  Returns true if the item was found in the order and successfully removed, otherwise it returns false.

## IOrderItem Interface
Define an interface named `IOrderItem` in the _IOrderItem.cs_ file and the `DogsNSuch` namespace that defines the expected functionality for items added to an order.  This should include properties for:

`Name` - a readonly `string` which is the human-readable name of the item (i.e. `"Chicago Dog"`)

`Description` - a readonly `string` which provides the menu description of the item

`Price` - a readonly `decimal` that is the price of the item.

`Calories` - readonly `uint` that is the calories of the item.

`Ingredients` - a readonly array of `string` which is the list of ingredients for preparing the order item, i.e. `["Hoagie", "Kielbasa", "Sauerkraut", "Brown Mustard"]`.

## Refactor Dog, Drink, and Side Classes
To add instances of your dogs, drinks, and side classes to the `Order`, you must refactor them to implement the `IOrderItem` interface. This will entail adding extra properties to these classes to fulfill the interface requirements.

### Refactoring Dog Classes
As your dog classes already have a `Name`, `Description`, `Price`, and `Calories`, you will only need to add the `Ingredients` property.  Its contents should include: the name of the selected bun, the name of selected sausage, and the names of any ingredients whose boolean properties are set to `true`.  Note that these should be in _human case_, i.e. "Dill Pickle Slice", not _Pascal_ or _Camel Case_.  

#### Hints
* A generic `List<T>` can be converted into an array with `List<T>.ToArray()`.

* A `Dictionary<T, U>` can be used to easily map enum values to strings.

### Refactoring Drink Classes
Drinks already have properties for `Name`, `Description`, `Price`, and `Calories`, so you should only have to add `Ingredients`.  Since there is nothing to customize on the drinks, this property will _always_ return an empty array.

### Refactoring Side Classes
Sides also already have properties for `Name`, `Description`, `Price`, and `Calories`, so you should only have to add `Ingredients`.  Only the Chili has a possible ingredient (cheddar cheese), so the others will _always_ return an empty array.

## Unit Testing 
You will need to add a unit test class for each dog, side, and drink.  These should be defined in the `Test` project and `DogsNSuch.Test` namespace in a file corresponding to the class it is testing, i.e. `ChicagoDog` should have a test class named `ChicagoDogUnitTests` declared in the _ChicagoDogUnitTests.cs_ file.  You will need to add sufficient test methods to the class to be reasonably sure of its functionality.  This includes:

### Name Property Tests
You should test that the actual `Name` property matches the expected value.  These values can be found in the description for [Milestone 2]({{<ref "d-milestones-u21/04-milestone-2">}}).  When the `Name` property can vary, i.e. with different sizes of side or different flavors of drink, your test should verify the correct name is used based on those other properties, i.e. a large french fry should have the name "Large French Fries" and a Drink with flavor `DrinkFlavor.RCCola` should have the name "RC Cola".

You can either write multiple facts or combine these different configurations under a single theory test.

### Description Property Tests 
You should test the actual `Description` property matches the expected value.  These values can be found in the description for [Milestone 2]({{<ref "d-milestones-u21/04-milestone-2">}}). 

### Price Property Tests 
You should test the actual `Price` property matches the expected value.  These values can be found in the descriptions for [Milestone 1]({{<ref "d-milestones-u21/03-milestone-1">}}) [Milestone 2]({{<ref "d-milestones-u21/04-milestone-2">}}).  When the `Price` property is calculated (i.e. based on the size of a side), you should test for each possible value.  Note you will need to calculate the expected value by hand, and hard-code it into the test.

When the number of possible permutations is very large (i.e. with the `Dog` boolean properties), you should test at a minimum:
* Each boolean property in isolation (i.e. each boolean for an ingredient set to `true` while all others are `false`)
* All boolean properties set to `true`
* A sampling (at least eight) of different combinations of booleans set to `true` and `false`

### Calories Property Tests
You should test the actual `Calories` property matches the expected value.  These values can be found in the descriptions for [Milestone 1]({{<ref "d-milestones-u21/03-milestone-1">}}) [Milestone 2]({{<ref "d-milestones-u21/04-milestone-2">}}).  When the `Calories` property is calculated (i.e. based on the size of a side), you should test for each possible value.  Note you will need to calculate the expected value by hand, and hard-code it into the test.

When the number of possible permutations is very large (i.e. with the `Dog` boolean properties), you should test at a minimum:
* Each boolean property in isolation (i.e. each boolean for an ingredient set to `true` while all others are `false`)
* All boolean properties set to `true`
* A sampling (at least eight) of different combinations of booleans set to `true` and `false`

This is most easily accomplished with a theory, though it is possible to use multiple facts.

### Enumeration Property Tests
You should test that all enumeration properties are initialized to the correct default value.  These expectations can be found in the descriptions for [Milestone 1]({{<ref "d-milestones-u21/03-milestone-1">}}) [Milestone 2]({{<ref "d-milestones-u21/04-milestone-2">}}).

### Boolean Property Tests 
You should test that all boolean properties are initialized to the correct default value (either `true` or `false` according to the assignment descriptions).  These expectations can be found in the descriptions for [Milestone 1]({{<ref "d-milestones-u21/03-milestone-1">}}) [Milestone 2]({{<ref "d-milestones-u21/04-milestone-2">}}).

### Inheritance/Implementation Tests 
You should also verify that every class can be treated as its base class (when it inherits from a base class), and that _all_ item classes can be treated as an `IOrderItem`.  This can be done with the `Assert.IsAssignableFrom<T>()` template method, i.e.:

```csharp
[Fact]
public void ChicagoDogIsADog() 
{
    var dog = new ChicagoDog();
    Assert.IsAssignableFrom<Dog>(dog);
}

[Fact]
public void ChicagoDogIsAnIOrderItem()
{
    var dog = new ChicagoDog();
    Assert.IsAssignableFrom<IOrderItem>(dog);
}
```

### Collection Tests
For collection properties (like `Items` and `Ingredients`) you should test that the collection contains the expected values (if any).   This can be done with the `Assert.Collection()`, `Assert.Contains()`, or `Assert.Empty()` methods, i.e.:

```csharp
public void EmptyArrayShouldBeEmpty() 
{
    string[] empty = new String[0];
    Assert.Empty(empty);
}

public void ArrayShouldContainApple() 
{
    string[] fruits = new String[] {"Apple", "Orange", "Peach"};
    Assert.Contains(fruits, "Apple");
}

public void ArrayShouldContainFruits()
{
    string[] fruits = new String[] {"Apple", "Orange", "Peach"};
    Assert.Collection(fruits,
      one => one == "Apple",
      two => two == "Orange",
      three => three == "Peach"
    );
}
```

Note that `Assert.Collection()` tests _all_ the items in the collection, and in a specific order (i.e. the array `["Orange", "Apple", "Peach"]` would fail the third test).  Thus multiple `Assert.Contains()` calls can be more flexible about ordering:

```
public void ArrayShouldContainFruitsInAnyOrder()
{
    string[] fruits = new String[] {"Apple", "Orange", "Peach"};
    Assert.Contains(fruits, f => f == "Apple");
    Assert.Contains(fruits, f => f == "Orange");
    Assert.Contains(fruits, f => f == "Peach");
    Assert.Equals(3, fruits.Length);
}
```

Because it does not verify the length of the array, we should do that as well (hence the `Assert.Equals()`).

As with other calculated fields, you should test different configurations of the class (i.e. different customizations of the `Dog` class when testing `Dog.Ingredients`, and `Order` instances with different `IOrderItems` added) to ensure these are being populated correctly.  You should have at least eight variations when possible.

#### Hints
Since the various specialty dog classes inherit the `Price` and `Calories` from the base `Dog` class, you may think that you only need to test these for the base class.  Not so!  Because your tests will be used to determine if future refactoring introduced breaking changes, you _cannot depend on this functionality always being defined in only the base class_.  So you must duplicate your tests across all of these classes.  This is one instance where copying code is acceptable.

### XML Style Documentation
All public classes, properties, methods, fields, etc. should be documented inline using UML-Style documentation, as covered in the [documentation chapter]{((<ref 03-documentation>))}.

### UML Class Diagram
You will need to include a UML Class Diagram for the `Data` project, which should follow the guidelines set out in the [UML Chapter]({{<ref "05-uml">}}).  This should be added to a _documentation_ folder in your project, which __must__ be added to source control.  See ({{<ref "b-git-and-github/12-adding-documentation-files">}}) for guidance on ensuring the files are correctly added.  You may include either Visio, PDF, or an image file, but including a Visio file ensures you can continue to edit your UML to keep it up-to-date with changes you will make in future milestones.

## Submissions

* Create a new release tag - Submit the release URL

  * If you do not remember how to do this, please revisit the [Create a Release page]({{<ref "b-git-and-github/11-release">}})

  * Keep in mind the version!!!

### Review of the week

* [Document your C# code with XML comments](https://docs.microsoft.com/en-us/dotnet/csharp/codedoc)
* [UML Class Diagram Creation](https://support.microsoft.com/en-us/office/create-a-uml-class-diagram-de6be927-8a7b-4a79-ae63-90da8f1a8a6b)