---
title: "Anonymous Types"
pre: "07. "
weight: 70
date: 2018-08-24T10:53:26-05:00
---

Another new addition to C# is [anonymous types](https://docs.microsoft.com/en-us/dotnet/csharp/programming-guide/classes-and-structs/anonymous-types).  These are read-only objects whose type is created by the compiler rather than being defined in code.  They are created using syntax very similar to object initializer syntax.

For example, the line:

```csharp
var name = new { First="Jack", Last="Sprat" };
```

Creates an anonymous object with properties `First` and `Last` and assigns it to the variable name.  Note we have to use `var`, because the object does not have a defined type.  Anonymous types are primarily used with LINQ, which we'll cover in the future.