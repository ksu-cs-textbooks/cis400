+++
title = "Milestone 3 Requirements"
pre = "5. "
weight = 50
date = 2018-08-24T10:53:26-05:00
+++

{{% notice noiframe %}}
This textbook was authored for the **CIS 400 - Object-Oriented Design, Implementation, and Testing** course at Kansas State University.  This section describes assignments specific to the **Spring 2023** offering of that course.  Prior semester offerings can be found [here](old). If you are not enrolled in the course, please disregard this section.
{{% /notice %}}

For this milestone, you will be creating tests for the menu items you've written in previous milestones.

### General requirements:

* You need to follow the style laid out in the [C# Coding Conventions](https://docs.microsoft.com/en-us/dotnet/csharp/programming-guide/inside-a-program/coding-conventions)

* You need to document your code using [XML-style comments](https://docs.microsoft.com/en-us/dotnet/csharp/language-reference/xmldoc/recommended-tags), with a minimum of `<summary>` tags, plus `<param>`, `<returns>`, and `<exception>` as appropriate.  

### Assignment requirements:

You will need to create unit test classes for:
  * `FlyingSaucer` 
  * `CrashedSaucer`
  * `LivestockMutilation`
  * `OuterOmelette`
  * `CropCircle`
  * `GlowingHaystack`
  * `TakenBacon`
  * `MissingLinks`
  * `EvisceratedEggs`
  * `YoureToast`

### Purpose:

This milestone serves to practice writing tests utilizing the XUnit testing framework. If you have any confusion after you have read the entire assignment please do not hesitate to reach out to a Professor Bean, the TAs, or your classmates over Discord.

### Unit Test Classes
For each class in your `Data` project, add a corresponding unit test class in the `Test` project. These should use the same name as the `Data` class, with `UnitTest` appended, i.e. the unit tests for the `FlyingSaucer` class are found in the `FlyingSaucerUnitTests` class.  

Each unit test class should include fact or theory tests to verify:
* The default starting value of every property
* That constraints specified on the values of properties are adhered to
* The expected value of every derived property based on possible state combinations for the object.  If more than eight possibilities exist, at least eight must be specified by your `[InlineData]`

All of your tests should pass - if they do not, check to make sure your code being tested is correct, and also that your test is well-written.

To serve as a guide, the full unit tests for `FlyingSaucer` can be found in the `FlyingSaucerUnitTest` class in the Test project.

## Submitting the Assignment

Once your project is complete, merge your feature branch back into the `main` branch and [create a release]({{<ref "B-git-and-github/11-release">}}) tagged `v0.3.0` with name `"Milestone 3"`.  Copy the URL for the release page and submit it to the Canvas assignment.

## Grading Rubric

The grading rubric for this assignment will be:

**25% Structure** Did you implement the structure as laid out in the specification?  Are the correct names used for classes, enums, properties, methods, events, etc?  Do classes inherit from expected base classes?

**25% Documentation** Does every class, method, property, and field use the correct XML-style documentation?  Does every XML comment tag contain explanatory text?

**25% Design** Are you appropriately using C# to create reasonably efficient, secure, and usable software?  Does your code contain bugs that will cause issues at runtime?

**25% Functionality** Does the program do what the assignment asks?  Do properties return the expected values?  Do methods perform the expected actions?

{{% notice warning %}}
Projects that do not compile will receive an automatic grade of 0.
{{% /notice %}}
