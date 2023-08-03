+++
title = "Milestone 9 Requirements"
pre = "11. "
weight = 110
date = 2018-08-24T10:53:26-05:00
+++

{{% notice noiframe %}}
This textbook was authored for the **CIS 400 - Object-Oriented Design, Implementation, and Testing** course at Kansas State University.  This section describes assignments specific to the **Spring 2023** offering of that course.  Prior semester offerings can be found [here](old). If you are not enrolled in the course, please disregard this section.
{{% /notice %}}

### General requirements:

* You will need to follow the style laid out in the C# Coding Conventions

* You will need to comment your code using XML comments

* You will need to update your UML to reflect your current code

* You will need to write appropriate unit tests for your code

### Assignment requirements:

* Create a new ASP.NET Core Web project named "Website" using the Razor Pages option

* Update the Layout, Privacy Page, and About page following the details laid out below

* Create a static Menu class in your Data project

* Update the Index page to dynamically list the full menu provided by the Data library

* Update your UML Class Diagrams for:
  * Data Project
  * Website Project

(You don't need to create a UML of your test project, though you can if you like)

### Purpose:

This assignment is to get you started on creating a ASP.NET project, and using razor pages to implement a website.   

### Assignment Details

Begin by creating a new Razor Pages app named “Website” within your project. Then implement the requirements listed below.

Beyond these core requirements, you may add features and elements as you see fit. Moreover, you are encouraged to style the site using CSS.

{{% notice tip %}}
An [art package](/files/FlyingSaucerMenuArt.zip) has been provided for you to use in developing your site.  Or, you can create your own assets!
{{% /notice %}}

{{% notice warning %}}
The example website images are drawn from a prior semester's project.  You will need to create yours to reflect the information from _this semester's_ project! {{% /notice %}}

#### Privacy Page

Modify the Razor page named _Privacy.cshtml_ to meet the following guidelines. An example of what this might look like:

![Privacy page example](/images/d.10.1.png)

It should:
1. Set the page title to “Privacy Policy”
2. Render a `<h1>` tag with the text “Dino Diner Website Privacy Policy” or something similar.
3. Render the following privacy policy in a `<p>` tag:

_The Flying Saucer values and respects the privacy and autonomy of all sentient beings, regardless of their planet of origin. This site does not collect your data. This site does not use cookies. This site only offers information about the Flying Saucer restaurant and its menu selection._

#### About Page 

Create a new Razor page named _About.cshtml_. It should meet the following guidelines. An example of what this might look like:

![About page example](/images/d.10.2.png)

1. Set the page title to “About”
2. Render a `<h1>` tag with the text “About Dino Diner”
3. Render the following description in a `<p>` tag:

_Founded in 2023 by definitely human Earth students of the CIS 400 course, the Flying Saucer offers breakfast repasts at any hour of the day for your avid consuming. Beam down to any of our many Earth-based locations for a taste._

#### Layout

Modify the existing (created by the template) _Shared/_Layout.cshtml_ to (at a minimum):

1. Set the page title to what is provided by the page with the string “- The Flying Saucer” concatenated to the end
2. Provide a navigation link to the About page and the Privacy page, and also in-page links (links that scroll down the page) to Entrees, Sides, and Drinks.
3. Change the copyright statement to “(c) 2022 - The Flying Saucer LLC.”

{{% notice hint %}}

You can make the browser scroll to a specific section of the page by adding a `#` followed by the `id` of the page you want to scroll to.  I.e. if you want to scroll to the tag `<h1 id="sides">` on the home page, the corresponding URL would be `/home#sides`.  With a normal anchor tag, this would be: `<a href="/home#sides">Sides</a>`.

If you are using the ASP tag helpers, the equivalent tag would be `<a asp-page="Home" asp-fragment="sides">Sides</a>`.
{{% /notice %}}

The navigation bar should look something like:

![Navigation example](/images/d.10.3.png)


#### Create a static Menu class
In your `Data` project you should create a static class named `Menu` declared in the file _Menu.cs_ which contains the following `static` properties:

* `Entrees` which returns an `IEnumerable<IMenuItem>` containing an instance of all available entrees in their default configuration.
* `Sides` which returns an `IEnumerable<IMenuItem>` containing an instance of all available sides.
* `Drinks` which returns an `IEnumerable<IMenuItem>` containing all available drinks.  As each drink has 3 different sizes, this collection should contain a small and large instance of each. 
* `FullMenu` should return an `IEnumerable<IMenuItem>` containing all of the items on the menu (one of each of the items found in the categories above).

#### Index Page 

Modify the existing _Index.cshtml_ page to display the full menu of Dino Diner according to the guidelines that follow.  An example of what this might look like:

![Home page example](/images/d.10.4.png)

##### Welcome Message
Add a first-level header (`<h1>`) identifying the page as "Dino Diner".

Under that, add a section greeting the customer with the message:

_Breakfast out of this World!_

##### List the Menu Categories
List the three categories of menu items (Entrees, Sides, and Drinks)

##### List the Menu Items
Below each of the menu category headers, list the items in that category. Each item should be placed in a `<div>` with a class of `"menu-item"`. The `<div>` should include, nested inside, the name of the item, its price, and its calories. If an item comes in multiple sizes, you will need to list the price and calories for each size.

You may use additional HTML elements to organize and present this information, and use CSS to style it as you see fit. 

You should use the methods from your `Menu` class in the Data project to determine the entrees, sides, and drinks to display.  This will mean using the `Menu` class in the model class for the index page, _Index.cshtml.cs_.


## Testing 
Testing continues to be a critical part of writing our project.  You will need to write tests for all of your code in the _Data_ project.  We will introduce testing a Razor Page app in a future module, so you don't need to test it yet.

#### Testing the Menu Class
You should test your `Menu` class to ensure that your properties are returning all the appropriate menu items.  Some strategies you may want to employ:

1. Checking the count of items in a category matches your expectation (i.e. the sides category contains 4 sides, each can be 3 sizes, for a total of 4x3 combinations, or a total of 12 items)
2. Checking that each unique combination exists in the category.  This can be done with the `Assert.Contains()` or `Assert.Collection()` [Collection Assertions](<ref "/1-object-orientation/04-testing/05-xunit-assertions#collection-assertions">}})
3. As there are a lot of possible combinations, this is one time you may need to include additional logic in your tests (i.e. loops).

