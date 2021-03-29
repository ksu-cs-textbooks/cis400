---
title: "Point of Sale Milestone #4 - Assignment Description"
pre: "14. "
weight: 140
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

Clicking this button should dispose of the current order and start a new one.  This is most easily accomplished by replacing the `Order` object bound to the `DataContext` of your top-level order control with a new `Order` instance.  If your databinding is set up correctly, this will empty the displayed order, zero the displayed subtotal, tax, and total, and a new order number will be displayed.

#### Completing the Order
The "Complete Order" button should also be available somewhere in the GUI at every step of taking the order.  Clicking it should display the payment options screen. 

#### Payment Options Screen 
The three payment options should be prominently displayed using appropriate controls.  These options are "Cash" and "Credit/Debit".  In addition, the order details should continue to be visible, in case the customer wants to confirm any details.  There should also be a "Return to Order" button that returns to the active order to allow for additional changes to be made.

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

![Cash Payment Control Mockup]({{<static "images/CashPayment.png">}})

Note that this kind of control could be composed of other custom controls, i.e. a `CurrencyControl` that exposes a `Label`, `CustomerQuantity`, `ChangeQuantity` dependency properties and looks something like:

![Currency Control Mockup]({{<static "images/CurrencyControl.png">}})

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

One of the primary benefits of the MVVM architecture is it allows you to push logic that would otherwise be in the View classes into the ViewModel, and create unit tests for this viewmodel.  You should write unit tests for the intermediate class that test the ability to make correct change, finalize the sale, and update properties correctly.

Since you will not be able to replace the `CashDrawer` with a mock instance, you should invoke its `Reset()` method at the start of each test to ensure that each test starts with the drawer in the same state.

### Point of Sale Milestone 3 Rubric

Every assignment begins with 100 points, from which points are deducted using the following rubric.  If the total score is reduced to 0, then the assignment is assigned a grade of 0.

Comments
* -1 point for every public member (other than test methods) not commented using XML-Style comments, as is discussed in the [documentation chapter]({{<ref "1-object-orientation/03-documentation">}}).
* -1 point for every file not containing a header describing the file purpose and author(s). **Note: you do not need to include these in XAML files**

Canceling the Order 
* -5 points if pressing the "Cancel" button while preparing the order does not cause a new order (with new number and date/time and no items) to be displayed in the order control.

Completing the Order 
* -5 points if pressing the "Complete" button while preparing the order does not open the payment option screen

Payment Options screen 
* -5 points if a "Cash" option is not presented 
* -5 points if a "Credit/Debit" or "Card" option is not presented

Credit/Debit Payment 
* -10 points if card payment is not implemented using the RoundRegister.dll library
* -5 points if the order is not completed on a successful card payment (i.e. receipt prints and new order begins)
* -5 points if an appropriate error is not displayed on a payment failure (i.e. "Insufficient funds", "Declined", ...) and option for alternative payment is not made available

Cash Payment 
* -10 points if the cash payment screen does not allow the user to specify the bills and coins the customer is offering as payment
* -10 points if the cash payment screen does not calculate the change due to the user _based on the bills and coins available in the cash drawer_
* -5 points if the completed cash payment does not result in the number of bills/coins in the drawer being correctly adjusted for bills taken in/change given out 
* -5 points if the order is not completed on a successful cash payment (i.e. the receipt prints and a new order begins)

Cash Payment ModelView class
* -1 point for every missing property to represent the quantity of each kind of currency in the drawer
* -1 point for every missing property to represent the quantity of each kind of currency the customer is using to pay
* -1 point for every missing property to represent the quantity of each kind of currency that should be provided to the customer as change for the transaction.

Cash Payment ModelView Unit tests 
* -1 point for every coin or bill property in the drawer that is not tested for its ability to be changed
* -1 point for every coin or bill property in customer payment that is not tested for its ability to be changed
* -10 points if the ability to make _correct_ change based on the _bills and coins currently in the drawer_ is not tested
* -5 points if completing the payment results in the corresponding removal of bills/coins for change and addition of bills/coins from the payment is not tested.

UML Diagram
* -2 points for every missing or incorrect class
* -2 points for every missing or incorrect association

### Submissions

* Create a new release tag - Submit the release URL

  * Your release tag for this project should be a new minor version, i.e. if your first Point of Sale milestone was **v.1.0.0**, this release will be **v1.3.0**.

  * If you do not remember how to do this, please revisit the [Git Workflows]({{<ref "b-git-workflows/01-introduction">}})