---
title: "Generics"
pre: "05. "
weight: 50
date: 2018-08-24T10:53:26-05:00
---

Generics expand the type system of C# by allowing classes and structs to be defined with a generic type parameter, which will be instantiated when it is used in code.  This avoids the necessity of writing similar specialized classes that each work with a different data type.  You've used examples of this extensively in your _CIS 300 - Data Structures_ course. 

For example, the generic `List<T>` can be used to create a list of any type.  If we want a list of integers, we declare it using `List<int>`, and if we want a list of booleans we declare it using `List<bool>`.  Both use the same generic list class.

You can declare your own generics as well.  Say you need a binary tree, but want to be able to support different types.  We can declare a generic `BinaryTreeNode<T>` class:

```csharp 
/// <summary>
/// A class representing a node in a binary tree 
/// <summary>
/// <typeparam name="T">The type to hold in the tree</typeparam>
public class BinaryTreeNode<T> 
{
    /// <summary> 
    /// The value held in this node of the tree 
    /// </summary>
    public T Value { get; set; }

    /// <summary> 
    /// The left branch of this node
    /// </summary>
    public BinaryTreeNode<T> Left { get; set; }

    /// <summary> 
    /// The right branch of this node
    /// </summary>
    public BinaryTreeNode<T> Right { get; set; }
}
```

Note the use of `<typeparam>` in the XML comments.  You should always document your generic type parameters when using them.
