---
title: "Inheritance And Events"
pre: "7. "
weight: 7
date: 2018-08-24T10:53:26-05:00
---

Considering that C# was developed as an object-oriented language from the ground up, you would expect that events would be inheritable just like properties, fields, and methods.  Unfortunately this is not the case.  Remember, the C# language is compiled into intermediate language to run on the .NET Runtime, and this Runtime proceeded C# (it is also used to compile Visual Basic), and the way events are implemented in intermediate language does not lend itself to inheritance patterns.

This has some important implications for writing C# events:
* You cannot invoke events defined in a base class in a derived class
* The `virtual` and `override` keywords used with events do not actually create an overridden event - you instead end up with two separate implementations.

The standard way programmers have adopted to this issue is to:
1. Define the event normally in the base class 
2. Add a `protected` helper method to that base class that will invoke the event, taking whatever parameters are needed
3. Calling that helper method from derived classes.

For example, the `PropertyChanged` event we discussed previously is often invoked from a helper method named `OnPropertyChanged()` that is defined like this:

```csharp
protected virtual void OnPropertyChanged(string propertyName)
{
    this.PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
}
```

In derived classes, you can indicate a property is changing by calling this event, and passing in the property name, i.e.:

```csharp
private object _tag = null;

/// <summary>
/// An object to represent whatever you need 
/// </summary>
public object Tag {
  get => _obj;
  set 
  {
    if(value != _obj) 
    {
      _obj = value;
      OnPropertyChanged(nameof(this.Tag));
    }
  }
}
```

Note the call to `OnPropertyChanged()` - this will trigger the `PropertyChanged` event handler on the base class. 

{{% notice tip %}}
You might have noticed the use of `nameof(this.Tag)` in the example code above.  The <a href="https://docs.microsoft.com/en-us/dotnet/csharp/language-reference/operators/nameof" target="_blank">nameof expression</a> returns the _name_ of a property as a string.  This approach is preferred over just writing the string, as it makes it less likely a typo will result in your code not working as expected.
{{% /notice %}}