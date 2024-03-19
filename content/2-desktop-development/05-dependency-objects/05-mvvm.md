---
title: "MVVM Architecture"
pre: "5. "
weight: 5
date: 2018-08-24T10:53:26-05:00
---

You have probably noticed that as our use of WPF grows more sophisticated, our controls start getting large, and often filled with complex logic.  You are not alone in noticing this trend.  Microsoft architects Ken Cooper and Ted Peters also struggled with the idea, and introduced a new software architectural pattern to help alleviate it: [Model-View-ViewModel](https://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93viewmodel).  This approach splits the user interface code into two classes: the View (the XAML + codebehind), and a ViewModel, which applies any logic needed to format the data from the model object into a form more easily bound and consumed by the view.

![MVVM Pattern](/images/MVVMPattern.png)

There are several benefits to this pattern:

1. Complex logic is kept out of the View classes, allowing them to focus on the task of presentation
2. Presentation logic is kept out of the Model classes, allowing them to focus on the task of data management and allowing them to be easily re-used for other views
3. Presentation logic is gathered in the ViewModel class, where it can be easily tested

Essentially, this pattern is an application of the [Single-Responsibility Principle](https://en.wikipedia.org/wiki/Single-responsibility_principle) (that each class in your project should bear a single responsibility).