+++
title = "Milestone 10 Requirements"
pre = "12. "
weight = 120
date = 2018-08-24T10:53:26-05:00
+++

{{% notice noiframe %}}
This textbook was authored for the **CIS 400 - Object-Oriented Design, Implementation, and Testing** course at Kansas State University.  This section describes assignments specific to the **Fall 2022** offering of that course.  Prior semester offerings can be found [here](old). If you are not enrolled in the course, please disregard this section.
{{% /notice %}}


### General requirements:

* You will need to follow the style laid out in the C# Coding Conventions

* You will need to comment your code using XML comments

* You will need to update your UML to reflect your current code

* You will need to write appropriate unit tests for your code

### Assignment requirements:

* Add a form to your _Index.cshtml_ page for searching and filtering your menu.

* Add searching and filtering functionality to your menu to support searching/filtering order items by name, price, and calories.

* Add unit tests for the new searching/filtering functions

* Update your UML Class Diagrams for:
  * Data Library
  * Website

(You don't need to create a UML of your test project, though you can if you like)

### Purpose:

This assignment is to introduce submitting and processing form data, as well as applying searching and filtering to data results.

### Assignment Details

* You will be adding a search and filter form to your Index page that when submitted, displays only the menu items that fit the search criteria, including:
  * Name
  * Price range
  * Calories range

* You will add appropriate tests for the search and filter functionality.

{{% notice info %}}
In the last milestone, you had to display every option for each menu category.  In some cases, this was a _lot_ of permutations!  For this milestone, you may make whatever changes you like to the static menu class in order to display the menu as you would prefer, including modifying what is contained in your collection properties, adding additional properties, etc.

The index page should display all pertinent information about your menu, but you may do so in whatever form you choose (i.e. display options in a table, put size information in a callout box, or table, etc). Just be certain that _all_ information is available to a customer (i.e. the calories of a Cretaceous Coffee in its various sizes and with/without cream).
{{% /notice %}}

#### Search and Filter Form
Add a form to your Index.cshtml page. that contains inputs for:

1. A submit button to run the search and filter operations
2. A text input to enter search terms into (search the Name of the menu item for the term)
3. A series of checkboxes corresponding to the types of order items (Entree, Drink, and Side)
4. Two number inputs specifying a range that calories should fall into
5. Two number inputs specifying a range that price should fall into.

Each of these additional inputs should be arranged so that their purpose and use is clear to the casual web surfer. I.e. they should be clearly labeled and ordered. Look at your Movie site for ideas.

In addition, any search terms or filter values that are set should persist (reappear in the form) when a search operation is run.

Finally, the results listed on the page should be only those that fit the search and filtering criteria (unless none have been set, in which case the full menu should be displayed).

#### Search and Filter functionality
The Searching and Filtering functionality should be implemented so that when the form on _index.cshtml_ is submitted, the displayed menu results are only those that match the search and/or filter conditions.

Searching should consider the name of the item.  The search should be _case insensitive_ (i.e. capital and lower case letters are treated identically) and work for multiple terms.  Finally, search terms do not need to appear in a particular sequence for a result to be returned (i.e. searching "Nuggets Dino" should return Dino Nuggets options). _Hint: You might want to use `String.Split()` to break up your search terms._

#### Testing the Menu Search and Filter Methods
You should add tests to verify that the search and filtering functions operate as expected. Remember to test both valid and null values for all parameters.  Pay special attention to the search function - it should behave as described above.  You may want to use the exact described scenarios as part of your tests.

## Submitting the Assignment
Once your project is complete, merge your feature branch back into the `main` branch and [create a release]({{<ref "B-git-and-github/11-release">}}) tagged `v0.10.0` with name `"Milestone 10"`.  Copy the URL for the release page and submit it to the Canvas assignment.

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


