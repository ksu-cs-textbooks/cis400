---
title: "Milestone 10 Requirements"
pre: "12. "
weight: 120
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

* You will add descriptions to all `IMenuItems`, and tweak your index page so that they appear there.

* You will be adding a search and filter form to your Index page that when submitted, displays only the menu items that fit the search criteria.

* You will add tests for the description properties.

* You will add tests for the search and filter functionality.

#### Description Property

Add a `string` get-only property to your `IMenuItem` interface.  Then, implement the property on each menu item class.  It should return the description appearing in the table below corresponding to the item:

<table>
  <tr>
    <th>Menu Item</th>
    <th>Description</th>
  </tr>
  <tr>
    <td>Virgo Classic Gyro</td>
    <td>The classic American gyro - seasoned doner pork, fresh sliced tomato, diced onion, shredded lettuce, and tzatziki sauce, wrapped in a warm flaky pita.</td>
  </tr>
  <tr>
    <td>Scorpio Spicy Gyro</td>
    <td>A gyro with a spicy twist - seasoned doner chicken, steamed peppers, chopped onions, and shredded lettuce topped with hot wing sauce and wrapped in a warm pita.</td>
  </tr>
  <tr>
    <td>Leo Lamb Gyro</td>
    <td>A fresh take on the gyro - seasoned doner lamb, fresh sliced tomato, diced onion, steamed eggplant, and shredded lettuce, smothered in mint chutney and served in a pita.</td>
  </tr>
  <tr>
    <td>Pices Fish Dish</td>
    <td>Halibut baked with onions and tomatoes in a red wine sauce</td>
  </tr>
  <tr>
    <td>Aries Fries</td>
    <td>Crispy fried potatoes topped with feta cheese, onions, and herbs.</td>
  </tr>
  <tr>
    <td>Gemini Stuffed Grape Leaves</td>
    <td>Grape leaves stuffed with spiced meat and rice.</td>
  </tr>
  <tr>
    <td>Sagittarius Greek Salad</td>
    <td>A fresh salad of sliced cucumbers, tomatoes, peppers, onion, olives, and feta cheese.</td>
  </tr>
  <tr>
    <td>Taurus Tabuleh</td>
    <td>A bulgar salad rife with fresh herbs and lemon.</td>
  </tr>
  <tr>
    <td>Libra Libation</td>
    <td>Real imported sparkling or still Greek sodas in a variety of flavors.</td>
  </tr>
  <tr>
    <td>Capricorn Mountain Tea</td>
    <td>Tea brewed from the ironwort plant, a traditional herbal health enhancer.</td>
  </tr>
  <tr>
    <td>Aquarius Ice</td>
    <td>Italian flavored ices, the coolest treat you can eat with a spoon!</td>
  </tr>
  <tr>
    <td>Cancer Halva Cake</td>
    <td>A gluten-free cake made from sesame seeds</td>
  </tr>
</table>

#### Testing Descriptions 
Add to your menu item unit tests tests of your new `Description` properties.

#### Displaying Descriptions on the Index Page
Refactor your index page so that it includes the description for each `IMenuItem` on the page.

#### Search and Filter Form
Add a form to your Index.cshtml page. that contains inputs for:

1. A submit button to run the search and filter operations
2. A text input to enter search terms into (search both the Name and Description)
3. A series of checkboxes corresponding to the types of order items (Entree, Side, and Drink)
4. Two number inputs specifying a range that calories should fall into
5. Two number inputs specifying a range that price should fall into.

Each of these additional inputs should be arranged so that their purpose and use is clear to the casual web surfer. I.e. they should be clearly labeled and ordered. Look at your Movie site for ideas.

In addition, any search terms or filter values that are set should persist (reappear in the form) when a search operation is run.

Finally, the results listed on the page should be only those that fit the search and filtering criteria (unless none have been set, in which case the full menu should be displayed).

#### Search and Filter functionality
The Searching and Filtering functionality should be implemented so that when the form on _index.cshtml_ is submitted, the displayed menu results are only those that match the search and/or filter conditions.

Searching should consider _both_ the name of the item and its description.  The search should be _case insensitive_ (i.e. capital and lower case letters are treated identically) and work for multiple terms (i.e. searching for "tomatoes eggplant" should include a Virgo Classic Gyro, even though "eggplant" does not appear in its name or description).  Finally, search terms do not need to appear in a particular sequence for a result to be returned (i.e. searching "chicken wing sauce" should return a Scorpio Spicy Gyro, even though the words do not appear in that exact sequence in its description). _Hint: You might want to use `String.Split()` to break up your search terms._

#### Testing the Menu Search and Filter Methods
You should add tests to verify that the search and filtering functions operate as expected. Remember to test both valid and null values for all parameters.  Pay special attention to the search function - it should behave as described above.  You may want to use the exact described scenarios as part of your tests.

## Submitting the Assignment
Once your project is complete, merge your feature branch back into the `main` branch and [create a release]({{% ref "B-git-and-github/12-release" %}}) tagged `v0.10.0` with name `"Milestone 10"`.  Copy the URL for the release page and submit it to the Canvas assignment.

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


