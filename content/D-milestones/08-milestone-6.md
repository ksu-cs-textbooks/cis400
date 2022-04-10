---
title: "Milestone 6 Requirements"
pre: "8. "
weight: 80
date: 2018-08-24T10:53:26-05:00
---

{{% notice noiframe %}}
This textbook was authored for the **CIS 400 - Object-Oriented Design, Implementation, and Testing** course at Kansas State University.  This section describes assignments specific to the **Fall 2022** offering of that course.  If you are not enrolled in the course, please disregard this section.
{{% /notice %}}

### General requirements:

* You will need to follow the style laid out in the C# Coding Conventions

* You will need to comment your code using XML comments

* You will need to update your UML to reflect your current code

* You will need to update your tests to reflect changes to your Data project

### Assignment requirements:

* Implement the `INotifyPropertyChanged` interface on all menu items

* Override the default `ToString()` method on all Entrees, Sides, Drinks, and Treats to supply a descriptive name for the item

* Write tests for all additions to the `Data` project

* Use data binding to modify the object you are customizing through the controls you have added to your customization screen

* Update your UML Class Diagrams for:
  * Data Library
  * Point of Sale

(You don't need to create a UML of your test project, though you can if you like)

### Purpose:

This assignment is intended to familiarize you with the concept of data binding, especially:
1. How it depends on `PropertyChanged` events to work. 
2. How data binding is expressed in XAML (the Binding syntax)
3. How the `DataContext` property in WPF controls can be used to share a bound object

Additionally, this assignment should give you plenty of practice making WPF controls functional. This is also where your projects will really start to diverge from each other depending on the implementation route you choose to follow.

### Assignment Details

#### Implementing INotifyPropertyChanged
Most of this assignment is centered around the implementation of the `INotifyPropertyChanged` interface.  This needs to be implemented on every menu item.  Implementing the interface requires you to declare an event of type `PropertyChangedEventHandler` named `PropertyChanged`.  Doing this much satisfies the _letter_ of the `INotifyPropertyChanged` interface, but not the _intent_.

To satisfy the intent, you should also _invoke_ any event listeners registered with your `PropertyChanged` event handler _when one of the properties of the object changes_, with the details about that change.  You must do this for **ALL** properties that can change in your menu item classes (Hint: you can skip properties like the `FriedPie.Price`, which cannot change).

{{% notice tip %}}
Think carefully about the requirement of invoking `PropertyChanged` _when and where the property changes_.  Consider the `Price` property of a `Popper`.  Where does it change?  It (depending on your implementation) has no setter!  Remember, it is a _calculated_ value, and its value is dependent on the `Size` property.  So when the `Size` property changes, so does the `Price` property!  You must account for **all** the possible places in your class' code that trigger a property might change when you implement `INotifyPropertyChanged`.
{{% /notice %}}

{{% notice warning %}}
An odd side effect of the nature of the .NET platform is that events _cannot be invoked from a different class than they are defined in_.  This includes _inherited_ events.  The standard practice to get around this issue is to declare a protected helper method to do the invocation in a base class that also implements the event, i.e.:
```csharp
protected virtual void OnPropertyChanged(string propertyName)
{
    this.PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
}
```
This method can then be called in derived classes to indicate a property is changing.
{{% /notice %}}


#### Testing your INotifyPropertyChanged Implementation
To verify that you have correctly implemented these properties, you need to write additional tests to check that the property does, indeed change. The [PropertyChange Assertion]({{<ref "/1-object-orientation/04-testing/05-xunit-assertions#property-change-assertions">}}) we discussed in the testing chapter is used for this purpose.  These tests should be placed in the unit test class corresponding to the menu item being tested.

Here is an example using the `FriedPie`:

```csharp
[Theory]
[InlineData(PieFilling.Peach)]
[InlineData(PieFilling.Apricot)]
[InlineData(PieFilling.Pineapple)]
[InlineData(PieFilling.Blueberry)]
[InlineData(PieFilling.Apple)]
[InlineData(PieFilling.Pecan)]
public void ChangingFlavorShouldNotifyOfChange(PieFilling flavor)
{
  var pie = new FriedPie();
  Assert.PropertyChanged(pie, "Flavor", ()=>{
    pie.Flavor = flavor;
  });
}
```

{{% notice info %}}
Remember that calculated properties will change _based on the property they are calculated from_, and you must also test for these.  I.e. on the sides, you might have a test method `PricePropertyChangedWhenSizeChanges(Size size)`.  Alternatively, you could combine multiple property checks into one test, i.e. `ShouldNotifyOfPropertyChangedWhenSizeChanges(Size size, string propertyName)` and supply the names of the separate properties through `[InlineData]`.
{{% /notice %}}

Additionally, it is a good idea to test that the menu item classes implements the `INotifyPropertyChanged` interface.  This can be accomplished with the `IsAssignableFrom<T>(object obj)` [Type Assertion]({{<ref "/1-object-orientation/04-testing/05-xunit-assertions#type-assertions">}}), i.e.:

```csharp
public void FriedPieShouldImplementINotifyChanged()
{
  var pie = new FriedPie();
  Assert.IsAssignableFrom<INotifyPropertyChanged>(pie);
}
```

#### Override ToString()
Every C# object has a `ToString()` method that gives a textual representation of the object.  This is also used by WPF when you bind an object to a text control, like a `TextBox`.  The default behavior of `ToString()` is to give the fully-qualified name of the class, i.e. for a `FriedPie` it would return `"FriedPiper.Data.FriedPie"`.  It is therefore a good idea to _override_ this behavior in our data classes to use a more human-readable name, i.e. `"Fried Cherry Pie"`. The string returned should be the same as that provided by your `Name` property.

#### Testing ToString() Implementation
You should add a test method named `ToStringShouldReturnExpectedValue()` to each of your Entree, Side, Drink, and Treat unit test classes to verify your `ToString()` implementation returns the expected value.  It may or may not need parameters (i.e. `size`, `flavor`), depending on the class in question.

#### Binding Items for Customization

When you open a customization screen for a menu item, you need to also _bind_ the object you are customizing.  The customization control's `DataContext` should be set to the object you want to customize.

The exact way in which you will do this depends on your implementation, but it will likely occur in your event listener for when a menu item is clicked, or in a helper method. Your process should be something like:

1. Create an instance of the appropriate Entree, Side, Drink, or Treat (based on which button was clicked)
2. Bind that instance as the `DataContext` of the corresponding customization control instance
3. Display that customization control instance in the `MainWindow`, replacing or covering up the `MenuItemSelectionControl`

Since the event you are listening for happens in the `MenuItemSelectionControl` but the displaying must happen in the `MainWindow`, you must decide which of these two locations you want to host the event listener.  If you choose the `MainWindow` you will be using a [Routed Event]({{<ref "2-desktop-development/03-events/08-routed-events">}}), i.e. `Button.Click`.  If you choose the `MenuItemsSelectionControl` you will need to climb the [Elements tree]({{<ref "2-desktop-development/02-element-tree/03-navigating-the-tree">}}) to reach the `MainWindow`.

#### Binding Customization Controls
Once you know you have your menu item classes (your entrees, sides, drinks, and treats) ready, you can bind their properties to the controls you have created in your customization screens.  Since you have set the screen's `DataContext` to be a new instance of that item (in the previous requirement), these controls will now directly modify the bound menu item object.

With many controls, verifying your binding is working correctly may be difficult (as the control behaves the same either way).  Using breakpoints, or supplying an initialized object with properties changed from their default to the binding are two ways of verifying. Alternatively, you can bind the same property to a display-only `<TextBlock>` in a summary section. This verification will become much easier when we add order tracking in the next milestone.

#### Updating your UML
Finally, update your UML to reflect the current state of your `Data` and `PointOfSale` projects.  

The `INotifyPropertyInterface` can be added like so:

![INotifyPropertyChanged UML]({{<static "images/d.7.1.png">}})

Because this is a _realization_ relationship, you will also need to add the event to your class boxes.  It should be placed in the second box (with your properties) and use the `event` stereotype, i.e.:

```
+PropertyChanged:PropertyChangedEventHandler <<event>>
```

Also, remember that any event listeners you have defined in your code behind in the `PointOfSale` project must be represented in your UML.  Also, any properties you have given a `x:Name` attribute in your XAML, i.e.:

```xml
<MainWindow>
  <Border x:Name="SwitchBorder">
  </Border>
</MainWindow>
```

Are _public properties_ and should therefore show up in your UML, i.e.:

```
+SwitchBorder:Border <<get, set>>
```

You do not need to show components defined in the XAML that do not have a `x:Name` property.

**Note: You do not need to create a UML diagram of your `DataTest` project, though you can if you want.**


## Submitting the Assignment

Once your project is complete, merge your feature branch back into the `main` branch and [create a release]({{<ref "B-git-and-github/11-release">}}) tagged `v0.6.0` with name `"Milestone 6"`.  Copy the URL for the release page and submit it to the Canvas assignment.

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