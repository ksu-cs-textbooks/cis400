+++
title = "Milestone 5 Requirements"
pre = "7. "
weight = 70
date = 2018-08-24T10:53:26-05:00
+++

{{% notice noiframe %}}
This textbook was authored for the **CIS 400 - Object-Oriented Design, Implementation, and Testing** course at Kansas State University.  This section describes assignments specific to the **Spring 2023** offering of that course.  Prior semester offerings can be found [here](old). If you are not enrolled in the course, please disregard this section.
{{% /notice %}}

### General requirements:

* You need to follow the style laid out in the [C# Coding Conventions](https://docs.microsoft.com/en-us/dotnet/csharp/programming-guide/inside-a-program/coding-conventions)

* Add tests for any new functionality you add to your `data` project (we will test the `PointOfSale` project soon).

* Update your UML diagrams to reflect any changes in your Data and PointOfSale projects' structure (you do not need to include test projects in the UML).

### Assignment requirements:

You will need to:

* Add a new WPF Project `PointOfSale` to your solution.

* Create GUI components by extending the WPF `UserControl` base class to create your own custom controls to allow the cashier to take an order

* Add an override of the `ToString()` method to all of your menu classes

* Create/Update UML Class Diagrams corresponding to your projects (both the `Data` and `PointOfSale` projects).  Hint: this is when you'll start using the _has-a_ associations more regularly.

### Purpose:

This assignment is intended to introduce you to Microsoft's Windows Presentation Foundations' approach to using Extensible Application Markup Language (XAML) to create user interfaces.  XAML is a markup language based on XML which is used by WPF in a manner similar to how HTML defines the display of web pages. This assignment will challenge you to use a language you probably have not used before. We will focus on navigation between screens and how to connect user input with functionality.

### Creating the PointOfSale Project

You will create a new project, named `PointOfSale` in your `FlyingSacuer` solution.  This project **must be a .NET 6.0 WPF App**, as is shown in the images below:

![Selecting .NET Core WPF App from the New Project Wizard](/images/d.f22.7.1.png)

![Naming the project in the New Project Wizard](/images/d.f22.7.2.png)

![Selecting .NET Core 6.0 as the Target Framework from the New Project Wizard](/images/d.f22.7.3.png)

If you do not have the option of creating a .NET WPF , you may need to update your installation of Visual Studio and add the Desktop Workflow.  These steps are laid out below.

#### Updating Visual Studio to the Latest Version 

To update Visual Studio, select `Help > Check for Updates`:

![Help > Check for Updates](/images/d.f21.7.4.png)

This will launch the Visual Studio installer and it will check for a newer version and prompt you to install it if there is one.

#### Installing the Desktop Workflow

To install the Desktop Workflow, select `Tools > Get Tools and Features...`.  This will open the Visual Studio installer in modification mode.  Make sure the **.NET Desktop Development** workflow is checked.  If it isn't, check it and click the **Modify** button.

![.NET Desktop Development Workflow](/images/d.f21.7.5.png)

As some students find a video walkthrough more approachable, here is the same material in video tutorial form:

{{<youtube 3bn7gigo1IY >}}


### Setting the Default Assembly and Namespace

A newly created project in Visual Studio defaults to using the project name as the namespace name.  In this case, it will use `PointOfSale`.  We would like it to be `TheFlyingSaucer.PointOfSale` instead.  You can make this the default for all new files created in the project by right-clicking the project in the Solution Explorer and choosing "Properties":

![Selecting the Project Properties in Visual Studio](/images/d.7.8.png)

This opens the Project Properties, which includes a field for the default namespace. Update it to use `TheFlyingSaucer.PointOfSale` and save:

![Updating Default Namespace and Assembly Names](/images/d.f22.7.9.png)

Now all future classes you create in this project will begin in the `TheFlyingSaucer.PointOfSale` namespace by default, and when you compile the project, the file it creates will be _TheFlyingSaucer.PointOfSale.dll_.

Note that this does not change the namespace for _existing_ files, so you'll need to update the `MainWindow` namespace by hand.  Because our controls use _partial_ classes, you need to do this in two places: _MainWindow.xaml.cs_ and _MainWindow.xaml_.  The first looks just like any other C# file namespace, and should be familiar.  But the second (_MainWindow.xaml.cs_) is XAML, and looks a bit different:

```xml
<Window x:Class="PointOfSale.MainWindow"
        xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        xmlns:d="http://schemas.microsoft.com/expression/blend/2008"
        xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"
        xmlns:local="clr-namespace:PointOfSale"
        mc:Ignorable="d"
        Title="MainWindow" Height="450" Width="800">
```

There are actually **two** places you need to make a change here.  The first is in the `x:Class` property, which defines what class this XAML file is providing functionality for. You must use the _fully qualified class name_, i.e. include the namespaces.  Right now it is using `"PointOfSale.MainWindow"`, but it now needs to be `"TheFlyingSaucer.PointOfSale.MainWindow"`.

Th second place is the `xmlns:local` property.  This is assigning an alias of `local` to the provided namespace (xmlns stands for xml namespace), which allows us to access components we define in our project.  Its value needs to likewise be updated to `clr-namespace:TheFlyingSaucer.PointOfSale`.  

The `clr-namespace` here refers to a _common language runtime_ namespace - essentially we are creating a bridge between our C# namespace and the XML local namespace.

### Creating the GUI Components

Most of this assignment is concerned with creating custom components which bundle related functionality into a single custom control.  These are created by extending the `UserControl` class found in WPF, and embedding controls into other controls, either by nesting them within XAML, or by adding them programmatically.  The goal is to create a complete user interface for the Point of Sale system.  The initial screen might look something like:

![Example POS Main Screen](/images/d.s23.7.6.png)

In this arrangement, we see three components (The `MainWindow` which is _composed_ of the other controls and manages the overall layout, an `OrderSummaryControl` that displays the order details, and the `MenuItemSelectionControl`.

![Example Components of the POS](/images/d.s23.7.8.png)

#### MainWindow

Every WPF application has a class that extends the `MainWindow` control.  This serves as the topmost control and contains the other controls/components of the program, as well as managing windows operations (going fullscreen, closing, etc). Some of the logic of the application can be placed into this class as well, though in many cases it makes more sense to place this in a component that is the child of the `MainWindow`.

The `MainWindow` component also defines the default size of the application.  In our case, your application should be targeting a touch screen interface with a resolution of 1080 x 720, so you should set the `Width` and `Height` attributes of your `<MainWindow>` accordingly.  It should also be composed of (contain) a `<OrderSummaryControl>` and a `<MenuSelectionControl>` instance (the requirements for these components appear below), and you will determine how large these components will be displayed based on how you position them within the `MainWindow`.

{{% notice hint %}}
You may notice that most controls have a `DesignWidth` and `DesignHeight` attribute - this determines the size the control is shown _in Visual Studio's GUI Designer_.  This does **not** reflect the actual size that will be used when the program is run (that is calculated based on the size of the container).  It is a good idea to change these attributes to match the _expected_ size of your control when displayed.
{{% /notice %}}

Additionally, the `MainWindow` should have placeholder buttons for "Cancel Order", "Complete Order", and "Back to Menu". We will add the functionality for these buttons in a later milestone.

#### Order Summary Control
Define a custom component `OrderSummaryControl` in the files _OrderSummaryControl.xaml_ and _OrderSummaryControl.xaml.cs_. This component will be used to display the order details - the order number, date, price, tax, and total.  You should create placeholders for all of this information using the standard WPF components, i.e. `<TextBlock>` and organize them using one of the layout strategies you have learned.

In addition to these placeholders, you will also want to include a `<ListView>` that displays all of the items currently in the order.  Clicking one of the menu item buttons in the `MenuItemSelectionScreen` should add it here.

#### Menu Item Selection Control
Define a custom component `MenuItemSelectionControl` in the files _MenuSelectionControl.xaml_ and _MenuSelectionControl.xaml.cs_. This component will be used to display buttons corresponding to each menu item, allowing it to be added to the order. 

You can arrange these buttons in any fashion you like, but be mindful of your end-users.  You should try to achieve a design that is intuitive to the average user. Also as you design this control, keep in mind _usability_ and the cashiers who will be using it.  For some cashiers, small buttons may be difficult to touch due to advanced age, neuromuscular conditions, or simply large fingertips, so make your buttons large and easy to distinguish.  Similarly, some cashiers my have various vision issues, so making text large and easy-to-read is important.  Finally, some cashiers may be illiterate, so pictures of the menu item are often included as well.

The `MenuItemSelectionControl` must allow for the selection of each menu item currently offered by The Flying Saucer:

_Entrees_
* Flying Saucer
* Crashed Saucer
* Livestock Mutilation
* Outer Omlette

_Sides_
* Crop Circle
* Glowing Haystack
* Taken Bacon
* Missing Links
* Eviscerated Eggs
* You're Toast 

_Drinks_
* Liquified Vegetation
* Saucer Fuel
* Inorganic Substance 

Remember also that your `MenuItemSelectionControl`'s size is determined by the amount of space you have allocated for it in the `MainWindow`.  You should use this size as your `DesignWidth` and `DesignHeight` to ensure the control is completely visible in the final program.

#### Add Event Handlers to Menu Item Selection buttons
Clicking one of the buttons in the `MenuItemSelectionScreen`  should add an instance of the corresponding menu item class to the order currently being displayed in the `OrderSummaryScreen`.  You will need to add event hander(s) as needed to accomplish this.

#### Check for Legibility in Other Resolutions

WPF allows GUIs to be _responsive_ to different display sizes by automatically resizing controls to match the available space.  Doing so successfully requires some attention to how you lay out components, however. It is a good idea to perform a quality check by running your program and stretching/shrinking the window to see how your controls cope.  If a small change in resolution makes some of your controls inaccessible, you will want to fix this.

{{% notice warning %}}
Dragging components in the visual GUI editor like you did when working with Windows Forms will use the component's `Margin` property to absolutely position the child component in its parent.  This will **not** work well if the window is resized, and should be avoided.  Instead, edit the XAML directly and use layout controls to position your elements.
{{% /notice %}}

#### Update your UMLs

Once you've created your new controls and all the classes involved, remember to add them to your UML diagram for the `PointOfSale` project.  This can either be a new UML diagram, or you can create another namespace in your existing UML diagram.

You might wonder how to represent WPF controls in UML given that there are two files associated with each control: a _.xaml_ and a _.xaml.cs_.  While there are _two_ files, they represent a _single_ class (remember, WPF uses the `partial` keyword to declare control classes), so there will only be a single box for each control.

Technically, any control you embed inside another control is a _composition_ relationship, i.e. adding a `<TextBox>` to a custom control.  However, in the interest of legibility of the resulting UML diagram, we will only show these relationships for custom controls defined in our project.  So you will need to show the relationship between `MainWindow`, `MenuItemSelectionControl`, and `OrderSummaryControl` (as well as any other custom controls you create, if you also compose these controls with simpler user-defined controls).  

Also, if you made any modifications to the data project, remember to update its UML diagram as well.  This also includes fixing any issues your grader found in your previous diagram version.  

**Note: You do not need to create a UML diagram of your `DataTest` project, though you can if you want.**

## Override ToString for Menu Items

Once you have your `OrderSummaryControl` and menu item selection buttons working, you will probably notice that it is displaying the fully qualified name of the objects, i.e. `"TheFlyingSaucer.Data.FlyingSaucer"` rather than the `Name` property.  This is because by default the `ListView` invokes the `ToString()` method of any object in its `ItemSource` as it displays it.  

An easy workaround is to override the `ToString()` method of all of your menu items to display the `Name` property.  Hint - you can place this override in your base classes, and let the derived classes inherit it, allowing you to write it only 3 times rather than 13.

#### Updating your UML

Note that these additional methods will need to be added to your Data project UML class diagram.

#### Adding Tests

Likewise, you will want to add tests for the `ToString()` method to all of your unit tests.  Note that even if you implement the method in your base class, you should _test_ it in the derived classes.

## Submitting the Assignment

Once your project is complete, merge your feature branch back into the `main` branch and [create a release]({{<ref "B-git-and-github/11-release">}}) tagged `v0.5.0` with name `"Milestone 5"`.  Copy the URL for the release page and submit it to the Canvas assignment.


## Grading Rubric
The grading rubric for this assignment will be:

**20% Structure** Did you implement the structure as laid out in the specification?  Are the correct names used for classes, enums, properties, methods, events, etc?  Do classes inherit from expected base classes?

**20% Documentation** Does every class, method, property, and field use the correct XML-style documentation?  Does every XML comment tag contain explanatory text?  Is there a UML Diagram for the data project?  Does the UML accurately reflect the structure of the project

**20% Design** Are you appropriately using C# to create reasonably efficient, secure, and usable software?  Does your code contain bugs that will cause issues at runtime?

**20% Functionality** Does the program do what the assignment asks?  Do properties return the expected values?  Do methods perform the expected actions?

**20% Tests** Does the test suite include unit tests for all classes?  Do the unit tests provide adequate coverage of the project?


{{% notice warning %}}
Projects that do not compile will receive an automatic grade of 0.
{{% /notice %}}