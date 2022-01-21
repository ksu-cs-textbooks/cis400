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

### Purpose:

To practice using LINQ to filter and sort data and develop facility with using CSS media queries to create responsive web designs.

### Assignment Details

For this milestone you will be modifying your filtering approach to use LINQ, and using CSS media queries to make your website responsive.

Beyond these core requirements, you may add features and elements as you see fit. Moreover, you are encouraged to style the site using CSS.

#### Responsive Design
Use CSS media queries to make your menu responsive - on screens wider than 490 pixels, you should display the menu as three columns, but on screens smaller than that (i.e. phones), display them as a single column.

#### Search and Filter Functionality
Refactor your searching and filtering function to use LINQ queries.  Searching should be case-insensitive.  If multiple search terms are included, i.e. "Potato Egg", you should find everything with "Potato" in the name or description _and_ everything with "Egg" in the name and description.
