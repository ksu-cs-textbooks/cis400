---
title: "Message Dispatching"
pre: "4. "
weight: 4
date: 2018-08-24T10:53:26-05:00
---
The term _dispatch_ refers to how a language decides which polymorphic operation (a method or function) a message should trigger.

Consider polymorphic functions in C# (aka _Method Overloading_, where multiple methods use the same name but have different parameters) like this one for calculating the rounded sum of an array of numbers:

```csharp
int RoundedSum(int[] a) {
  int sum = 0;
  foreach(int i in a) {
    sum += i;
  }
  return sum;
}

int RoundedSum(float[] a) {
    double sum = 0;
    foreach(int i in a) {
        sum += i;
    }
    return (int)Math.Round(sum);
}
```

How does the interpreter know which version to invoke at runtime?  It should not be a surprise that it is determined by the arguments - if an integer array is passed, the first is invoked, if a float array is passed, the second.

## Object-Oriented Polymorphism

However, inheritance can cause some challenges in selecting the appropriate polymorphic form.  Consider the following fruit implementations that feature a **Blend()** method:

```csharp
/// <summary>
/// A base class representing fruit
/// </summary>
public class Fruit
{
    /// <summary>
    /// Blends the fruit
    /// </summary>
    /// <returns>The result of blending</returns>
    public string Blend() {
      return "A pulpy mess, I guess";
    }
}

/// <summary>
/// A class representing a bananna
/// </summary>
public class Banana : Fruit
{
    /// <summary>
    /// Blends the banana
    /// </summary>
    /// <returns>The result of blending the banana</returns>
    public string Blend()
    {
        return "yellow mush";
    }
}

/// <summary>
/// A class representing a Strawberry
/// </summary>
public class Strawberry : Fruit
{
    /// <summary>
    /// Blends the strawberry
    /// </summary>
    /// <returns>The result of blending a strawberry</returns>
    public string Blend()
    {
        return "Gooey Red Sweetness";
    }
}
```

Let's add fruit instances to a list, and invoke their Blend() methods:

```csharp
List<Fruit> toBlend = List<Fruit>();
toBlend.Add(new Banana());
toBlend.Add(new Strawberry());

forEach(Fruit item in toBlend) {
  Console.WriteLine(item.Blend());
}
```

You might expect this code to produce the lines:

```
yellow mush
Gooey Red Sweetness
```

As these are the return values for the Blend() methods for the Banana and Strawberry, respectively.  However, we will get:

```
A pulpy mess, I guess?
A pulpy mess, I guess?
```

Which is the return values for the Fruit base class.  The line `forEach(Fruit item in toBlend)` explicitly tells the interpreter to treat the `item` as a Fruit instance, so of the two available methods (the base or super class implementation), the Fruit base class one is selected.

C# 4.0 introduced a new keyword, _dynamic_ to allow variables like `item` to be dynamically typed at runtime.  Hence, changing the loop to this:

```csharp
forEach(dynamic item in toBlend) {
  Console.WriteLine(item.Blend());
}
```

Will give us the first set of results we discussed.

## Method Overriding
Of course, part of the issue in the above example is that we actually have _two_ implementations for Blend available to each fruit.  If we wanted all Bananas to use the Banana's Blend method, even when the banana was being treated as a Fruit, we need to _override_ the base method instead of creating a new one that hides it (in fact, in Visual Studio we should get a warning that our new method hides the base implementation, and be prompted to add the _new_ keyword if that was our intent).

To override a base class method, we first must mark it as _abstract_ or _virtual_.  The first keyword, _abstract_, indicates that the method _does not have an implementation_ (a body).  The second, _virtual_, indicates that the base class _does_ provide an implementation.  We should use abstract when each derived class will define its own implementation, and virtual when some derived classes will want to use a common base implementation.

In our Fruit, since we're providing a unique implementation in each derived class, the _abstract_ keyword is more appropriate:

```csharp
/// <summary>
/// A base class representing fruit
/// </summary>
public abstract class Fruit : IBlendable
{
    /// <summary>
    /// Blends the fruit
    /// </summary>
    /// <returns>The result of blending</returns>
    public abstract string Blend();
}
```   

As you can see above, the `Blend()` method does not have a body, only the method signature.

Also, note that if we use an abstract method in a class, the class itself must _also_ be declared abstract.  The reason should be clear - an abstract method cannot be called, so we should not create an object that only has the abstract method.  The virtual keyword can be used in both abstract and regular classes.

Now we can override the Blend() method in Banana class:

```csharp
/// <summary>
/// A class representing a bananna
/// </summary>
public class Banana : Fruit
{
    /// <summary>
    /// Blends the banana
    /// </summary>
    /// <returns>The result of blending the banana</returns>
    public override string Blend()
    {
        return "yellow mush";
    }
}
```

Now, even if we go back to our non-dynamic loop that treats our Fruit as Fruit instances, we'll get the result of the banana's Blend() method.

We can override any method marked abstract, virtual, or override (this last will only occur in a derived class whose base class is also derived, as it is overriding an already-overridden method).

## Sealed Methods
We can also apply the sealed keyword to overridden methods, which prevents them from being overridden further.  Let's apply this to the Strawberry class:

```csharp
/// <summary>
/// A class representing a Strawberry
/// </summary>
public class Strawberry : Fruit
{
    /// <summary>
    /// Blends the strawberry
    /// </summary>
    /// <returns>The result of blending a strawberry</returns>
    public sealed override string Blend()
    {
        return "Gooey Red Sweetness";
    }
}
```

Now, any class inheriting from Strawberry will not be allowed to override the Blend() method.