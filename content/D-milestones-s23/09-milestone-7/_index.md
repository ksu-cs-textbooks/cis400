+++
title = "Milestone 7 Requirements"
pre = "9. "
weight = 90
date = 2018-08-24T10:53:26-05:00
+++

{{% notice noiframe %}}
This textbook was authored for the **CIS 400 - Object-Oriented Design, Implementation, and Testing** course at Kansas State University.  This section describes assignments specific to the **Spring 2023** offering of that course.  Prior semester offerings can be found [here](old). If you are not enrolled in the course, please disregard this section.
{{% /notice %}}


In this assignment, we will be modifying the Point of Sale application to allow the user taking an order to modify individual items in an order.  This will involve creating more custom controls, implementing data binding on all menu items, and adding the ability to display different controls in our app as needed.


### General requirements:

* You will need to follow the style laid out in the C# Coding Conventions

### Assignment requirements:

* Create custom controls for count, size, etc.

* Create custom controls for modifying specific menu items

* Implement `IPropertyChanged` on all menu items

* Data bind menu items

* Refactor Order to pass forward property changes

* Create/expand your unit tests for any new classes, properties, or methods (at this point, you do not need to test custom WPF control classes)

* Update UML Diagrams

### Purpose:

This assignment is intended to help you gain a greater grasp of using composition to create complex controls from simpler ones, and to gain more practice utilizing data binding. 

#### Creating Custom Controls for Common Properties

Several of your menu items have aspects in common, such as a count of some kind (i.e. `FlyingSaucer.StackSize`), or a `ServingSize`.  Instead of re-implementing controls for these properties over and over again, you can instead create a simpler control that _only_ sets the count or allows for selection from the enumerated values.

This is both good DRY (do not repeat yourself) practice and simplifies the creation of more complex controls that can be composed using these basic controls. For this milestone, you should create (at a minimum):

1. A custom control for displaying and updating a count value
2. A custom control for displaying and updating enumerated values (such as a `ServingSize` value)

You may create additional controls as you see fit.

##### Create Menu Item Customization Controls

Once you have your basic controls created, you should turn your attention to creating controls that will allow the user to modify an item in the order.  These should be specific to a menu item, i.e. a `FlyingSaucerCustomizationControl` should be used to customize a `FlyingSaucer`.  You will need a control for each menu item served at The Flying Saucer.

Your customization controls should:
* Display the name of the menu item, i.e. "Flying Saucer".  
* Display and allow changing any boolean properties (i.e. `FlyingSaucer.Syrup`) - a `<CheckBox>` or `<ToggleButton>` is appropriate for this task
* Display and allow changing of any numeric properties (i.e. `FlyingSaucer.StackSize`) - you should use a common custom control (as described above) for this.
* Displaying and allow changing of any enumerated properties (i.e. `SaucerFuel.Size`) - you should use a common custom control (as described above) for this.
* Displaying the `Calories` property - this should _not_ be an editable control, i.e. a `<TextBlock>` would be appropriate.


#### Implement IPropertyChanged on all menu items

The `INotifyPropertyChanged` interface needs to be implemented on every menu item (Note that this can be done _through inheritance_, so you might only have to implement it in a common base class - though see the warning below for a common gotcha).  Implementing the interface requires you to declare an event of type `PropertyChangedEventHandler` named `PropertyChanged`.  Doing this much satisfies the _letter_ of the `INotifyPropertyChanged` interface, but not the _intent_.

To satisfy the intent, you should also _invoke_ any event listeners registered with your `PropertyChanged` event handler _when one of the properties of the object changes_, with the details about that change.  You must do this for **ALL** properties that can change in your menu item classes (Hint: you can skip properties like the `OuterOmlette.Price`, which cannot change).

{{% notice tip %}}
Think carefully about the requirement of invoking `PropertyChanged` _when and where the property changes_.  Consider the `Price` property of a `CrashedSacucer`.  Where does it change?  It (depending on your implementation) has no setter!  Remember, it is a _calculated_ value, and its value is dependent on the `Size` property.  So when the `Size` property changes, so does the `Price` property!  You must account for **all** the possible places in your class' code that trigger a property might change when you implement `INotifyPropertyChanged`.
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
To verify that you have correctly implemented these properties, you need to write additional tests to check that the property does, indeed change. The [PropertyChange Assertion]({{% ref "/1-object-orientation/04-testing/05-xunit-assertions#property-change-assertions" %}}) we discussed in the testing chapter is used for this purpose.  These tests should be placed in the unit test class corresponding to the menu item being tested.

Here is an example using the `SaucerFuel`:

