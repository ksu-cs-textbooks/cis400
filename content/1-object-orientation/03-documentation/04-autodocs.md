---
title: "Autodocs"
pre: "4. "
weight: 4
date: 2018-08-24T10:53:26-05:00
---

One of the biggest innovations in documenting software was the development of autodocumentation tools. These were programs that would read source code files, and combine information parsed from the code itself and information contained in code comments to generate documentation in an easy-to-distribute form (often HTML).  One of the earliest examples of this approach came from the programming langauge Java, whose [API specification](https://docs.oracle.com/javase/7/docs/api/) was generated from the language source files using [JavaDoc](https://en.wikipedia.org/wiki/Javadoc).

This approach meant that the language of the documentation was embedded _within the source code itself_, making it far easier to update the documentation as the source code was refactored.  Then, every time a release of the software was built (in this case, the Java language), the documentation could be regenerated from the updated comments and source code.  This made it far more likely developer documentation would be kept up-to-date.

Microsoft adopted a similar strategy for the .NET langauges, known as XML comments.  This approach was based on embedding XML tags into comments above classes, methods, fields, properties, structs, enums, and other code objects.  These comments are set off with a triple forward slash (`///`) to indicate the intent of being used for autodoc generation.  Comments using double slashes (`//`) and slash-astrisk notation (`/* */`) are ignored in this autodoc scheme.

For example, to document an Enum, we would write:

```csharp
/// <summary>
/// An enumeration of fruits used in pies 
/// </summary>
public enum Fruit {
    Cherry,
    Apple,
    Blueberry,
    Peach
}
```

At a bare minimum, comments should include a `<summary>` element containing a description of the code structure being described.

Let's turn our attention to documenting a class:

```csharp 
public class Vector2 {

    public float X {get; set;}

    public float Y {get; set;}

    public Vector2(float x, float y) {
        X = x;
        Y = y;
    }

    public void Scale(float scalar) {
        X *= scalar;
        Y *= scalar;
    }

    public float DotProduct(Vector2 other) {
        return this.X * other.X + this.Y * other.Y;
    }

    public float Normalize() {
        float magnitude = Math.Sqrt(Math.Pow(this.X, 2), Math.Pow(this.Y, 2));
        if(magnitude == 0) throw new DivideByZeroException();
        X /= magnitude;
        Y /= magnitude;
    }
}
```

We would want to add a `<summary>` element just above the class declaration, i.e.:

```csharp 
/// <summary>
/// A class representing a two-element vector composed of floats 
/// </summary>
```

Properties should be described using the `<value>` element, i.e.:

```csharp
/// <value>
/// The x component of the vector 
/// </value>
```

And methods should use `<summary>`, plus `<param>` elements to describe parameters.  It has an attribute of `name` that should be set to match the parameter it describes:

```csharp 
/// <summary>
/// Constructs a new two-element vector 
/// </summary>
/// <param name="x">The X component of the new vector</param>
/// <param name="y">The Y component of the new vector</param>
```

The `<paramref>` can be used to reference a parameter in the `<summary>`:

```csharp 
/// <summary>
/// Scales the Vector2 by the provided <paramref name="scalar"/> 
/// </summary>
/// <param name="scalar">The value to scale the vector by</param>
```

If a method returns a value, this should be indicated with the `<returns>` element:

```csharp
/// <summary>
/// Computes the dot product of this and an <paramref name="other"> vector
/// </summary>
/// <param name="other">The vector to compute a dot product with</param>
/// <returns>The dot product</returns>
```

And, if a method might throw an exception, this should be also indicated with the `<exception>` element, which uses the `cref` attribute to indicate the specific exception:

```csharp
/// <summary>
/// Normalizes the vector
/// </summary>
/// <remarks>
/// This changes the length of the vector to one unit.  The direction remains unchanged 
/// </remarks>
/// <exception cref="System.DivideByZeroException">
/// Thrown when the length of the vector is 0.
/// </exception>
```

Note too, the use of the `<remarks>` element in the above example to add supplemental information.  The `<example>` element can also be used to provide examples of using the class, method, or other code construct.  There are more elements available, like `<see>` and `<seealso>` that generate links to other documentation, `<para>`, `<code>`, `<c>`, and `<list>` which are used to format text, and so on.  See [the official documentation](https://docs.microsoft.com/en-us/dotnet/csharp/codedoc) for a complete list and discussion.

Thus, our completely documented class would be:

```csharp
/// <summary>
/// A class representing a two-element vector composed of floats 
/// </summary>
public class Vector2 {

    /// <value>
    /// The x component of the vector 
    /// </value>
    public float X {get; set;}

    /// <value>
    /// The y component of the vector 
    /// </value>
    public float Y {get; set;}

    /// <summary>
    /// Constructs a new two-element vector 
    /// </summary>
    /// <param name="x">The X component of the new vector</param>
    /// <param name="y">The Y component of the new vector</param>
    public Vector2(float x, float y) {
        X = x;
        Y = y;
    }

    /// <summary>
    /// Scales the Vector2 by the provided <paramref name="scalar"/> 
    /// </summary>
    /// <param name="scalar">The value to scale the vector by</param>
    public void Scale(float scalar) {
        X *= scalar;
        Y *= scalar;
    }

    /// <summary>
    /// Computes the dot product of this and an <paramref name="other"> vector
    /// </summary>
    /// <param name="other">The vector to compute a dot product with</param>
    /// <returns>The dot product</returns>
    public float DotProduct(Vector2 other) {
        return this.X * other.X + this.Y * other.Y;
    }

    /// <summary>
    /// Normalizes the vector
    /// </summary>
    /// <remarks>
    /// This changes the length of the vector to one unit.  The direction remains unchanged 
    /// </remarks>
    /// <exception cref="System.DivideByZeroException">
    /// Thrown when the length of the vector is 0.
    /// </exception>
    public float Normalize() {
        float magnitude = Math.Sqrt(Math.Pow(this.X, 2), Math.Pow(this.Y, 2));
        if(magnitude == 0) throw new DivideByZeroException();
        X /= magnitude;
        Y /= magnitude;
    }
}
```

With the exception of the `<remarks>`, the XML documentation elements used in the above code should be considered the _minimum_ for best practices.  That is, every `Class`, `Struct`, and `Enum` should have a `<summary>`. Every property should have a `<value>`. And every method should have a `<summary>`, a `<param>` for every parameter, a `<returns>` if it returns a value (this can be omitted for `void`) and an `<exception>` for every exception it might throw.

There are multiple autodoc programs that generate documentation from XML comments embedded in C# code, including open-source [Sandcastle Help File Builder](https://github.com/EWSoftware/SHFB) and the simple [Docu](https://github.com/jagregory/docu), as well as multiple commerical products.

However, the perhaps more important consumer of XML comments is _Visual Studio_, which uses these comments to power its Intellisense features, displaying text from the comments as tooltips as you edit code.  This intellisense data is automatically built into DLLs built from Visual Studio, making it available in projects that utilize compiled DLLs as well.