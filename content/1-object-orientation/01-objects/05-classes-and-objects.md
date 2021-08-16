---
title: "Classes and Objects"
pre: "5. "
weight: 5
date: 2018-08-24T10:53:26-05:00
---

The module-based encapsulation suggested by Parnas and his contemporaries grouped state and behavior together into smaller, self-contained units.  Alan Kay and his co-developers took this concept a step farther.  Alan Kay was heavily influenced by ideas from biology, and saw this encapsulation in similar terms to _cells_.  

![Typical Animal Cell]({{<static "images/1.1.5.1.png">}})

Biological cells are also encapsulated - the complex structures of the cell and the functions they perform are all within a cell wall.  This wall is only bridged in carefully-controlled ways, i.e. cellular pumps that move resources into the cell and waste out. While single-celled organisms do exist, far more complex forms of life are made possible by many similar cells working together.

This idea became embodied in object-orientation in the form of _classes_ and _objects_.  An object is like a specific cell.  You can create many, very similar objects that all function identically, but each have their own individual and different _state_.  The _class_ is therefore a definition of that type of object's structure and behavior.  It defines the shape of the object's state, and how that state can change.  But each individual _instance_ of the class (an object) has its own current state.

Let's re-write our `Vector3` struct as a class using this concept:

```csharp
public class Vector3 {

    public double X;
    public double Y;
    public double Z;

    public Vector3(double x, double y, double z) {
        X = x;
        Y = y;
        Z = z;
    }

    public double DotProduct(Vector3 other) {
        return X * other.X + Y * other.Y + Z * other.Z;
    }

    public void Scale(double scalar) {
        X *= scalar;
        Y *= scalar;
        Z *= scalar;
    }
}
```

Here we have defined:

1. The _structure_ of the object state - three doubles, `X`, `Y`, and `Z`
2. How the object is constructed - the `Vector3()` constructor that takes a value for the object's initial state
3. Instructions for how that object state can be changed, i.e. our `Scale()` method

We can create as many objects from this class definition as we might want:

```csharp
Vector3 one = new Vector3(1.0, 1.0, 1.0);
Vector3 up = new Vector3(0.0, 1.0, 0.0);
Vector3 a = new Vector3(5.4, -21.4, 3.11);
```

Conceptually, what we are doing is not that different from using a compound data type like a struct and a module of functions that work upon that struct.  But practically, it means _all the code for working with Vectors appears in one place_.  This arguably makes it much easier to find all the pertinent parts of working with vectors, and makes the resulting code better organized and easier to maintain and add features to.

Classes also provide additional benefits over structs in the form of _polymorphism_, which we'll discuss in [Chapter 2]({{< ref "01-objects/02-polymorphism" >}}).