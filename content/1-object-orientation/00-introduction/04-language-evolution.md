---
title: "Language Evolution"
pre: "4. "
weight: 40
date: 2018-08-24T10:53:26-05:00
---

One of the strategies that computer scientists employed to counter the software crisis was the development of new programming languages.  These new languages would often 1) adopt new techniques intended to make errors harder to make while programming, and 2) remove problematic features that had existed in earlier languages.  

## A Fortran Example
Let's take a look at a working (and in current use) program built using Fortran, one of the most popular programming languages at the onset of the software crisis.  This software is the Environmental Policy Integrated Climate (EPIC) Model, created by researchers at Texas A&M:

<blockquote>
Environmental Policy Integrated Climate (EPIC) model is a cropping systems model that was developed to estimate soil productivity as affected by erosion as part of the Soil and Water Resources Conservation Act analysis for 1980, which revealed a significant need for improving technology for evaluating the impacts of soil erosion on soil productivity.  EPIC simulates approximately eighty crops with one crop growth model using unique parameter values for each crop.  It predicts effects of management decisions on soil, water, nutrient and pesticide movements, and their combined impact on soil loss, water quality, and crop yields for areas with homogeneous soils and management. 
<a href="https://epicapex.tamu.edu/epic/">EPIC Homepage</a>
</blockquote>

You can download the raw source code [here](https://epicapex.tamu.edu/software/) (click "EPIC v.1102" under "Source Code"). Open and unzip the source code, and open a file at random using your favorite code editor.  See if you can determine what it does, and how it fits into the overall application.  

Try this with a few other files.  What do you think of the organization?  Would you be comfortable adding a new feature to this program?

## New Language Features
You probably found the Fortran code in the example difficult to wrap your mind around - and that's not surprising, as more recent languages have moved away from many of the practices employed in Fortran.  Additionally, our computing environment has dramatically changed since this time.  

### Symbol Character Limits
One clear example is symbol names for variables and procedures (functions) - notice that in the Fortran code they are typically short and cryptic: `RT`, `HU`, `IEVI`, `HUSE`, and `NFALL`, for example.  You've been told since your first class that variable and function names should express clearly what the variable represents or a function does.  Would `rainFall`, `dailyHeatUnits`, `cropLeafAreaIndexDevelopment`, `CalculateWaterAndNutrientUse()`, `CalculateConversionOfStandingDeadCropResidueToFlatResidue()` be easier to decipher? (Hint: the documentation contains some of the variable notations in a list starting on page 70, and some in-code documentation of global variables occurs in *MAIN_1102.f90*.).

Believe it or not, there was an actual _reason_ for short names in these early programs.  A six character name would fit into a 36-bit register, allowing for fast dictionary lookups - accordingly, early version of FORTRAN enforced a limit of six characters for variable names. However, it is easy to replace a symbol name with an automatically generated symbol during compilation, allowing for _both_ fast lookup and human readability at a cost of some extra computation during compilation.  This step is built into the compilation process of most current programming languages, allowing for arbitrary-length symbol names with no runtime performance penalty.

<!-- TODO: Type Checking, Linting -->

## Paradigm Shifts

In addition to these less drastic changes, some evolutionary language changes had sweeping effects, changing the way we approach and think about how programs should be written and executed. These "big ideas" of how programming languages should work are often called _paradigms_.  In the early days of computing, we had two common ones: _imperative_ and _functional_.

At its core, imperative programming simply means the idea of writing a program as a sequence of commands, i.e. this Python script uses a sequence of commands to write to a file:

```python
f = open("example.txt")
f.write("Hello from a file!")
f.close()
```

An imperative program would start executing the first line of code, and then continue executing line-by-line until the end of the file or a command to stop execution was reached. In addition to moving one line through the program code, imperative programs could jump to a specific spot in the code and continue execution from there, using a `GOTO` statement.  We'll revisit that aspect shorty.

In contrast, functional programming consisted primarily of functions. One function was designated as the 'main' function that would start the execution of the program. It would then call one or more functions, which would in turn call more functions. Thus, the entire program consisted of function definitions. Consider this Python program:

```python
def concatenateList(str, list):
  if(len(list) == 0):
    return str
  elif(len(list) == 1):
    head = list.pop(0)
    return concatenateList(str + head, list)
  else:
    head = list.pop(0)
    return concatenateList(str + head + ", ", list)

def printToFile(filename, body):
  f = open(filename)
  f.write(body)

def printListToFile(filename, list):
  body = concatenateList("", list)
  printToFile(filename, body)

def main():
  printListToFile("list.txt", ["Dog", "Cat", "Mouse"])

main()
```
You probably see elements of your favorite higher-order programming language in both of these descriptions.  That's not surprising as modern languages often draw from multiple programming paradigms (after all, both the above examples were written in Python). This, too, is part of language evolution - language developers borrow good ideas as they find them.

But as languages continued to evolve and language creators sought ways to make programming easier, more reliable, and more secure to address the software crisis, new ideas emerged that were large enough to be considered new paradigms. Two of the most impactful of these new paradigms these are _structured programming_ and _object orientation_.  We'll talk about each next.