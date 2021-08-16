---
title: "Information Hiding"
pre: "6. "
weight: 6
date: 2018-08-24T10:53:26-05:00
---

Now let's return to the concept of [information hiding](https://en.wikipedia.org/wiki/Information_hiding), and how it applies in object-oriented languages.

Unanticipated changes in state are a major source of errors in programs. Again, think back to the EPIC source code we [looked at earlier]({{<ref "1-object-orientation/00-introduction/04-language-evolution">}}). It may have seemed unusual now, but it used a common pattern from the early days of programming, where _all_ the variables the program used were declared in one spot, and were _global_ in scope (i.e. any part of the program could reassign any of those variables).

If we consider the program as a state machine, that means that any part of the program code could change any part of the program state.  Provided those changes were intended, everything works fine. But if the _wrong_ part of the state was changed problems would ensue.

For example, if you were to make a typo in the part of the program dealing with water run-off in a field which ends up assigning a new value to a variable that was supposed to be used for crop growth, you've just introduced a very subtle and difficult-to-find error.  When the crop growth modeling functionality fails to work properly, we'll probably spend serious time and effort looking for a problem in the crop growth portion of the code... but the problem doesn't lie there at all!

### Access Modifiers
There are several techniques involved in data hiding in an object-oriented language.  One of these is [access modifiers](https://docs.microsoft.com/en-us/dotnet/csharp/programming-guide/classes-and-structs/access-modifiers), which determine what parts of the program code can access a particular class, field, property, or method.  Consider a class representing a student:

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

By using the access modifier `private`, we have indicated that our fields `first`, `last`, and `wid` cannot be accessed (seen or assigned to) outside of the code that makes up the `Student` class.  If we were to create a specific student:

```csharp
Student willie = new Student("Willie", "Wildcat", 888888888);
```

We would not be able to change his name, i.e. `willie.first = "Bob"` would fail, because the field `first` is private.  In fact, we cannot even see his name, so `Console.WriteLine(willie.first);` would also fail.  

If we want to allow a field or method to be accessible _outside_ of the object, we must declare it `public`.  While we _can_ declare fields public, this violates the core principles of encapsulation, as any outside code can modify our object's state in uncontrolled ways.

### Accessor Methods
Instead, in a true object-oriented approach we would write public  **_accessor methods_**, a.k.a. *getters* and *setters*.  These are methods that allow us to see and change field values _in a controlled way_.  Adding accessors to our Student class might look like:

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

Notice how the `SetFirst()` and `SetLast()` method check that the provided name has at least one character?  We can use setters to make sure that we never allow the object state to be set to something that makes no sense.

Also, notice that the `wid` field only has a getter.  This effectively means once a student’s Wid is set by the constructor, it cannot be changed (it’s readonly).  This allows us to share data without allowing it to be changed outside of the class.

## C# Properties
While accessors provide a powerful control mechanism in object-oriented languages, they also require a lot of boilerplate typing.  Many languages therefore introduce a mechanism for quickly defining basic accessors.  In C#, we have [Properties](https://docs.microsoft.com/en-us/dotnet/csharp/programming-guide/classes-and-structs/properties).  Let’s rewrite our Student class with Properties:

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

For the most basic accessor (like Nickname in the example), we can create a property in one line with both getter and setter, with an implicit backing field.  We can also explicitly create our backing field (the private field) as we did for `last`, `first`, and `wid`.  We can also make a property read-only by not defining a setter, like we did for `Wid`.  One of the nice properties of properties is they are treated  like fields instead of methods, and can use the assignment operator:

```csharp
Student willie = new Student("William", "Wildcat", 888888888);
willie.Nickname = "Willie";
Console.Write(willie.First + " " + willie.Last);
```

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