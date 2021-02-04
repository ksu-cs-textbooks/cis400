---
title: "Nullables"
pre: "06. "
weight: 60
date: 2018-08-24T10:53:26-05:00
---

Returning to the distinction between value and reference types, a _value_ type stores its value directly in the variable, while a _reference_ type stores an address to another location in memory that has been allocated to hold the value.  This is why reference types can be `null` - this indicates they aren't pointing at anything.  In contrast, value types cannot be null - they _always_ contain a value.  However, there are times it would be convenient to have a value type be allowed to be null.

For these circumstances, we can use the [`Nullable<T>`](https://docs.microsoft.com/en-us/dotnet/api/system.nullable-1) generic type, which allows the variable to represent the same values as before, _plus_ `null`.  It does this by wrapping the value in a simple structure that stores the value in its `Value` property, and also has a boolean property for `HasValue`.  More importantly, it supports explicit casting into the template type, so we can still use it in expressions, i.e.:

```csharp 
Nullable<int> a = 5;
int b = 6;
int c = (int)a + b;
// This evaluates to 11.
```

However, if the value is `null`, we'll get an `InvalidOperationException` with the message _"Nullable object must have a value"_.

There is also syntactic sugar for declaring nullable types.  We can follow the type with a question mark (`?`), i.e.:

```csharp
int? a = 5;
```

Which works the same as `Nullable<int> a = 5;`, but is less typing.