{{% notice hint %}}
Keep in mind that the equality operator (`==`) when used with objects tests the two are _the exact same object_, not that their properties are equal! So to determine if two menu items are equivalent, you either must compare their properties, or override their `Equals()` method to compare their properties.
{{% /notice %}}

## Updating your UML

#### Data Project UML

Your UML Diagram needs to be updated to reflect any changes you made in this milestone, including adding the `Menu` class.

{{% notice tip %}}
Remember that static classes and methods are _underlined_ in a UML class diagram.
{{% /notice %}}

#### Web Project UML
You will need to add a UML class diagram for your new project.  You can either combine this with your existing UML (if you do this, clearly indicate which classes belong to which project), or create a second diagram.

A Razor Page is composed of two parts - the _CSHTML_ rendering template and the _CS_ file containing the page's model class.  Only the class needs to appear in a UML diagram document. It is handled the same way as any class.

## Submitting the Assignment

Once your project is complete, merge your feature branch back into the `main` branch and [create a release]({{<ref "B-git-and-github/11-release">}}) tagged `v0.9.0` with name `"Milestone 9"`.  Copy the URL for the release page and submit it to the Canvas assignment.

## Grading Rubric

The grading rubric for this assignment will be:

**15% Structure** Did you implement the structure as laid out in the specification?  Are the correct names used for classes, enums, properties, methods, events, etc?  Do classes inherit from expected base classes?

**15% Documentation** Does every class, method, property, and field use the correct XML-style documentation?  Does every XML comment tag contain explanatory text?

**15% Design** Are you appropriately using C# to create reasonably efficient, secure, and usable software?  Does your code contain bugs that will cause issues at runtime?

**15% UML Diagrams** Does your UML diagram reflect the code actually in your release?  Are all classes, enums, etc. included?  Are associations correctly identified?

**20% Functionality** Does the program do what the assignment asks?  Do properties return the expected values?  Do methods perform the expected actions?

**20% Testing** Do you have unit tests for all classes?  Do your unit tests cover all the functionality of those classes? Do you have a written test plan for your GUI? Do you have a record of employing the test plan in your release?

{{% notice warning %}}
Projects that do not compile will receive an automatic grade of 0.
{{% /notice %}}
