---
title: "Structured Programming"
pre: "5. "
weight: 50
date: 2018-08-24T10:53:26-05:00
---

Another common change to programming languages was the removal of the `GOTO` statement, which allowed the program execution to jump to an arbitrary point in the code (much like a [choose-your-own adventure](https://en.wikipedia.org/wiki/Choose_Your_Own_Adventure) book will direct you to jump to a page). The GOTO came to be considered too primitive, and too easy for a programmer to misuse [^goto]. 

[^goto]: Dijkstra, Edgar (1968). ["Go To Statement Considered Harmful"](https://homepages.cwi.nl/~storm/teaching/reader/Dijkstra68.pdf)

While the `GOTO` statement is absent from most modern programming languages the actual _functionality_ remains, abstracted into control-flow structures like conditionals, loops, and switch statements.  This is the basis of [structured programming](https://en.wikipedia.org/wiki/Structured_programming), a paradigm adopted by all modern higher-order programming languages. 

Each of these control-flow structures can be represented by careful use of `GOTO` statements (and, in fact the resulting assembly code from compiling these languages does just that). The benefit of using structured programming is it promotes "reliability, correctness, and organizational clarity" by clearly defining the circumstances and effects of code jumps [^wirth1974].

[^wirth1974]: Wirth, Nicklaus (1974). ["On the Composition of Well-Structured Programs"](https://oberoncore.ru/_media/library/wirth_on_the_composition_of_well-structured_programs.pdf)

You probably aren't very familiar with GOTO statements because the structured programming paradigm has become so dominant.  Before we move on, let's see how some familiar structured programming patterns were originally implemented using GOTOs:

### Conditional (if statement)
In C#, you are probably used to writing if statements with a true branch:

```csharp
int x = 4;
if(x < 5) 
{
  x = x * 2;
}
Console.WriteLine("The value is:" + x);
```
With GOTOs, it would look something like:

```csharp
int x = 4;
if(x < 5) goto TrueBranch;

AfterElse:
  Console.WriteLine("The value is:" + x);
  Environment.Exit(0);

TrueBranch:
  x = x * 2;
  goto AfterElse
```

### Conditional (if-else statement)

Similarly, a C# if statement with an else branch:

```csharp
int x = 4;
if(x < 5) 
{
  x = x * 2;
}
else 
{
  x = 7;
}
Console.WriteLine("The value is:" + x);
```

And using GOTOs:

```csharp
int x = 4;
if(x < 5) goto TrueBranch;
goto FalseBranch;

AfterElse:
  Console.WriteLine("The value is:" + x);
  Environment.Exit(0);

TrueBranch:
  x = x * 2;
  goto AfterElse;

FalseBranch: 
  x = 7;
  goto AfterElse;

```

Note that with the goto, we must tell the program to stop running explicitly with `Environment.Exit(0)` or it will continue on to execute the labeled code (we could also place the TrueBranch and FalseBranch _before_ the main program, and use a goto to jump to the main program).

### While Loop
Loops were also originally constructed entirely from GOTOs, so the familiar while loop:

```csharp
int times = 5;
while(times > 0)
{
  Console.WriteLine("Counting Down: " + times);
  times = times - 1;
}
```

Can be written:

```csharp
int times = 5;
Test:
  if(times > 0) goto Loop;
  Environment.Exit(0);

Loop: 
  Console.WriteLine("Counting Down: " + times);
  times = times - 1;
  goto Test;
```

The `do while` and `for` loops are implemented similarly. As you can probably imagine, as more control flow is added to a program, using GOTOs and corresponding labels to jump to becomes very hard to follow.


{{% notice info %}}
Interestingly, the [C# language does have a goto statement](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/statements/jump-statements#the-goto-statement) (Java does not). Likely this is because C# was designed to compile to intermediate language like Visual Basic, which is an evolution of BASIC which was old enough to have a goto.

Accordingly, the above examples with the `goto` statements are valid C# code. You can even compile and run them. However, you should avoid using `goto` statements in your code.
{{% /notice %}}


