---
title: "Typed Elements"
pre: "4. "
weight: 4
date: 2018-08-24T10:53:26-05:00
---
A second basic building block for UML diagrams is a _typed element_.  Typed elements (as you might expect from the name) have a _type_.  Fields and parameters are typed elements, as are method parameters and return values.

The pattern for defining a typed element is:

$$
\texttt{[visibility] element : type [constraint]} 
$$

The optional $[visibility]$ indicates the visibility of the element, the $element$ is the name of the typed element, and the $type$ is its type, and the $[constraint]$ is an optional constraint.  

### Visibility
In UML _visibility_ (what we would call access level in C#) is indicated with symbols, i.e.:

* $\texttt{+}$ indicates `public`
* $\texttt{-}$ indicates `private`
* $\texttt{\#}$ indicates `protected`

I.e. the field:

```csharp 
protected int Size;
```

Would be expressed:

<div>
$$
\texttt{# Size : int}
$$
</div>

### Constraints
A typed element can include a _constraint_ indicating some restriction for the element.  The constraints are contained in a pair of curly braces after the typed element, and follow the pattern:

$$
\texttt{ {element: boolean expression} }
$$

For example:

$$
\texttt{- age: int {age: >= 0}}
$$

Indicates the private variable `age` must be greater than or equal to 0.
