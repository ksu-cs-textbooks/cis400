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

Modify the Razor page named _Privacy.cshtml_ to meet the following guidelines. An example of what this might look like:

![Privacy page example](images/d.10.1.png)

It should:

1. Set the page title to “Privacy Policy”
2. Render a `<h1>` tag with the text “The Flying Saucer Website Privacy Policy” or something similar.
3. Render the following privacy policy in a `<p>` tag:

_The Flying Saucer respects the privacy and autonomy of all sentient beings.  This site does not collect your data. This site does not use cookies. This site only offers information about The Flying Saucer and its out-of-this world consumable foodstuffs._

#### About Page 

Create a new Razor page named _About.cshtml_. It should meet the following guidelines. An example of what this might look like:

![About page example](images/d.10.2.png)

1. Set the page title to “About”
2. Render a `<h1>` tag with the text “About The Flying Saucer”
3. Render the following description in a `<p>` tag:

_Founded in 2021 by a group of definitely human Earth people, The Flying Saucer provides breakfast repast at any hour of the day for your devouring.  Beam down to and of our many Earth-based locations for a taste._

#### Layout

Modify the existing (created by the template) _Shared/_Layout.cshtml_ to (at a minimum):

1. Set the page title to what is provided by the page with the string “- The Flying Saucer” concatenated to the end
2. Provide a navigation link to the new About page, as well as the Privacy page, and the Entrees, Sides, and Drinks on the index page.
3. Change the copyright statement to “(c) 2020 - The Flying Saucer LLC.”
4. Add the flying saucer logo to the navigation bar.

{{% notice hint %}}

You can make the browser scroll to a specific section of the page by adding a `#` followed by the `id` of the page you want to scroll to.  I.e. if you want to scroll to the tag `<h1 id="entrees">` on the home page, the corresponding URL would be `/home#entrees`.  With a normal anchor tag, this would be: `<a href="/home#entrees">Entrees</a>`.

If you are using the ASP tag helpers, the equivalent tag would be `<a asp-page="Home" asp-fragment="entrees">Entrees</a>`.
{{% /notice %}}

The navigation bar should look like:

![Navigation example](images/d.10.3.png)

#### Index Page 

Modify the existing _Index.cshtml_ page to display the full menu of The Flying Saucer according to hte guidelines that follow.  An example of what this might look like:

![Home page example](images/d.10.4.png)

##### Welcome Message
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

### Website Milestone 1 Rubric

Every assignment begins with 100 points, from which points are deducted using the following rubric.  If the total score is reduced to 0, then the assignment is assigned a grade of 0.

Comments
* -1 point for every public member (other than test methods) not commented using XML-Style comments, as is discussed in the [documentation chapter]({{% ref "1-object-orientation/03-documentation" %}}).
* -1 point for every file not containing a header describing the file purpose and author(s). **Note: you do not need to include these in CSHTML files**

Privacy Page
* -20 points if the privacy page is missing 
* -5 points if the page title does not contain "Privacy"
* -5 points if a header with the term "Privacy" or "Privacy Policy" does not appear above the privacy message
* -10 points if the page does not contain the supplied privacy message

About Page 
* -20 points if the about page is missing
* -5 points if the page title does not contain "About"
* -5 points if a header with the term "About" does not appear above the about message
* -10 points if the page does not contain the supplied about message

Layout
* -5 points if the flying saucer logo does not appear in the navigation bar 
* -5 points if the string "The Flying Saucer" does not appear in the title 
* -5 points for each missing navigation link (Should contain links for about, privacy, entrees, sides, and drinks)

Home Page
* -20 points if the home page is missing
* -10 points for each missing section (should have a section for entrees, sides, drinks, Syrup flavors, Juice Flavors, and Egg Styles)
* -5 points for each item missing from a section (i.e. missing the "Space Scramble" in the "Entrees" section)
* -5 points for each menu item missing its image, name, price, calories, or description

UML Diagram
* -2 points for every missing or incorrect class
* -2 points for every missing or incorrect association

{{% notice info %}}
You only need to include one UML box for each razor page (cshtml and cshtml.cs).  Technically, the cshtml file is just a text file, and the cshtml.cs file defines a model class, so we only need to include the class defined in the cshtml.cs file.

Alternatively, you can represent the cshtml portion as a box labeled with the page name, and draw an association line between it and the model class it uses (just a  plain line if fine, as the cshtml page is not a class).  
{{% /notice %}}

### Submissions

* Create a new release tag - Submit the release URL

  * Your release tag for this project should be a new minor version, i.e. if your first Point of Sale milestone was **v.1.0.0**, this release will be **v1.3.0**.

  * If you do not remember how to do this, please revisit the [Git Workflows]({{% ref "b-git-workflows/01-introduction" %}})
