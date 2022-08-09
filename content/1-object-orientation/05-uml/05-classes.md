---
title: "Classes"
pre: "5. "
weight: 5
date: 2018-08-24T10:53:26-05:00
---

In a UML class diagram, individual classes are represented with a box divided into three compartments, each of which is for displaying specific information:

![Class Diagram example](/images/5.5.1.png)

The first compartment identifies the class - it contains the name of the class. The second compartment holds the _attributes_ of the class (in C#, these are the _fields_ and _properties_).  And the third compartment holds the _operations_ of the class (in C#, these are the _methods_).

In the diagram above, we can see the `Fruit` class modeled on the right side. 

### Attributes
The _attributes_ in UML represent the _state_ of an object.  For C#, this would correspond to the _fields_ and _properties_ of the class.

We indicate fields with a typed element, i.e. in the example above, the `blended` field is represented with:

```math
$$
\texttt{-blended:bool}
$$ 
```

Indicating it should be declared `private` with the type `bool`.

For properties, we add a stereotype containing either `get`, `set`, or both.  I.e. if we were to expose the private field bool with a public accessor, we would add a line to our class diagram with:

```math
$$
\texttt{+Blended:bool&lt;&lt;get,set&gt;&gt;}
$$
```

{{% notice info %}}
In C#, properties are technically methods.  But we use the same syntax to utilize them as we do fields, and they serve the same role - to expose aspects of the class state. So for the purposes of this class we'll classify them as attributes.
{{% /notice %}}

### Operators
The _operators_ in UML represent the _behavior_ of the object, i.e. the _methods_ we can invoke upon it.  These are declared using the pattern:

```math
$$ 
\texttt{visibility name([parameter list])[:return type]}
$$
```

The  $\texttt{[visibility]}$ uses the same symbols as typed elements, with the same correspondences. The $\texttt{name}$ is the name of the method, and the $\texttt{[parameter list]}$ is a comma-separated list of typed elements, corresponding to the parameters.  The $\texttt{[:return type]}$ indicates the return type for the method (it can be omitted for void). 

Thus, in the example above, the protected method `Blend` has no parameters and returns a string.  Similarly, the method:

```csharp 
public int Add(int a, int b)
{
    return a + b;
}
```

Would be expressed:

```math
$$
\texttt{+Add(a:int, b:int):int}
$$
```

## Static and Abstract
In UML, we indicate a class is static by _underlining_ its name in the first compartment of the class diagram.  We can similarly indicate static operators and methods is static by underlining the entire line referring to them.

To indicate a class is abstract, we _italicize_ its name.  Abstract methods are also indicated by italicizing the entire line referring to them.