---
title: "Website Milestone #1 - Assignment Description"
pre: "10. "
weight: 100
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
2. Render a `<h1>` tag with the text “The Flying Saucer Website Privacy Policy”
3. Render the following privacy policy in a `<p>` tag:

_The Flying Saucer respects the privacy and autonomy of all sentient beings.  This site does not collect your data. This site does not use cookies. This site only offers information about The Flying Saucer and its out-of-this world consumable foodstuffs._

#### About Page 

Create a new Razor page named _About.cshtml_. It should:

1. Set the page title to “About”
2. Render a `<h1>` tag with the text “About The Flying Saucer”
3. Render the following description in a `<p>` tag:

_Founded in 2021 by a group of definitely human Earth people, The Flying Saucer provides breakfast repast at any hour of the day for your devouring.  Beam down to and of our many Earth-based locations for a taste._

#### Layout

Modify the existing (created by the template) _Shared/_Layout.cshtml_ to (at a minimum):

1. Set the page title to what is provided by the page with the string “- The Flying Saucer” concatenated to the end
2. Provide a navigation link to the new About page
3. Change the copyright statement to “(c) 2020 - The Flying Saucer LLC.”
4. Add the flying saucer logo to the navigation bar.

{{% notice hint %}}

You can make the browser scroll to a specific section of the page by adding a `#` followed by the `id` of the page you want to scroll to.  I.e. if you want to scroll to the tag `<h1 id="entrees">` on the home page, the corresponding URL would be `/home#entrees`.  With a normal anchor tag, this would be: `<a href="/home#entrees">Entrees</a>`.

If you are using the ASP tag helpers, the equivalent tag would be `<a asp-page="Home" asp-fragment="entrees">Entrees</a>`.
{{% /notice %}}

#### Index Page 

Modify the existing _Index.cshtml_ page to display the full menu of The Flying Saucer, following these guidelines:

Welcome Message
Add a first-level header (`<h1>`) identifying the page as "The Flying Saucer".

Under that, add a section greeting the customer with the message:

_Breakfast out of this World!_

(You can find an image bearing this message in the graphics resources.)

##### List the Menu Categories
List the three categories of menu items (Entrees, Sides, and Drinks) using second-level header tags (`<h2>`).

##### List the Menu Items
Below each of the menu category headers, list the items in that category. Each item should be placed in a `<div>` with a class of menu-item. The `<div`> should include, nested inside, an image of the item (see the art resources for files you can use), the name of the item, its price, its calories, and its description. If an item comes in multiple sizes, you will need to list the price and calories for each size.

You may use additional HTML elements to organize and present this information, and use CSS to style it as you see fit.  You may choose to follow the suggestions of the graphic designer included with the art assets.

You should use the methods from your `Menu` class in the Data project to determine the entrees, sides, and drinks to display.  This will mean using the `Menu` class in the model class for the index page, _Index.cshtml.cs_.

##### Display the Syrup Flavors 
List the flavors available for the Syrups somewhere on the page, under a heading "Syrup Flavors".