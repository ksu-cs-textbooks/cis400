---
title: "Automated Testing"
pre: "3. "
weight: 3
date: 2018-08-24T10:53:26-05:00
---

Automated testing is the practice of using a program to test another program.  Much as a compiler is a program that translates a program from a higher-order language into a lower-level form, a test program executes a test plan against the program being tested.  And much like you must supply the program to be compiled, for automated testing you must supply the tests that need to be executed. In many ways the process of writing automated tests is like writing a manual test plan - you are writing instructions of what to try, and what the results should be.  The difference is with a manual test plan, you are writing these instructions for a human.  With an automated test plan, you are writing them for a program.

Automated tests are typically categorized as _unit_, _integration_, and _system_ tests:

* **Unit tests** focus on a single unit of code, and test it in isolation from other parts of the code.  In object-oriented programs where code is grouped into objects, these are the units that are tested.  Thus, for each class you would have a corresponding file of unit tests. 
* **Integration** tests focus on the interaction of units working together, and with infrastructure external to the program (i.e. databases, other programs, etc). 
* **System** tests look at the entire program's behavior.

The complexity of writing tests scales with each of these categories.  Emphasis is usually put on writing unit tests, especially as the classes they test are written.  By testing these classes early, errors can be located and fixed quickly.

