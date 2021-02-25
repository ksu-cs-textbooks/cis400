---
title: "PropertyChanged"
pre: "6. "
weight: 6
date: 2018-08-24T10:53:26-05:00
---

We often have classes which encapsulate data we might need to look at.  For example, we might have a "Smart" dog dish, which keeps track of the amount of food it contains in ounces.  So it exposes a `Weight` property.

Now let's assume we have a few possible add-on products that can be combined with that smart bowl.  One is a "dinner bell", which makes noises when the bowl is filled (ostensibly to attract the dog, but mostly just to annoy your neighbors).  Another is a wireless device that sends texts to your phone to let you know when the bowl is empty.

How can the software running on these devices determine when the bowl is empty or full?  One possibility would be to check the bowl's weight constantly, or at a set interval.  We call this strategy _polling_:

```csharp 
/// <summary>
/// The run button for the Dinner Bell add-on
/// </summary>
public void Run()
{
    while(bowl.Weight != 0) {
        // Do nothing
    }
    // If we reach here, the bowl is empty!
    sendEmptyText();
}
```

The problem with this approach is that it means our program is running full-bore _all the time_.  If this is a battery-operated device, those batteries will drain quickly.  It might be better if we let the smart bowl notify the Dinner Bell, but if we did this using methods, the Smart Bowl would need a reference to that dinner bell... and any other accessories we plug in.

This was a common problem in GUI design - sometimes we need to know when a property changes because we are displaying that property's value in the GUI, possibly in multiple places.  But if that property is _not_ part of a GUI display, we may not care when it changes.

### The INotifyPropertyChanged Interface

The standard answer to this dilemma in .NET is the `INotifyPropertyChanged` interface - an interface defined in the `System.ComponentModel` namespace that requires you to implement a single event `PropertyChanged` on the class that is changing.  You can define this event as:

```csharp 
public event PropertyChangedEventHandler PropertyChanged;
```
This sets up the `PropertyChanged` event handler on your class.  Let's first look at writing event listeners to take advantage of this event.

#### PropertyChanged Event Listeners

In our example, we would do this with the smart dog bowl, and add listeners to the dinner bell and empty notification tools.  The `PropertyChangedEventArgs` includes the name of the property that is changing (`PropertyName`) - so we can check that 1) the property changing is the weight, and 2) that the weight meets our criteria, i.e.:


```csharp 
/// <summary>
/// A SmartBowl accessory that sends text notifications when the SmartBowl is empty
/// </summary>
public class EmptyTexter
{
    /// <summary>
    /// Constructs a new EmptyTexter object 
    /// </summary>
    /// <param Name="bowl">The SmartBowl to listen to</param>
    public EmptyTexter(SmartBowl bowl)
    {
        bowl.PropertyChanged += onBowlPropertyChanged;
    }

    /// <summary>
    /// Responds to changes in the Weight property of the bowl
    /// </summary>
    /// <param Name="Sender">The bowl sending the event</param>
    /// <param Name="e">The event arguments (specifying which property changed)</param>
    private void onBowlPropertyChanged(object sender, PropertyChangedEventArgs e)
    {
        // Only move forward if the property changing is the weight
        if (e.PropertyName == "Weight")
        {
            if (sender is SmartBowl)
            {
                var bowl = sender as SmartBowl;
                if (bowl.Weight == 0) textBowlIsEmpty();
            }
        }
    }

    /// <summary>
    /// Helper method to notify bowl is empty
    /// </summary>
    private void textBowlIsEmpty()
    {
        // TODO: Implement texting
    }
}
```

Note that in our event listener, we need to check the specific property that is changing is the one we care about - the `Weight`.  We also cast the source of the event back into a `SmartBowl`, but only after checking the cast is possible.  Alternatively, we could have stored the `SmartBowl` instance in a class variable rather than casting.

