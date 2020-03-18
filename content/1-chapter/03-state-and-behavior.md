---
title: "State and Behavior"
pre: "3. "
weight: 3
date: 2018-08-24T10:53:26-05:00
---

# State

The data stored in a program at any given moment (in the form of variables, objects, etc.) is the *state* of the program.  Consider a variable:

```csharp
int a = 5;
```

The state of the variable **a** after this line is **5**.  If we then run:

```csharp
a = a * 3;
```

The state is now **15**. Consider the Vector3 struct we defined in the last section:

```csharp
public struct Vector3 {
    public double x;
    public double y;
    public double z;

    // constructor
    public Vector3(double x, double y, double z) {
        this.x = x;
        this.y = y;
        this.z = z;
    }
}
```

If we create an instance of that struct in the variable **b**:

```csharp
Vector3 b = new Vector3(1.2, 3.7, 5.6);
```

The state of our variable **b** is {1.2, 3.7, 5.6}.  If we change one of **b**’s fields:

```csharp
b.x = 6.0;
```

The state of our variable **b** is {6.0, 3.7, 5.6}.

We can also think about the state of the *program*, which would be something like: {a: 5, b: {x: 6.0, y: 3.7, z: 5.6}}, or a state vector like: {5, 6.0, 3.7, 5.6}.  We can therefore think of a program as a *state machine*.

We can in fact, draw our entire program as a state table listing all possible legal states (combinations of variable values) and the transitions between those states.  Techniques like this can be used to reason about our programs and even prove them correct!

## Behavior

What causes our program to transition between states?  If we look at our earlier examples, it is clear that \*assignment \*is a strong culprit.  Expressions clearly have a role to play, and control-flow structures decide which transformations take place.  In fact, we can say that our program code is what drives state changes - the \*behavior \*of the program.

Just as we can encapsulate state (as we did in our struct), we can encapsulate behavior in functions, like this one:

```csharp
public Vector3 Add(Vector3 first, Vector3 second) {
    return new Vector3(
        first.x + second.x,
        first.y + second.y,
        first.z + second.z
    );
}
```

Now we can use that encapsulated behavior to cause a state change:

```csharp
Vector3 c = new Vector3(1.2, 1.4, 3.2);
Vector3 d = Add(b, c);
```

Object-orientation took the next step of encapsulating the related *state* and *behavior* together into a single object.  Consider re-writing our Vector3 as a class:

```csharp
public class Vector3 {
    public double x;
    public double y;
    public double z;

    public Vector3(double x, double y, double z) {
        this.x = x;
        this.y = y;
        this.z = z;
    }

    public void Add(Vector3 other) {
        this.x += other.x;
        this.y += other.y;
        this.z += other.z;
    }

    public void Subtract(Vector3 other) {
        this.x -= other.x;
        this.y -= other.y;
        this.z -= other.z;
    }
}
```

With this cass definition, we can utilize state and behavior together:

```csharp
Vector3 e = new Vector3(0.0, 1.0, 0.0);
Vector3 f = new Vector3(-1.0, 0.0, 0.0);
e.Subtract(f);
```

## Message Passing

Message passing is a way to request a unit of code engage in a behavior, i.e. changing its state, or sharing some aspect of its state.  Consider the real-world analogue of a letter sent via the postal service.  Such a message consists of: an address the message needs to be sent to, a return address, the message itself (the letter), and any data that needs to accompany the letter (the enclosures).  A specific letter might be a wedding invitation.  The message includes the details of the wedding (the host, the location, the time), an enclosure might be a refrigerator magnet with these details duplicated.  The recipient should (per custom) send a response to the host addressed to the return address letting them know if they will be attending.

In an object-oriented language, message passing primarily take the form of methods.  Consider the Vector3’s Add method, above.  The method name, **Add** provides the details of what the message is intended to accomplish (the letter).  Invoking it on a specific variable, i.e. **Difference**, tells us who the message is being sent to (the recipient address).  The return type indicates what we need to send back to the recipient (the invoking code), and the parameters provide any data needed by the class to address the task (the enclosures).

Let’s define a new method for our Vector3 class that emphasizes the role message passing plays in mutating object state:

