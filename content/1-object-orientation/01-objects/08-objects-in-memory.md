---
title: "Objects in Memory"
pre: "8. "
weight: 8
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
    public double Mass 
    {
        get { return mass; }
    }

    /// <summary>
    /// The planet's radius in Earth Radius units (~6.738 x 10^6m)
    /// </summary>
    private double radius;
    public double Radius 
    {
        get { return radius; }
    }

    /// <summary>
    /// Constructs a new planet
    /// <param name="mass">The planet's mass</param>
    /// <param name="radius">The planet's radius</param>
    public Planet(double mass, double radius) 
    {
        this.mass = mass;
        this.radius = radius;
    }

}
```

It describes a planet as having a mass and a radius. But a class does more than just labeling the properties and fields and providing methods to mutate the state they contain.  It also specifies how *memory needs to be allocated* to hold those values as the program runs. In memory, we would need to hold _both_ the mass and radius values.  These are stored side-by-side, as a series of bits that are on or off.  You probably remember from CIS 115 that a `double` is stored as a **sign bit**, **mantissa** and **exponent**.  This is also the case here - a C# `double` requires 64 bits to hold these three parts, and we can represent it with a memory diagram:

![The Planet memory diagram](/images/1.1.7.1.png)

We can create a specific planet by invoking its constructor, i.e.:

```csharp
new Planet(1, 1);
```

This *allocates* (sets aside) the memory to hold the planet, and populates the mass and radius with the supplied values.  We can represent this with a memory diagram:

![The constructed planet's memory diagram](/images/1.1.7.2.png)

With memory diagrams, we typically write the values of variables in their human-readable form.  Technically the values we are storing are in binary, and would each be `0000000000010000000000000000000000000000000000000000000000000001`, so our overall object would be the bits: `00000000000100000000000000000000000000000000000000000000000000010000000000010000000000000000000000000000000000000000000000000001`.

And this is _exactly_ how it is stored in memory!  The nice boxes we drew in our memory diagram are a tool for us to reason about the memory, **not** something that actually exists in memory.  Instead, the compiler determines the starting point for each `double` by looking at the structure defined in our `class`, i.e. the first field defined is `mass`, so it will be the first 64 bits of the object in memory.  The second field is `radius`, so it starts 65 bits into the object and consists of the next (and final) 64 bits.

If we assign the created `Planet` object to a variable, we allocate memory for that variable:

```csharp
Planet earth = new Planet(1, 1);
```

Unlike our `double` and other primitive values, this allocated memory holds a _reference_ (an starting address of the memory where the object was allocated).  We indicate this with a box and arrow connecting the variable and object in our memory diagram:

![The memory diagram for the earth variable](/images/1.1.7.3.png)

A reference is either 32 bits (on a computer with a 32-bit CPU) or 64 bits (on a computer with a 64-bit CPU), and essentially is an offset from the memory address $0$ indicating where the object will be located in memory (in the computer's RAM).  You'll see this in far more detail in **CIS 450 - Computer Architecture and Operations**, but the important idea for now is the variable stores _where the object is located in memory_ **not** _the object's data itself_.  This is also why if we define a class variable but don't assign it an object, i.e.:

```csharp
Planet mars;
```

![The memory diagram for the mars variable](/images/1.1.7.4.png)

The value of this variable will be `null`.  It's because it doesn't point anywhere!

Returning to our Earth example, `earth` is an *instance* of the class `Planet`.  We can create other instances, i.e.

```csharp
Planet mars = new Planet(0.107, 0.53);
```

![The memory diagram for the initialized mars variable](/images/1.1.7.5.png)

We can even create a **Planet** instance to represent one of the exoplanets discovered by [NASA’s TESS](https://www.nasa.gov/tess-transiting-exoplanet-survey-satellite "Testing Exoplanet Survey Satellite"):

```csharp
Planet hd21749b = new Planet(23.20, 2.836);
```

![The memory diagram for three planets](/images/1.1.7.6.png)

Let’s think more deeply about the idea of a class as a blueprint.  A blueprint for what, exactly?  For one thing, it serves to describe the *state* of the object, and helps us label that state.  If we were to check our variable **mars’** radius, we do so based on the property **Radius** defined in our class:

```csharp
mars.Radius
```

This would follow the `mars` reference to the `Planet` object it represents, and access the second group of 64 bits stored there, interpreting them as a `double` (basically it adds 64 to the `reference` address and then reads the next 64 bits)

{{% notice info %}}
Incidentally, this is why we start counting at 0 in computer science.  The `mass` bits start at the start of our `Planet` object, referenced by `mars` i.e. if `mars` holds the reference address $5234$, then the bits of `mass` _also_ begin at $5234$, or $5234+0$.  And the `radius` bits start at $5234 + 64$.
{{% /notice %}}

State and memory are clearly related - the current state is what data is stored in memory.  It is possible to take that memory’s current state, write it to persistent storage (like the hard drive), and then read it back out at a later point in time and restore the program to exactly the state we left it with.  This is actually what Windows does when you put it into hibernation mode.

The process of writing out the state is known as *serialization*, and it’s a topic we’ll revisit later.

{{% notice info %}}
#### The Static Modifier and Memory
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