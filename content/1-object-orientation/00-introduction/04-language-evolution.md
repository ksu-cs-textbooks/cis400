---
title: "Language Evolution"
pre: "4. "
weight: 40
date: 2018-08-24T10:53:26-05:00
---

One of the strategies that computer scientists employed to counter the software crisis was the development of new programing languages.  These new languages would often 1) adopt new techniques intended to make errors harder to make while programming, and 2) remove problematic features that had existed in earlier languages.  

## A Fortran Example
Let's take a look at a working (and in current use) program built using Fortran, one of the most popular programming languages at the onset of the software crisis.  This software is the Environmental Policy Integrated Climate (EPIC) Model, created by researchers at Texas A&M:

<blockquote>
Environmental Policy Integrated Climate (EPIC) model is a cropping systems model that was developed to estimate soil productivity as affected by erosion as part of the Soil and Water Resources Conservation Act analysis for 1980, which revealed a significant need for improving technology for evaluating the impacts of soil erosion on soil productivity.  EPIC simulates approximately eighty crops with one crop growth model using unique parameter values for each crop.  It predicts effects of management decisions on soil, water, nutrient and pesticide movements, and their combined impact on soil loss, water quality, and crop yields for areas with homogeneous soils and management. 
<a href="https://epicapex.tamu.edu/epic/">EPIC Homepage</a>
</blockquote>

You can download the [raw source code](https://my.syncplicity.com/share/qkybbapeauicx0l/epic1102_code%20032819) and the [accompanying documentation](https://agrilifecdn.tamu.edu/epicapex/files/2015/05/EpicModelDocumentation.pdf).  Open and unzip the source code, and open a file at random using your favorite code editor.  See if you can determine what it does, and how it fits into the overall application.  

Try this with a few other files.  What do you think of the organization?  Would you be comfortable adding a new feature to this program?

## New Language Features
You probably found the Fortran code in the example difficult to wrap your mind around - and that's not surprising, as more recent languages have moved away from many of the practices employed in Fortran.  Additionally, our computing environment has dramatically changed since this time.  

### Symbol Character Limits
One clear example is symbol names for variables and procedures (functions) - notice that in the Fortran code they are typically short and cryptic: `RT`, `HU`, `IEVI`, `HUSE`, and `NFALL`, for example.  You've been told since your first class that variable and function names should express clearly what the variable represents or a function does.  Would `rainFall`, `dailyHeatUnits`, `cropLeafAreaIndexDevelopment`, `CalculateWaterAndNutrientUse()`, `CalculateConversionOfStandingDeadCropResidueToFlatResidue()` be easier to decipher? (Hint: the documentation contains some of the variable notations in a list starting on page 70, and some in-code documentation of global variables occurs in *MAIN_1102.f90*.).

Believe it or not, there was an actual _reason_ for short names in these early programs.  A six character name would fit into a 36-bit register, allowing for fast dictionary lookups - accordingly, early version of FORTRAN enforced a limit of six characters for variable names[^namelength]. However, it is easy to replace a symbol name with an automatically generated symbol during compilation, allowing for _both_ fast lookup and human readability at a cost of some extra computation during compilation.  This step is built into the compilation process of most current programming languages, allowing for arbitrary-length symbol names with no runtime performance penalty.

[^namelength]: Weishart, Conrad (2010). ["How Long Can a Data Name Be?"](https://www.idinews.com/history/nameLength.html)

### Structured Programming Paradigm
Another common change to programming languages was the removal of the `GOTO` statement, which allowed the program execution to jump to an arbitrary point in the code (much like a [choose-your-own adventure](https://en.wikipedia.org/wiki/Choose_Your_Own_Adventure) book will direct you to jump to a page). The GOTO came to be considered too primitive, and too easy for a programmer to misuse [^goto]. 

[^goto]: Dijkstra, Edgar (1968). ["Go To Statement Considered Harmful"](https://homepages.cwi.nl/~storm/teaching/reader/Dijkstra68.pdf)

However, the actual _functionality_ of a `GOTO` statement remains in higher-order programming languages, abstracted into control-flow structures like conditionals, loops, and switch statements.  This is the basis of [structured programming](https://en.wikipedia.org/wiki/Structured_programming), a paradigm adopted by all modern higher-order programming languages. Each of these control-flow structures can be represented by careful use of `GOTO` statements (and, in fact the resulting assembly code from compiling these languages does just that). The benefit of using structured programming is it promotes "reliability, correctness, and organizational clarity" by clearly defining the circumstances and effects of code jumps [^wirth1974].

[^wirth1974]: Wirth, Nicklaus (1974). ["On the Composition of Well-Structured Programs"](https://oberoncore.ru/_media/library/wirth_on_the_composition_of_well-structured_programs.pdf)

### Object-Orientation Paradigm
The object-orientation paradigm was similarly developed to make programming large projects easier and less error-prone.  We'll examine just how it seeks to do so in the next few chapters.  But before we do, you might want to see how language popularity has fared since the onset of the software crisis, and how new languages have appeared and grown in popularity in this animated chart from _Data is Beautiful_:

<iframe width="560" height="315" src="https://www.youtube-nocookie.com/embed/Og847HVwRSI" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

Interestingly, the four top languages in 2019 (Python, JavaScript, Java, and C#) all adopt the object-oriented paradigm - though the exact details of how they implement it vary dramatically.

The term "Object Orientation" was coined by Alan Kay while he was a graduate student in the late 60's. Alan Kay, Dan Ingalls, Adele Goldberg, and others created the first object-oriented language, [Smalltalk](https://en.wikipedia.org/wiki/Smalltalk), which became a very influential language from which many ideas were borrowed.  To Alan, the essential core of object-orientation was three properties a language could possess: [^Elliot2018]

* Encapsulation
* Message passing
* Dynamic binding

[^Elliot2018]: Eric Elliot, "The Forgotten History of Object-Oriented Programming," _Medium_, Oct. 31, 2018.

We'll take a look at each of these in the next few chapters.