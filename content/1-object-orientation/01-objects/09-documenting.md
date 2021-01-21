---
title: "Documenting Objects"
pre: "9. "
weight: 9
date: 2018-08-24T10:53:26-05:00
hidden: true
---
While often overlooked, *documenting* is a critically important part of writing software.  There are two purposes to documenting:

1. To explain to end users how the software should be used, and
2. To explain to developers how the software works.

For the moment, we'll focus on the second use for documentation - documentation intended for developers.  In the early days of programming, this would often be done in a separate file or files from the source code, due to memory limitations (Remember the EPIC documentation?).  But today we often employ in-code documentation, along with powerful tools that make it even more useful.

## .NET XML Documentation
Consider the .NET XML Documentation - a collection of XML tags and commenting styles that Visual Studio will find and use for Intellisense (the tooltips that pop up as you code in Visual Studio, explaining what a class is and how it is to be used).  

Let's revisit our **Vector3** class and employ this documentation approach:

```csharp
/// <summary>
/// A class representing a 3-element vector using doubles.
/// </summary>
public class Vector3 {

  /// <summary>
  /// Gets or sets the X property
  /// </summary>
  public double X {get; set;};

  /// <summary>
  /// Gets or sets the Y property
  /// </summary>
  public double Y {get; set;};

  /// <summary>
  /// Gets or sets the Z property
  /// </summary>
  public double Z {get; set;};

  /// <summary>
  /// Constructs a new instance of Vector3 with
  /// X, Y, and Z properties set to 0.
  /// </summary>
  public Vector3() {
    this.X = 0;
    this.Y = 0;
    this.Z = 0;
  }

  /// <summary>
  /// Constructs a new instance of Vector3 with
  /// the supplied values for X, Y, and Z.
  /// <param name="X">A double precision number for the x component of the vector.</param>
  /// <param name="Y">A double precision number for the y component of the vector.</param>
  /// <param name="Z">A double precision number for the z component of the vector.</param>
  /// </summary>
  public Vector3(double x, double y, double z) {
    this.X = x;
    this.Y = y;
    this.Z = z;
  }
}
```

Using the .NET XML documentation format makes your documentation consistent with that of other developers, and therefore easier to read.  However, this is not its only benefit.  As discussed earlier, it is used to supply Intellisense details in Visual Studio.

We can also use the XML file to autogenerate html documentation using tools like [DocFX](https://dotnet.github.io/docfx/).