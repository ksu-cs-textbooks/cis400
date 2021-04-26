---
title: "Website Milestone #3 - Assignment Description"
pre: "17. "
weight: 170
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

* Refactor your searching and filtering functionality to use LINQ.

* Convert your website design to be responsive (adjusting to the size of the screen)

* Update your UML Class Diagrams for:
  * Data Library
  * Website

(You don't need to create a UML of your test project, though you can if you like)

* Add unit tests for your descriptions

### Purpose:

To practice using LINQ to filter and sort data and develop facility with using CSS media queries to create responsive web designs.

### Assignment Details

For this milestone you will be adding descriptions to your menu items, modifying your filtering approach to use LINQ, and using CSS media queries to make your website responsive.

Beyond these core requirements, you may add features and elements as you see fit. Moreover, you are encouraged to style the site using CSS.

#### Responsive Design
Use CSS media queries to make your menu responsive - on screens wider than 490 pixels, you should display the menu as three columns, but on screens smaller than that (i.e. phones), display them as a single column.

#### Search and Filter Functionality
Refactor your searching and filtering functionality to use LINQ queries.  If multiple search terms are included, i.e. "Potato Ketchup", you should find everything with "Potato" in the name or description _and_ everything with "Ketchup" in the name and description.

### Website Milestone 3 Rubric

Every assignment begins with 100 points, from which points are deducted using the following rubric.  If the total score is reduced to 0, then the assignment is assigned a grade of 0.

Comments
* -1 point for every public member (other than test methods) not commented using XML-Style comments, as is discussed in the [documentation chapter]({{<ref "1-object-orientation/03-documentation">}}).
* -1 point for every file not containing a header describing the file purpose and author(s). **Note: you do not need to include these in CSHTML files**

Searching
* -10 points if the search term input is missing
* -10 points if the search functionality does not work for finding terms either the Name or Description or does not use LINQ
* -10 points if the search is not case-insensitive
* -10 points if the search does not return results which mach only part of multiple search terms

Searching Tests
* -5 points if you are missing a test for a search term in the name
* -5 points if you are missing a test for a search term in the description
* -5 points if you are missing a test for a search term not found in either a name or description
* -5 points if you are missing a test for an empty string (`""`) as the search term

Type Filtering
* -10 points if the checkbox for each of the type categories (Entrees, Sides, Drinks) that is missing
* -10 points if the filter functionality for of the type categories (Entrees, Sides, Drinks) that is missing or does not use LINQ

Calories Filtering
* -10 points each if the minimum or maximum calorie input is missing
* -10 points if the filter functionality for the calorie filtering does not work or does not use LINQ.

Calorie Filtering Tests
* -5 points if you are missing a test for calories above a minimum
* -5 points if you are missing a test for calories below a maximum
* -5 points if you are missing a test for calories between a minimum and maximum

Price Filtering
* -10 points each if the minimum or maximum price input is missing
* -10 points if the filter functionality for of the price filtering does not work or does not use LINQ.

Price Filtering Tests
* -5 points if you are missing a test for price above a minimum
* -5 points if you are missing a test for price below a maximum
* -5 points if you are missing a test for price between a minimum and maximum

UML Diagram
* -2 points for every missing or incorrect class
* -2 points for every missing or incorrect association


{{% notice info %}}
You only need to include one UML box for each razor page (cshtml and cshtml.cs).  Technically, the cshtml file is just a text file, and the cshtml.cs file defines a model class, so we only need to include the class defined in the cshtml.cs file.

Alternatively, you can represent the cshtml portion as a box labeled with the page name, and draw an association line between it and the model class it uses (just a  plain line if fine, as the cshtml page is not a class).  
{{% /notice %}}

### Submissions

* Create a new release tag - Submit the release URL

  * Your release tag for this project should be a new minor version, i.e. if your first Point of Sale milestone was **v.1.0.0**, this release will be **v1.3.1**.

  * If you do not remember how to do this, please revisit the [Git Workflows]({{<ref "b-git-workflows/01-introduction">}})
