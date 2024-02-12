---
title: "Mock Objects"
pre: "6. "
weight: 6
date: 2018-08-24T10:53:26-05:00
---

One of the most important ideas behind unit testing is the idea that you are testing an object _in isolation_ from other objects (This is in direct contrast to _integration testing_, where you are interested in how objects are working together).

But how do we test a class that has a strong dependency on another class? Let's consider the case of an Automated Teller Machine (ATM). If we designed its control system using an object-oriented language, one natural architecture would be to have classes representing the cash dispenser, card reader, keyboard, display, and user's bank accounts. Then we might coordinate each of these into a central object, representing the entire ATM.

Unit testing most of these classes would be straightforward, but how do we unit test the ATM class?  It would have dependencies on each of the other classes.  If we used normal instances of those, we'd have no idea if the test was failing due to the ATM class or its dependency. This is where _mock objects_ come into play.  

We start by replacing each of the dependencies with an interface using the same method signatures, and we pass the dependencies through the ATM constructor.  We make sure our existing classes implement the interface, and pass them into the ATM when we create it.  Thus, this step doesn't change much about how our program operates - we're still using the same classes to do the same things.

But in our unit tests for the `ATM` class, we can create new classes that implement the interfaces and pass them into the ATM instance we are testing.  These are our _mock_ classes, because they "fill in" for the real classes.  Typically, a mock class is much simpler than a real class, and exposes information we might need in our test.  For example, our Display class might include a `DisplayText` method, so have it implement an `IDisplay` interface that lists `DisplayText`. Then our `MockDisplay` class might look like:

```csharp
internal class MockDisplay :IDisplay
{
  public string LastTextDisplayed {get; set;}

  public void DisplayText(string text) 
  {
    LastTextDisplayed = text;
  }
}
```

Note that our mock class implements the required method, `DisplayText`, but in a very different way than a real display would - it just holds onto the string and makes it accessible with a public property. That way, we could check its value in a test:

```csharp
[fact]
public void ShouldDisplayGreetingOnStartup()
{
  MockDisplay md = new MockDisplay();
  MockKeyboard mk = new MockKeyboard();
  MockCardReader mcr= new MockCardReader();
  MockCashDispenser mcd = new MockCashDispenser();
  Atm atm = new Atm(md, mk, mcr, mcd);
  Assert.Equal("Hello ATM!", md.LastTextDisplayed);
}
```

Given our knowledge of C#, the only way `md.LastTextDisplayed` would be the string specified was if the `ATM` class asked it to display the message when it was constructed. Thus, we know it will do the same with the real `DisplayScreen` class.  And if we have also thoroughly unit tested the `DisplayScreen` class, then we have a strong basis for believing our system is built correctly.

This approach also allows us to test things that would normally be very difficult to do - for example, we can write a method to have a `MockCardReader` trigger a `CardInserted` event:

```csharp
internal class MockCardReader : ICardReader 
{
  public event EventHandler<CardInsertedEventArgs> CardInserted;

  public void TriggerCardInserted()
  {
    CardInserted.Invoke(this, new CardInsertedEventArgs());
  }
}
```

Which allows us to check that the ATM prompts a user for a PIN once a card is inserted:

```csharp
[Fact]
public void ShouldPromptForPinOnCardInsert()
{
  MockDisplay md = new MockDisplay();
  MockKeyboard mk = new MockKeyboard();
  MockCardReader mcr= new MockCardReader();
  MockCashDispenser mcd = new MockCashDispenser();
  Atm atm = new Atm(md, mk, mcr, mcd);
  mcr.TriggerCardInserted();
  Assert.Equal("Please enter your PIN:", md.LastTextDisplayed);
}
```

Using mock objects like this can greatly simplify the test-writing process, and improve the quality and robustness of your unit tests.