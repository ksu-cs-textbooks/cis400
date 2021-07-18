---
title: "Milestone 7 - Assignment Description"
pre: "9. "
weight: 90
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

* Add searching and filtering functionality to the Index page 

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

![Privacy page example]({{<static "images/d.u21.9.1.png">}})

It should:

1. Set the page title to “Privacy Policy”
2. Render a `<h1>` tag with the text “The Flying Saucer Website Privacy Policy” or something similar.
3. Render the following privacy policy in a `<p>` tag:

_At Dogs 'N Such, we value your privacy.  This site does not collect your data. This site does not use cookies. This site only offers information about Dogs 'N Such and its delicious fare._

#### About Page 

Create a new Razor page named _About.cshtml_. It should meet the following guidelines. An example of what this might look like:

![About page example]({{<static "images/d.u21.9.2.png">}})

1. Set the page title to “About”
2. Render a `<h1>` tag with the text “About The Flying Saucer”
3. Render the following description in a `<p>` tag:

_Founded in 2021 by a group of computer science students, Dogs 'N Such provides the finest of regional sausage delicacies.  Come get some!_

#### Layout

Modify the existing (created by the template) _Shared/_Layout.cshtml_ to (at a minimum):

1. Set the page title to what is provided by the page with the string “- Dogs 'N Such” concatenated to the end
2. Provide a navigation link to the new About page, as well as the Privacy page, and the Entrees, Sides, and Drinks on the index page.
3. Change the copyright statement to “(c) 2020 - Dogs 'N Such LLC.”

{{% notice hint %}}

You can make the browser scroll to a specific section of the page by adding a `#` followed by the `id` of the page you want to scroll to.  I.e. if you want to scroll to the tag `<h1 id="entrees">` on the home page, the corresponding URL would be `/home#entrees`.  With a normal anchor tag, this would be: `<a href="/home#entrees">Entrees</a>`.

If you are using the ASP tag helpers, the equivalent tag would be `<a asp-page="Home" asp-fragment="entrees">Entrees</a>`.
{{% /notice %}}

The navigation bar should look something like:

![Navigation example]({{<static "images/d.u21.9.3.png">}})

#### Index Page 

Modify the existing _Index.cshtml_ page to display the full menu of Dogs 'N Such according to hte guidelines that follow.  An example of what this might look like:

![Home page example]({{<static "images/d.u21.9.4.png">}})

##### Welcome Message
Add a first-level header (`<h1>`) identifying the page as "Dogs 'N Such".

Under that, add a section greeting the customer with the message:

_The finest regional sausage delicacies!_

##### List the Menu Categories
List the three categories of menu items (Entrees, Sides, and Drinks) using second-level header tags (`<h2>`).

##### List the Menu Items
Below each of the menu category headers, list the items in that category. Each item should be placed in a `<div>` with a class of menu-item. The `<div`> should include, nested inside, the name of the item, its price, its calories, and its description. If an item comes in multiple sizes, you will need to list the price and calories for each size.

You may use additional HTML elements to organize and present this information, and use CSS to style it as you see fit.  This includes adding images!

You should use the methods from your `Menu` class in the Data project to determine the entrees, sides, and drinks to display.  This will mean using the `Menu` class in the model class for the index page, _Index.cshtml.cs_.

#### Search and Filter Form
Add a form to your Index.cshtml page. that contains inputs for:

1. A submit button to run the search and filter operations
2. A text input to enter search terms into (search both the Name and Description)
3. A series of checkboxes corresponding to the types of order items (Entree, Side, and Drink)
4. Two number inputs specifying a range that calories should fall into
5. Two number inputs specifying a range that price should fall into.

Each of these additional inputs should be arranged so that their purpose and use is clear to the casual web surfer. I.e. they should be clearly labeled and ordered. Look at your Movie site for ideas.

In addition, any search terms or filter values that are set should persist (reappear) when a search operation is run.

Finally, the results listed on the page should be only those that fit the search and filtering criteria (unless none have been set, in which case the full menu should be displayed).

#### Search and Filter functionality
The Searching and Filtering functionality should be implemented in your Menu class in the Data project as static methods. Each of these methods should take an `IEnumerable<IOrderItem>` as its starting collection, and return an `IEnumerable<IOrderItem>` that is the filtered or searched collection. If the filter options or search term is null, then the original collection should be returned.

The search should be _case insensitive_ (i.e. capital and lower case letters are treated identically) and work for multiple terms (i.e. searching for "buttermilk pancakes" should include the FlyingSaucer, even though "buttermilk" does not appear in its name or description).  _Hint: You might want to use `String.Split()` to break up your search terms._

The suggested structure for the Menu class is represented in the UML class diagram, below:

![UML]({{<static "images/web-ms-2.1.png">}})

#### Testing the Menu Search and Filter Methods
You should add tests to verify that the search and filtering functions operate as expected. Remember to test both valid and null values for all parameters.


{{% notice info %}}
You only need to include one UML box for each razor page (cshtml and cshtml.cs).  Technically, the cshtml file is just a text file, and the cshtml.cs file defines a model class, so we only need to include the class defined in the cshtml.cs file.

Alternatively, you can represent the cshtml portion as a box labeled with the page name, and draw an association line between it and the model class it uses (just a  plain line if fine, as the cshtml page is not a class).  
{{% /notice %}}

### Submissions

* Create a new release tag - Submit the release URL

  * If you do not remember how to do this, please revisit the [Create a Release page]({{<ref "b-git-and-github/11-release">}})

  * Keep in mind the version!!!

### Review of the week

* [Introduction to Razor Pages in ASP.NET Core](https://docs.microsoft.com/en-us/aspnet/core/razor-pages/?view=aspnetcore-5.0&tabs=visual-studio)

* [Language-Integrated Query (LINQ)](https://docs.microsoft.com/en-us/dotnet/csharp/programming-guide/concepts/linq/)