---
title: "Class Library Milestone #3 - Zach's Review"
pre: "5. "
weight: 50
date: 2018-08-24T10:53:26-05:00
---

{{% notice noiframe %}}
This textbook was authored for the **CIS 400 - Object-Oriented Design, Implementation, and Testing** course at Kansas State University.  This section describes assignments specific to that course.  If you are not enrolled in the course, please disregard this section.
{{% /notice %}}

# Class Data Library Milestone #3

### Let's Review!!!!

```csharp
/* Abstract vs. Virtual */

public abstract class abstractionAndVirtualizationExample
{
    /* Abstract:
    Abstract methods do not provide implementation and require derived classes to override the method */
    public abstract double doSomethingThatReturnsADouble(int someParamIfNeeded);

    /* Virtual:
    You do not have to provide an implementation, but you can */
    public virtual void doSomething()
    {
        Console.Out.WriteLine("Yeet skeet");
    }
}

public class Example : abstractionAndVirtualizationExample
{
    public override double doSomethingThatReturnsADouble(int someParamIfNeeded)
    {
        /* Provide the implementation here */
        
        doSomething(); /* Notice I can call the doSomething() method without having it in within this class. This is because I am using the default implementation provided by the abstract class */
        
        return 0;
    }
}
```

### Break it down, what is important?

#### Abstract Methods:

* Reside in abstract classes and have not method body.

* Requires non-abstract child classes to override the method and provide their own implementation

#### Virtual Methods:

* Can reside in abstract and non-abstract classes

* Can provide a default implementation but is not required

* If a class wants to use the default implementation you do not have to override the method, but you can if needed

[Stack Overflow Post on Virtual vs. Abstract](https://stackoverflow.com/questions/14728761/difference-between-virtual-and-abstract-methods)

```csharp
/* Interfaces */

/* Interface:
    Can only have abstract method headers and properties included within these classes. Notice the "I" infront of the name for the interface. This is common practice for naming interfaces in C#. Also laid out in the coding conventions */
public interface IsomeInterface
{
    /* A getter property */
    string returnStringProperty { get; }

    /* Method headers, because these are within an interface you do not technically have to override them in the classes that implement the interface */
    void someMethod();

    int someOtherMethod();
}

/* This class implements the above interface */
public class someClass : IsomeInterface
{
    public string returnStringProperty { get { return new string("Yeet skeet"); } }

    public void someMethod()
    {
        Console.Out.WriteLine("I am an example");
    }

    public int someOtherMethod()
    {
        Console.Out.WriteLine("I just return 0");
        return 0;
    }
}
```

### Break it down, what is important?

Abstract and interface classes are similar but not the same. Interfaces should be used as a generalization of a collection of different classes. Such as a Shape, where the collection of different classes includes Square, Triangle, even a tetrahedron. Any class that uses a interface must provide their own implementation for the properties and methods outlined in the interface class.

[w3c Schools on Interfaces](https://www.w3schools.com/cs/cs_interface.asp)

### What does inheritance allow us to do in code?

```csharp
/* Let us take the BriarheartBurger for example */
public void ExamplesOfInheritanceCasting()
{
    /* Casting examples */
    BriarheartBurger BB = new BriarheartBurger();
    Entree e = (Entree)BB;
    IOrderItem IOI1 = (IOrderItem)e;
    IOrderItem IOI2 = (IOrderItem)BB

    /* How to cast back to specifics
    Best way I have found is to use if/is statements */
    if(IOI1 is Entree) /* Do something */
    else if(IOI1 is Drink) /* Do something
    /* Continue as needed */ 
}

/* I can treat items as a general class until I need to do something specific with them. This will be especially useful in the PointOfSale milestones */
```
