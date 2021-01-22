---
title: "The static Keyword"
pre: "3. "
weight: 30
date: 2018-08-24T10:53:26-05:00
---

To start, let's revisit one more keyword that causes a lot of confusion for new programmers, `static`.  We mentioned it briefly when talking about encapsulation and modules, and said we could mimic a module in C# with a static class.  We offered this example:

```csharp
/// <summary>
/// A library of vector math functions
/// </summary>
public static class VectorMath
{
    
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

Notice how we didn't construct an object from the `Math` class?  In C# we *cannot construct static classes* - they simply exist as a container for static fields and methods.  If you're thinking that doesn't sound very object-oriented, you're absolutely right.  The `static` keyword allows for some very non-object-oriented behavior more in line with imperative languages like C.  Bringing the idea of `static` classes into C# let programmers with an imperative background use similar techniques to what they were used to, which is why `static` classes have been a part of C# from the beginning.

### Static Methods in Regular Classes

You can also create `static` methods within a non-static class.  For example, we could refactor our `Vector3` class to add a static `DotProduct()` within it:

```csharp
public struct Vector3 {
    public double X {get; set;}
    public double Y {get; set;}
    public double Z {get; set;}

    /// <summary> 
    /// Creates a new Vector3 object
    /// </summary>
    public Vector3(double x, double y, double z) {
        this.X = x;
        this.Y = y;
        this.Z = z;
    }

    /// <summary>
    /// Computes the dot product of this vector and another one 
    /// </summary>
    /// <param name="other">The other vector</param>
    public double DotProduct(Vector3 other) {
        return this.X * other.X + this.Y * other.Y + this.Z * other.Z;
    }

    /// <summary>
    /// Computes the dot product of two vectors 
    /// </summary>
    /// <param name="a">The first vector<param>
    /// <param name="b">The second vector</param>
    public static DotProduct(Vector3 a, Vector3 b)
    {
        return a.DotProduct(b);
    }
}
```

This method would be invoked like any other `static` method, i.e.:

```csharp
Vector3 a = new Vector3(1,3,4);
Vector3 b = new Vector3(4,3,1);
Vector3.DotProduct(a, b);
```

You can see we're doing the same thing as the instance method `DotProduct(Vector3 other)`, but in a library-like way.

### Static Fields Within Regular Classes

We can also declare fields as `static`, which has a meaning slightly different than static methods.  Specifically, the field is _shared_ amongst all instances of the class.  Consider the following class:

```csharp
public class Tribble
{
    private static int count = 1;

    public Tribble() 
    {
        count *= 2;
    }

    public int TotalTribbles
    {
        get 
        {
            return count;
        }
    }
}
```

If we create a single Tribble, and then ask how many total Tribbles there are:

```csharp
var t = new Tribble();
t.TotalTribbles; // expect this to be 2
```

We would expect the value to be 2, as `count` was initialized to `1` and then multiplied by `2` in the Tribble constructor.  But if we construct _two_ Tribbles:

```csharp 
var t = new Tribble();
var u = new Tribble();
t.TotalTribbles; // will be 4
u.TotalTribbles; // will be 4
```

This is because _all instances of Tribble share the `count` field_.  So it is initialized to `1`, multiplied by `2` when tribble `a` was constructed, and multiplied by `2` again when tribble `b` was constructed.  Hence $1 * 2 * 2 = 4$.  Every additional Tribble we construct will double the total population (which is the trouble with Tribbles).

## Why Call This Static?
Which brings us to a point of confusion for most students, _why call this static_?  After all, doesn't the word _static_ indicate _unchanging_?

The answer lies in how memory is allocated in a program.  Sometimes we know in advance how much memory we need to hold a variable, i.e. a `double` in C# requires 64 bits of memory.  We call these types _value types_ in C#, as the value is stored directly in memory where our variable is allocated.  Other types, i.e. a `List<T>`, we may not know exactly how much memory will be required.  We call these _reference_ types.  Instead of the variable holding a binary value, it holds a binary _address_ to _another_ location in memory where the list data is stored (hence, it is a _reference_).  

When your program runs, it gets assigned a big chunk of memory from the operating system.  Your program is loaded into the first part of this memory, and the remaining memory is used to hold variable values as the program runs.  If you imagine that memory as a long shelf, we put the program instructions and any literal values to the far left of this shelf.  Then, as the program runs and we need to create space for variables, we either put them on the left side or right side of the remaining shelf space.  Value types, which we know will only exist for the duration of their scope (i.e. the method they are defined in) go to the left, and once we've ended that scope we remove them.  Similarly, the references we create (holding the address of memory of reference types) go on the left.  The _data_ of the reference types however, go on the right, because we don't know when we'll be done with them. 

We call the kind of memory allocation that happens on the left _static_, as we know it should exist as long as the variable is in scope.  Hence, the `static` keyword.  In lower-level languages like C, we have to manually allocate space for our reference types (hence, not static).  C# is a _memory managed_ language in that we don't need to manually allocate and deallocate space for reference types, but we _do_ allocate space every time we use the `new` keyword, and the garbage collector frees any space it decides we're done with (because we no longer have references pointing at it).  So pointers _do_ exist in C#, they are just "under the hood".

By the way, the left side of the shelf we call the **Stack**, and the right the **Heap**.  This is the source of the name for a **Stack Overflow Exception** - it means your program used up all the available space in the **Stack**, but still needs more.  This is why it typically happens with infinite loops or recursion - they keep allocating variables on the stack until they run out of space.

Memory allocation and pointers is covered in detail in  **CIS 308 - C Language Lab**, and you'll learn more about how programs run and the heap and stack in **CIS 450 - Computer Architecture and Operations**.



