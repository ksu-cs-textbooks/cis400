---
title: "The static Keyword"
pre: "10. "
weight: 10
date: 2018-08-24T10:53:26-05:00
---

Before we move on, let's revisit one more keyword that causes a lot of confusion for new programmers, `static`.  We mentioned it briefly when talking about encapsulation and modules, and said we could mimic a module in C# with a static class.  We offered this example:

```csharp
/// <summary>
/// A library of vector math functions
/// </summary>
public static class VectorMath() {
    
    /// <summary>
    /// Computes the dot product of two vectors 
    /// </summary>
    public static double DotProduct(Vector3 a, Vector3 b) {
        return a.x * b.x + a.y * b.y + a.z * b.z;
    }

    /// <summary>
    /// Computes the magnitude of a vector
    /// </summary>
    public static double Magnitude(Vector3 a) {
        return Math.Sqrt(Math.Pow(a.x, 2) + Math.Pow(a.y, 2) + Math.Pow(a.z, 2));
    }

}
```

You've probably worked with the C# `Math` class before, which is declared the same way - as a static class containing static methods.  For example, to compute 8 cubed, you might have used:

```csharp
Math.Pow(8, 3);
```

Notice how we didn't construct an object from the `Math` class?  In C# we *cannot construct static classes* - they simply exist as a container for static fields and methods.  If you're thinking that doesn't sound very object-oriented, you're absolutely right.  The `static` keyword allows for some very non-object-oriented behavior more in line with  imperative languages like C.  

It's important to remember that C# is not a _pure object-oriented language_, instead it is a _production_ language (one meant to be used to create real-world applications).  The creators of C# (as with most production languages) are not above breaking paradigm rules to make code easier to write and read.  In fact, C 
