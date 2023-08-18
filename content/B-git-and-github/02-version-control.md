---
title: "Version Control Software"
pre: "2. "
weight: 2
date: 2018-08-24T10:53:26-05:00
---

Have you ever been working on a paper for a class, and stopped every now and then to save it under a slightly different name, i.e. "Paper draft 1.docx", "Paper draft 2.docx", "Paper final draft.docx", "Paper final draft with Merge suggestions.docx", and so on?

Effectively what you were doing was _version control_ - keeping old copies of a project around. This can be a lifesaver if your current file gets corrupted and becomes unusable.  It can also be helpful to go back and see older versions, perhaps to see what a section looked like _before_ your last set of changes.  It might also be handy if that last major revision just isn't working, and you want to go back to what the paper looked like _before_ you started making changes.

Now think about programming projects, which involve _multiple_ files.  You could copy your project directory and rename it... but it's a lot of effort, and also chews up memory on your computer.  And have you ever found those multiple folders/files become difficult to navigate and sort through?  Also, what happens if your entire _computer_ gets trashed?  Or stolen?  Where are you with your multiple copies of files/directories then?

Version control software was invented to help solve these problems, along with one more pressing issue - working with others and _sharing_ those code files between everyone on the team.  No doubt you probably have or have heard some horror stories from CIS 115 or other courses were one member of the team accidentally overwrote the content that the rest of the team had painstakingly added to the group's Wiki page...

Ideal version control software therefore:
* Provides a mechanism for saving incremental changes to a project 
* Allows you to easily revert back to an earlier version of the project 
* Can be used to back up the project to a separate machine/location (preferably with some geographic distance, so if your workplace is destroyed by fire, flood, or other disaster your work isn't forever lost)
* Allows different team members to contribute to a shared project without overwriting your teammates' work