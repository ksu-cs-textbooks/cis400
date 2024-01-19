---
title: "C# Properties"
pre: "7. "
weight: 7
date: 2018-08-24T10:53:26-05:00
---

While accessor methods provide a powerful control mechanism in object-oriented languages, they also require a lot of typing the same code syntax over and over (we often call this [boilerplate](https://en.wikipedia.org/wiki/Boilerplate_text)).  Many languages therefore introduce a mechanism for quickly defining basic accessors.  In C#, we have [Properties](https://docs.microsoft.com/en-us/dotnet/csharp/programming-guide/classes-and-structs/properties).  Let’s rewrite our Student class with Properties:

```csharp
public class Student {

    private string _first;
    /// <summary>The student's first name</summary>
    public string First {
        get { return _first; }
        set { if(value.Length > 0) _first = value;}
    }

    private string _last;
    /// <summary>The student's last name</summary>
    public string Last {
        get { return _last; }
        set { if(value.Length > 0) _last = value; }
    }

    private uint _wid;
    /// <summary>The student's Wildcat ID number</summary>
    public uint Wid {
        get { return this.wid; }
    }

    /// <summary>The student's full name</summary>
    public string FullName 
    {
      get 
      {
        return $"{First} {Last}"
      }
    }

    /// <summary>Constructs a new student object</summary>
    /// <param name="first">The new student's first name</param>
    /// <param name="last">The new student's last name</param>
    /// <param wid="wid">The new student's Wildcat ID number</param>
    public Student(string first, string last, uint wid) {
        _first = first;
        _last = last;
        _wid = wid;
    }
}
```

If you compare this example to the previous one, you will note that the code contained in bodies of the `get` and `set` are identical to the corresponding getter and setter methods. Essentially, C# properties are shorthand for writing out the accessor methods.  In fact, when you compile a C# program it transforms the `get` and `set` back into methods, i.e. the `get` in first is used to generate a method named `get_First()`.

While properties _are_ methods, the syntax for working with them in code is identical to that of fields, i.e. if we were to create and then print a `Student`'s identifying information, we'd do something like: 

```csharp
Student willie = new Student("Willie", "Wildcat", 99999999);
Console.Write("Hello, ")
Console.WriteLine(willie.FullName);
Console.Write("Your WID is:");
Console.WriteLine(willie.Wid);
```

Note too that we can declare properties with only a `get` or a `set` body, and that properties can be derived from other state rather than having a private backing field.


{{% notice info %}}
#### Properties are _Methods_

While C# properties are used like fields, i.e. `Console.WriteLine(willie.Wid)` or `willie.First = "William"`, they are actually _methods_.  As such, they _do not add structure to hold state_, hence the need for a _backing variable_.  

The `Nickname` property in the example above is special syntax for an _implicit_ backing field - the C# compiler creates the necessary space to hold the value.  But we can _only_ access the value stored through that property.  If you need direct access to it, you _must_ create a backing variable.

However, we don't always need a backing variable for a Property getter if the value of a property can be calculated from the current state of the class, i.e., we could add a property `FullName` to our `Student` class:

```csharp 
public string FullName {
    get {
        return first + " " + last;
    }
}
```

Here we're effectively generating the value of the `FullName` property from the `first` and `last` backing variables every time the `FullName` property is requested.  This does cause a bit more computation, but we also know that it will always reflect the current state of the first and last names.
{{% /notice %}}

## Auto-Property Syntax
Not all properties need to do extra logic in the `get` or `set` body.  Consider our `Vector3` class we discussed earlier. We used public fields to represent the `X`, `Y`, and `Z` components, i.e.:

```csharp
public double X = 0;
```

If we wanted to switch to using properties, the `X` property would end up like this:

```csharp
private double _x = 0;
public double X 
{
  get 
  {
    return _x;
  }
  set 
  {
    _x = value;
  }
}
```

Which seems like a lot more work for the same effect. To counter this perception and encourage programmers to use properties even in cases like this, C# also supports _auto-property_ syntax. An auto-property is written like:

```csharp
public double X {get; set;} = 0;
```

Note the addition of the `{get, set}` - this is what tells the compiler we want a property and not a field.  When compiled, this code is transformed into a full getter and setter whose bodies match the basic `get` and `set` in the example above. The compiler even creates a private backing field (but we cannot access it in our code, because it is only created at compile time).  Any time you don't need to do any additional logic in a get or set, you can use this syntax.  

Note that in the example above, we set a default value of `0`.  You can omit setting a default value.  You can also define a get-only autoproperty that always returns the default value (remember, you cannot access the compiler-generated backing field, so it can never be changed):

```csharp
public double Pi {get} = 3.14;
```

In practice, this is effectively a constant field, so consider carefully if it is more appropriate to use that instead:

```csharp
public const PI = 3.14;
```

While it is possible to create a set-only auto-property, you will not be able access its value, so it is of limited use.

## Expression-Bodied Members

Later versions of C# introduced a concise way of writing functions common to functional languages known as lambda syntax, which C# calls [Expression-Bodied Members](https://learn.microsoft.com/en-us/dotnet/csharp/programming-guide/statements-expressions-operators/expression-bodied-members). 

Properties can be written using this concise syntax.  For example, our `FullName` get-only derived property in the `Student` written as an expression-bodied read-only property would be:

```csharp
public FullName => $"{FirstName} {LastName}"
```

Note the use of the arrow formed by an equals and greater than symbol `=>`.  Properties with both a getter and setter can also be written as expression-bodied properties.  For example, our `FirstName` property could be rewritten:

```csharp
public FirstName 
{
  get => _first;
  set => if(value.Length > 0) _first = value;
}
```

This syntax works well if your property bodies are a single expression.  However, if you need multiple lines, you should use the regular property syntax instead (you can also mix and match, i.e. use an expression-bodied `get` with a regular `set`).

## Different Access Levels

It is possible to declare your property as `public` and give a different access level to one of the accessors, i.e. if we wanted to add a GPA property to our student:

```csharp
public double GPA { get; private set; } = 4.0;
```

In this case, we can access the value of the GPA outside of the student class, but we can only set it from code inside the class. This approach works with all ways of defining a property.

## Init Property Accessor

C# 9.0 introduced a third accessor, `init`.  This also sets the value of the property, but can _only_ be used when the class is being initialized, and it can only be used once. This allows us to have some properties that are _immutable_ (unable to be changed).

Our student example treats the `Wid` as immutable, but we can use the `init` keyword with an auto-property for a more concise representation:

```csharp
public uint Wid {get; init;}
```

And in the constructor, replace setting the backing field (`_wid = wid`) with setting the property (`Wid = wid`). This approach is similar to the public property/private setter, but won't allow the property to ever change once declared.