---
title: "Adding Documentation Files"
pre: "12. "
weight: 120
date: 2018-08-24T10:53:26-05:00
---
When adding existing documentation files (i.e. UML documents) to your project, you may think adding them through Visual Studio's Solution Explorer would be the way to go.  However, this can lead to an unexpected issue.  Look closely at the example below:

![Bad Documentation Example](/images/b.12.1.png)

We can see the PDF has been added to the solution file in the Solution Explorer, and we can see its raw data open in the editing pane.  But take a close look at the Properties.  The file is located in the Downloads folder!  Since the file is not present in a folder managed by Git, **IT WILL NOT BE COMMITTED!**

The _ONLY_ way to get Git to track a file is to _PUT IT INTO A DIRECTORY TRACKED BY GIT_. Visual Studio's Solution Explorer does _NOT_ copy existing PDF files, it simply creates a virtual representation of the file within the solution that points to where that file exists on your filesystem.

## Open the Solution in File Explorer
To summarize, you must _move or copy_ the file you want to share into the solution directory using your operating system's file system, _NOT VISUAL STUDIO_.  Visual Studio typically places your projects in the directory `C:/Users/%username%/source/repos/%solutionname%/` where `%username%` is your Windows username and `%solutionname%` is your solution's name. If you asked Visual Studio to save your files in another location, you need to look there.

However, there is a quick way to open the exact solution folder from within Visual Studio.  Right-click the solution in the Solution Explorer and choose **Open Folder in File Explorer** from the context menu:

![Open Folder in File Explorer](/images/b.12.2.png)

Then you can use File Explorer to create your Documentation folder and place your documents:

![Copy File into Documentation Folder](/images/b.12.3.png)

Once the document is in place, you will need to [commit your changes]({{<ref "b-git-and-github/05-staging-and-committing#committing">}}) and [push them to GitHub]({{<ref "b-git-and-github/09-remote-repositories#pushing">}})