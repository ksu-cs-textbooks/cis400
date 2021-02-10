---
title: "Lambda Syntax"
pre: "08. "
weight: 80
date: 2018-08-24T10:53:26-05:00
---

The next topic we'll cover is _lambda syntax_.  You may remember from CIS 115 the _Turing Machine_, which was Alan Turing's theoretical computer he used to prove a lot of theoretical computer science ideas.  Another mathematician of the day, Alan Church, created his own equivalent of the Turing machine expressed as a formal logic system, [Lambda calculus](https://en.wikipedia.org/wiki/Lambda_calculus).  Broadly speaking, the two approaches do the same thing, but are expressed very differently - the Turing machine is an (imaginary) hardware-based system, while Lambda Calculus is a formal symbolic system grounded in mathematical logic.  Computer scientists develop familiarity with both conceptions, and some of the most important work in our field is the result of putting them together.

But they do represent two different perspectives, which influenced different programming language paradigms.  The Turing machine you worked with in CIS 115 is very similar to assembly language, and the imperative programming paradigm draws strongly upon this approach.  In contrast, the logical and functional programming paradigms were more influenced by Lambda calculus.  This difference in perspective also appears in how functions are commonly written in these different paradigms.  A imperative language tends to define functions something like:

```
Add(param1, param2)
{
    return param1 + param2;
}
```

While a functional language might express the same idea as:

```
(param1, param2) => param1 + param2
```

This "arrow" or "lambda" syntax has since been adopted as an alternative way of writing functions in many modern languages, including C#.  In C#, it is primarily used as syntactic sugar, to replace what would otherwise be a lot of typing to express a simple idea.

Consider the case where we want to search a `List<string> AnimalList` for a string containing the substring `"kitten"`.  The `List.Find()` takes a predicate - a static method that can be invoked to find an item in the list.  We have to define a static method, i.e.:

```csharp
private static bool FindKittenSubstring(string fullString)
{
    return fullString.Contains("kitten");
}
```

From this method, we create a predicate:

```csharp
Predicate<string> findKittenPredicate = FindKittenSubstring;
```

Then we can pass that predicate into our `Find`:

```csharp
bool containsKitten = AnimalList.Find(findKittenPredicate);
```

This is quite a lot of work to express a simple idea.  C# introduced lambda syntax as a way to streamline it.  The same operation using lambda syntax is:

```csharp
bool containsKitten = AnimalList.Find((fullString) => fullString.Contains("kitten"));
```

Much cleaner to write.  The C# compiler is converting this lambda expression into a predicate as it compiles, but we no longer have to write it!  You've seen this syntax in your XUnit tests, and you'll also see it when we cover LINQ.  It has also been adapted to simplify writing getters and setters.  Consider this case:

```csharp
public class Person 
{
    public string LastName { get; set; }
    
    public string FirstName { get; set; }

    public string FullName 
    { 
        get 
        {
            return FirstName + " " + LastName;

        }
    }
}
```

We could instead express this as:

```csharp
public class Person 
{
    public string LastName { get; set; }

    public string FirstName { get; set; }

    public string FullName => FirstName + " " + LastName;
}
```

In fact, all methods that return the result of a single expression can be written this way:

```csharp
public class VectorMath
{
    public double Add(Vector a, Vector b) => new Vector(a.X + b.X, a.Y + b.Y, a.Z + b.Z);
}
```