```csharp
[Theory]
[InlineData(ServingSize.Small, "Size")]
[InlineData(ServingSize.Medium, "Size")]
[InlineData(ServingSize.Large, "Size")]
[InlineData(ServingSize.Small, "Price")]
[InlineData(ServingSize.Medium, "Price")]
[InlineData(ServingSize.Large, "Price")]
[InlineData(ServingSize.Small, "Calories")]
[InlineData(ServingSize.Medium, "Calories")]
[InlineData(ServingSize.Large, "Calories")]
public void ChangingSizeShouldNotifyOfPropertyChanges(ServingSize size, string propertyName)
{
  SaucerFuel saucerFuel = new();
  Assert.PropertyChanged(saucerFuel, propertyName, ()=>{
    saucerFuel.Size = size;
  });
}
```

{{% notice info %}}
Remember that calculated properties will change _based on the property they are calculated from_, and you must also test for these.  I.e. on the sides, you might have a test method `PricePropertyChangedWhenSizeChanges(Size size)`.  Alternatively, you could combine multiple property checks into one test, i.e. `ShouldNotifyOfPropertyChangedWhenSizeChanges(Size size, string propertyName)` (as in the example above) and supply the names of the separate properties through `[InlineData]`.
{{% /notice %}}

Additionally, it is important to test that the menu item classes implements the `INotifyPropertyChanged` interface.  This can be accomplished with the `IsAssignableFrom<T>(object obj)` [Type Assertion]({{% ref "/1-object-orientation/04-testing/05-xunit-assertions#type-assertions" %}}), i.e.:

```csharp
public void ShouldImplementINotifyChanged()
{
  SaucerFuel saucerFuel = new();
  Assert.IsAssignableFrom<INotifyPropertyChanged>(saucerFuel);
}
```

{{% notice info %}}
You might be wondering why it is important to test for if the class actually implements `INotifyPropertyChanged`.  Property binding _only_ works if the class can be cast to be an instance of `INotifyPropertyChanged`, so even if you have correctly set up the `PropertyChanged` event, your GUI will not update unless you have explicitly implemented the interface.
{{% /notice %}}
For the various Menu Items to serve as targets of data binding, you must also implement the `INotifyPropertyChanged` interface on each of them.  


#### Display bound customization controls when adding or editing an item in the order

When an item is added to an order, or an item already in the order is selected to be customized, you should display a customization control to the user:

![Example POS Customization Control](/images/d.f22.7.7.png)

For the control to be usable, you will need to temporarily replace or cover your `MenuItemSelectionControl`. Two common strategies for accomplishing this are:

1. Swapping the `Child` property of a `<Border>` or other WPF control between a `<MenuItemSelectionControl>` and the various customization screens you will need, or
2. Having all controls pre-loaded into the `<MainWindow>`, but using their [Visibility](https://learn.microsoft.com/en-us/dotnet/api/system.windows.uielement.visibility?view=windowsdesktop-7.0) property to hide or show them as needed.

##### Binding the menu item to the customization control

In either case, when you display one of your item customization controls, you will also want to set its `DataContext` property to the specific menu item you want to customize. This will apply any changes made through the customization control to the bound menu item object.

##### Editing or Removing Items from the Order

In addition to allowing the user to customize items as they are added to the order, you need to allow them to edit items previously added.  In addition, you will want to provide a mechanism for _removing_ items from the order.

A common approach is to add edit and remove buttons to your `<DataTemplate>` displayed in the `OrderSummaryControl`'s `<ListView>`.  Because the `DataTemplate` used as the `ItemTemplate` has the individual order item as its `DataContext`, placing the buttons within the `<DataTemplate>` means those buttons _also_ have the individual `IMenuItem` object as their `DataContext`, while the `OrderSummaryControl` itself has the `Order` as its `DataContext`. 

You can leverage this to use the `Remove()` method of your `Order` class without needing to pass a lot of variables around. For customization, you'll also need to display the appropriate customization control, and bind the item to its `DataContext`.

#### Update Order properties when Menu Item properties change

Finally, now that your menu items implement `IPropertyChanged`, you can handle the issue of when a property of an item in an order changes that also affects a property of the `Order` class.  For example, changing the `Size` of a `SaucerFuel` changes its price, so the `Order` containing it should update its own `Subtotal`, `Tax`, and `Total`.  Think carefully about how your menu items can communicate this change to the order class that contains them. Hint: we did something very similar in our Data Binding Exercise.

#### Update Your UML Diagrams

You will need to update your UML diagrams to reflect the changes you have made to the Data and Point of Sale projects.  Remember to mark the associations between your `Order` and its various Menu Item instances.

## Submitting the Assignment

Once your project is complete [create a release]({{% ref "B-git-and-github/12-release" %}}) tagged `v0.7.0` with name `"Milestone 7"`.  Copy the URL for the release page and submit it to the Canvas assignment.

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

-->