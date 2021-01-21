---
title: "Casting"
pre: "5. "
weight: 5
date: 2018-08-24T10:53:26-05:00
---
You have probably used casting to convert numeric values from one type to another, i.e.:

```csharp 
int a = 5;
double b = a;
```

And 

```csharp 
int c = (int)b;
```

What you are actually doing when you cast is _transforming a value from one type to another_.  In the first case, you are taking the value of `a` (5), and converting it to the equivalent double (5.0).  If you consider the internal representation of an integer (a 2's complement binary number) to a double (an [IEEE 754 standard](https://en.wikipedia.org/wiki/IEEE_754) representation), we are actually applying a conversion algorithm to the binary representations.  

We call the first operation an _implicit cast_, as we don't expressly tell the compiler to perform the cast. In contrast, the second assignment is an _explicit cast_, as we signify the cast by wrapping the _type_ we are casting to in parenthesis before the variable we are casting.  We _have_ to perform an explicit cast in the second case, as the conversion has the possibility of losing some precision (i.e. if we cast 7.2 to an integer, it would be truncated to 7).  In any case where the conversion may lose precision or possibly throw an error, an _explicit_ cast is required.

## Custom Casting Conversions
We can actually [extend the C# language to add additional conversions](https://docs.microsoft.com/en-us/dotnet/csharp/language-reference/operators/user-defined-conversion-operators) to provide additional casting operations.  Consider if we had `Rectangle` and `Square` structs:

```csharp
/// <summary>A struct representing a rectangle</summary>
public struct Rectangle {
    
    /// <summary>The length of the short side of the rectangle</summary>
    public int ShortSideLength;
    
    /// <summary>The length of the long side of the rectangle</summary>
    public int LongSideLength;
    
    /// <summary>Constructs a new rectangle</summary>
    /// <param name="shortSideLength">The length of the shorter sides of the rectangle</param>
    /// <param name="longSideLength">The length of the longer sides of the rectangle</param>
    public Rectangle(int shortSideLength, int longSideLength){
        ShortSideLength = shortSideLength;
        LongSideLength = longSideLength;
    }
}

/// <summary>A struct representing a square</summary>
public struct Square {

    /// <summary> The length of the square's sides</summary>
    public int SideLength;

    /// <summary>Constructs a new square</summary>
    /// <param name="sideLength">The length of the square's sides</param>
    public Square(int sideLength){
        SideLength = sideLength;
    }
}
```

Since we know that a square is a special case of a rectangle (where all sides are the same length), we might define an implicit casting operator to convert it into a `Rectangle` (this would be placed inside the `Square` struct definition):

```csharp
    /// <summary>Casts the <paramref name="square"/> into a Rectangle</summary>
    /// <param name="square">The square to cast</param>
    public static implicit operator Rectangle(Square square) 
    {
        return new Rectangle(square.SideLength, square.SideLength);
    }
```

Similarly, we might create a cast operator to convert a rectangle to a square.  But as this can _only_ happen when the sides of the rectangle are all the same size, it would need to be an _explicit_ cast operator , and throw an exception when that condition is not met (this method is placed in the `Rectangle` struct definition):

```csharp
    /// <summary>Casts the <paramref name="rectangle"/> into a Square</summary>
    /// <param name="rectangle">The rectangle to cast</param>
    /// <exception cref="System.InvalidCastOperation">The rectangle sides must be equal to cast to a square</exception>
    public static explicit operator Square(Rectangle rectangle){
        if(rectangle.LongSideLength != rectangle.ShortSideLength) throw new InvalidCastException("The sides of a square must be of equal lengths");
        return new Square(rectangle.LongSideLength);
    }
```

## Casting and Inheritance
Casting becomes a bit more involved when we consider inheritance.  As you saw in the previous discussion of inheritance, we can treat derived classes _as the base class_, i.e. the code:

```csharp 
Student sam = new UndergraduateStudent("Sam", "Malone");
```

Is actually _implicitly casting_ the undergraduate student "Sam Malone" into a student class.  Because an `UndergraduateStudent` is a `Student`, this cast can be _implicit_.  Moreover, we don't need to define a casting operator - we can always implicitly cast a class to one of its ancestor classes, it's built into the inheritance mechanism of C#.

Going the other way requires an _explicit cast_ as there is a chance that the `Student` we are casting _isn't_ an undergraduate, i.e.:

```csharp
UndergraduateStudent u = (UndergraduateStudent)sam;
```

If we tried to cast `sam` into a graduate student:

```csharp
GraduateStudent g = (GraduateStudent)sam;
```

The program would throw an `InvalidCastException` when run.

## Casting and Interfaces
Casting interacts similarly with interfaces.  A class can be implicitly cast to an interface it implements:

```csharp
IJumpable roo = new Kangaroo();
```

But must be _explicitly_ cast to convert it back into the class that implemented it:

```csharp 
Kangaroo k = (Kangaroo)roo;
```

And if that cast is illegal, we'll throw an `InvalidCastException`:

```csharp
Car c = (Car)roo;
```

## The `as` and `is` Operators
When we are casting reference and nullable types, we have a few additional casting options - the `as` and `is` casting operators.  

The `as` operator performs the cast, or evaluates to `null` if the cast fails (instead of throwing an `InvalidCastException`), i.e.:

```csharp
UndergraduateStudent u = sam as UndergraduateStudent; // evaluates to an UndergraduateStudent 
GraduateStudent g = sam as GraduateStudent; // evaluates to null
Kangaroo k = roo as Kangaroo; // evaluates to a Kangaroo 
Car c = roo as Kangaroo; // evaluates to null
```

The `is` operator evaluates to a boolean, `true` if the cast is possible, `false` if not:

```csharp
sam is UndergraduateStudent; // evaluates to true
sam is GraduateStudent; // evaluates to false
roo is Kangaroo; // evaluates to true
roo is Car; // evaluates to false
```

The `is` operator is commonly used to determine if a cast will succeed before performing it, i.e.:

```csharp
if(sam is UndergraduateStudent) 
{
    Undergraduate samAsUGrad = sam as UndergraduateStudent;
    // TODO: Do something undergraduat-ey with samAsUGrad
}
```

This pattern was so commonly employed, it led to the addition of the [is type pattern matching operator](https://docs.microsoft.com/en-us/dotnet/csharp/pattern-matching#the-is-type-pattern-expression) in C# version 7.0:

```csharp 
if(sam is UndergraduateStudent samAsUGrad) 
{
    // TODO: Do something undergraduat-ey with samAsUGrad
}
```

If the cast is possible, it is performed and the result assigned to the provided variable name (in this case, `samAsUGrad`).  This is another example of [syntactic sugar](https://en.wikipedia.org/wiki/Syntactic_sugar).