---
title: "Developmental Epistemology of Computer Programming"
pre: "6. "
weight: 60
date: 2018-08-24T10:53:26-05:00
---
Among these neo-Piagetian researchers was an group including Raymond Lister and Donna M. Teague whom applied these theories to the learning of computer science, formulating a theory Lister calls _The Developmental Epistemology of Computer Programming_. This theory describes the traits of programmers at each of the stages of development.  In particular, they use a student's ability to _trace_ code (explain line-by-line what it does) as a demarcation between stages.

<table>
  <tr>
    <th>Stage</th>
    <th>Traits</th>
  </tr>
  <tr>
    <td>Sensorimotor</td>
    <td>
      <ul>
        <li>Cannot trace code with >= 50% accuracy</li>
        <li>Dominant problem-solving strategy is trial and error</li>
      </ul>
    </td>
  </tr>
  <tr>
    <td>Preoperational</td>
    <td>
      <ul>
        <li>Can trace code with >= 50% accuracy</li>
        <li>Traces without abstracting any meaning from the code</li>
        <li>Cannot see relationships between lines of code</li>
        <li>Struggles to make effective use of diagrammatic abstractions of code</li> 
        <li>Dominant problem-solving strategy is quasi-random code changes and copious trial runs</li>
      </ul>
    </td>
  </tr>
  <tr>
    <td>Concrete Operational</td>
    <td>
      <ul>
        <li>Dominant problem-solving strategy is hasty design, futile patching</li>
        <li>Can establish purpose of code by working backwards from execution results</li>
        <li>Tends to reduce levels of abstraction to make concepts more understandable</li>
      </ul>
    </td>
  </tr>
  <tr>
    <td>Formal Operational</td>
    <td>
      <ul>
        <li>Uses hypothetico-deductive reasoning</li>
        <li>Reads code rather than traces to deduce purpose</li>
      </ul>
    </td>
  </tr>
</table>

These stages reflect the progress the learner is making through _accommodation_, creating the mental structures needed to reason about programming.  An expert has developed these structures, which reflect patterns in how code is written - that is why an expert no longer traces code - they can _see_ the patterns in the code and immediately grasp its action and purpose.  In contrast, the novice must deduce the result of each line of code, put those understandings together, and then deduce what it is doing overall.  

Writing a program is similar, the expert begins with a clear picture of the patterns she must employ, and focuses on fleshing those out, while a novice must create the program 'from whole cloth', reasoning out each step of the process.  They are not yet capable of reasoning about the program they are writing in the abstract.

This also helps explain why learning to program can be so hard.  Abstraction is considered a central tool in programming; we use abstractions constantly to simplify and make programs more understandable to other programmers.  Consider a higher-level programing language, like C#.  Each syntax element is an abstraction for a more complex machine-level process.  The statement:

```C# 
x += 2;
```

Stands in for machine instructions along the lines of:

```
PUSH REG5 TO REG1
PUSH 2 TO REG2
ADD REG1 AND REG2
PUSH REG3 TO REG5
```

Which are in turn, simplifications and abstractions of the actual process of adding the two binary values in register 1 and register 2 (remember studying binary math in CIS 115)?

Also, many of the productivity tools created to support expert programmers (i.e. automatic code completion) may actually _hamper_ your learning, as they alleviate the need to carry out part of the process you are learning.  Consider turning these features off in your development environment until you have developed fluency as a programmer. 

{{% notice info %}}
To turn off autocomplete in Visual Studio:
* From Visual Studio, select **"Tools" > "Options"**.
* Select **"Text Editor"** in the left pane.
* Select the language you are using (C#, C++, Basic, etc.).
* For C# and Basic, choose **"IntelliSense"**. For C or C++, choose **"Advanced"**, then scroll to the **"IntelliSense"** section.
* For C# and Basic, check the **"Show completion list after a character is typed"** to disable it. For C/C++, you will have a few options, such as **"Disable Auto Updating"**, **"Disable Squiggles"**, and **"Disable #include Auto Complete"**. Set any of these to **"True"** to turn them off.
{{% /notice %}}
