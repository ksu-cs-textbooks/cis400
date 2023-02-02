+++
title = "Milestone 3 Requirements"
pre = "5. "
weight = 50
date = 2018-08-24T10:53:26-05:00
+++

{{% notice noiframe %}}
This textbook was authored for the **CIS 400 - Object-Oriented Design, Implementation, and Testing** course at Kansas State University.  This section describes assignments specific to the **Spring 2023** offering of that course.  Prior semester offerings can be found [here](old). If you are not enrolled in the course, please disregard this section.
{{% /notice %}}

For this milestone, you will be creating tests for the menu items you've written in previous milestones.

### General requirements:

* You need to follow the style laid out in the [C# Coding Conventions](https://docs.microsoft.com/en-us/dotnet/csharp/programming-guide/inside-a-program/coding-conventions)

* You need to document your code using [XML-style comments](https://docs.microsoft.com/en-us/dotnet/csharp/language-reference/xmldoc/recommended-tags), with a minimum of `<summary>` tags, plus `<param>`, `<returns>`, and `<exception>` as appropriate.  

### Assignment requirements:

You will need to create unit test classes for:
  * `FlyingSaucer` 
  * `CrashedSaucer`
  * `LivestockMutilation`
  * `OuterOmelette`
  * `CropCircle`
  * `GlowingHaystack`
  * `TakenBacon`
  * `MissingLinks`
  * `EvisceratedEggs`
  * `YoureToast`

### Purpose:

This milestone serves to practice writing tests utilizing the XUnit testing framework. If you have any confusion after you have read the entire assignment please do not hesitate to reach out to a Professor Bean, the TAs, or your classmates over Discord.

### Unit Test Classes
For each class in your `Data` project, add a corresponding unit test class in the `Test` project. These should use the same name as the `Data` class, with `UnitTest` appended, i.e. the unit tests for the `FlyingSaucer` class are found in the `FlyingSaucerUnitTests` class.  

Each unit test class should include fact or theory tests to verify:
* The default starting value of every property
* That constraints specified on the values of properties are adhered to
* The expected value of every derived property based on possible state combinations for the object.  If more than eight possibilities exist, at least eight must be specified by your `[InlineData]`

All of your tests should pass - if they do not, check to make sure your code being tested is correct, and also that your test is well-written.

To serve as a guide, the full unit tests for `FlyingSaucer` can be found in the `FlyingSaucerUnitTest` class in the Test project.

The expected value tables from the earlier milestones are reprinted below

{{% notice warning %}}
A few of the properties have been updated with new expectations.  These are highlighted in yellow to make it easy to find. You will need to refactor (modify) your classes to match.
{{% /notice %}}


#### Flying Saucer
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
    <td>"Flying Saucer"</td>
  </tr>
  <tr>
    <td>Description</td>
    <td>get only</td>
    <td>string</td>
    <td>"A stack of six pancakes, smothered in rich maple syrup, and topped with mixed berries and whipped cream."</td>
  </tr>
  <tr>
    <td>Stack Size</td>
    <td>get and set</td>
    <td>uint</td>
    <td>Default of 6, no more than 12</td>
  </tr>
  <tr>
    <td>Syrup</td>
    <td>get and set</td>
    <td>bool</td>
    <td>Defaults to true</td>
  </tr>
  <tr>
    <td>WhippedCream</td>
    <td>get and set</td>
    <td>bool</td>
    <td>Defaults to true</td>
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
    <td style="background-color: #FBEC5D">$8.50, plus an additional $0.75 for each additional slice beyond the default</td>
  </tr>
  <tr>
    <td>Calories</td>
    <td>get only</td>
    <td>uint</td>
    <td>64 per slice of french toast, plus 32 calories if syrup is included, 414 calories if whipped cream is included, and 89 calories if berries are included</td>
  </tr>
  <tr>
    <td>SpecialInstructions</td>
    <td>get only</td>
    <td>IEnumerable&langle;string&rangle;</td>
    <td>Should include: 
      <ul>
        <li>"[n] slices" with [n] being the number of slices when it is not the default 2</li>
        <li>"Hold Butter" if Butter is false</li>
        <li>"Hold Syrup" if Syrup is false</li>
      </ul>
    </td>
</table>

#### Crashed Saucer
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
    <td>"Crashed Saucer"</td>
  </tr>
  <tr>
    <td>Description</td>
    <td>get only</td>
    <td>string</td>
    <td>"A stack of crispy french toast smothered in syrup and topped with a pat of butter."</td>
  </tr>
  <tr>
    <td>Stack Size</td>
    <td>get and set</td>
    <td>uint</td>
    <td>Default of 2, no more than 6</td>
  </tr>
  <tr>
    <td>Syrup</td>
    <td>get and set</td>
    <td>bool</td>
    <td>Defaults to true</td>
  </tr>
  <tr>
    <td>Butter</td>
    <td>get and set</td>
    <td>bool</td>
    <td>Defaults to true</td>
  </tr>
  <tr>
    <td>Price</td>
    <td>get only</td>
    <td>decimal</td>
    <td>$6.45, plus an additional $1.50 for each additional slice beyond the default</td>
  </tr>
  <tr>
    <td>Calories</td>
    <td>get only</td>
    <td>uint</td>
    <td>149 per slice of french toast, plus 52 calories if syrup is included, and 35 calories if butter is included</td>
  </tr>
  <tr>
    <td>SpecialInstructions</td>
    <td>get only</td>
    <td>IEnumerable&langle;string&rangle;</td>
    <td>Should include: 
      <ul>
        <li>"[n] slices" with [n] being the number of slices when it is not the default 2</li>
        <li>"Hold Butter" if Butter is false</li>
        <li>"Hold Syrup" if Syrup is false</li>
      </ul>
    </td>
</table>

#### Livestock Mutilation
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
    <td>"Livestock Mutilation"</td>
  </tr>
  <tr>
    <td>Description</td>
    <td>get only</td>
    <td>string</td>
    <td>"A hearty serving of biscuits, smothered in sausage-laden gravy."</td>
  </tr>
  <tr>
    <td>Biscuits</td>
    <td>get and set</td>
    <td>uint</td>
    <td>Defaults to 3, maximum of 8</td>
  </tr>
  <tr>
    <td>Gravy</td>
    <td>get and set</td>
    <td>bool</td>
    <td>Defaults to true</td>
  </tr>
  <tr>
    <td>Price</td>
    <td>get only</td>
    <td>decimal</td>
    <td>$7.25 + $1.00 per biscuit beyond 3.</td>
  </tr>
  <tr>
    <td>Calories</td>
    <td>get only</td>
    <td>uint</td>
    <td>49 per biscuit, plus 140 calories for gravy</td>
  </tr>
  <tr>
    <td>SpecialInstructions</td>
    <td>get only</td>
    <td>IEnumerable&langle;string&rangle;</td>
    <td>Should include: 
      <ul>
        <li>"[n] biscuits" with [n] being the number of biscuits when it is not the default 3</li>
        <li>"Hold Gravy" if Gravy is false</li>
      </ul>
    </td>
</table>

#### Outer Omelette
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

#### Crop Circle
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

#### Glowing Haystack
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

#### Taken Bacon
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
    <td style="background-color: #FBEC5D">Defaults to 2 strips of bacon, must be a value between 1 and 6</td>
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

#### Missing Links
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
    <td>string</td>
    <td>Sizzling pork sausage links."</td>
  </tr>
  <tr>
    <td>Count</td>
    <td>get and set</td>
    <td>uint</td>
    <td style="background-color: #FBEC5D">Defaults to 2 sausage links, must be a value between 1 and 8</td>
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

#### Eviscerated Eggs
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
    <td style="background-color: #FBEC5D">Defaults to 2 eggs, must be a value between 1 and 6</td>
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

#### You're Toast
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
    <td style="background-color: #FBEC5D">Defaults to 2 slices of toast, must be a value between 1 and 12</td>
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

Once your project is complete, merge your feature branch back into the `main` branch and [create a release]({{<ref "B-git-and-github/11-release">}}) tagged `v0.3.0` with name `"Milestone 3"`.  Copy the URL for the release page and submit it to the Canvas assignment.

## Grading Rubric

The grading rubric for this assignment will be:

**25% Structure** Did you implement the structure as laid out in the specification?  Are the correct names used for classes, enums, properties, methods, events, etc?  Do classes inherit from expected base classes?

**25% Documentation** Does every class, method, property, and field use the correct XML-style documentation?  Does every XML comment tag contain explanatory text?

**25% Design** Are you appropriately using C# to create reasonably efficient, secure, and usable software?  Does your code contain bugs that will cause issues at runtime?

**25% Functionality** Does the program do what the assignment asks?  Do properties return the expected values?  Do methods perform the expected actions?

{{% notice warning %}}
Projects that do not compile will receive an automatic grade of 0.
{{% /notice %}}
