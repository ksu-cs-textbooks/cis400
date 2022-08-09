---
title: "Boxes"
pre: "3. "
weight: 3
date: 2018-08-24T10:53:26-05:00
---

UML class diagrams are largely composed of _boxes_ - basically a rectangular border containing text. UML class diagrams use boxes to represent units of code - i.e. classes, structs, and enumerations.  These boxes are broken into compartments.  For example, an `Enum` is broken into two compartments:

![A UML Enum representation](/images/5.3.1.png)

### Stereotypes 

UML is intended to be language-agnostic.  But we often find ourselves in situations where we want to convey language-specific ideas, and the UML specification leaves room for this with  _stereotypes_. Stereotypes consist of text enclosed in double less than and greater than symbols.  In the example above, we indicate the box represents an enumeration with the {{<math>}}$ \texttt{&lt&ltenum&gt;&gt;}${{</math>}} stereotype.