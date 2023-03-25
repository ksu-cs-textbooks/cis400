---
title: "Testing GUIs"
pre: "2. "
weight: 2
date: 2018-08-24T10:53:26-05:00
---

Testing a GUI-based application presents some serious challenges.  A GUI has a strong dependence on the environment it is running in - the operating system is ultimately responsible for displaying the GUI components, and this is also influenced by the hardware it runs on.  As we noted in our [discussion of WPF]({{<ref "2-desktop-development/01-wpf/02-wpf-features">}}), screen resolution can vary dramatically.  So how our GUI appears on one machine may be completely acceptable, but unusable on another.  

For example, I once had an installer that used a fixed-size dialog that was so large, on my laptop the "accept" button was off-screen below the bottom of the screen - and there was no way to click it.  This is clearly a problem, but the developer failed to recognize it because on their development machine (with nice large monitors) everything fit!  So how do we test a GUI application in this uncertain environment?

One possibility is to fire the application up on as many different hardware platforms as we can, and check that each one performs acceptably.  This, of course, requires a _lot_ of different computers, so increasingly we see companies instead turning to _virtual machines_ - a program that _emulates_ the hardware of a different computer, possibly even running a different operating system!  In either case, we need a way to go through a series of checks to ensure that on each platform, our application is usable. 

How can we ensure rigor in this process?  Ideally we'd like to automate it, just as we do with our Unit tests... and while there have been some steps in this direction, the honest truth is we're just not there yet.  Currently, there is no substitute for human eyes - and human judgement - on the problem.  But humans are also notorious for loosing focus when doing the same thing repeatedly... which is exactly what this kind of testing _is_.  Thus, we develop _test plans_ to help with this process.  We'll take a look at those next.