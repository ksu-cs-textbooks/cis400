---
title: "Extension Methods"
pre: "5. "
weight: 50
date: 2018-08-24T10:53:26-05:00
---

In order to use LINQ with your `IEnumerable` collections, you must include this using statement:

```csharp
using System.LINQ 
```

Without it, the LINQ collection methods will not be available.  You might be wondering why, as your collections are mostly defined in the `System.Collections` or `System.Collections.Generic` namespaces.

The answer is that LINQ on collections is implemented using [extension methods](https://docs.microsoft.com/en-us/dotnet/csharp/programming-guide/classes-and-structs/extension-methods).  This is a C# feature that allows you to add methods to any class, even a `sealed` class.  But how can we add methods to a sealed class?  Isn't the point of sealing a class to prevent altering it?

The answer is that extension methods don't actually modify the class itself.  Instead, they make available additional methods that the compiler "pretends" are a part of the class.  But these are defined separate from the class, and cannot modify it, nor access private or protected members of the class.  As the LINQ extension methods are defined in the `System.LINQ` namespace, we must make them available with a using statement before the compiler and intellisense will let us use them.

Let's see an example of creating our own extension methods.  As programmers, we often use class names in Pascal case, that might be useful to convert into human-readable strings.  Let's write an extension method to do this transformation:

```csharp
using System.Text;

namespace StringExtensions {
    
    /// <summary>
    /// Converts a camel-case or pascal case string into a human-readable one 
    /// </summary>
    public static string Humanize(this String s)
    {
        StringBuilder sb = new StringBuilder();
        int start = 0;
        for(int i = 1; i < s.Length; i++) 
        {
            // An upper case character is the start of a new word
            if(Char.IsUpper(s[i]))
            {
                // So we'll add the last word to the StringBuilder
                string word = s.Substring(start, i - start);
                sb.Append(word);
                // Since that wasn't the last word, add a space 
                sb.Append(" ");
                // Mark the start of the new word 
                start = i;
            }
        } 
        // We should have one more word left 
        sb.Append(s.Substring(start));
        return sb.ToString();
    }

}
```

Notice a couple of important features.  First, the method is defined as `static`.  All extension methods are `static` methods.  Second, note the use of `this` in the first parameter, `this string s`.  The use of the `this` keyword is what tells C# the method is an extension method.  Moreover, it indicates the class that is being extended - `String` (which is equivalent to `string`).  

Other than these two details, the rest of the method looks much like any other method.  But any time this method is in scope (i.e. within the `StringExtensions` namespace, or in any file with a `using StringExtensions` statement), there will be an additional method available on `string`, `Humanize()`.

That's all there is to writing an extension method.  Go ahead and try writing your own to convert human-readable strings into Pascal or Camel case!