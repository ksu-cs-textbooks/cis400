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
2. A text input to enter search terms into (search both the Name and Description)
3. A series of checkboxes corresponding to the types of order items (Entree, Side, and Drink)
4. Two number inputs specifying a range that calories should fall into
5. Two number inputs specifying a range that price should fall into.

Each of these additional inputs should be arranged so that their purpose and use is clear to the casual web surfer. I.e. they should be clearly labeled and ordered. Look at your Movie site for ideas.

In addition, any search terms or filter values that are set should persist (reappear) when a search operation is run.

Finally, the results listed on the page should be only those that fit the search and filtering criteria (unless none have been set, in which case the full menu should be displayed).

#### Search and Filter functionality
The Searching and Filtering functionality should be implemented in your Menu class in the Data project as static methods. Each of these methods should take an IEnumerable<IOrderItem> as its starting collection, and return an IEnumerable<IOrderItem> that is the filtered or searched collection. If the filter options or search term is null, then the original collection should be returned.

The search should be _case insensitive_ (i.e. capital and lower case letters are treated identically) and work for multiple terms (i.e. searching for "buttermilk pancakes" should include the FlyingSaucer, even though "buttermilk" does not appear in its name or description).  _Hint: You might want to use `String.Split()` to break up your search terms._

The suggested structure for the Menu class is represented in the UML class diagram, below:

![UML]({{<static "images/web-ms-2.1.png">}})

#### Testing the Menu Search and Filter Methods
You should add tests to verify that the search and filtering functions operate as expected. Remember to test both valid and null values for all parameters.

### Website Milestone 2 Rubric

Every assignment begins with 100 points, from which points are deducted using the following rubric.  If the total score is reduced to 0, then the assignment is assigned a grade of 0.

Comments
* -1 point for every public member (other than test methods) not commented using XML-Style comments, as is discussed in the [documentation chapter]({{<ref "1-object-orientation/03-documentation">}}).
* -1 point for every file not containing a header describing the file purpose and author(s). **Note: you do not need to include these in CSHTML files**

Searching
* -10 points if the search term input is missing
* -10 points if the search functionality does not work for finding terms either the Name or Description
* -10 points if the search is not case-insensitive
* -10 points if the search does not return results which mach only part of multiple search terms.

Type Filtering
* -10 points if the checkbox for each of the type categories (Entrees, Sides, Drinks) that is missing
* -10 points if the filter functionality for of the type categories (Entrees, Sides, Drinks) that is missing.

Calories Filtering
* -10 points each if the minimum or maximum calorie input is missing
* -10 points if the filter functionality for the calorie filtering does not work.

Price Filtering
* -10 points each if the minimum or maximum price input is missing
* -10 points if the filter functionality for of the price filtering does not work.

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
