+++
title = "Milestone 1 Requirements"
pre = "3. "
weight = 30
date = 2018-08-24T10:53:26-05:00
+++

{{% notice noiframe %}}
This textbook was authored for the **CIS 400 - Object-Oriented Design, Implementation, and Testing** course at Kansas State University.  This section describes assignments specific to the **Spring 2023** offering of that course.  Prior semester offerings can be found [here](old). If you are not enrolled in the course, please disregard this section.
{{% /notice %}}

For this milestone, you are creating your first feature branch and release. You will repeat this process for every future milestone, so get it down now!

### General requirements:

* You need to follow the style laid out in the [C# Coding Conventions](https://docs.microsoft.com/en-us/dotnet/csharp/programming-guide/inside-a-program/coding-conventions)

### Assignment requirements:

You will need to:

1. Accept the GitHub assignment
2. Create a feature branch, make changes, and push your branch to GitHub
3. Merge your feature branch back into your main branch
4. Create and submit a release

### Purpose:

The purpose of this assignment is to set up your local repository, practice working with feature branches, and learn how to create and turn in a release.  These are all tasks that you will revisit with each milestone, so it pays to get comfortable with them now.

### Recommendations:

You'll likely want to come back and revisit the [feature branches]({{<ref "D-milestones/02-feature-branches">}}) as well as this page as you work on future assignments.

### Part 1 - Accept the GitHub Assignment and Clone your Repo

This part should be familiar from prior semesters.  Accept the GitHub classroom assignment (You can find the link in the assignment on Canvas).  Then clone the remote repository it creates to your development machine.  You can do this from Visual Studio's **File > Clone Repository...** option or from the command line with:

```
$ git clone [repoURL] 
```

{{% notice tip %}}
It is common practice to indicate a terminal cursor with the `$` - but it is _not_ part of the command.  You only need to type what comes after the `$` - in this case `git clone [repoURL]`.  Likewise `[repoURL]` should be replaced with your actual repository URL
{{% /notice %}}

Where `[repoURL]` is the clone repo from GitHub:

[The GitHub Clone URL](/images/b.3.1.png)

This task is covered in more detail in the section on [remote repositories]({{<ref "/B-git-and-github/09-remote-repositories">}})

### Part 2 - Create and Check Out a Local Feature Branch, Make and Commit Changes, and Push to GitHub

Once you have cloned your project to a local repo and set up your webhook, you are ready to create your first feature branch, `ms1` (for milestone 1).  I recommend doing this from the command line.  You can open a terminal in Visual Studio by visiting the **View > Terminal** menu option or by pressing the `CTRL` + backtick keys.  Then you can create your branch with the command:

```
$ git branch ms1
```

And check it out with the command:

```
$ git checkout ms1
```

From this point until you check out a different branch, any commits you make will be made to the `ms1` branch.

The changes you will need to make are adding two new classes to the `Data` project representing two additional entree options at the Flying Saucer, the Crashed Saucer (an order of French toast) and the Livestock Mutilation (an order of biscuits and gravy). The structure of these classes (along with the provided `FlyingSaucer` class) is detailed in the UML diagram below:

![The Additional Milestone 1 Classes](/images/d.s23.3.1.png)

The `CrashedSaucer` class should be defined in a file named _CrashedSaucer.cs_. The names of its properties and their expected values appear in the table below:

<table>
  <tr>
    <th>Property</th>
    <th>Accessors</th>
    <th>Type</th>
    <th>Value</th>
  </tr>
  <tr>
    <td>Name</td>
    <td>get only</td>
    <td>string</td>
    <td>"Crashed Saucer"</td>
  </tr>
  <tr>
    <td>Description</td>
    <td>get only</td>
    <td>string</td>
    <td>"A stack of crispy french toast smothered in syrup and topped with a pat of butter."</td>
  </tr>
  <tr>
    <td>Stack Size</td>
    <td>get and set</td>
    <td>uint</td>
    <td>Default of 2, no more than 6</td>
  </tr>
  <tr>
    <td>Syrup</td>
    <td>get and set</td>
    <td>bool</td>
    <td>Defaults to true</td>
  </tr>
  <tr>
    <td>Butter</td>
    <td>get and set</td>
    <td>bool</td>
    <td>Defaults to true</td>
  </tr>
  <tr>
    <td>Price</td>
    <td>get only</td>
    <td>decimal</td>
    <td>$6.45, plus an additional $1.50 for each additional slice beyond the default</td>
  </tr>
  <tr>
    <td>Calories</td>
    <td>get only</td>
    <td>uint</td>
    <td>149 per slice of french toast, plus 52 calories if syrup is included, and 35 calories if butter is included</td>
  </tr>
  <tr>
    <td>SpecialInstructions</td>
    <td>get only</td>
    <td>IEnumerable&langle;string&rangle;</td>
    <td>Should include: 
      <ul>
        <li>"[n] slices" with [n] being the number of slices when it is not the default 2</li>
        <li>"Hold Butter" if Butter is false</li>
        <li>"Hold Syrup" if Syrup is false</li>
      </ul>
    </td>
</table>

The `LivestockMutilation` class should be defined in a file named _LivestockMutilation.cs_. The names of its properties and their expected values appear in the table below:

<table>
  <tr>
    <th>Property</th>
    <th>Accessors</th>
    <th>Type</th>
    <th>Value</th>
  </tr>
  <tr>
    <td>Name</td>
    <td>get only</td>
    <td>string</td>
    <td>"Livestock Mutilation"</td>
  </tr>
  <tr>
    <td>Description</td>
    <td>get only</td>
    <td>string</td>
    <td>"A hearty serving of biscuits, smothered in sausage-laden gravy."</td>
  </tr>
  <tr>
    <td>Biscuits</td>
    <td>get and set</td>
    <td>uint</td>
    <td>Defaults to 3, maximum of 8</td>
  </tr>
  <tr>
    <td>Gravy</td>
    <td>get and set</td>
    <td>bool</td>
    <td>Defaults to true</td>
  </tr>
  <tr>
    <td>Price</td>
    <td>get only</td>
    <td>decimal</td>
    <td>$7.25 + $1.00 per biscuit beyond 3.</td>
  </tr>
  <tr>
    <td>Calories</td>
    <td>get only</td>
    <td>uint</td>
    <td>49 per biscuit, plus 140 calories for gravy</td>
  </tr>
  <tr>
    <td>SpecialInstructions</td>
    <td>get only</td>
    <td>IEnumerable&langle;string&rangle;</td>
    <td>Should include: 
      <ul>
        <li>"[n] biscuits" with [n] being the number of biscuits when it is not the default 3</li>
        <li>"Hold Gravy" if Gravy is false</li>
      </ul>
    </td>
</table>

Because you have made changes to the project, it is a good idea to run your tests and make sure you didn't inadvertently break another feature (we'd normally also add new tests for what you added, but we'll cover that later in the semester).

Once you have done so, you will want to add the new files to those staged for a commit with:

```
$ git add .
```

Then you can commit your changes with:

```
$ git commit -a -m "Added the CrashedSaucer and LivestockMutilation classes"
```

Finally, you want to push this commit to your remote branch, `origin/ms1`.  You can do this with the command:

```
$ git push origin ms1
```

The first time you do this, it will also create the `origin/ms1` branch on GitHub.

You can also commit and push changes _before_ you've finished working on your new classes.  This is especially helpful if you need to stop working - it backs up your files in in case something happens.  Likewise, if you want to start working on a different machine (say moving from lab to home), you can pull the latest version of your code from GitHub.

{{% notice tip %}}
If you need to pull this remote branch into another local repo (say you created the branch in the lab but now you are on your home computer), the process is covered in the [previous section]({{<ref "../02-feature-branches#pulling-a-remote-feature-branch-to-another-local-machine">}})
{{% /notice %}}

### Part 3 - Merging your Feature Branch and Submitting to GitHub

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
Unless you have made changes to your `main` branch in the meantime, this should go smoothly.  If you have changed `main` as well, it is possible that Git may encounter a section of code where changes have been made on both branches, and it is uncertain of how to merge them.  In this case you will need to [resolve the merge conflicts]{{<ref "/B-git-and-github/10-merge-conflicts">}} and create a new commit with the resolution before moving on.
{{% /notice %}}

Now you can push your `main` branch to GitHub:

```
$ git push origin main
```

Now [create a release]({{<ref "/B-git-and-github/11-release">}}) tagged `v0.1.0` with name `"Milestone 1"`.  Copy the URL for the release page and submit it to the Canvas assignment.