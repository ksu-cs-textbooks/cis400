---
title: "Pattern Matching"
pre: "08. "
weight: 80
date: 2018-08-24T10:53:26-05:00
---

Pattern matching is another idea common to functional languages that has gradually crept into C#.  Pattern matching refers to extracting information from structured data by matching the shape of that data.

We've already seen the pattern-matching is operator [in our discussion of casting]({{<ref "1-object-orientation/02-polymorphism/05-casting.md">}}).  This allows us to extract the _cast_ version of a variable and assign it to a new one:

```csharp
if(oldVariable is SpecificType newVariable)
{
    // within this block newVariable is (SpecificType)oldVariable
}
```

The `switch` statement is also an example of pattern matching.  The traditional version only matched constant values, i.e.:

```csharp
switch(choice)
{
    case "1":
        // Do something
        break;
    case "2":
        // Do something else
        break;
    case "3":
        // Do a third thing
        break;
    default:
        // Do a default action
        break;
}
```

However, in C# version 7.0, this has been expanded to also match patterns.  For example, given a `Square`, `Circle`, and `Rectangle`  class that all extend a `Shape` class, we can write a method to find the area using a switch:

```csharp
public static double ComputeCircumference(Shape shape)
{
    switch(shape)
    {
        case Square s:
            return 4 * s.Side;
        case Circle c:
            return c.Radius * 2 * Math.PI;
        case Rectangle r:
            return 2 * r.Length + 2 * r.Height;
        default:
            throw new ArgumentException(
                message: "shape is not a recognized shape",
                paramName: nameof(shape)
            );
    }
}
```

Note that here we match the type of the `shape` _and_ cast it to that type making it available in the provided variable, i.e. `case Square s:` matches if `shape` can be cast to a `Square`, and `s` is the result of that cast operation.

This is further expanded upon with the use of `when` clauses, i.e. we could add a special case for a circle or square with a circumference of 0:

```csharp
public static double ComputeCircumference(Shape shape)
{
    switch(shape)
    {
        case Square s when s.Side == 0:
        case Circle c when c.Radius == 0:
            return 0;
        case Square s:
            return 4 * s.Side;
        case Circle c:
            return c.Radius * 2 * Math.PI;
        case Rectangle r:
            return 2 * r.Length + 2 * r.Height;
        default:
            throw new ArgumentException(
                message: "shape is not a recognized shape",
                paramName: nameof(shape)
            );
    }
}
```

The `when` applies conditions to the match that only allow a match when the corresponding condition is true.

{{% notice info %}}
C# 8.0, which is currently in preview, has [expanded greatly upon pattern matching](https://docs.microsoft.com/en-us/archive/msdn-magazine/2019/may/csharp-8-0-pattern-matching-in-csharp-8-0), adding exciting new features, such as the switch expression, tuples, and deconstruction operator.
{{% /notice %}}
