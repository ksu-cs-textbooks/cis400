---
title: "Message Passing"
pre: "8. "
weight: 8
date: 2018-08-24T10:53:26-05:00
---

The second criteria Alan Kay set for object-oriented languages was [message passing](https://en.wikipedia.org/wiki/Message_passing).  Message passing is a way to request a unit of code engage in a behavior, i.e. changing its state, or sharing some aspect of its state.  

Consider the real-world analogue of a letter sent via the postal service.  Such a message consists of: an address the message needs to be sent to, a return address, the message itself (the letter), and any data that needs to accompany the letter (the enclosures).  A specific letter might be a wedding invitation.  The message includes the details of the wedding (the host, the location, the time), an enclosure might be a refrigerator magnet with these details duplicated.  The recipient should (per custom) send a response to the host addressed to the return address letting them know if they will be attending.

In an object-oriented language, message passing primarily take the form of methods. Let's revisit our example `Vector3` class:

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
    /// <param name="other">The othe vector</param>
    public double DotProduct(Vector3 other) {
        return this.X * other.X + this.Y * other.Y + this.Z * other.Z;
    }
}
```

And let's use its `DotProduct()` method:

```csharp 
Vector3 a = new Vector3(1, 1, 2);
Vector3 b = new Vector3(4, 2, 1);
double c = a.DotProduct(b);
```

Consider the invocation of `a.DotProduct(b)` above.  The method name, `DotProduct` provides the details of what the message is intended to accomplish (the letter).  Invoking it on a specific variable, i.e. `a`, tells us who the message is being sent to (the recipient address).  The return type indicates what we need to send back to the recipient (the invoking code), and the parameters provide any data needed by the class to address the task (the enclosures).

Let’s define a new method for our Vector3 class that emphasizes the role message passing plays in mutating object state:

```csharp
public class Vector3 {
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

    public void Normalize() {
        var magnitude = Math.Sqrt(Math.pow(this.X, 2) + Math.Pow(this.y, 2), Math.Pow(this.z, 2);
        this.X /= magnitude;
        this.Y /= magnitude;
        this.Z /= magnitude;
    }
}
```

We can now invoke the `Normalize()` method on a Vector3 to mutate its state, shortening the magnitude of the vector to length 1.

```csharp
Vector3 f = new Vector3(9.0, 3.0, 2.0);
f.Normalize();
```

Note how here, `f` is the object receiving the message `Normalize`.  There is no additional data needed, so there are no parameters being passed in.  Our earlier `DotProduct()` method took a second vector as its argument, and used that vector's values to mutate its state.  

Message passing therefore acts like those special molecular pumps and other gate mechanisms of a cell that control what crosses the cell wall.  The methods defined on a class determine how outside code can interact with the object. An extra benefit of this approach is that a method becomes an abstraction for the behavior of the code, and the associated state changes it embodies.  As a programmer using the method, we don't need to know the exact implementation of that behavior - just what data we need to provide, and what it should return or how it will alter the program state.  This makes it far easier to reason about our program, and also means we can change the internal details of a class (perhaps to make it run faster) without impacting the other aspects of the program.

{{% notice info %}}
You probably have noticed that in many programming languages we speak of _functions_, but in C# and other object-oriented languages, we'll often speak of _methods_.  You might be wondering just what is the difference?

Both are forms of message passing, and share many of the same characteristics.  Broadly speaking though, _methods_ are _functions_ defined as part of an object.  Therefore, their bodies can access the state of the object.  In fact, that's what the `this` keyword in C# means - it refers to _this object_, i.e. the instance of the class that the method is currently executing for.  For non-object-oriented languages, there is no concept of `this` (or `self` as it appears in other languages).
{{% /notice %}}