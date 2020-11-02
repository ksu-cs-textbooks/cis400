---
title: "Website Milestone #2 - Assignment Description"
pre: "16. "
weight: 160
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

* Add a form to your _Index.cshtml_ page for searching and filtering your menu.

* Add searching and filtering functionality to your menu to support searching/filtering order items.

* Add unit tests for the new searching/filtering functions

* Update your UML Class Diagrams for:
  * Data Library
  * Website

(You don't need to create a UML of your test project, though you can if you like)

### Purpose:

This assignment is to introduce submitting and processing form data, as well as applying searching and filtering to data results.

### Assignment Details

#### Search and Filter Form
Add a form to your Index.cshtml page. that contains inputs for:

1. A submit button to run the search and filter operations
A text input to enter search terms into
2. A series of checkboxes corresponding to the types of order items (Entree, Side, and Drink)
3. Two number inputs specifying a range that calories should fall into
4. Two number inputs specifying a range that price should fall into.

Each of these additional inputs should be arranged so that their purpose and use is clear to the casual web surfer. I.e. they should be clearly labeled and ordered. Look at your Movie site for ideas.

In addition, any search terms or filter values that are set should persist (reappear) when a search operation is run.

Finally, the results listed on the page should be only those that fit the search and filtering criteria (unless none have been set, in which case the full menu should be displayed).

#### Search and Filter functionality
The Searching and Filtering functionality should be implemented in your Menu class in the Data project as static methods. Each of these methods should take an IEnumerable<IOrderItem> as its starting collection, and return an IEnumerable<IOrderItem> that is the filtered or searched collection. If the filter options or search term is null, then the original collection should be returned.

The suggested structure for the Menu class is represented in the UML class diagram, below:

![UML]({{<static "images/web-ms-2.1.png">}})

#### Testing the Menu Search and Filter Methods
You should add tests to verify that the search and filtering functions operate as expected. Remember to test both valid and null values for all parameters.