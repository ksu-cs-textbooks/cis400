---
title: "Constructors"
pre: "10. "
weight: 10
date: 2018-08-24T10:53:26-05:00
---

With our broader understanding of objects in memory, let's re-examine something you've been working with already, the concept of a class **constructor**.  A constructor is a special method in a class that when invoked, _reserves the necessary memory to hold the object data_ (which we call allocation), and initializes the values of those fields (the state).  

In most languages, the constructor is invoked with the `new` keyword to emphasize that a new object is being created, and memory allocated to hold it.

## Constructors in C#
In C#, the constructor always has the same name as the class it constructs and has no return type.  For example, if we defined a class `Square`, we might type:

```csharp
public class Square {
    public float length;

    public Square(float length) {
        this.length = length;
    }

    public float Area() {
        return length * length;
    }
}
```

Note that unlike the regular method, `Area()`, our constructor `Square()` does not have a return type.  In the constructor, we set the `length` field of the newly constructed object to the value supplied as the parameter `length`.  Note too that we use the `this` keyword to distinguish between the _field_ `length` and the _parameter_ `length`.  Since both have the same name, the C# compiler assumes we mean the parameter, unless we use `this.length` to indicate the field that belongs to `this` - i.e. this object.

## Parameterless Constructors

A parameterless constructor is one that does not have any parameters.  For example:

```csharp
public class Ball {
    private int x;
    private int y;

    public Ball() {
        x = 50;
        y = 10;
    }
}
```

Notice how no parameters are defined for `Ball()` - the parentheses are empty.

If we don't provide a constructor for a class the C# compiler automatically creates a _parameterless_ constructor for us, i.e. the class `Bat`:

```csharp
public class Bat {
    private bool wood = true;
}
```

Can be created by invoking `new Bat()`, even though we did not define a constructor for the class.  If we define _any_ constructors, parameterless or otherwise, then the C# compiler will not create an automatic parameterless constructor.

