---
title: "Working With Disposables"
pre: "3. "
weight: 30
date: 2018-08-24T10:53:26-05:00
---

In the previous section, we looked at a line of code that included the keyword `using` in a way you haven't probably seen it before:

```csharp
using Stream responseStream = response.GetStream() 
{
  // TODO: Use the responseStream
}
```

Let's examine this statement in more detail.  This use of `using` is a [using statement](https://docs.microsoft.com/en-us/dotnet/csharp/language-reference/keywords/using-statement), not to be confused with a [using directive](https://docs.microsoft.com/en-us/dotnet/csharp/language-reference/keywords/using-directive).  

When you put a statement like `using System.Text`, you are using the _using directive_, which instructs the compiler to use types in the corresponding namespace without needing to provide the fully qualified namespace. You've been using this technique for some time, so it should be familiar to you.

In contrast, the _using statement_ is used in the body of your code in conjunction with an object implementing the `IDisposable` interface.  Objects that implement this interface have a `Dispose()` method, which needs to be called when you are done with them.  These kinds of objects typically access some resource from outside of the program, which needs to be released when you are done with it. 

#### Managed vs. Unmanaged Resources

To understand this better, let's talk about _managed_ vs. _unmanaged_ resources.  We say a resource is _managed_ when obtaining and releasing it is handled by the language.  Memory is a great example of this.  In C#, we are using _managed memory_.  When we invoke a constructor or declare an array, the interpreter automatically creates the memory we need to hold them.  

In contrast, C uses _unmanaged memory_.  When we want to create an array, we must _allocate_ that memory with `alloc()`, `calloc()`, or `malloc()` function call.

This might not seem very different, until we are done with the array.  In C#, we can simply let it fall out of scope, knowing the garbage collector should eventually free that memory.  But in a C program, we must manually free the memory with a call to `free()`.

Sometimes in C#, we need to access some resource in a way that is unmanaged - in which case, we must be sure to free the resource when we are done with it. 

#### IDisposable

The `IDisposable()` interface provides a standard way of handling this kind of situation. It requires any class implementing it to define a `Dispose()` method that frees any unmanaged resources.  A _stream_ (the data being read in from a file, the network, or a terminal) is a good example of an unmanaged resource - the stream is actually created by the operating system, and the `Stream` object (a `FileStream`, `BufferedStream`, etc) is a C# object providing access to it.

Let's focus on a `FileStream` for a moment.  One is created every time you ask the operating system to open a file, i.e.:

```csharp
FileStream fs = File.OpenRead("somefile.txt");
```

The `File.OpenRead()` method asks the operating system to provide a stream to the file named `"somefile.txt"`.  We can then read that stream until we reach the end of file marker (indicating we've read the entire file):

```csharp
byte data = fs.ReadByte();
// Invariant: while there are bytes in the file to read
while(data != -1)
{
  // Write the current byte to the console
  System.Out.Write(data);
  // Read the next byte
  data = fs.ReadByte();
}
```

Once we've finished reading the file, we need to call `Dispose()` on the stream to tell the operating system that we're done with it:

```csharp
fs.Dispose();
```

If we don't, then the operating system will assume we're still working with the file, and refuse to let any other program read it.  Including our own program, if we were to run it again.

But what happens if an error occurs while reading the file? We'll never reach the call to `Dispose()`, so we'll _never free the file_!  In order to access it, we'd have to restart the computer.  Not great.

We _could_ manage this with a `try/catch/finally`, i.e.:

```csharp
try 
{
  FileStream fs = File.OpenRead("somefile.txt");
  byte data = fs.ReadByte();
  // Invariant: while there are bytes in the file to read
  while(data != -1)
  {
    // Write the current byte to the console
    System.Out.Write(data);
    // Read the next byte
    data = fs.ReadByte();
  }
  fs.Dispose();
}
catch(Exception e) 
{
  // Do something with e
}
finally
{
  fs.Dispose();
}
```

But you have to catch all exceptions.  

#### Using Statement

A using statement operates similarly, but takes far less typing:

```csharp
using FileStream fs = File.OpenRead("somefile.txt")
{
  byte data = fs.ReadByte();
  // Invariant: while there are bytes in the file to read
  while(data != -1)
  {
    // Write the current byte to the console
    System.Out.Write(data);
    // Read the next byte
    data = fs.ReadByte();
  }
}
```

It also comes with some benefits.  One, it creates a new scope (within the `{}` following the using statement).  If for some reason the stream can't be opened, this scope is skipped over.  Similarly it jumps execution to the end of the scope if an error occurs.  Finally, it _automatically_ calls `Dispose()` when the scope ends.  

#### Syntax Shorthand 

As of C# 8.0, a shorthand for the using statement that omits the scope markers (the `{}`) is available.  In this case, the scope is from the start of the `using` statement to the end of its containing scope (usually a method):

```csharp
using FileStream fs = File.OpenRead("somefile.txt");
byte data = fs.ReadByte();
// Invariant: while there are bytes in the file to read
while(data != -1)
{
  // Write the current byte to the console
  System.Out.Write(data);
  // Read the next byte
  data = fs.ReadByte();
}
```

This format can be nice when you need to nest multiple `using` statements, but I would suggest sticking with the scoped version until you are comfortable with the concepts involved.