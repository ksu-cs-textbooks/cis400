---
title: "Summary"
pre: "8. "
weight: 8
date: 2018-08-24T10:53:26-05:00
---
In this chapter, we explored the concept of types and discussed how variables are specific types that can be explicitly or implicitly declared.  We saw how in a statically-typed language (like C#), variables are not allowed to change types (though they can do so in a dynamically-typed language).  We also discussed how casting can convert a value stored in a variable into a different type.  Implicit casts can happen automatically, but explicit casts must be indicated by the programmer using a cast operator, as the cast could result in loss of precision or the throwing of an exception.

We explored how class declarations and interface declarations create new types.  We saw how polymorphic mechanisms like interface implementation and inheritance allow objects to be treated as (and cast to) different types.  We also introduced the `as` and `is` casting operators, which can be used to cast or test the ability to cast, respectively.  We saw that if the `as` cast operator fails, it evaluates to null instead of throwing an exception.  We also saw the `is` type pattern expression, which simplifies a casting test and casting operation into a single expression.

Next, we looked at how C# collections leverage the use of interfaces, inheritance, and generic types to quickly and easily make custom collection objects that interact with the C# language in well-defined ways.

Finally, we explored how messages are dispatched when polymorphism is involved. We saw that the method invoked depends on what Type we are currently treating the object as.  We saw how the C# modifiers `protected`, `abstract`, `virtual`, `override`, and `sealed` interacted with this message dispatch process.  We also saw how the `dynamic` type could delay determining an object's type until runtime.