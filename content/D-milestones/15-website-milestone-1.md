---
title: "Website Milestone #1 - Assignment Description"
pre: "15. "
weight: 150
date: 2018-08-24T10:53:26-05:00
---

{{% notice noiframe %}}
This textbook was authored for the **CIS 400 - Object-Oriented Design, Implementation, and Testing** course at Kansas State University.  This section describes assignments specific to that course.  If you are not enrolled in the course, please disregard this section.
{{% /notice %}}


### General requirements:

* You will need to follow the style laid out in the C# Coding Conventions

* You will need to comment your code using XML comments

* You will need to update your UML to reflect your current code

* You will need to write appropriate unit tests for your code

### Assignment requirements:

* Create a new ASP.NET Core web project named Website using the Razor Pages option

* Update the Layout, Privacy Page, and About page following the details laid out below

* Update the Index page to dynamically list the full menu provided by the Data library

* Update your UML Class Diagrams for:
  * Data Library
  * Website

(You don't need to create a UML of your test project, though you can if you like)

### Purpose:

This assignment is to get you started on creating a ASP.NET project, and using razor pages to implement a website.   

### Assignment Details

Begin by creating a new Razor Pages app named “Website” within your project. Then implement the requirements listed below.

Beyond these core requirements, you may add features and elements as you see fit. Moreover, you are encouraged to style the site using CSS.

#### Privacy Page

Modify the Razor page named _Privacy.cshtml_. It should:

1. Set the page title to “Privacy Policy”
2. Render a `<h1>` tag with the text “Cowboy Cafe Website Privacy Policy”
3. Render the following privacy policy in a `<p>` tag:

_Bleakwind Buffet respects and values the privacy of its customers, as we hope you respect and value our own. This site does not collect any data on you. This site does not use cookies. This site only displays information about Bleakwind Buffet and its delectable food and delightful Skyrim-themed ambiance._

#### About Page 

Create a new Razor page named _About.cshtml_. It should:

1. Set the page title to “About”
2. Render a `<h1>` tag with the text “About Bleakwind Buffet”
3. Render the following description in a `<p>` tag:

_Founded in 2020 from the game-saturated mind of Undergraduate Teaching Assistant Zachery Brunner, Bleakwind Buffet is devoted to bringing you the finest in Skyrim-themed dining experiences. So put your bow down, pull up a chair, and join the feast!_

#### Layout

Modify the existing _Shared/_Layout.cshtml_ to:

1. Set the page title to what is provided by the page with the string “- Cowboy Cafe” concatenated to the end
2. Provide a navigation link to the new About page
3. Change the copyright statement to “(c) 2020 - Bleakwind Buffet LLC.”

#### Index Page 

Modify the existing _Index.cshtml_ page to display the full menu of Bleakwind Buffet, following these guidelines:

Welcome Message
Add a first-level header (`<h1>`) identifying the page as Bleakwind Buffet.

Under that, add a section greeting the customer with the message:

_We at Bleakwind Buffet are proud to bring you authentic fantasy meals straight from the world of Skyrim. Shake the blood off your sword and sake your thirst with one of our old-fashioned sailor sodas. Hack into a Smokehouse Skeleton with your dagger. Or vanquish the the mighty Thalmor Triple Burger! You’ve had a hard adventure and earned your loot, so spend it with us!._

##### List the Menu Categories
List the three categories of menu items (Entrees, Sides, and Drinks) using second-level header tags (`<h2>`).

##### List the Menu Items
Below each of the menu category headers, list the items in that category. Each item should be placed in a `<div>` with a class of menu-item. The `<div`> should include, nested inside, the name of the item, its price, and its calories. If an item comes in multiple sizes, you will need to list the price and calories for each size.

You may use additional HTML elements to organize and present this information, and use CSS to style it as you see fit.

You should use the methods from your `Menu` class in the Data project to determine the entrees, sides, and drinks to display.  This will mean using the `Menu` class in the model class for the index page, _Index.cshtml.cs_.

##### Display the Combo Details 
Indicate that any entree, side, and drink can be combined into a Combo with a $1 discount.

##### Display the Soda Flavors 
List the flavors available for the Sailor Soda.