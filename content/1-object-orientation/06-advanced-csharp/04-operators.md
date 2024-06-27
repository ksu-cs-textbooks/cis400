---
title: "Operator Overloading"
pre: "04. "
weight: 40
date: 2018-08-24T10:53:26-05:00
---

C# allows you to override most of the language's operators to provide class-specific functionality.  The user-defined casts [we discussed earlier]({{% ref "1-object-orientation/02-polymorphism/05-casting.md" %}}) are one example of this.

Perhaps the most obvious of these are the arithmetic operators, i.e. `+`, `-`, `\`, `*`.  Consider our `Vector3` class we defined earlier.  If we wanted to overload the `+` operator to allow for vector addition, we could add it to the class definition:

```csharp
/// <summary>
/// A class representing a 3-element vector
/// </summary>
public class Vector3 
{
    /// <summary>The x-coordinate</summary>
    public double X { get; set;}

    /// <summary>The y-coordinate</summary>
    public double Y { get; set;}

    /// <summary>The z-coordinate</summary>
    public double Z { get; set;}

    /// <summary>
    /// Constructs a new vector
    /// </summary>
    public Vector3(double x, double y, double z)
    {
        X = x;
        Y = y;
        Z = z;
    }

    /// Adds two vectors using vector addition
    public static Vector3 operator +(Vector3 v1, Vector3 v2)
    {
        return new Vector3(v1.X + v2.X, v1.Y + v2.Y, v1.Z + v2.Z);
    }
}
```

Note that we have to make the method `static`, and include the `operator` keyword, along with the symbol of the operation.  This vector addition we are performing here is also a _binary_ operation (meaning it takes two parameters).  We can also define _unary_ operations, like negation:

```csharp 
/// Negates a vector
public static Vector3 operator -(Vector3 v)
{
    return new Vector3(-v.X, -v.Y, -v.Z);
}
```

The full list of [overloadable operators is found in the C# documentation](https://docs.microsoft.com/en-us/dotnet/csharp/language-reference/operators/operator-overloading#overloadable-operators)