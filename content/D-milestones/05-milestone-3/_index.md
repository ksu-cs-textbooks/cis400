+++
title = "Milestone 3 Requirements"
pre = "5. "
weight = 50
date = 2018-08-24T10:53:26-05:00
+++

{{% notice noiframe %}}
This textbook was authored for the **CIS 400 - Object-Oriented Design, Implementation, and Testing** course at Kansas State University.  This section describes assignments specific to the **Fall 2022** offering of that course.  Prior semester offerings can be found [here](old). If you are not enrolled in the course, please disregard this section.
{{% /notice %}}

For this milestone, you will be creating base classes for entrées, sides, and drinks served at Dino Diner. This will involve refactoring some already written classes, as well as adding some new ones.  

### General requirements:

* You need to follow the style laid out in the [C# Coding Conventions](https://docs.microsoft.com/en-us/dotnet/csharp/programming-guide/inside-a-program/coding-conventions)

* You need to document your code using [XML-style comments](https://docs.microsoft.com/en-us/dotnet/csharp/language-reference/xmldoc/recommended-tags), with a minimum of `<summary>` tags, plus `<param>`, `<returns>`, and `<exception>` as appropriate.  

### Assignment requirements:

You will need to:

* Create bases class for Burgers, Drink and Sides
* Create new enum for:
    * SodaFlavors
* Create new classes for:
    * T-Rex Triple Burger
    * Carnotaurus Cheeseburger
    * Deinonychus Double
    * Allosaurus All-American Burger
    * Plilosoda
    * Cretaceous Coffee
* Refactor existing classes to use inheritance

### Purpose:

This milestone serves to introduce and utilize aspects of polymorphism including base classes, abstract base classes, abstract methods, virtual methods, and method overriding.  While the actual programming involved is straightforward, the concepts can be challenging to master. If you have any confusion after you have read the entire assignment please do not hesitate to reach out to a Professor Bean, the TAs, or your classmates over Discord.

### Abstract Base Classes
You will need to create a base class for each of the kinds of items served at Dino Diner: _Entrees_, _Sides_, and _Drinks_. Because you will never instantiate one of these classes directly i.e. you would never write:

```csharp
Side side = new Side();
```

But rather:

```csharp 
Side side = new Triceritots();
```

You will want to declare these base classes `abstract`.

As you create these base classes, carefully consider what properties all items in that category have in common.  These properties should then be implemented in the base class, which will be one of the following:
* **A regular property** if the exact same functionality will be used in the derived classes and should never need to change,
* **A `virtual` property** if the exact same functionality will be used in almost all derived classes, but at least one is a special case, or
* **An `abstract` property** if the derived classes all have the same property but the returned values are different for each one.

Each abstract base class should be placed in the corresponding file and namespace, i.e. the class `Side` should be declared in the `DinoDiner.Data.Sides` namespace and in a file named _Side.cs_.  The classes you need to implement are `Entree`, `Side`, and `Drink`.

To give you a head start, your `Entree` base class should look like:

```csharp
namespace DinoDiner.Data.Entrees
{
    /// <summary>
    /// A base class for all entrees sold at DinoDiner
    /// </summary>
    public abstract class Entree
    {
        /// <summary>
        /// The name of the Entree
        /// </summary>
        public abstract string Name { get; }
        
        /// <summary>
        /// The price of the Entree
        /// </summary>
        public abstract decimal Price { get; }

        /// <summary>
        /// The calories of the Entree
        /// </summary>
        public abstract uint Calories { get; }
    }
}
```

### Create a Burger Base Class
Dino Diner offers a completely customizable burger, with several 'standard' configurations. To support this approach, you will want to create a base Burger class that contains _all_ the possible Burger ingredients available at Dino Diner.  This base class should be named `Burger` and should inherit from the `Entree` class.  The other burger classes (`TRexTriple`, `CarnotaurusCheeseburger`, `DeinonychusDouble`, and `AllosaurusAllAmericanBurger`) and set the appropriate default values for the boolean and enumeration properties through a parameterless constructor.  

The burger should provide a `Patties` property of type `Uint` indicating the number of patties it is served with. A single pattie is 204 calories, and adds $1.50 to the price of the burger.

The other burger ingredients should be represented with `bool` properties and are have the following properties:

<table>
  <tr>
    <th>Ingredient</th>
    <th>Calories</th>
    <th>Price</th>
  </tr>
  <tr>
    <td>Ketchup</td>
    <td>19</td>
    <td>$0.20</td>
  </tr>
  <tr>
    <td>Mustard</td>
    <td>3</td>
    <td>$0.20</td>
  </tr>
  <tr>
    <td>Pickle</td>
    <td>7</td>
    <td>$0.20</td>
  </tr>
  <tr>
    <td>Mayo</td>
    <td>94</td>
    <td>$0.20</td>
  </tr>
  <tr>
    <td>BBQ</td>
    <td>29</td>
    <td>$0.10</td>
  </tr>
  <tr>
    <td>Onion</td>
    <td>44</td>
    <td>$0.40</td>
  </tr>
  <tr>
    <td>Tomato</td>
    <td>22</td>
    <td>$0.40</td>
  </tr>
  <tr>
    <td>Lettuce</td>
    <td>5</td>
    <td>$0.30</td>
  </tr>
  <tr>
    <td>AmericanCheese</td>
    <td>104</td>
    <td>$0.25</td>
  </tr>
  <tr>
    <td>SwissCheese</td>
    <td>106</td>
    <td>$0.25</td>
  </tr>
  <tr>
    <td>Bacon</td>
    <td>43</td>
    <td>$0.50</td>
  </tr>
  <tr>
    <td>Mushrooms</td>
    <td>4</td>
    <td>$0.40</td>
  </tr>
</table>

### Create new Enum 
You will need to create a new enum in the `DinoDiner.Data.Enums` namespace to represent the soda flavors offered at Dino Diner which should be named `Soda Flavor` and contain:
* `Cola`
* `CherryCola`
* `DoctorDino`
* `LemonLime`
* `DinoDew`

### Create new Classes
You will need to create three new classes, `TRexTriple`, `CarnotaurusCheeseburger`, `DeinonychusDouble`, `AllosaurusAllAmericanBurger`, `Plilosoda`, and `Cretaceous Coffee`.

#### T-Rex Triple
The class `TRexTriple` should be declared in the `DinoDiner.Data.Entrees` namespace.  It should inherit from the `Burger` base class.  The default configuration is three patties served with Ketchup, Mayo, Pickle, Onion, Lettuce, and Tomato. The name should always be "T-Rex Triple".

#### Carnotaurus Cheeseburger
The class `CarnotaurusCheeseburger` should be declared in the `DinoDiner.Data.Entrees` namespace.  It should inherit from the `Burger` base class.  The default configuration is one patties served with Tomato, Ketchup, Pickle, and AmericanCheese. The name should always be "Carnotaurus Cheeseburger".

### Deinonychus Double
The class `DeinonychusDouble` should be declared in the `DinoDiner.Data.Entrees` namespace.  It should inherit from the `Burger` base class.  The default configuration is two patties served with BBQ, Pickle, Onion, Mushroom, and SwissCheese. The name should always be "Deinonychus Double".

#### Allosaurus All-American Burger 
The class `AllosaurusAll-AmericanBurger` should be declared in the `DinoDiner.Data.Entrees` namespace.  It should inherit from the `Burger` base class.  The default configuration is one patty served with Ketchup, Mustard, and Pickle. The name should always be "Allosaurus All-American Burger".

#### Plilosoda
The class `Plilosoda` should be declared in the `DinoDiner.Data.Drinks` namespace.  It represents a soda.  It should have a `Flavor` property of type `SodaFlavor` with getters and setters. It should have a `Size` property of type `ServingSize` with getters and setters.

It should have a `Price` get-only property of type `decimal`, a `Calories` get-only property of type `uint`, and a `Name` get-only property using the values laid out in the table below. **Note the use of spaces in the names!**

<table>
  <tr>
    <th>Flavor</th>
    <th>Size</th>
    <th>Price</th>
    <th>Calories</th>
    <th>Name</th>
  </tr>
  <tr>
    <td>Cola</td>
    <td>Small</td>
    <td>$1.00</td>
    <td>180</td>
    <td>Small Cola Plilosoda</td>
  </tr>
  <tr>
    <td>CherryCola</td>
    <td>Small</td>
    <td>$1.00</td>
    <td>100</td>
    <td>Small Cherry Cola Plilosoda</td>
  </tr>
  <tr>
    <td>Doctor Dino</td>
    <td>Small</td>
    <td>$1.00</td>
    <td>120</td>
    <td>Small Doctor Dino Plilosoda</td>
  </tr>
  <tr>
    <td>Lemon-Lime</td>
    <td>Small</td>
    <td>$1.00</td>
    <td>41</td>
    <td>Small Lemon-Lime Plilosoda</td>
  </tr>
  <tr>
    <td>DinoDew</td>
    <td>Small</td>
    <td>$1.00</td>
    <td>141</td>
    <td>Small Dino Dew Plilosoda</td>
  </tr>

  <tr>
    <td>Cola</td>
    <td>Medium</td>
    <td>$1.75</td>
    <td>288</td>
    <td>Medium Cola Plilosoda</td>
  </tr>
  <tr>
    <td>CherryCola</td>
    <td>Medium</td>
    <td>$1.75</td>
    <td>160</td>
    <td>Medium Cherry Cola Plilosoda</td>
  </tr>
  <tr>
    <td>Doctor Dino</td>
    <td>Medium</td>
    <td>$1.75</td>
    <td>192</td>
    <td>Medium Doctor Dino Plilosoda</td>
  </tr>
  <tr>
    <td>Lemon-Lime</td>
    <td>Medium</td>
    <td>$1.75</td>
    <td>66</td>
    <td>Medium Lemon-Lime Plilosoda</td>
  </tr>
  <tr>
    <td>DinoDew</td>
    <td>Medium</td>
    <td>$1.75</td>
    <td>256</td>
    <td>Medium Dino Dew Plilosoda</td>
  </tr>

  <tr>
    <td>Cola</td>
    <td>Large</td>
    <td>$2.50</td>
    <td>432</td>
    <td>Large Cola Plilosoda</td>
  </tr>
  <tr>
    <td>CherryCola</td>
    <td>Large</td>
    <td>$2.50</td>
    <td>240</td>
    <td>Large Cherry Cola Plilosoda</td>
  </tr>
  <tr>
    <td>Doctor Dino</td>
    <td>Large</td>
    <td>$2.50</td>
    <td>288</td>
    <td>Large Doctor Dino Plilosoda</td>
  </tr>
  <tr>
    <td>LemonLime</td>
    <td>Large</td>
    <td>$2.50</td>
    <td>98</td>
    <td>Large Lemon-Lime Plilosoda</td>
  </tr>
  <tr>
    <td>DinoDew</td>
    <td>Large</td>
    <td>$2.50</td>
    <td>338</td>
    <td>Large Dino Dew Plilosoda</td>
  </tr>
</table>

#### Cretaceous Coffee
The class `CretaceousCoffee` should also be declared in the `DinoDiner.Data.Drinks` namespace. It should have a `Size` property of `ServingSize`.  It should have a `Name` property of type `string` that returns "[Size] Cretaceous Coffee" where [Size] is the size of the coffee. It should have a `Price` property of type `Decimal` that returns $0.75 for small, $1.25 for medium, and $2.00 for large.  It should also have a `Calories` property of type `uint` that returns 0 calories.  It should also have a boolean property `Cream` indicating the coffee is served with cream that defaults to `false`.  If it is `true`, the `Calories` property should instead return 64.

### Refactor Existing Classes to use Inheritance
Once you have the `Side` base class, refactor your existing side classes (`Fryceritops`, `MeteorMacAndCheese`, `MezzorellaSticks`, and `Triceritots`) to inherit from it.  You will also want to refactor their existing properties as they should now inherit many of them from the base class; some may be deleted, others will need to be refactored as overridden methods by adding the `override` keyword.  

Likewise you will want to refactor the existing entree base classes (`Brontowurst`,
`DinoNuggets`, `PterodactylWings`, and `VelociWrap`) to inherit from the `Entree` base class.  You will want to refactor their properties as well.

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