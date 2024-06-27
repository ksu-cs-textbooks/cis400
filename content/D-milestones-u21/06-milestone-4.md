---
title: "Milestone 4 Requirements"
pre: "6. "
weight: 60
date: 2018-08-24T10:53:26-05:00
---

For this milestone, you will be creating a new project to run a Point-of-Sale system (POS). A POS is the modern equivalent of a cash register, used to put together a sale, take payment, print receipts, and typically integrates with a businesses' inventory tracking system and accounting system. In our case, we are focusing on the kind of POS found in the fast-food industry; one that takes orders, and sends an order to the kitchen, as well as taking payment and printing a receipt.

### General requirements:

* You need to follow the style laid out in the [C# Coding Conventions](https://docs.microsoft.com/en-us/dotnet/csharp/programming-guide/inside-a-program/coding-conventions)

* All classes should be declared in their respective namespace (see below)

* Document your classes using XML-Style comments

* Create UML class diagrams to represent your project

### Assignment requirements:

* Create a new project of type Windows Presentation Foundation named _PointOfSale_ within the _DogsNSuch_ solution

* Create GUI components by extending the WPF `UserControl` base class to create your own custom controls to allow the cashier to construct an order by clicking buttons for each menu item and add them to a list.  The GUI should look something like:

![GUI layout](images/d.u21.4.1.png)

* Update your UML Class Diagrams to reflect the current state of both projects:
  * Data
  * PointOfSale

(You don't need to create a UML of your test project, though you can if you want)

### Purpose:

This assignment is intended to introduce you to Microsoft’s Windows Presentation Foundations' approach to using Extensible Application Markup Language (XAML) to create user interfaces. XAML is a markup language based on XML which is used by WPF in a manner similar to how HTML defines the display of web pages. This assignment will challenge you to use a language you probably have not used before. We will focus on navigation between screens and how to connect user input with functionality.

### Recommendations:

* Get in the habit of reading the entire assignment before you start to code. Make sure you understand what is being asked of you. Please do not stub your toe and have to redo work because you did not read the entire assignment.

* Accuracy is _important_.  Your class, property, enumeration and other names, along with the descriptions _must match the specification given here_.  Otherwise, your code is **not correct**.  While typos may be a small issue in writing intended for human consumption, in computer code _it is a big problem!_ 

* Remember that you must document your classes.  This includes a general identity comment at the top of your files, i.e.:

```csharp
/*
* Author: Nathan Bean
* Edited by: (Only include if you are not the original author)
* File name: Something.cs
* Purpose: To inform the students of the requirements for this milestone
*/
```
**AND** XML-Style comments above every public class, field, property, and method!

### Menu Item Selection Control

Create a custom WPF control named `MenuItemSelection` in the file _MenuItemSelection.xaml_ and _MenuItemSelection.xaml.cs_ that extends the `UserControl` class.  This control should have buttons for each item that appears on the Dogs 'N Such menu, which are large enough for a user to easily touch them when displayed on a touch screen.

It should also have buttons for finalizing and canceling an order.

Your control should look something like:

![MenuItemSelectionControl](images/d.u21.4.2.png)

The only functionality that needs to be supplied for these buttons is switching to the appropriate customization screen when a button is pressed (i.e. pressing the "Hot Dog" button should swap to display a Hot Dog customization screen).  See the refactoring MainWindow discussion below

### Order Summary Control

Create a custom WPF control named `OrderSummary` in the file _OrderSummary.xaml_ and _OrderSummary.xaml.cs_ that extends the `UserControl` class.  This control should display an order number, the date of the order, a list of ordered items, the subtotal, tax, and total.

Your control should look something like:

![Order Summary Control](images/d.u21.4.3.png)

This control does not yet need to have implemented functionality - that will be implemented in the next milestone.

## Dog Customization Control

Create a custom WPF control named `DogCustomization` in the file _DogCustomization.xaml_ and _DogCustomization.xaml.cs_ that extends the `UserControl` class.  This control should display radio buttons and checkboxes or other appropriate controls for customizing a hot dog. It should also have a button for returning to the menu.

Your control should look something like:

![Dog Customization Control](images/d.u21.4.4.png)

At this point, only the button for returning to the menu selection screen needs to be operable.  See the discussion on refactoring the MainWindow, below.

## Refactor MainWindow

Refactor the MainWindow class to display the Menu Selection Control and the Order Summary Control.  It should look something like:

![Main Window](images/d.u21.4.1.png)

You should then implement an event handler that will swap the `MenuItemSelection` control for a `DogCustomization` control when one of the hot dog buttons is clicked in the `MenuItemSelection` control.  After swapping, your window should look something like:

![Main Window swapped to dog customization](images/d.u21.4.5.png)

Similarly, you will need to implement an event handler to swap back to the `MenuItemSelection` control when the return to menu button in the `DogCustomization` screen is clicked.

### Hints
The event handlers can implemented by attaching a `Button.Click` event handler directly to the `MainWindow` and determining which button was clicked there.  Alternatively, you can attach the event listener in the individual controls (`MenuItemSelection` and `DogCustomization`) and either navigate the elements tree or use `App.MainWindow` to access the `MainWindow` and invoke a method on it (you will need to define the method).

### XML Style Documentation
All public classes, properties, methods, fields, etc. should be documented inline using UML-Style documentation, as covered in the [documentation chapter]{((<ref 03-documentation>))}.

### UML Class Diagram
You will need to include a UML Class Diagram for the `Data` project and the `PointOfSale` project, which should follow the guidelines set out in the [UML Chapter]({{% ref "05-uml" %}}).  This should be added to a _documentation_ folder in your project, which __must__ be added to source control.  See ({{% ref "b-git-and-github/13-adding-documentation-files"  %}}) for guidance on ensuring the files are correctly added.  You may include either Visio, PDF, or an image file, but including a Visio file ensures you can continue to edit your UML to keep it up-to-date with changes you will make in future milestones.

Note that WPF controls define a single class in two parts (the _.xaml_ file and the _.xaml.cs_ file).  Despite it being spread over two files, it is still a single class and should have only a single box in the UML diagram.

## Submissions

* Create a new release tag - Submit the release URL

  * If you do not remember how to do this, please revisit the [Create a Release page]({{% ref "b-git-and-github/12-release" %}})

  * Keep in mind the version!!!

### Review of the week

* [Windows Presentation Foundation Docs](https://docs.microsoft.com/en-us/dotnet/desktop/wpf/?view=netdesktop-5.0)