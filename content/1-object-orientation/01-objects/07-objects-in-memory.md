---
title: "Objects in Memory"
pre: "7. "
weight: 7
date: 2018-08-24T10:53:26-05:00
---

We often talk about the **_class_** as a *blueprint* for an **_object_**.  This is because classes define what properties and methods an object should have, in the form of the class definition.  An object is created from this blueprint by invoking the class' **constructor**. Consider this class representing a planet:

```csharp
/// <summary>
/// A class representing a planet
// </summary>
public class Planet {

    /// <summary>
    /// The planet's mass in Earth Mass units (~5.9722 x 10^24kg)
    /// </summary>
    private double mass;
    public double Mass {
        get { return mass; }
    }

    /// <summary>
    /// The planet's radius in Earth Radius units (~6.738 x 10^6m)
    /// </summary>
    private double radius;
    public double Radius {
        get { return radius; }
    }

    /// <summary>
    /// Constructs a new planet
    /// <param name="mass">The planet's mass</param>
    /// <param name="radius>The planet's radius</param>
    public Planet(double mass, double radius) {
        this.mass = mass;
        this.radius = radius;
    }

}
```

It describes a planet as having a mass and a radius.  We can create a specific planet by invoking its constructor, i.e.:

```csharp
Planet earth = new Planet(1, 1);
```

In this example, **earth** is an *instance* of the class **Planet**.  We can create other instances, i.e.

```csharp
Planet mars = new Planet(0.107, 0.53);
```

We can even create a **Planet** instance to represent one of the exoplanets discovered by [NASA’s TESS](https://www.nasa.gov/tess-transiting-exoplanet-survey-satellite "Testing Extoplanet Survey Satelite"):

```csharp
Planet hd21749b = new Planet(23.20, 2.836);
```

Let’s think more deeply about the idea of a class as a blueprint.  A blueprint for what, exactly?  For one thing, it serves to describe the *state* of the object, and helps us label that state.  If we were to check our variable **mars’** radius, we do so based on the property **Radius** defined in our class:

```csharp
mars.Radius
```

But a class does more than just labeling the properties and fields and providing methods to mutate the state they contain.  It also specifies how *memory needs to be allocated* to hold those values as the program runs.

Looking at our Planet class again, we can see it contains two doubles.  We know in C#, that each double needs 32 bits to represent it.  Therefore, when the constructor is run, it must allocate 64 bits (two 32 bit chunks) to store these values as the program runs. 

State and memory are clearly related - the current state is what data is stored in memory.  It is possible to take that memory’s current state, write it to persistent storage (like the hard drive), and then read it back out at a later point in time and restore the program to exactly the state we left it with.  This is actually what Windows does when you put it into hibernation mode.

The process of writing out the state is known as *serialization*, and it’s a topic we’ll revisit later.

{{% notice info %}}
You might have wondered how the `static` modifier plays into objects.  Essentially, the `static` keyword indicates the field or method it modifies _exists in only one memory location_.  I.e. a static field references the _same_ memory location for all objects that possess it.  Hence, if we had a simple class like:

```csharp
public class Simple {
    public static int A;
    public int B;

    public Simple(int a, int b) {
        this.A = a;
        this.B = b;
    }
}
```

And created a couple of instances:

```csharp 
Simple first = new Simple(10, 12);
Simple second = new Simple(8, 5);
```

The value of `first.A` would be 8 - because `first.A` and `second.A` reference the _same_ memory location, and `second.A` was set _after_ `first.A`.  If we changed it again:

```csharp
first.A = 3;
```

Then both `first.A` and `second.A` would have the value 3, as they share the same memory.  `first.B` would still be 12, and `second.B` would be 5.

Another way to think about `static` is that it means the field or method we are modifying belongs to the _class_ and not the individual _object_.  Hence, each object _shares_ a `static` variable, because it belongs to their class.  Used on a method, `static` indicates that the method belongs to the class definition, not the object instance.  Hence, we must invoke it _from the class_, not an object instance: i.e. `Math.Pow()`, not `Math m = new Math(); m.Pow();`.  

Finally, when used with a class, `static` indicates we can't create objects from the class - the class definition exists on its own.  Hence, the `Math m = new Math();`  is actually an error, as the `Math` class is declared static.
{{% /notice %}}