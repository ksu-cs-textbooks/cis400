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

* Add description to menu items

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

#### Descriptions

Refactor your `IOrderItem` interface to include a new property, `Description`, and add the provided descriptions to each Entree, Side, and Drink:

##### Entrees
* **Briarheart Burger:** Single patty burger on a brioche bun. Comes with ketchup, mustard, pickle, and cheese.
* **Double Draugr:** Double patty burger on a brioche bun. Comes with ketchup, mustard, pickle, cheese, tomato, lettuce, and mayo.
* **Thalmor Tripple:** Think you are strong enough to take on the Thalmor? Inlcudes two 1/4lb patties with a 1/2lb patty inbetween with ketchup, mustard, pickle, cheese, tomato, lettuce, mayo, bacon, and an egg.
* **Smokehouse Skeleton:** Put some meat on those bones with a small stack of pancakes. Includes sausage links, eggs, and hash browns on the side. Topped with the syrup of your choice.
* **Garden Orc Omelette:** Vegetarian. Two egg omelette packed with a mix of broccoli, mushrooms, and tomatoes. Topped with cheddar cheese.
* **Philly Poacher:** Cheesesteak sandwich made from grilled sirloin, topped with onions on a fried roll.
* **Jucy T-Bone:** Juicy T-Bone, not much else to say.

##### Sides
* **Vokun Salad:** A seasonal fruit salad of mellons, berries, mango, grape, apple, and oranges.
* **Fried Miraak:** Perfectly prepared hash brown pancakes.
* **Mad Otar Grits:** Cheesey Grits.
* **Dragonborn Waffle Fries:** Crispy fried potato waffle fries.

##### Drinks
* **Sailor’s Soda:** An old-fashioned jerked soda, carbonated water and flavored syrup poured over a bed of crushed ice.
* **Markarth Milk:** Hormone-free organic 2% milk.
* **Aretino Apple Juice:** Fresh squeezed apple juice.
* **Candlehearth Coffee:** Fair trade, fresh ground dark roast coffee.
* **Warrior Water:** It's water.  Just water.

#### Display Descriptions to the Website
Add displaying the descriptions to your index page. You are free to format and style these however you like.

#### Responsive Design
Use CSS media queries to make your menu responsive - on screens wider than 490 pixels, you should display the menu as three columns, but on screens smaller than that (i.e. phones), display them as a single column.

#### Search and Filter Functionality
Refactor your searching and filtering function to use LINQ queries.  In addition, expand your search to include the description text.  If multiple search terms are included, i.e. "Potato Ketchup", you should find everything with "Potato" in the name or descrition _and_ everything with "Ketchup" in the name and description.