Or, we can use the new [is type pattern expression](https://docs.microsoft.com/en-us/dotnet/csharp/pattern-matching#the-is-type-pattern-expression):

```csharp 
if(sender is SmartBowl bowl) {
    // Inside this body, bowl is the sender cast as a SmartBowl
    // TODO: logic goes here
}
```

This is syntactic sugar for:

```csharp
if(sender is SmartBowl) {
    var bowl = sender as SmartBowl;
    // TODO: logic goes here
}
```

Notice how the is type pattern expression merges the if test and variable assignment?  

Also, notice that the only extra information supplied by our `PropertyChangedEventArgs` is the name of the property - not its prior value, or any other info.  This helps keep the event lightweight, but it does mean if we need to keep track of prior values, we must implement that ourselves, as we do in the `DinnerBell` implementation:


```csharp 
/// <summary>
/// A SmartBowl accessory that makes noise when the bowl is filled
/// </summary>
public class DinnerBell
{
    /// <summary>
    /// Caches the previous weight measurement 
    /// </summary>
    private double lastWeight;

    /// <summary>
    /// Constructs a new DinnerBell object 
    /// </summary>
    /// <param Name="bowl">The SmartBowl to listen to</param>
    public DinnerBell(SmartBowl bowl)
    {
        lastWeight = bowl.Weight;
        bowl.PropertyChanged += onBowlPropertyChanged;
    }

    /// <summary>
    /// Responds to changes in the Weight property of the bowl
    /// </summary>
    /// <param Name="Sender">The bowl sending the event</param>
    /// <param Name="e">The event arguments (specifying which property changed)</param>
    private void onBowlPropertyChanged(object sender, PropertyChangedEventArgs e)
    {
        // Only move forward if the property changing is the weight
        if (e.PropertyName == "Weight")
        {
            // Cast the sender to a smart bowl using the is type expression
            if (sender is SmartBowl bowl)
            {
                // Ring the dinner bell if the bowl is now heavier 
                // (i.e. food has been added)
                if (bowl.Weight > lastWeight) ringTheBell();
                // Cache the new weight
                lastWeight = bowl.Weight;
            }
        }
    }

    /// <summary>
    /// Helper method to make noise 
    /// </summary>
    private void ringTheBell()
    {
        // TODO: Implement noisemaking
    }
}
```
#### PropertyChanged Event Handler

For the event listeners to work as expected, we need to implement the `PropertyChanged` event handler in our `SmartBowl` class with:

```csharp 
public event PropertyChangedEventHandler PropertyChanged;
```

Which makes it available for the event listeners to attach to.  But this is only _part_ of the process, we also need to _invoke_ this event when it happens.  This is done with the `Invoke(object sender, EventArgs e)` method defined for every event handler. It takes two parameters, an `object` which is the source of the event, and the `EventArgs` defining the event.  The specific kind of `EventArgs` corresponds to the event declaration - in our case, `PropertyChangedEventArgs`.

Let's start with a straightforward example.  Assume we have a `Name` property in the `SmartBowl` that is a customizable string, allowing us to identify the bowl, i.e. "Water" or "Food".  When we change it, we need to invoke the `PropertyChanged` event, i.e.:

```csharp
private string name = "Bowl";
public string Name {
    get {return name;}
    set 
    {
        name = value;
        PropertyChanged?.Invoke(this, new PropertyChangedEventArgs("Name"));
    }
}
```

Notice how we use the setter for `Name` to invoke the `PropertyChanged` event handler, _after_ the change to the property has been made.  This invocation needs to be done _after_ the change, or the responding event listener may grab the _old_ value (remember, event listeners are triggered _synchronously_).

Also note that we use the  null-conditional operator [`?.`](https://docs.microsoft.com/en-us/dotnet/csharp/language-reference/operators/member-access-operators#null-conditional-operators--and-) to avoid calling the `Invoke()` method if `PropertyChanged` is null (which is the case if no event listeners have been assigned).  

Now let's tackle a more complex example.  Since our `SmartBowl` uses a sensor to measure the weight of its contents, we might be able to read the sensor data - probably through a driver or a class representing the sensor. Rather than doing this constantly, let's set a polling interval of 1 minute:

```csharp 
/// <summary>
/// A class representing a "smart" dog bowl.
/// </summary>
public class SmartBowl : INotifyPropertyChanged 
{
    /// <summary>
    /// Event triggered when a property changes
    /// </summary>
    public event PropertyChangedEventHandler PropertyChanged;

    /// <summary>
    /// The weight sensor installed in the bowl
    /// </summary>
    Sensor sensor;

    private string name = "Bowl";
    /// <summary>
    /// The name of this bowl
    /// </summary>
    public string Name
    {
        get { return name; }
        set
        {
            name = value;
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs("Name"));
        }
    }

    private double weight;
    /// <summary>
    /// The weight of the bowl contents, measured in ounces
    /// </summary>
    public double Weight
    {
        get { return weight; }
        set
        {
            // We only want to treat the weight as changing 
            // if the change is more than a 16th of an ounce
            if (Math.Abs(weight - value) > 1 / 16)
            {
                weight = value;
                // Notify of the property changing
                PropertyChanged?.Invoke(this, new PropertyChangedEventArgs("Weight"));
            }
        }
    }

    /// <summary>
    /// Constructs a new SmartBowl 
    /// </summary>
    /// <param Name="sensor">the weight sensor</param>
    public SmartBowl(Sensor sensor)
    {
        this.sensor = sensor;
        // Set the initial weight
        weight = sensor.Value;
        // Set a timer to go off in 1 minute  
        // (ms = 60 seconds/minute * 1000 milliseconds/seconds)
        var timer = new System.Timers.Timer(60 * 1000);
        // Set the timer to reset when it goes off 
        timer.AutoReset = true;
        // Trigger a sensor read each time the timer elapses
        timer.Elapsed += readSensor;
    }

    /// <summary>
    /// Handles the elapsing of the polling timer by updating the weight
    /// </summary>
    private void readSensor(object Sender, System.Timers.ElapsedEventArgs e)
    {
        this.Weight = sensor.Value;
    }

}
```

Notice in this code, we use the setter of the `Weight` property to trigger the `PropertyChanged` event.  Because we're dealing with a real-world sensor that may have slight variations in the readings, we also only treat changes of more than 1/16th of an ounce as significant enough to change the property.

{{% notice warning %}}
With the `INotifyPropertyChanged` interface, the _only_ aspect Visual Studio checks is that the `PropertyChanged` event handler is declared.  There is no built-in check that the programmer is using it as expected.  Therefore it is upon you, the programmer, to ensure that you meet the expectation that comes with implementing this interface: _that any public or protected property that changes will invoke the `PropertyChanged` event handler_.
{{% /notice %}}

#### Testing the PropertyChanged Event Handler 

Finally, we should write unit tests to confirm that our `PropertyChanged` event handler works as expected:

```csharp 

public class SmartBowlUnitTests {

    /// <summary>
    /// A mock sensor that increases its reading by one ounce 
    /// every time its Value property is invoked.
    /// </summary>
    class MockChangingWeightSensor : Sensor
    {
        double value = 0.0;

        public double Value {
            get {
                value += 1;
                return value;
            }
        }
    }

    [Fact]
    public void NameChangeShouldTriggerPropertyChanged() 
    {
        var bowl = new SmartBowl(new MockChangingWeightSensor());
        Assert.PropertyChanged(bowl, "Name", () => {
            bowl.Name = "New Name";
        });
    }

    [Fact]
    public void WeightChangeShouldTriggerPropertyChanged()
    {
        var bowl = new SmartBowl(new MockChangingWeightSensor());
        Assert.PropertyChangedAsync(bowl, "Weight", () => {
            return Task.Delay(2 * 60 * 1000);
        });
    }
}
```

The `PropertyChanged` interface is so common in C# programming that we have _two_ assertions dealing with it.  The first we use to test the `Name` property:

```csharp
[Fact]
public void NameChangeShouldTriggerPropertyChanged() 
{
    var bowl = new SmartBowl(new MockChangingWeightSensor());
    Assert.PropertyChanged(bowl, "Name", () => {
        bowl.Name = "New Name";
    });
}
```

Notice that `Assert.PropertyChanged(@object ojb, string propertyName, Action action)` takes three arguments - first the object with the property that should be changing, second the name of the property we expect to change, and third an action that should trigger the event.  In this case, we change the name property.

The second is a bit more involved, as we have an event that happens based on a timer.  To test it therefore, we have to wait for the timer to have had an opportunity to trigger.  We do this with an asynchronous action, so we use the `Assert.PropertyChangedAsync(@object ojb, string propertyName, Func<Task> action)`.  The first two arguments are the same, but the last one is a `Func` (a function) that returns an asynchronous `Task` object.  The simplest one to use here is `Task.Delay`, which delays for the supplied period of time (in our case, two minutes).  Since our property should change on one-minute intervals, we'll know if there was a problem if it doesn't change after two minutes.