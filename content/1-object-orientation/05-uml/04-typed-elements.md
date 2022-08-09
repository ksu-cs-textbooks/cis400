---
title: "Typed Elements"
pre: "4. "
weight: 4
date: 2018-08-24T10:53:26-05:00
---
A second basic building block for UML diagrams is a _typed element_.  Typed elements (as you might expect from the name) have a _type_.  Fields and parameters are typed elements, as are method parameters and return values.

The pattern for defining a typed element is:

```math
$$
\texttt{[visibility] element : type [constraint]} 
$$
```

The optional {{<math>}}$\texttt{[visibility]}${{</math>}} indicates the visibility of the element, the {{<math>}}$\texttt{element}${{</math>}} is the name of the typed element, and the {{<math>}}$\texttt{type}${{</math>}} is its type, and the {{<math>}}$\texttt{[constraint]}${{</math>}} is an optional constraint.  

### Visibility
In UML _visibility_ (what we would call access level in C#) is indicated with symbols, i.e.:

* {{<math>}}$\texttt{+}${{</math>}} indicates `public`
* {{<math>}}$\texttt{-}${{</math>}} indicates `private`
* {{<math>}}$\texttt{#}${{</math>}} indicates `protected`

I.e. the field:

```csharp 
protected int Size;
```

Would be expressed:

```math
$$
\texttt{# Size : int}
$$
```

### Constraints
A typed element can include a _constraint_ indicating some restriction for the element.  The constraints are contained in a pair of curly braces after the typed element, and follow the pattern:

```math
$$
\texttt{ {element: boolean expression} }
$$
```

For example:

```math
$$
\texttt{- age: int {age: >= 0}}
$$
```

Indicates the private variable `age` must be greater than or equal to 0.
