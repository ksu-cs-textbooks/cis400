---
title: "Production Languages"
pre: "2. "
weight: 20
date: 2018-08-24T10:53:26-05:00
---

It is important to understand that C# is a _production_ language - i.e. one intended to be used to create real-world software.  To support this goal, the developers of the C# language have made many efforts to make C# code easier to write, read, and reason about.  Each new version of C# has added additional syntax and features to make the language more powerful and easier to use.  In some cases, these are entirely new things the language couldn't do previously, and in others they are _syntactic sugar_ - a kind of abbreviation of an existing syntax.  Consider the following `if` statement:

```csharp
if(someTestFlag) 
{
    DoThing();
}
else 
{ 
    DoOtherThing();
}
```

As the branches only execute a single expression each, this can be abbreviated as:

```csharp
if(someTestFlag) DoThing();
else DoOtherThing();
```

Similarly, Visual Studio has evolved side-by-side with the language.  For example, you have probably come to like _Intellisense_ - Visual Studio's ability to offer descriptions of classes and methods as you type them, as well as _code completion_, where it offers to complete the statement you have been typing with a likely target.  As we mentioned in our section on learning programming, these powerful features can be great for a professional, but can interfere with a novice programmer's learning.  

Let's take a look at some of the features of C# that we haven't examined in detail yet.