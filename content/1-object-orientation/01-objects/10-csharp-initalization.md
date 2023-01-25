---
title: "C# Object Initialization"
pre: "10. "
weight: 10
date: 2018-08-24T10:53:26-05:00
---

With our broader understanding of objects in memory, let's re-examine something you've been working with already, how the values in that memory are _initialized_ (set to their initial values).  In C#, there are four primary ways a value is initialized:

1. By zeroing the memory
2. By setting a default value
4. By the constructor
5. With Initialization syntax

This also happens to be the order in which these operations occur - i.e. the default value can be overridden by code in the constructor. Only after all of these steps are completed is the initialized object returned from the constructor.

## Zeroing the Memory

This step is actually done for you - it is a feature of the C# language.  Remember, allocated memory is simply a series of bits. Those bits have likely been used previously to represent something else, so they will already be set to 0s or 1s.  Once you treat it as a variable, it will have a specific meaning.  Consider this statement:

```
int foo;
```

That statement allocates the space to hold the value of `foo`.  But what is that value?  In many older languages, it would be whatever is specified by how the bits were set previously - i.e. it could be any integer within the available range.  And each time you ran the program, it would probably be a _different_ value!  This is why it is always a good idea to _assign_ a value to a variable immediately after you declare it.

The creators of C# wanted to avoid this potential problem, so in C# any memory that is allocated by a variable declaration is also _zeroed_ (all bits are set to 0).  Exactly what this means depends on the variable's type. Essentially, for numerics (integers, floating points, etc) the value would be `0`, for booleans it would be `false`.  And for reference types, the value would be `null`.

## Default Values

A second way a field's value can be set is by assigning a default value after it is declared.  Thus, if we have a private backing `_count` in our `CardDeck` class, we could set it to have a default value of 52:

```csharp
public class CardDeck
{
  private int _count = 52;

  public int Count 
  {
    get 
    {
      return _count;
    }
    set 
    {
      _count = value;
    }
  }
}
```

This ensures that `_count` starts with a value of 52, instead of 0.

We can also set a default value when using auto-property syntax:

```csharp
public class CardDeck
{
  public int Count {get; set;} = 52;
}
```

{{% notice info %}}
It is important to understand that the default value is assigned _as the memory is allocated_, which means the object doesn't exist yet.  Basically, we cannot use methods, fields, or properties of the class to set a default value.  For example:

```csharp
public class CardDeck
{
  public int Count {get; set;} = 52;
  public int PricePerCard {get;} = 5m / Count; 
}
```

Won't compile, because we don't have access to the `Count` property when setting the default for `PricePerCard`.
{{% /notice %}}

## Constructors

This brings us to the constructor, the standard way for an object-oriented program to initialize the state of the object as it is created. In C#, the constructor always has the same name as the class it constructs and has no return type.  For example, if we defined a class `Square`, we might type:

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

### Parameterless Constructors

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

## Initializer Syntax

Finally, C# introduces some special syntax for setting initial values after the constructor code has run, but before initialization is completed - [Object initializers](https://learn.microsoft.com/en-us/dotnet/csharp/programming-guide/classes-and-structs/object-and-collection-initializers).  For example, if we have a class representing a rectangle:

```csharp
public class Rectangle 
{
  public int Width {get; set;}
  public int Height {get; set;}
}
```

We could initialize it with:

```csharp
Rectangle r = new Rectangle() {
  Width = 20,
  Height = 10
};
```

The resulting rectangle would have its width and height set to 20 and 10 respectively _before_ it was assigned to the variable `r`.

{{% notice info %}}
In addition to the `get` and `set` accessor, C# has an `init` operator that works like the `set` operator but can _only_ be used during object initialization. 
{{% /notice %}}