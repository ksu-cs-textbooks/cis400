---
title: "Interfaces"
pre: "3. "
weight: 3
date: 2018-08-24T10:53:26-05:00
---

If we think back to the concept of _message passing_ in object-oriented languages, it can be useful to think of the collection of public methods available in a class as an _interface_, i.e., a list of messages you can dispatch to an object created from that class.  When you were first learning a language (and probably even now), you find yourself referring to these kinds of lists, either in the language documentation, or via Intellisense in Visual Studio.

![The Java API](/images/2.1.3.1.png)

![Visual Studio Intellisense](/images/2.1.3.2.png)

Essentially, programmers use these 'interfaces' to determine what methods can be invoked on an object.  In other words, which _messages_ can be _passed_ to the object.  This 'interface' (note the lowercase i) is determined by the class definition, specifically what methods it contains.

In dynamically typed programming languages, like Python, JavaScript, and Ruby, if two classes accept the same message, you can treat them interchangeably, i.e. the `Kangaroo` class and `Car` class both define a `jump()` method, you could populate a list with both, and call the `jump()` method on each:

```javascript
var jumpables = [new Kangaroo(), new Car(), new Kangaroo()];
for(int i = 0; i < jumpables.length; i++) {
    jumpables[i].jump();
}
```

This is sometimes called [duck typing](https://en.wikipedia.org/wiki/Duck_typing), from the sense that "if it walks like a duck, and quacks like a duck, it might as well be a duck."

However, for statically typed languages we must explicitly indicate that two types both possess the same message definition, by making the interface _explicit_.  We do this by declaring an `Interface`.  I.e., the Interface for classes that possess a parameter-less jump method might be:

```csharp 
/// <summary>
/// An interface indicating an object's ability to jump
/// </summary>
public Interface IJumpable {
    
    /// <summary>
    /// A method that causes the object to jump
    /// </summary>
    void Jump();
}
```

In C#, it is common practice to preface Interface names with the character `I`. The `Interface` declaration defines an 'interface' - the shape of the messages that can be passed to an object implementing the interface - in the form of a method signature.  Note that this signature _does not include a body_, but instead ends in a semicolon (`;`).  An interface simply indicates the message to be sent, _not the behavior it will cause!_  We can specify as many methods in an `Interface` declaration as we want.

Also note that the method signatures in an `Interface` declaration _do not have access modifiers_.  This is because the whole purpose of defining an interface is to signify methods _that can be used by other code_.  In other words, `public` access is implied by including the method signature in the `Interface` declaration.  

This `Interface` can then be implemented by other classes by listing it after the class name, after a colon `:`.  Any `Class` declaration implementing the interface _must define public methods thats signatures match those were specified by the interface_:

```javascript 
/// <summary>A class representing a kangaroo</summary>
public class Kangaroo : IJumpable 
{
    /// <summary>Causes the Kangaroo to jump into the air</summary>
    public void Jump() {
        // TODO: Implement jumping...
    }
}

/// <summary>A class representing an automobile</summary>
public class Car : IJumpable 
{
    /// <summary>Helps a stalled car to start by providing electricity from another car's battery</summary>
    public void Jump() {
        // TODO: Implement jumping a car...
    }

    /// <summary>Starts the car</summary>
    public void Start() {
        // TODO: Implement starting a car...
    }
}
```

We can then treat these two disparate classes as though they shared the same type, defined by the `IJumpable` interface:

```csharp
List<IJumpable> jumpables = new List<IJumpable>() {new Kangaroo(), new Car(), new Kangaroo()};
for(int i = 0; i < jumpables.Count; i++)
{
    jumpables[i].Jump();
}
```

Note that while we are treating the Kangaroo and Car instances _as_ `IJumpable` instances, we can _only_ invoke the methods defined in the `IJumpable` interface, even if these objects have other methods. Essentially, the interface represents a new _type_ that can be shared amongst disparate objects in a statically-typed language. The Interface definition serves to assure the static type checker that the objects implementing it can be treated as this new type - i.e. the `Interface` provides a mechanism for implementing polymorphism. 

We often describe the relationship between the interface and the class that implements it as a *is-a* relationship, i.e. a Kangaroo _is a_ IJumpable (i.e. a Kangaroo is a thing that can jump).  We further distinguish this from a related polymorphic mechanism, inheritance, by the strength of the relationship.  We consider interfaces **weak is a** connections, as other than the shared interface, a Kangaroo and a Car don't have much to do with one another.

A C# class can implement as many interfaces as we want, they just need to be separated by commas, i.e.:

```csharp
public class Frog : IJumpable, ICroakable, ICatchFlies
{
    // TODO: Implement frog class...
}
```

Next we'll look at inheritance, which represents a **strong is-a** relationship.