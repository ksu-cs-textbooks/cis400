
---
title: "Object-Orientation"
pre: "6. "
weight: 60
date: 2018-08-24T10:53:26-05:00
---

The object-orientation paradigm was similarly developed to make programming large projects easier and less error-prone.  

The term "Object Orientation" was coined by Alan Kay while he was a graduate student in the late 60's. Alan Kay, Dan Ingalls, Adele Goldberg, and others created the first object-oriented language, [Smalltalk](https://en.wikipedia.org/wiki/Smalltalk), which became a very influential language from which many ideas were borrowed.  To Alan, the essential core of object-orientation was three properties a language could possess: [^Elliot2018]

* Encapsulation
* Message passing
* Dynamic binding

[^Elliot2018]: Eric Elliot, "The Forgotten History of Object-Oriented Programming," _Medium_, Oct. 31, 2018.

Let's break down each of these ideas, and see how they helped address some of the problems we've identified in this chapter.

__Encapsulation__ refers to breaking programs into smaller units that are easier to read and reason about. In an object-oriented language these units are _classes and objects_, and the data contained in this units is protected with _information hiding_.

__Message Passing__ allows us to send well-defined messages between objects.  In an object oriented language, calling a method on an object is a form of message passing, as are events.

__Dynamic Binding__ means we can have more than one possible way to handle messages and the appropriate one can be determined at run-time.  This is the basis for _polymorphism_, an important idea in many object-oriented languages.

Remember these terms and pay attention to how they are implemented in the languages you are learning.  They can help you understand the ideas that inspired the features of these languages.

We'll take a deeper look at each of these in the next few chapters. But before we do, you might want to see how language popularity has fared since the onset of the software crisis, and how new languages have appeared and grown in popularity in this animated chart from _Data is Beautiful_:

<iframe width="560" height="315" src="https://www.youtube-nocookie.com/embed/Og847HVwRSI" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

Interestingly, the four top languages in 2019 (Python, JavaScript, Java, and C#) all adopt the object-oriented paradigm - though the exact details of how they implement it vary dramatically.

