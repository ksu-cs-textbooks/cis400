+++
title = "Milestone 4 Requirements"
pre = "6. "
weight = 60
date = 2018-08-24T10:53:26-05:00
+++

{{% notice noiframe %}}
This textbook was authored for the **CIS 400 - Object-Oriented Design, Implementation, and Testing** course at Kansas State University.  This section describes assignments specific to the **Spring 2023** offering of that course.  Prior semester offerings can be found [here](old). If you are not enrolled in the course, please disregard this section.
{{% /notice %}}

For this milestone, you will be creating new classes representing an order and refactoring your existing classes to implement an interface and base classes.  You will also need to update your unit tests to account for these changes.  Finally, you will also create a UML class diagram to represent your classes.

### General requirements:

* You need to follow the style laid out in the [C# Coding Conventions](https://docs.microsoft.com/en-us/dotnet/csharp/programming-guide/inside-a-program/coding-conventions)

* You need to document your code using [XML-style comments](https://docs.microsoft.com/en-us/dotnet/csharp/language-reference/xmldoc/recommended-tags), with a minimum of `<summary>` tags, plus `<param>`, `<returns>`, and `<exception>` as appropriate.  

### Assignment requirements:

You will need to:

* Create an `IMenuItem` interface to represent an item appearing on the menu

* Refactor your existing classes to implement the `IMenuItem` interface

* Add additional unit tests to verify your menu items can be treated as `IMenuItem` instances

* Create an `Order` class to represent a collection of menu items being ordered together

* Create a UML diagram for your `Data` Project

### Purpose:

This milestone serves to introduce and utilize aspects of polymorphism including base classes, abstract base classes, abstract methods, virtual methods, method overriding, and interfaces.  While the actual programming involved is straightforward, the concepts involved can be challenging to master. If you have any confusion after you have read the entire assignment please do not hesitate to reach out to a Professor Bean, the TAs, or your classmates over Discord.

### IMenuItem Interface

You will create an interface named `IMenuItem` in the file _IMenuItem.cs_ to represent the properties that all menu items share, which should include: 

* A get-only `Name` property of type `string`
* A get-only `Description` property of type `string`
* A get-only `Price` property of type `decimal`
* A get-only `Calories` property of type `uint`
* A get-only `SpecialInstructions` property of type `IEnumerable<string>` 

You will need to implement this interface on all existing and future menu items defined in the `Data` project.

You will also want to test that your menu items can be cast to be an `IMenuItem` using the `Assert.IsAssignableFrom<T>()` assertion in the corresponding unit test file with a new `Fact`.

### Abstract Base Classes 

You will also write abstract base classes representing `Entree`, `Side`, and `Drink` menu items, in files named _Entree.cs_, _Side.cs_, and _Drink.cs_ respectively. These should generalize (collect together) the properties that each of these categories of menu items have in common - either as `abstract` or `virtual` properties, to be overridden as needed in the derived classes.

All of your menu classes should be refactored to derive from one of these abstract base classes. Note that this may allow you to remove methods or require you to `override` the base method.

You will also want to test that your menu items can be cast to be the corresponding base class using the `Assert.IsAssignableFrom<T>()` assertion in the corresponding unit test file with a new `Fact`.

### Drink Classes

You will also need to implement new classes representing the drinks available at The Flying Saucer, which are Liquified Vegetation, Saucer Fuel, and Inorganic Substance.  All drinks have a `Size` property of type `ServingSize`, in addition to the normal `IMenuItem` properties.

#### Liquified Vegetation
<table>
  <tr>
    <th>Property</th>
    <th>Accessors</th>
    <th>Type</th>
    <th>Value</th>
  </tr>
  <tr>
    <td>Name</td>
    <td>get only</td>
    <td>string</td>
    <td>"Liquified Vegetation"</td>
  </tr>
  <tr>
    <td>Description</td>
    <td>get only</td>
    <td>string</td>
    <td>"A cold glass of blended vegetable juice."</td>
  </tr>
  <tr>
    <td>Size</td>
    <td>get and set</td>
    <td>ServingSize</td>
    <td>Default of `ServingSize.Small`</td>
  </tr>
  <tr>
    <td>Ice</td>
    <td>get and set</td>
    <td>bool</td>
    <td>Defaults to true</td>
  </tr>
  <tr>
    <td>Price</td>
    <td>get only</td>
    <td>decimal</td>
    <td>$1.00 for small, $1.50 for medium, $2.00 for large</td>
  </tr>
  <tr>
    <td>Calories</td>
    <td>get only</td>
    <td>uint</td>
    <td>72 for small, 144 for medium, 216 for large</td>
  </tr>
  <tr>
    <td>SpecialInstructions</td>
    <td>get only</td>
    <td>IEnumerable&langle;string&rangle;</td>
    <td>Should include: 
      <ul>
        <li>"No Ice" if Ice is false</li>
      </ul>
    </td>
</table>

### Saucer Fuel
<table>
  <tr>
    <th>Property</th>
    <th>Accessors</th>
    <th>Type</th>
    <th>Value</th>
  </tr>
  <tr>
    <td>Name</td>
    <td>get only</td>
    <td>string</td>
    <td>"Saucer Fuel" or "Decaf Saucer Fuel" if Decaf is true</td>
  </tr>
  <tr>
    <td>Description</td>
    <td>get only</td>
    <td>string</td>
    <td>"A steaming cup of coffee."</td>
  </tr>
  <tr>
    <td>Size</td>
    <td>get and set</td>
    <td>ServingSize</td>
    <td>Default of `ServingSize.Small`</td>
  </tr>
  <tr>
    <td>Decaf</td>
    <td>get and set</td>
    <td>bool</td>
    <td>Defaults to false</td>
  </tr>
  <tr>
    <td>Cream</td>
    <td>get and set</td>
    <td>bool</td>
    <td>Defaults to false</td>
  </tr>
  <tr>
    <td>Price</td>
    <td>get only</td>
    <td>decimal</td>
    <td>$1.00 for small, $1.50 for medium, $2.00 for large</td>
  </tr>
  <tr>
    <td>Calories</td>
    <td>get only</td>
    <td>uint</td>
    <td>1 for small, 2 for medium, 3 for large, plus 29 calories for cream</td>
  </tr>
  <tr>
    <td>SpecialInstructions</td>
    <td>get only</td>
    <td>IEnumerable&langle;string&rangle;</td>
    <td>Should include: 
      <ul>
        <li>"With Cream" if Cream is true</li>
      </ul>
    </td>
</table>

#### Inorganic Substance
<table>
  <tr>
    <th>Property</th>
    <th>Accessors</th>
    <th>Type</th>
    <th>Value</th>
  </tr>
  <tr>
    <td>Name</td>
    <td>get only</td>
    <td>string</td>
    <td>"Inorganic Substance"</td>
  </tr>
  <tr>
    <td>Description</td>
    <td>get only</td>
    <td>string</td>
    <td>"A cold glass of ice water."</td>
  </tr>
  <tr>
    <td>Size</td>
    <td>get and set</td>
    <td>ServingSize</td>
    <td>Default of `ServingSize.Small`</td>
  </tr>
  <tr>
    <td>Ice</td>
    <td>get and set</td>
    <td>bool</td>
    <td>Defaults to true</td>
  </tr>
  <tr>
    <td>Price</td>
    <td>get only</td>
    <td>decimal</td>
    <td>$0.00 for any size</td>
  </tr>
  <tr>
    <td>Calories</td>
    <td>get only</td>
    <td>uint</td>
    <td>0 for all sizes</td>
  </tr>
  <tr>
    <td>SpecialInstructions</td>
    <td>get only</td>
    <td>IEnumerable&langle;string&rangle;</td>
    <td>Should include: 
      <ul>
        <li>"No Ice" if Ice is false</li>
      </ul>
    </td>
</table>

### Order Class

You will also need to create a class, `Order` in a file _order.cs_, representing an order containing multiple, potentially customized menu items.  This class will need to implement the `ICollection<IMenuItem>` interface, allowing it to be treated as a collection.  In addition to the methods and properties required for the interface, it should have the additional properties of:

* `Subtotal`, a get-only `decimal` that is the price of all items in the order
* `TaxRate`, a get/set `decimal` that represents the sales tax rate
* `Tax`, a get-only `decimal` that is the tax for the order (`Subtotal` * `TaxRate`)
* `Total`, a get-only `decimal` that is the sum of the `Subtotal` and `Tax`

### UML Class Diagram

Finally, you will need to create a UML class diagram for the `Data` project, and add it to your repository.  This can be done with Visio or another visual editing program like [Draw.io](https://draw.io) or [Lucid Charts](https://www.lucidchart.com/pages/landing). You should save the diagram in a PDF or image format that the graders can view. You _also_ will want to keep it in an editable format, as you'll be updating it in future milestones. Be sure to follow the instructions in [Adding Documentation Files]{{<ref "/B-git-and-github/12-adding-documentation-files">}} and double-check that the UML diagrams appear in your release.

## Submitting the Assignment
Once your project is complete, merge your feature branch back into the `main` branch and [create a release]({{<ref "/B-git-and-github/11-release">}}) tagged `v0.4.0` with name `"Milestone 4"`.  Copy the URL for the release page and submit it to the Canvas assignment.

## Grading Rubric
The grading rubric for this assignment will be:

**20% Structure** Did you implement the structure as laid out in the specification?  Are the correct names used for classes, enums, properties, methods, events, etc?  Do classes inherit from expected base classes?

**20% Documentation** Does every class, method, property, and field use the correct XML-style documentation?  Does every XML comment tag contain explanatory text?  Is there a UML Diagram for the data project?  Does the UML accurately reflect the structure of the project

**20% Design** Are you appropriately using C# to create reasonably efficient, secure, and usable software?  Does your code contain bugs that will cause issues at runtime?

**20% Functionality** Does the program do what the assignment asks?  Do properties return the expected values?  Do methods perform the expected actions?

**20% Tests** Does the test suite include unit tests for all classes?  Do the unit tests provide adequate coverage of the project?


{{% notice warning %}}
Projects that do not compile will receive an automatic grade of 0.
{{% /notice %}}