---
title: "Milestone 6 - Assignment Description"
pre: "8. "
weight: 80
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

* Add the _CircleRegister.dll_ as a dependency to your project

* Implement the functionality for the "complete order" and "cancel order" buttons.

* Process the payment providing options for credit, debit, or cash using the provided CircleRegister classes.

* Implement a GUI to support the cashier in collecting a customer's cash payment and making the correct change.

* Print the receipt using the provided CircleRegister class.

* Update your UML Class Diagrams for:
  * Data Library
  * Point of Sale

(You don't need to create a UML of your test project, though you can if you like)

### Purpose:

This assignment is to simulate working with an outside DotNET library - in this case a library for communicating with a cash register, card reader, and receipt printer.

In addition, this assignment will require you to implement the Model-View-ViewModel architecture and create custom controls with dependency properties.

### Assignment Details

#### Canceling the Order
The "Cancel Order" button should be available somewhere in the GUI at every step of taking the order.

Clicking this button should dispose of the current order and start a new one.  This is most easily accomplished by replacing the `Order` object bound to the `DataContext` of your MainWindow with a new `Order` instance.  If your databinding is set up correctly, this will empty the displayed order, zero the displayed subtotal, tax, and total, and a new order number will be displayed.

#### Completing the Order
The "Complete Order" button should also be available somewhere in the GUI at every step of taking the order.  Clicking it should display the payment options screen. 

#### Payment Options Screen 
You will need to create an additional control to manage payment options.  The three payment options should be prominently displayed using appropriate controls.  These options are "Cash" and "Credit/Debit".  In addition, the order details should continue to be visible, in case the customer wants to confirm any details.  There should also be a "Return to Order" button that returns to the active order to allow for additional changes to be made.

Choosing the "Credit/Debit" option should invoke the `CardReader.RunCard()` method defined in _RoundRegister.dll_ with the amount of the transaction.  This will return one of five options (also defined in _RoundRegister.dll_'s `RoundRegister` namespace):

* `CardTransactionResult.Approved`
* `CardTransactionResult.Declined`
* `CardTransactionResult.ReadError`
* `CardTransactionResult.InsufficientFunds`
* `CardTransactionResult.IncorrectPin`

If the result is `CardTransactionResult.Approved`, the order receipt should print.  Then a new order should begin (see the details on _Canceling the Order_ above for details).

Choosing the "Cash" option should display a special GUI for taking a cash payment from the customer, as detailed in the _Cash Payment Processing_ below.

#### Cash Payment Processing 
The Round Register includes a cash drawer which initially contains a set amount of bills and coins.  The static `CashDrawer` class in the _RoundRegister.dll_ represents this drawer, and keeps track of each of the number of each kind of currency it contains.  As customer payments are taken, and change given, the drawer's values need to be updated to reflect the changing amounts of currency.

Unfortunately, the developers of Round Payments, Inc. did not provide a class that will integrate with a WPF form easily.  You will therefore need to create an intermediary class to update the `RoundRegister.CashDrawer` and serve as the `DataContext` for your cash payment control.  This intermediary class will need to provide properties for the GUI to bind.  These properties need to include:

1. Properties to represent the quantity of each kind of currency in the drawer
2. Properties to represent the quantity of each kind of currency the customer is using to pay
3. Properties to represent the quantity of each kind of currency that should be provided to the customer as change for the transaction.

This intermediate class also needs to incorporate the logic for making appropriate change.  Hint: Always start with the largest currency possible, and make use of the modulus operator or `Math.Floor`.

Finally, you need to provide a method for finalizing the transaction which invokes the `CashDrawer.Open()` method, adds the quantity of currency the customer paid to the `CashDrawer`'s fields, and deducts the quantity given as change.

If you set up this intermediate control correctly, your codebehind for the cash payment control should be minimal - you will need to bind the intermediate class as the `DataContext`, and all your controls should be set up as bindings.

Thus, the `RoundRegister.CashDrawer` is the _Model_, your intermediary class is the _ModelView_, and the custom WPF user control is the _View_ of the MVVM architectural pattern.

A possible configuration for the cash payment control might be:

![Cash Payment Control Mockup](images/CashPayment.png)

Note that this kind of control could be composed of other custom controls, i.e. a `CurrencyControl` that exposes a `Label`, `CustomerQuantity`, `ChangeQuantity` dependency properties and looks something like:

![Currency Control Mockup](images/CurrencyControl.png)

While the exact appearance and functionality of the GUI is up to you, it should provide a "Return to Order" button which returns to the order to allow changes to be made, as well as a "Finalize Sale" which should invoke the method you defined in your intermediate class for finalizing the sale.  Once this has finished, you should print the receipt and begin a new order (see the details on _Canceling the Order_ above for details).

#### Printing the Receipt 

The _RoundRegister.dll_ contains a `ReceiptPrinter` class that exposes two methods: 

* `PrintLine(string text)` prints a single line of text onto the receipt tape.  
* `CutTape()` cuts the register tape, so the printed receipt can be removed.

You should add to your PointOfSale project a method or class that manages printing a receipt based on an order and payment method.  The printed receipt must contain:
* The order number
* The date and time the order was finalized
* A complete list of all items in the order, including their price and special instructions
* The subtotal for the order 
* The tax for the order
* The total for the order 
* The payment method (i.e. cash or card)
* The change owed

The arrangement of these items and their labels should be such that a customer would reasonably be able to understand the entire receipt.  You will need to print the receipt one line at a time with `PrintLine(string text)` and finish with a `CutTape()` call.  Also, note that **each line in the receipt cannot be longer than 40 characters**.  You will need to ensure that no line exceeds this limit!

To make it easier for you to check your work, the printed results are saved in a file, _receipts.txt_, which should end up in your _debug_ folder.

You should print a receipt for each completed sale.

#### Testing the Cash Payment Processing

One of the primary benefits of the MVVM architecture is it allows you to push logic that would otherwise be in the View classes into the ViewModel, and create unit tests for this ViewModel.  You should write unit tests for the intermediate class that test the ability to make correct change, finalize the sale, and update properties correctly.

Since you will not be able to replace the `CashDrawer` with a mock instance, you should invoke its `Reset()` method at the start of each test to ensure that each test starts with the drawer in the same state.

#### Testing the GUI
In addition to the automated tests, you should write a _test plan_ document for testing the GUI.  This should lead a user through a series of tests (adding specific items to the order) and provide guidance of expected results (i.e. should show specific price and order details).  This test plan should be include the process of making at least four different orders all the way through finalizing the sale.


### Submissions

* Create a new release tag - Submit the release URL

  * If you do not remember how to do this, please revisit the [Create a Release page]({{% ref "b-git-and-github/12-release" %}})

  * Keep in mind the version!!!

  ### Review of the week

* [WPF Apps with the Model-View-ViewModel Design Pattern](https://docs.microsoft.com/en-us/archive/msdn-magazine/2009/february/patterns-wpf-apps-with-the-model-view-viewmodel-design-pattern)