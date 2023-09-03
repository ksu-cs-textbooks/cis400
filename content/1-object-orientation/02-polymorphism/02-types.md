---
title: "Types"
pre: "2. "
weight: 2
date: 2018-08-24T10:53:26-05:00
---
Before we can discuss polymorphism in detail, we must first understand the concept of _types_.  In computer science, a _type_ is a way of categorizing a variable by its storage strategy, i.e., how it is represented in the computer's memory.

You've already used types extensively in your programming up to this point.  Consider the declaration:

```csharp
int number = 5;
```

The variable **number** is declared to have the type **int**.  This lets the .NET interpreter know that the value of number will be stored using a specific scheme.  This scheme will use 32 bits and contain the number in <a href="https://en.wikipedia.org/wiki/Two%27s_complement" target="_blank">Two's compliment binary form</a>.  This form, and the number of bytes, allows us to represent numbers in the range -2,147,483,648 to 2,147,483,647.  If we need to store larger values, we might instead use a *long* which uses 64 bits of storage.  Or, if we only need positive numbers, we might instead use a *uint*, which uses 32 bits and stores the number in regular [base 2 (binary) form](https://en.wikipedia.org/wiki/Binary_number).

This is why languages like C# provide multiple [integral](https://docs.microsoft.com/en-us/dotnet/csharp/language-reference/builtin-types/integral-numeric-types) and [float](https://docs.microsoft.com/en-us/dotnet/csharp/language-reference/builtin-types/floating-point-numeric-types) types.  Each provides a different representation, representing a tradeoff between memory required to store the variable and the range or precision that variable can represent.

In addition to integral and float types, most programming languages include types for booleans, characters, arrays, and often strings.  C# is no exception - you can read about its built-in value types [in the documentation](https://docs.microsoft.com/en-us/dotnet/csharp/language-reference/keywords/value-types).

## User-Defined Types
In addition to built-in types, most programming languages support _user-defined types_, that is, new types defined by the programmer.  For example, if we were to define a C# enum:

```csharp
public enum Grade {
  A,
  B,
  C,
  D,
  F
}
```

Defines the type _Grade_.  We can then create variables with that type:

```csharp
Grade courseGrade = Grade.A;
```

Similarly, *structs* provide a way of creating user-defined compound data types.

## Classes are Types
In an object-oriented programming language, a Class also _defines a new type_.  As we discussed in the previous chapter, the Class defines the structure for the _state_ (what is represented) and _memory_ (how it is represented) for objects implementing that type.  Consider the C# class Student:

```csharp
public class Student {
  // backing variables
  private float creditPoints = 0;
  private uint creditHours = 0;

  /// <summary>
  /// Gets and sets first name.
  /// </summary>
  public string First { get; set; }

  /// <summary>
  /// Gets and sets last name.
  /// </summary>
  public string Last { get; set; }

  /// <summary>
  /// Gets the student's GPA
  /// </summary>
  public float GPA {
    get {
      return creditPoints / creditHours;
    }
  }

  /// <summary>
  /// Adds a final grade for a course to the
  // student's GPA.
  /// </summary>
  /// <param name="grade">The student's final letter grade in the course</param>
  /// <param name="hours">The course's credit hours</param>
  public void AddCourseGrade(Grade grade, uint hours) {
    this.creditHours += hours;
    switch(grade) {
      case Grade.A:
        this.creditPoints += 4.0 * hours;
        break;
      case Grade.B:
        this.creditPoints += 3.0 * hours;
        break;
      case Grade.C:
        this.creditPoints += 2.0 * hours;
        break;
      case Grade.D:
        this.creditPoints += 1.0 * hours;
        break;
      case Grade.F:
        this.creditPoints += 0.0 * hours;
        break;
    }
  }
}
```

If we want to create a new student, we would create an instance of the class **Student** which is an object of _type_ **Student**:

```csharp
Student willie = new Student("Willie", "Wildcat");
```

Hence, the _type_ of an object is _the class it is an instance of_.  This is a staple across all object-oriented languages.

## Static vs. Dynamic Typed Languages
A final note on types.  You may hear languages being referred to as _statically_ or _dynamically_ typed.  A _statically_ typed language is one where the type is set by the code itself, either _explicitly_:

```csharp
int foo = 5;
```

or _implicitly_ (where the complier determines the type based on the assigned value):

```csharp
var bar = 6;
```

In a statically typed language, a variable _cannot_ be assigned a value of a different type, i.e.:

```csharp
foo = 8.3;
```

Will fail with an error, as a float is a different type than an int.  Similarly, because *bar* has an implied type of int, this code will fail:

```csharp
bar = 4.3;
```

However, we can _cast_ the value to a new type (changing how it is represented), i.e.:

```csharp
foo = (int)8.9;
```

For this to work, the language must know how to perform the cast. The cast may also lose some information - in the above example, the resulting value of **foo** is *8* (the fractional part is discarded).

In contrast, in a _dynamically_ typed language the type of the variable changes when a value of a different type is assigned to it.  For example, in JavaScript, this expression is legal:

```javascript
var a = 5;
a = "foo";
```

and the type of **a** changes from int (at the first assignment) to string (at the second assignment).

C#, Java, C, C++, and Kotlin are all _statically typed languages_, while Python, JavaScript, and Ruby are _dynamically typed languages_.   