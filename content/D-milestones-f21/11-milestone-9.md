---
title: "Milestone 9 Requirements"
pre: "11. "
weight: 110
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
  * Data Project
  * Website Project

(You don't need to create a UML of your test project, though you can if you like)

### Purpose:

This assignment is to get you started on creating a ASP.NET project, and using razor pages to implement a website.   

### Assignment Details

Begin by creating a new Razor Pages app named “Website” within your project. Then implement the requirements listed below.

Beyond these core requirements, you may add features and elements as you see fit. Moreover, you are encouraged to style the site using CSS.

{{% notice warning %}}
The example website images are drawn from a prior semester's project.  You will need to create yours to reflect the information from _this semester's_ project!
{{% /notice %}}

#### Privacy Page

Modify the Razor page named _Privacy.cshtml_ to meet the following guidelines. An example of what this might look like:

![Privacy page example]({{<static "images/d.10.1.png">}})

It should:
1. Set the page title to “Privacy Policy”
2. Render a `<h1>` tag with the text “Gyro Scope Website Privacy Policy” or something similar.
3. Render the following privacy policy in a `<p>` tag:

_Gyro Scope respects the privacy of our diners.  This site will not ask for your sign. This site does not collect your data. This site does not use cookies. This site only offers information about Gyro Scope restaurant and its menu selection._

#### About Page 

Create a new Razor page named _About.cshtml_. It should meet the following guidelines. An example of what this might look like:

![About page example]({{<static "images/d.10.2.png">}})

1. Set the page title to “About”
2. Render a `<h1>` tag with the text “About Gyro Scope”
3. Render the following description in a `<p>` tag:

_Founded in 2022 by students of the CIS 400 course, Gyro Scope offers the finest and fastest mediterranean foods as suggested by the alignments of the stars._

#### Layout

Modify the existing (created by the template) _Shared/_Layout.cshtml_ to (at a minimum):

1. Set the page title to what is provided by the page with the string “- Gyro Scope” concatenated to the end
2. Provide a navigation link to the new About page, as well as the Privacy page, and the Entrees, Sides, Drinks, and Treats on the index page.
3. Change the copyright statement to “(c) 2020 - Gyro Scope LLC.”

{{% notice hint %}}

You can make the browser scroll to a specific section of the page by adding a `#` followed by the `id` of the page you want to scroll to.  I.e. if you want to scroll to the tag `<h1 id="entrees">` on the home page, the corresponding URL would be `/home#entrees`.  With a normal anchor tag, this would be: `<a href="/home#entrees">Entrees</a>`.

If you are using the ASP tag helpers, the equivalent tag would be `<a asp-page="Home" asp-fragment="entrees">Entrees</a>`.
{{% /notice %}}

The navigation bar should look something like:

![Navigation example]({{<static "images/d.10.3.png">}})

#### Index Page 

Modify the existing _Index.cshtml_ page to display the full menu of Gyro Scope according to hte guidelines that follow.  An example of what this might look like:

![Home page example]({{<static "images/d.10.4.png">}})

##### Welcome Message
Add a first-level header (`<h1>`) identifying the page as "Gyro Scope".

Under that, add a section greeting the customer with the message:

_When the planets align!_

##### List the Menu Categories
List the four categories of menu items (Entrees, Sides, Drinks, and Treats) using second-level header tags (`<h2>`).

##### List the Menu Items
Below each of the menu category headers, list the items in that category. Each item should be placed in a `<div>` with a class of `"menu-item"`. The `<div>` should include, nested inside, the name of the item, its price, its calories, and its description. If an item comes in multiple sizes, you will need to list the price and calories for each size.

You may use additional HTML elements to organize and present this information, and use CSS to style it as you see fit.  You may choose to follow the suggestions of the graphic designer included with the art assets.

You should use the methods from your `Menu` class in the Data project to determine the entrees, sides, and drinks to display.  This will mean using the `Menu` class in the model class for the index page, _Index.cshtml.cs_.


## Submitting the Assignment

Once your project is complete, merge your feature branch back into the `main` branch and [create a release]({{<ref "B-git-and-github/11-release">}}) tagged `v0.8.0` with name `"Milestone 8"`.  Copy the URL for the release page and submit it to the Canvas assignment.

## Grading Rubric

The grading rubric for this assignment will be:

**20% Structure** Did you implement the structure as laid out in the specification?  Are the correct names used for classes, enums, properties, methods, events, etc?  Do classes inherit from expected base classes?

**20% Documentation** Does every class, method, property, and field use the correct XML-style documentation?  Does every XML comment tag contain explanatory text?

**20% Design** Are you appropriately using C# to create reasonably efficient, secure, and usable software?  Does your code contain bugs that will cause issues at runtime?

**20% Functionality** Does the program do what the assignment asks?  Do properties return the expected values?  Do methods perform the expected actions?

**20% UML Diagrams** Does your UML diagram reflect the code actually in your release?  Are all classes, enums, etc. included?  Are associations correctly identified?

{{% notice warning %}}
Projects that do not compile will receive an automatic grade of 0.
{{% /notice %}}
