---
title: "Point of Sale Milestone #1"
pre: "8. "
weight: 80
date: 2018-08-24T10:53:26-05:00
---

{{% notice noiframe %}}
This textbook was authored for the **CIS 400 - Object-Oriented Design, Implementation, and Testing** course at Kansas State University.  This section describes assignments specific to that course.  If you are not enrolled in the course, please disregard this section.
{{% /notice %}}

This week we begin developing the software for a _Point of Sale System (POS)_.  A POS is the modern equivalent of a cash register, used to put together a sale, take payment, print receipts, and typically integrates with a businesses' inventory tracking system and accounting system.  In our case, we are focusing on the kind of POS found in the fast-food industry; one that takes orders, and sends an order to the kitchen, as well as taking payment and printing a receipt.

{{% notice note %}}
**Design Contest Announcement**

With the Point of Sale project, we want to encourage you to go above and beyond the core requirements of the assignments, and create an application that is both attractive and easy to use.  In other words, a _great design_!  This will both help you develop your skills, and make a great portfolio piece when you start applying for jobs.  

Accordingly, every semester we award prizes (Radina's Gift Cards) for the best POS design.  This will be judged by your TAs, and will be decided at the last milestone in the Point of Sale project (POS #4).  To be a serious contender though, you should start your efforts with this milestone.

Also, the departmental graphic designer has prepared images that may be used in your Point of Sale.  You can find them on Canvas or download them [here]({{<static "files/FlyingSaucerMenuArt.zip">}}).
{{% /notice %}}

### General requirements:

* You will need to follow the style laid out in the C# Coding Conventions

* Adding a new project named _PointOfSale_

* You will need to comment your code using XML comments

### Assignment requirements:

* Create a new Project of type Windows Presentation Foundation within your _FlyingSaucer_ project

* Create GUI components by extending the WPF `UserControl` base class to create your own custom controls consisting of layout elements and customization screens for all menu items currently offered on the menu

* Provide navigation functionality to switch between selection and customization screens

* Create/Update UML Class Diagrams corresponding to your projects (both the _Data_ and _PointOfSale_ projects).  Hint: this is when you'll start using the _has-a_ associations more regularly.

### Purpose:

This assignment is intended to introduce you to Microsoft's Windows Presentation Foundations' approach to using Extensible Application Markup Language (XAML) to create user interfaces.  XAML is a markup language based on XML which is used by WPF in a manner similar to how HTML defines the display of web pages. This assignment will challenge you to use a language you probably have not used before. We will focus on navigation between screens and how to connect user input with functionality.

### Assignment Details

Most of this class is concerned with creating custom components which bundle related functionality into a single custom control.  These are created by extending the `UserControl` class found in WPF, and embedding controls into other controls, either by nesting them within XAML, or by adding them programmatically.  The goal is to create a complete user interface for the Point of Sale system.  The initial screen might look something like:

![Example POS Main Screen]({{<static "images/d.6.1.png">}})

And pressing a button like the "Flying Saucer" button would add a Flying Saucer instance to the order (to be done next milestone) and will open a customization screen:

![Example POS Customization Screen]({{<static "images/d.6.2.png">}})

Which displays the customization options for the selected menu item.  The "Done" button in this screen will then return back to the main screen.  

In this arrangement, we might see three components (The MainWindow, an order component that manages the overall order, and either the menu item selection screen, or a customization screen for a specific element):

![Example Components of the POS]({{<static "images/d.6.3.png">}})

Making the menu item selection screen and the customization screens children (i.e. a composition association) of the `OrderComponent` greatly simplifies managing the swapping between the various screens as changes are being made to the order - though this is certainly not the only way of setting up the application.

{{% notice tip %}}
Note that this example is only one possible direction for your design to go.  The requirement is simply to display the order being built and provide the option to customize the menu item with its specific customizations.  If you would like to organize your application differently, use different controls, add images, multimedia, animations, or use a completely different approach - you are free to do so!  Doing so will make it more likely your Point of Sale will stand out from the rest of the class.  Our department graphic designer has created some [art resources]({{<static "files/FlyingSaucerMenuArt.zip">}}) you may choose to use in your project.
{{% /notice %}}

Because of the flexibility offered in WPF and in this assignment, we are not requiring specific classes be written, but rather bundles of _functionality_ (which you _will_ probably want to collect into custom components built of classes extending the `UserControl` base class).  We'll break down this required functionality according to these suggested components next:

#### MainWindow

While the assignment doesn't require specific classes, every WPF application has a class that extends the `MainWindow` control, so you will definitely have one.  This serves as the topmost control and contains the other controls/components of the program, as well as managing windows operations (going fullscreen, closing, etc). Optionally, some of the logic of the application can be moved into this class as well, though in many cases it makes more sense to place this in a component that is the child of the `MainWindow`.

In addition, your MainWindow, MenuSelectionControl, or OrderComponent control should have a button or other mechanism for:

1. Completing the order building process and starting the payment process (this does not need to be implemented yet, but your design should consider it)
2. Canceling the in-progress order, for those occasions where the customer changes their mind.

This mechanism does not need to be functional at this point - but have a spot for it to go!

#### Order Component

The POS needs to manage creating and completing orders - adding items to the order, customizing those items, totaling the cost and applying tax, and collecting payment.  While each of these processes will be tackled in a later milestone, it makes sense to have a single component responsible for them already in your application design.  Much of these processes should be pushed into their own components (i.e. you will likely want to have a component for displaying the order information, and separate components for customizing specific menu items).  Since these actions are bundled within the concept of an order, it makes sense to have one component oversee each of these subcomponents.

Remember that this component would then need to provide space for these subcomponents to be displayed, and that the order details should probably _always_ be displayed throughout the order process, probably alongside other components.

#### Menu Selection Screen Component

The POS also needs to allow the cashier to select items to add to the order.  Thus, this screen will probably primarily consist of buttons to allow the user to select items from the menu.  This could be handled by just one screen, or be split between multiple screens (i.e. select a menu category - entrees, sides, drinks, and then the specific items in that category).  As you design this control, keep in mind _usability_ and the cashiers who will be using it.  For some cashiers, small buttons may be difficult to touch due to advanced age, neuro-muscular conditions, or simply large fingertips, so making your buttons large and easy to distinguish is a good idea.  Similarly, some cashiers my have various vision issues, so making text large and easy-to-read is a good idea.  Finally, some cashiers may be illiterate, so pictures of the menu item are often included as well.

The Menu Selection screen (or screens) must allow for the selection of each menu item currently offered by the Flying Saucer:

_Entrees_
* Flying Saucer
* Crashed Saucer
* The Outer Omelette
* Space Scramble
* Livestock Mutilation
* Nothing to See Here

_Sides_
* Crop Circle Oats
* Glowing Haystack
* Taken Bacon
* Missing Links
* Eviscerated Eggs
* You're Toast!

_Drinks_
* Liquified Vegetation
* Saucer Fuel
* Water

#### Item Customization Screen Components

For each menu item, you will need to allow the cashier to customize it to meet the customer's requests.  You will probably want to accomplish this with a custom control for each type of menu item (though you may be able to combine multiple types under a single customization screen).

This means that for each boolean property in the menu item, the cashier should be able to change the boolean to `true` or `false` easily.  Checkboxes, toggle buttons, and switches are all common methods for representing this kind of functionality in a GUI.  Similarly, controls for changing categorical information (i.e. size, flavor) need to be supplied for those items that use them.  Commonly used approaches for this include drop-down selection menus and radio buttons.  As with the menu selection screen, these should be large enough to be easily interacted with, and clearly denote what they change (Note these do not yet need to be functional - that will be the focus of the next milestone).  

You will also need to provide a button or other means to return to the menu item selection screen once the customization is finished.

#### Menu/Customization Screen Navigation

For each button in your Menu Selection Screen, pressing that button should display the corresponding customization screen.  From the customization screen, clicking the "done" button should display the menu selection screen.  Further, this should be done without creating a memory leak (i.e. creating new screens and adding them to the elements tree as children of existing elements). The diagram below shows both desirable and undesirable element tree shapes as the user navigates the system:

![Good and Bad Elements Tree Shapes From Navigation]({{<static "images/d.6.4.png">}})

Note that you can still create new screens each navigation event and rely on the garbage collector to clean them up - you just need to ensure that references are no longer held for them (in which case you have a memory leak).  Or you can re-use screens you've already created.  Either approach will result in reasonable results.

#### Update your UMLs

Once you've created your new controls and all the classes involved, remember to add them to your UML diagram for the PointOfSale project.  This can either be a new UML diagram, or you can create another namespace in your existing UML diagram.

Also, if you made any modifications to the data project, remember to update its UML diagram as well.  This also includes fixing any issues your grader found in your previous diagram version.  

#### Point of Sale Milestone 1 Rubric

Every assignment begins with 100 points, from which points are deducted using the following rubric.  If the total score is reduced to 0, then the assignment is assigned a grade of 0.

Comments
* -1 point for every public member (other than test methods) not commented using XML-Style comments, as is discussed in the [documentation chapter]({{<ref "1-object-orientation/03-documentation">}}).
* -1 point for every file not containing a header describing the file purpose and author(s). **Note: you do not need to include these in XAML files**

Order Component
* -10 points if there is no order component displayed in the main window (it will just be a placeholder for now)

Menu Selection Component
* -10 points if the Menu Selection Component is not displayed in the main window when the program launches
* -2 points for every missing menu item

Item Customization Components
* -2 points for every missing customization option

Menu Screen / Customization Screen Navigation
* -10 points if pressing the item button in the Menu Selection Component does not display the corresponding Item Customization Component
* -10 points if pressing the "done" button does not return to the menu screen
* -10 points if your navigation scheme creates an endlessly nesting tree structure (causing a memory leak/performance problems)

UML Diagram
* -2 points for every missing or incorrect class
* -2 points for every missing or incorrect association

### Submissions

* Create a new release tag - Submit the release URL

  * Your release tag for this project should start a new major version, i.e. if your library milestones were **v.0.1.0, v0.2.0, and v0.3.0**, this release will be **v1.0.0**.  Likewise, if you started with version 1, this will be version 2.

  * If you do not remember how to do this, please revisit the [Git Workflows]({{<ref "b-git-workflows/01-introduction">}})