```csharp
public class Vector3 {
    public double x;
    public double y;
    public double z;

    public Vector3(double x, double y, double z) {
        this.x = x;
        this.y = y;
        this.z = z;
    }

    public void Normalize() {
        var magnitude = Math.Sqrt(this.x * this.x + this.y * this.y + this.z * this.z);
        this.x /= magnitude;
        this.y /= magnitude;
        this.z /= magnitude;
    }
}
```

We can now invoke the **Normalize()** method on a Vector3 to mutate its state, shortening the magnitude of the vector to length 1.

```csharp
Vector3 f = new Vector3(9.0, 3.0, 2.0);
f.Normalize();
f;
```

Note how here, **f** is the object receiving the message **Normalize**.  There is no additional data needed, so there are no parameters being passed in.  Our earlier **Add** and **Subtract** methods took a second vector as their argument, and used those values to mutate their state.  Finally, we can have a method that returns a value, such as **DotProduct**:

```csharp
public class Vector3 {
    public double x;
    public double y;
    public double z;

    public Vector3(double x, double y, double z) {
        this.x = x;
        this.y = y;
        this.z = z;
    }

    public double DotProduct(Vector3 other) {
        return this.x * other.x + this.y * other.y + this.z * other.z;
    }
}
```

## Data Hiding

Unanticipated changes in state are a major source of errors in programs.  Object-oriented programming uses the concept of *data hiding* to prevent these unanticipated changes.  Consider a class representing a student:

```csharp
public class Student {
    private string first;
    private string last;
    private uint wid;

    public Student(string first, string last, uint wid) {
        this.first = first;
        this.last = last;
        this.wid = wid;
    }
}
```

By using the access modifier **private**, we have indicated that our fields **first, last,** and **wid** cannot be seen outside of this code.  If we were to create a specific student:

```csharp
Student willie = new Student("Willie", "Wildcat", 888888888);
```

We would not be able to change his name, i.e. **willie.first = “Bob”** would fail, because the field **first** is private.  In fact, we cannot even see his name, so **Console.Writeline(willie.First);** would also fail.  Instead, we’d need to write **_accessor methods_**, a.k.a. *getters* and *setters*, methods that allow us to see and change field values.  Adding accessors to our Student class might look like:

```csharp
public class Student {
    private string first;
    private string last;
    private uint wid;

    public Student(string first, string last, uint wid) {
        this.first = first;
        this.last = last;
        this.wid = wid;
    }

    public string GetFirst() {
        return this.first;
    }

    public void SetFirst(string value) {
        if(value.Length > 0) this.first = value;
    }

    public string GetLast() {
        return this.last;
    }

    public void SetLast(string value) {
        if(value.Length > 0) this.last = value;
    }

    public uint GetWid() {
        return wid;
    }
}
```

Notice how the **SetFirst** and **SetLast** method check that the provided name has at least one character?  We can use setters to make sure that we never allow the object state to be set to something that makes no sense.

Also, notice that the **wid** field only has a getter.  This effectively means once a student’s Wid is set by the constructor, it cannot be changed (it’s readonly).

While accessors provide a powerful control mechanism in object-oriented languages, they also require a lot of boilerplate typing.  Many languages therefore introduce a mechanism for quickly defining basic accessors.  In C#, we have properties.  Let’s rewrite our Student class with properties:

```csharp
public class Student {

    private string first;
    public string First {
        get { return this.first; }
        set { if(value.Length > 0) this.first = value;}
    }

    private string last;
    public string Last {
        get { return this.last; }
        set { if(value.Length > 0) this.last = value; }
    }

    private uint wid;
    public uint Wid {
        get { return this.wid; }
    }

    public string Nickname { get; set; }

    public Student(string first, string last, uint wid) {
        this.first = first;
        this.last = last;
        this.wid = wid;
    }
}
```

For the most basic accessor (like Nickname in the example), we can create a property in one line with both getter and setter, with an implicit backing field.  We can also explicitly create our backing field (the private field) as we did for **last**, **first**, and **wid**.  We can also make a property read-only by not defining a setter, like we did for **Wid**.  One of the nice properties of properties is they are treated  like fields instead of methods, and can use the assignment operator:

```csharp
Student willie = new Student("William", "Wildcat", 888888888);
willie.Nickname = "Willie";
Console.Write(willie.First + " " + willie.Last);
```