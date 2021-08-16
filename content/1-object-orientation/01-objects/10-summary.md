---
title: "Summary"
pre: "10. "
weight: 10
date: 2018-08-24T10:53:26-05:00
---

In this chapter, we looked at how Object-Orientation adopted the concept of encapsulation to combine related state and behavior within a single unit of code, known as a class.  We also discussed the three key features found in the implementation of classes and objects in Object-Oriented languages:

1. Encapsulation of state and behavior within an object, defined by its class 
2. Information hiding applied to variables defined within that class to prevent unwanted mutations of object state
3. Message passing to allow controlled mutations of object state in well-defined ways

We explored how objects are instances of a class created through invoking a constructor method, and how each object has its own independent state but shares behavior definitions with other objects constructed from the same class.  We discussed several different ways of looking at and reasoning about objects - as a state machine, and as structured data stored in memory. We saw how the constructor creates the memory to hold the object state and initializes its values.  We saw how access modifiers and accessor methods can be used to limit and control access to the internal state of an object through message passing.  

Finally, we explored how all of these concepts are implemented in the C# language.