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
Instead, in a true object-oriented approach we would write public  **_accessor methods_**, a.k.a. *getters* and *setters* (so called because they _get_ or _set_ the value of a field).  These methods allow us to see and change field values _in a controlled way_.  Adding accessors to our Student class might look like:

```csharp
/// <summary>A class representing a K-State student</summary>
public class Student
{
    private string _first;
    private string _last;
    private uint _wid;

    /// <summary>Constructs a new student object</summary>
    /// <param name="first">The new student's first name</param>
    /// <param name="last">The new student's last name</param>
    /// <param wid="wid">The new student's Wildcat ID number</param>
    public Student(string first, string last, uint wid)
    {
        _first = first;
        _last = last;
        _wid = wid;
    }

    /// <summary>Gets the first name of the student</summary>
    /// <returns>The student's first name</returns>
    public string GetFirst()
    {
        return _first;
    }

    /// <summary>Sets the first name of the student</summary>
    public void SetFirst(string value)
    {
        if (value.Length > 0) _first = value;
    }

    /// <summary>Gets the last name of the student</summary>
    /// <returns>The student's last name</returns>
    public string GetLast()
    {
        return _last;
    }

    /// <summary>Sets the last name of the student</summary>
    /// <param name="value">The new name</summary>
    /// <remarks>The <paramref name="value"/> must be a non-empty string</remarks>
    public void SetLast(string value)
    {
        if (value.Length > 0) _last = value;
    }

    /// <summary>Gets the student's Wildcat ID Number</summary>
    /// <returns>The student's Wildcat ID Number</returns>
    public uint GetWid()
    {
        return _wid;
    }

    /// <summary>Gets the full name of the student</summary>
    /// <returns>The first and last name of the student as a string</returns>
    public string GetFullName()
    {
        return $"{_first} {_last}"
    }
}
```

Notice how the `SetFirst()` and `SetLast()` method check that the provided name has at least one character?  We can use setters to make sure that we never allow the object state to be set to something that makes no sense.

Also, notice that the `wid` field only has a getter.  This effectively means once a student’s Wid is set by the constructor, it cannot be changed.  This allows us to share data without allowing it to be changed outside of the class. 

Finally, the `GetFullName()` is also a getter method, but it does not have its own private backing field. Instead it _derives_ its value from the class state. We sometimes call this a derived getter for that reason. 
