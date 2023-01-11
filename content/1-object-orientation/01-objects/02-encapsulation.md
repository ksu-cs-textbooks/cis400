---
title: "Encapsulation"
pre: "2. "
weight: 2
date: 2018-08-24T10:53:26-05:00
---

The first criteria that Alan Kay set for an object-oriented language was _encapsulation_.  In computer science, the term encapsulation refers to organizing code into units.  This provides a mechanism for organizing complex software

A second related idea is _information hiding_, which provides mechanisms for controlling access to encapsulated data and how it can be changed.

Think back to the FORTRAN EPIC model we [introduced earlier]({{<ref "1-object-orientation/00-introduction/04-language-evolution">}}). All of the variables in that program were declared _globally_, and there were _thousands_.  How easy was it to find where a variable was declared?  Initialized?  Used?  Are you sure you found _all_ the spots it was used?

Also, how easy was it to determine what _part_ of the system a particular block of code belonged to?  If I told you the program involved modeling hydrology (how water moves through the soils), weather, erosion, plant growth, plant residue decomposition, soil chemistry, planting, harvesting, and chemical applications, would you be able to find the code for each of those processes?

Remember from our discussion on [the growth of computing]({{<ref "1-object-orientation/00-introduction/02-the-growth-of-computing">}}) the idea that as computers grew more powerful, we wanted to use them in more powerful ways?  The EPIC project grew from that desire - what if we could model _all the aspects influencing how well a crop grows_?  Then we could use that model to help us make better decisions in agriculture.  Or, what if we could model all the processes involved in weather?  If we could do so, we could help save lives by predicting dangerous storms!  A century ago, you knew a tornado was coming when you heard its roaring winds approaching your home.  Now we have warnings that conditions are favorable to produce one hours in advance.  This is all thanks to using computers to model some very complex systems.

But how do we go about writing those complex systems?  I don't know about you, but I wouldn't want to write a model the way the EPIC programmers did.  And neither did most software developers at the time - so computer scientists set out to define better ways to write programs.  David Parnas formalized some of the best ideas emerging from those efforts in his 1972 paper "On the Criteria To Be Used in Decomposing Systems into Modules". [^Parnas1972]

[^Parnas1972]: D. L. Parnas, ["On the criteria to be used in decomposing systems into modules"](https://dl-acm-org.er.lib.k-state.edu/doi/10.1145/361598.361623) _Communications of the ACM_, Dec. 1972.

<blockquote>
A <i>data structure</i>, its internal linkings, <i>accessing procedures and modifying procedures</i> are part of a single module.  
</blockquote>

Here he suggests organizing code into _modules_ that group related variables and the procedures that operate upon them.  For the EPIC module, this might mean all the code related to weather modeling would be moved into its own module.  That meant that if we needed to understand how weather was being modeled, we _only_ had to look at the weather module.

<blockquote>
They are not shared by many modules as is conventionally done. 
</blockquote>

Here he is laying the foundations for the concept we now call [scope](https://en.wikipedia.org/wiki/Scope_(computer_science)) - the idea of where a specific symbol (a variable or function name) is accessible within a program's code.  By limiting access to variables to the scope of a particular module, only code in that module can change the value.  That way, we can't accidentally change a variable declared in the weather module from the soil chemistry module (which would be a very hard error to find, as if the weather module doesn't seem to be working, that's what we would probably focus on trying to fix).

Programmers of the time referred to this practice as [information hiding](https://en.wikipedia.org/wiki/Information_hiding), as we 'hid' parts of the program from other parts of the program. Parnas and his peers pushed for not just hiding the data, but _also_ how the data was manipulated.  By hiding these implementation details, they could prevent programmers who were used to the globally accessible variables of early programming languages from looking into our code and using a variable that we might change in the future.

<blockquote>
<i>The sequence of instructions necessary to call a given routine and the routine itself are part of the same module.</i>
</blockquote>

As the actual implementation of the code is hidden from other parts of the program, a mechanism for sharing controlled access to some part of that module in order to use it needed to be made.  An interface, if you will, that describes how the other parts of the program might trigger some behavior or access some value.

