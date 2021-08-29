---
title: "Milestone 1 Requirements"
pre: "3. "
weight: 30
date: 2018-08-24T10:53:26-05:00
---

For this milestone, you are connecting your GitHub account to the Pendant Web App and creating your first feature branch and release.

### General requirements:

* You need to follow the style laid out in the [C# Coding Conventions](https://docs.microsoft.com/en-us/dotnet/csharp/programming-guide/inside-a-program/coding-conventions)

### Assignment requirements:

You will need to:

1. Accept the GitHub assignment
2. Link your GitHub account with Pendant 
3. Create a feature branch, make changes, and push your branch to GitHub
4. Create and submit a release

### Purpose:

The purpose of this assignment is to set up your local repository, practice working with feature branches, and learn how to create and turn in a release.  These are all tasks that you will revisit with each milestone, so it pays to get comfortable with them now.

### Recommendations:

Unlike future milestones, this milestone should not take very long to complete, provided you follow the steps outlined.  You'll likely want to come back and revisit the [feature branches]({{<ref "D-milestones-f21/02-feature-branches">}}) as well as this page as you work on future assignments.

### Part 1 - Accept the GitHub Assignment and Clone your Repo

This part should be familiar from prior semesters.  Accept the GitHub classroom assignment (You can find the link in the assignment on Canvas).  Then clone the remote repository it creates to your development machine.  You can do this from Visual Studio's **File > Clone Reposiotory...** option or from the command line with:

```
$ git clone [repoURL] 
```

{{% notice tip %}}
It is common practice to indicate a terminal cursor with the `$` - but it is _not_ part of the command.  You only need to type what comes after the `$` - in this case `git clone [repoURL]`.  Likewise `[repoURL]` should be replaced with your actual repository URL
{{% /notice %}}

Where `[repoURL]` is the clone repo from GitHub:

[The GitHub Clone URL]({{<static "images/b.3.1.png">}})

This task is covered in more detail in the section on [remote repositories]({{<ref "B-git-and-github/09-remote-repositories">}})

### Part 2 - Linking your GitHub Account with Pendant 

For this part of the assignment, you will need to visit https://pendant.cs.ksu.edu, log in with your K-State EID and Password, and visit the **GitHub** section.  

There you will need to click the button **Link your GitHub Account** and approve the request to authorize the Pendant application to use your GitHub account's public data.

After that, you will set up a webhook on your GitHub repo using the secret provided by Pendant.

This is covered step-by-step in the video:

<iframe width="560" height="315" src="https://www.youtube.com/embed/dvwnwn6Qy3w" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

### Part 3 - Create a Local Feature Branch, Make and Commit Changes, and Push to GitHub

Once you have cloned your project to a local repo and set up your webhook, you are ready to create your first feature branch, `ms1` (for milestone 1).  I recommend doing this from the command line.  You can open a terminal in Visual Studio by visiting the **View > Terminal** menu option or by pressing the `CTRL` + backtick keys.  Then you can create your branch with the command:

```
$ git branch ms1
```

And check it out with the command:

```
$ git checkout ms1
```

From this point until you check out a different branch, any commits you make will be made to the `ms1` branch.

The change you will need to make is to add a readonly `Name` property of type `string` to the `AquariusIce` class.  Once you have done so, you can commit your changes with:

```
$ git commit -a -m "Added the Name property to AquariusIce"
```

{{% notice note %}}
It is a common workflow to run the command:

```
$ git add . 
```

Before committing files.  This adds any newly-created files to tracking.  Here, we had no new files, so we could skip this step.  

Note that the Visual Studio GUI interface combines the two commands.
{{% /notice %}}

Finally, you want to push this commit to your remote branch, `origin/ms1`.  You can do this with the command:

```
$ git push origin ms1
```

The first time you do this, it will also create the `origin/ms1` branch on GitHub.

This push will also trigger the webhook you created in step 2.  You can visit https://pendant.cs.ksu.edu/Validations to see your feedback.  If you've missed something, you can make changes and do another commit and push.

{{% notice tip %}}
If you need to pull this remote branch into another local repo (say you created the branch in the lab but now you are on your home computer), the process is covered in the [previous section]({{<ref "D-milestones-f21/02-feature-branches#pulling-a-remote-feature-branch-to-another-local-machine">}})
{{% /notice %}}

### Part 4 - Merging your Feature Branch and Submitting to GitHub

Once you are happy with your code on your feature branch, it is time to merge it into the `main` branch and create a release.  First, double-check that all changes have been committed by running the command:

```
$ git status
```

You should see the message `"nothing to commit, working tree clean"`.  If you don't add and commit any changes before moving on.

Then switch back to the `main` branch with:

```
$ git checkout main
```

And merge your `ms1` branch changes into the `main` branch with:

```
$ git merge ms1
```

After this, your `main` branch contains all the code changes from your `ms1` branch.  

{{% notice note %}}
Unless you have made changes to your `main` branch in the meantime, this should go smoothly.  If you have changed `main` as well, it is possible that Git may encounter a section of code where changes have been made on both branches, and it is uncertain of how to merge them.  In this case you will need to [resolve the merge conflicts]{{<ref "B-git-and-github/10-merge-conflicts">}} and create a new commit with the resolution before moving on.
{{% /notice %}}

Now you can push your `main` branch to GitHub:

```
$ git push origin main
```

And [create a release]({{<ref "B-git-and-github/11-release">}}) tagged `v0.1.0` with name `"Milestone 1"`.  Copy the URL for the release page and submit it to the Canvas assignment.