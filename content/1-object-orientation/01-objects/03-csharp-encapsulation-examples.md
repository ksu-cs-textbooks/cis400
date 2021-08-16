---
title: "C# Encapsulation Examples"
pre: "3. "
weight: 3
date: 2018-08-24T10:53:26-05:00
---

Let's start by focusing on encapsulation's benefits to organizing our code by exploring some examples of encapsulation you may already be familiar with.

## Namespaces

The C# libraries are organized into discrete units called **_namespaces_**.  The primary purpose of this is to separate code units that potentially use the same name, which causes *name collisions* where the interpreter isn’t sure which of the possibilities you mean in your program.  This means you can use the same name to refer to two different things in your program, provided they are in different namespaces.

For example, there are two definitions for a Point Struct in the .NET core libraries: [System.Drawing.Point](https://docs.microsoft.com/en-us/dotnet/api/system.drawing.point) and [System.Windows.Point](https://docs.microsoft.com/en-us/dotnet/api/system.windows.point).  The two have a very different internal structures (the former uses integers and the latter doubles), and we would not want to mix them up.  If we needed to create an instance of both in our program, we would use their fully-quantified name to help the interpreter know which we mean:

```csharp
System.Drawing.Point pointA = new System.Drawing.Point(500, 500);
System.Windows.Point pointB = new System.Windows.Point(300.0, 200.0);
```

The [using directive](https://docs.microsoft.com/en-us/dotnet/csharp/language-reference/keywords/using-directive) allows you reference the type without quantification, i.e.:

```csharp
using System.Drawing;
Point pointC = new Point(400, 400);
```

You can also create an *alias* with the using directive, providing an alternative (and usually abbreviated) name for the type:

```csharp
using WinPoint = System.Windows.Point;
WinPoint pointD = new WinPoint(100.0, 100.0);
```

We can also declare our own namespaces, allowing us to use namespaces to organize our own code just as Microsoft has done with its .NET libraries.

Encapsulating code within a namespace helps ensure that the types defined within are only accessible with a fully qualified name, or when the using directive is employed.  In either case, the intended type is clear, and knowing the namespace can help other programmers find the type’s definition.

## Structs

In the discussion of namespaces, we used a [struct](https://docs.microsoft.com/en-us/dotnet/csharp/language-reference/keywords/struct).  A C# struct is what computer scientists refer to as a *[compound type](https://en.wikipedia.org/wiki/Composite_data_type)*, a type *composed* from other types.  This too, is a form of encapsulation, as it allows us to collect several values into a single data structure.  Consider the concept of a vector from mathematics - if we wanted to store three-dimensional vectors in a program, we could do so in several ways.  Perhaps the easiest would be as an array:

```csharp
double[] vectorA = {3, 4, 5};
```

However, other than the variable name, there is no indication to other programmers that this is intended to be a three-element vector.  And, if we were to accept it in a function, say a dot product:

```csharp
public double DotProduct(double[] a, double[] b) {
    if(a.Length < 3 || b.Length < 3) throw new ArgumentException();
    return a[0] * b[0] + a[1] * b[1] + a[2] * b[2];
}
```

We would need to check that both arrays were of length three…  A struct provides a much cleaner option, by allowing us to define a type that is composed of exactly three doubles:

```csharp
/// <summary>
/// A 3-element vector 
/// </summary>
public struct Vector3 {
    public double x;
    public double y;
    public double z;

    public Vector3(double x, double y, double z) {
        this.x = x;
        this.y = y;
        this.z = z;
    }
}
```

Then, our DotProduct can take two arguments of the Vector3 struct:

```csharp
public double DotProduct(Vector3 a, Vector3 b) {
    return a.x * b.x + a.y * b.y + a.z * b.z;
}
```

There is no longer any concern about having the wrong number of elements in our vectors - it will always be three.  We also get the benefit of having unique names for these *fields* (in this case, x, y, and z).

Thus, a struct allows us to create *structure* to represent multiple values in one variable, encapsulating the related values into a single data structure.  Variables, and compound data types, represent the *state* of a program.  We’ll examine this concept in detail next.

## Modules
You might think that the kind of modules that Parnas was describing don't exist in C#, but they actually do - we just don't call them 'modules'.  Consider how you would raise a number by a power, say 10 to the 8th power:

```csharp
Math.Pow(10, 8);
```

The `Math` class in this example is actually used _just like a module!_  We can't see the underlying implementation of the `Pow()` method, it provides to us a well-defined interface (i.e. you call it with the symbol `Pow` and two doubles for parameters), and this method and other related math functions (`Sin()`, `Abs()`, `Floor()`, etc.) are encapsulated within the `Math` class.  

We can define our own module-like classes by using the `static` keyword, i.e. we could group our vector math functions into a static `VectorMath` class:

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
{{% notice note %}}
To duplicate the module behavior with C#, we must declare both the class and its methods `static`.
{{% /notice %}}

## Classes

But what most distinguishes C# is that it is an _object-oriented_ language, and as such, it's primary form of encapsulation is _classes_ and _objects_.  The key idea behind encapsulation in an object-oriented language is that we encapsulate both _state_ and _behavior_ in the class definition.  Let's explore that idea more deeply in the next section. 