+++
title = "Milestone 2 Requirements"
pre = "4. "
weight = 40
date = 2018-08-24T10:53:26-05:00
+++

{{% notice noiframe %}}
This textbook was authored for the **CIS 400 - Object-Oriented Design, Implementation, and Testing** course at Kansas State University.  This section describes assignments specific to the **Spring 2023** offering of that course.  Prior semester offerings can be found [here](old). If you are not enrolled in the course, please disregard this section.
{{% /notice %}}

For this milestone, you will be creating classes to represent the offerings of _The Flying Saucer_ - a fast-food breakfast franchise.  These will be created within the _Data_ project of the solution you accepted from GitHub classroom.

### General requirements:

* You need to follow the style laid out in the [C# Coding Conventions](https://docs.microsoft.com/en-us/dotnet/csharp/programming-guide/inside-a-program/coding-conventions)

* You need to document your code using [XML-style comments](https://docs.microsoft.com/en-us/dotnet/csharp/language-reference/xmldoc/recommended-tags), with a minimum of `<summary>` tags, plus `<param>`, `<returns>`, and `<exception>` as appropriate.  

### Assignment requirements:

You will need to create

* Enums (2) representing:
  * Serving sizes available for certain menu items
  * The various egg preparations available

* Classes (1+) representing entrees:
  * Outer Omelette
  * Refactoring the Flying Saucer

* Classes (6) representing sides:
  * Crop Circle
  * Glowing Haystack
  * Taken Bacon
  * Missing Links
  * Eviscerated Eggs
  * You're Toast

### Purpose:

This milestone serves as a review of how to create classes and sets the stage for the rest of the semester. Everything included in this assignment you should have been exposed to before in CIS200 and CIS300. This assignment should be relatively straightforward, though it will take some time to complete. If you have any confusion after you have read the entire assignment please do not hesitate to reach out to a Professor Bean, the TAs, or your classmates over Discord.

### Recommendations:

* Get in the habit of reading the entire assignment before you start to code. Make sure you understand what is being asked of you. Please do not get ahead of yourself and have to redo work because you did not read the entire assignment.

* Accuracy is _important_.  Your class, property, enumeration and other names, along with the descriptions _must match the specification given here_.  Otherwise, your code is **not correct**.  While typos may be a small issue in writing intended for human consumption, in computer code _it is a big problem!_ 

* Remember that you must document your classes.  This was covered in prior courses and also discussed in [chapter 3]({{<ref "1-object-orientation/03-documentation">}}) of your textbook.

* The KSU.CS.CodeAnalyzers NuGet package installed in your project will automatically flag issues with for naming and commenting conventions in your code with warnings.  Be sure to address these!

* Create a new feature branch for your milestone and commit your changes to it, and only merge it back into the master branch when you've completed the assignment.

{{% notice tip %}}
You may be wondering why we ask you to create a feature branch rather than working in `main`, especially as it seems extra work.  There are two reasons:
1. It is good practice for the future when you are working on a team. Each team member typically has their own branch. That way, as you add incomplete code to your branch, your changes don't impact the other team member's work.  You only merge your new features to `main` when they are complete, tested, and working.
2. If the UTA asks you to correct a mistake in a former milestone and re-commit, you can switch back to that branch, fix the mistake, create a new release and turn it in.  All _without_ being impacted by your half-done work on the new milestone branch.  Then, you can merge the update to `main` into your current milestone branch so that you have them moving forward. 
{{% /notice %}}

## Enum Classes 

Each enumeration should be placed in a file named according to the enum, i.e. `ServingSize` should be defined in _ServingSize.cs_.

The needed enumerations are:

* `EggStyle` - The various ways an egg can be prepared
  * SoftBoiled
  * HardBoiled
  * Scrambled
  * Poached
  * SunnySideUp
  * OverEasy

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

You will need to create one new class `OuterOmelette`, and refactor another, `FlyingSaucer` to represent specific entrees offered at The Flying Saucer.

### Flying Saucer
The `FlyingSaucer` class provided in the starter project has an issue - the `Price` is constant at $8.50, regardless of the number of pancakes in the stack.  You'll need to refactor the `Price` property so that when additional pancake is added, the price of the entree increases by $0.50, and when a pancake is removed, it is decreased by $0.50.     

### Outer Omelette
You will need to create a class to represent the Outer Omelette entree named `OuterOmelette`.  The structure of this class is detailed in the UML below (you may add additional private members as needed).

![OuterOmelette UML diagram](/images/d.s23.4.1.png)

The specific values for the `OuterOmelette` properties are described in the table below

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
    <td>"Outer Omelette"</td>
  </tr>
  <tr>
    <td>Description</td>
    <td>get only</td>
    <td>string</td>
    <td>"A fully loaded Omelette."</td>
  </tr>
  <tr>
    <td>CheddarCheese</td>
    <td>get and set</td>
    <td>bool</td>
    <td>Defaults to true</td>
  </tr>
  <tr>
    <td>Peppers</td>
    <td>get and set</td>
    <td>bool</td>
    <td>Defaults to true</td>
  </tr>
  <tr>
    <td>Mushrooms</td>
    <td>get and set</td>
    <td>bool</td>
    <td>Defaults to true</td>
  </tr>
  <tr>
    <td>Tomatoes</td>
    <td>get and set</td>
    <td>bool</td>
    <td>Defaults to true</td>
  </tr>
  <tr>
    <td>Onions</td>
    <td>get and set</td>
    <td>bool</td>
    <td>Defaults to true</td>
  </tr>
  <tr>
    <td>Price</td>
    <td>get only</td>
    <td>decimal</td>
    <td>$7.45</td>
  </tr>
  <tr>
    <td>Calories</td>
    <td>get only</td>
    <td>uint</td>
    <td>94 for the eggs in the omelette, plus 113 calories for cheddar cheese, 24 calories for peppers, 4 calories for mushrooms, 22 calories for tomatoes, and 22 calories for onions</td>
  </tr>
  <tr>
    <td>SpecialInstructions</td>
    <td>get only</td>
    <td>IEnumerable&langle;string&rangle;</td>
    <td>For any ingredient not used, should include "Hold [ingredient]" where [ingredient] is the name of the ingredient, i.e. if the CheddarCheese property is false, it should include "Hold Cheddar Cheese"
    </td>
</table>


## Side Menu Item Classes

You will need to create classes to represent the six sides Crop Circle, Glowing Haystack, Taken Bacon, Missing Links, Eviscerated Eggs, and You're Toast. 

### Crop Circle

The structure for the `CropCircle` class appears in the UML diagram below:

![Crop Circle UML Diagram](/images/d.s23.4.2.png)

The specific values for the `CropCircle` properties are described in the table below

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
    <td>"Crop Circle"</td>
  </tr>
  <tr>
    <td>Description</td>
    <td>get only</td>
    <td>string</td>
    <td>"Oatmeal topped with mixed berries."</td>
  </tr>
  <tr>
    <td>Berries</td>
    <td>get and set</td>
    <td>bool</td>
    <td>Defaults to true</td>
  </tr>
  <tr>
    <td>Price</td>
    <td>get only</td>
    <td>decimal</td>
    <td>$2.00</td>
  </tr>
  <tr>
    <td>Calories</td>
    <td>get only</td>
    <td>uint</td>
    <td>158 calories, plus 89 calories if berries are included</td>
  </tr>
  <tr>
    <td>SpecialInstructions</td>
    <td>get only</td>
    <td>IEnumerable&langle;string&rangle;</td>
    <td>Includes "Hold Berries" if the Berries property is false.
    </td>
</table>

### Glowing Haystack

The structure for the `GlowingHaystack` class appears in the UML diagram below:

![Glowing Haystack UML Diagram](/images/d.s23.4.3.png)
The specific values for the `GlowingHaystack` properties are described in the table below

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
    <td>"Glowing Haystack"</td>
  </tr>
  <tr>
    <td>Description</td>
    <td>get only</td>
    <td>string</td>
    <td>"Hash browns smothered in green chile sauce, sour cream, and topped with tomatoes."</td>
  </tr>
  <tr>
    <td>Green Chile Sauce</td>
    <td>get and set</td>
    <td>bool</td>
    <td>Defaults to true</td>
  </tr>
  <tr>
    <td>Sour Cream</td>
    <td>get and set</td>
    <td>bool</td>
    <td>Defaults to true</td>
  </tr>
  <tr>
    <td>Tomatoes</td>
    <td>get and set</td>
    <td>bool</td>
    <td>Defaults to true</td>
  </tr>
  <tr>
    <td>Price</td>
    <td>get only</td>
    <td>decimal</td>
    <td>$2.00</td>
  </tr>
  <tr>
    <td>Calories</td>
    <td>get only</td>
    <td>uint</td>
    <td>470 calories, plus 15 calories for green chile sauce, 23 calories for sour cream, and 22 calories for tomatoes</td>
  </tr>
  <tr>
    <td>SpecialInstructions</td>
    <td>get only</td>
    <td>IEnumerable&langle;string&rangle;</td>
    <td>For any ingredient not used, should include "Hold [ingredient]" where [ingredient] is the name of the ingredient, i.e. if the GreenChileSauce property is false, it should include "Hold Green Chile Sauce"
    </td>
</table>

### Taken Bacon

The structure for the `TakenBacon` class appears in the UML diagram below:

![Taken Bacon UML Diagram](/images/d.s23.4.4.png)

The specific values for the `TakenBacon` properties are described in the table below

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
    <td>"Taken Bacon"</td>
  </tr>
  <tr>
    <td>Description</td>
    <td>get only</td>
    <td>string</td>
    <td>"Crispy strips of bacon."</td>
  </tr>
  <tr>
    <td>Count</td>
    <td>get and set</td>
    <td>uint</td>
    <td>Defaults to 2 strips of bacon</td>
  </tr>
  <tr>
    <td>Price</td>
    <td>get only</td>
    <td>decimal</td>
    <td>$1.00 per strip of bacon</td>
  </tr>
  <tr>
    <td>Calories</td>
    <td>get only</td>
    <td>uint</td>
    <td>43 calories per strip of bacon</td>
  </tr>
  <tr>
    <td>SpecialInstructions</td>
    <td>get only</td>
    <td>IEnumerable&langle;string&rangle;</td>
    <td>For any number of strips but two, should include "[n] strips" where [n] is the count.
    </td>
</table>

### Missing Links

The structure for the `MissingLinks` class appears in the UML diagram below:

![MissingLinks UML Diagram](/images/d.s23.4.6.png)

The specific values for the `MissingLinks` properties are described in the table below

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
    <td>"Missing Links"</td>
  </tr>
  <tr>
    <td>Description</td>
    <td>get only</td>
    <td>Sizzling pork sausage links."</td>
  </tr>
  <tr>
    <td>Count</td>
    <td>get and set</td>
    <td>uint</td>
    <td>Defaults to 2 sausage links</td>
  </tr>
  <tr>
    <td>Price</td>
    <td>get only</td>
    <td>decimal</td>
    <td>$1.00 per sausage link</td>
  </tr>
  <tr>
    <td>Calories</td>
    <td>get only</td>
    <td>uint</td>
    <td>391 calories per link of sausage</td>
  </tr>
  <tr>
    <td>SpecialInstructions</td>
    <td>get only</td>
    <td>IEnumerable&langle;string&rangle;</td>
    <td>For any number of links but two, should include "[n] links" where [n] is the count.
    </td>
</table>

### Eviscerated Eggs

The structure for the `EvisceratedEggs` class appears in the UML diagram below:

![Eviscerated Eggs UML Diagram](/images/d.s23.4.7.png)

The specific values for the `EvisceratedEggs` properties are described in the table below

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
    <td>"Eviscerated Eggs"</td>
  </tr>
  <tr>
    <td>Description</td>
    <td>get only</td>
    <td>string</td>
    <td>"Eggs prepared the way you like."</td>
  </tr>
  <tr>
    <td>Style</td>
    <td>get and set</td>
    <td>EggStyle</td>
    <td>Defaults to over easy</td>
  </tr>
  <tr>
    <td>Count</td>
    <td>get and set</td>
    <td>uint</td>
    <td>Defaults to 2 eggs</td>
  </tr>
  <tr>
    <td>Price</td>
    <td>get only</td>
    <td>decimal</td>
    <td>$1.00 per egg</td>
  </tr>
  <tr>
    <td>Calories</td>
    <td>get only</td>
    <td>uint</td>
    <td>78 calories per egg</td>
  </tr>
  <tr>
    <td>SpecialInstructions</td>
    <td>get only</td>
    <td>IEnumerable&langle;string&rangle;</td>
    <td>Should always contain a string corresponding to the Style property, i.e. if the Style property is EggStyle.OverEasy it should contain the string "Over Easy".
    If any number of eggs other than 2 is chosen, it should also contain "[n] eggs" where [n] is the number of eggs.
    </td>
</table>

### You're Toast

The structure for the `YouAreToast` class appears in the UML diagram below:

![You're Toast UML Diagram](/images/d.s23.4.8.png)

The specific values for the `YouAreToast` properties are described in the table below

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
    <td>"You're Toast"</td>
  </tr>
  <tr>
    <td>Description</td>
    <td>get only</td>
    <td>string</td>
    <td>"Texas toast."</td>
  </tr>
  <tr>
    <td>Count</td>
    <td>get and set</td>
    <td>uint</td>
    <td>Defaults to 2 slices of toast</td>
  </tr>
  <tr>
    <td>Price</td>
    <td>get only</td>
    <td>decimal</td>
    <td>$1.00 per slice of toast</td>
  </tr>
  <tr>
    <td>Calories</td>
    <td>get only</td>
    <td>uint</td>
    <td>100 calories per slice of toast</td>
  </tr>
  <tr>
    <td>SpecialInstructions</td>
    <td>get only</td>
    <td>IEnumerable&langle;string&rangle;</td>
    <td>For any number of slices but two, should include "[n] slices" where [n] is the count.
    </td>
</table>



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
