---
title: "Feature Branches"
pre: "2. "
weight: 20
date: 2018-08-24T10:53:26-05:00
linenumbers: false
---

{{% notice noiframe %}}
This textbook was authored for the **CIS 400 - Object-Oriented Design, Implementation, and Testing** course at Kansas State University.  This section describes assignments specific to the **Fall 2022** offering of that course.  If you are not enrolled in the course, please disregard this section.
{{% /notice %}}

As we are creating a project iteratively this semester, it is a good chance to practice using _feature branches_ with Git. This is a skill you will likely need to use in your future development efforts and career, and it can help solve many problems you may otherwise encounter when developing a project iteratively.

## Using Remote-Tracking Feature Branches

In the GitHub section, we talked about both [feature branches]({{<ref "B-git-and-github/08-branches">}}) _and_ [remote repositories]({{<ref "B-git-and-github/09-remote-repositories">}}).  It is important to understand that when you create a branch, you do so in the _local_ (i.e. on your machine) repository.  

For example, if you wanted to create a feature branch for data milestone 1, you would use this Git command on your development machine:

```
$ git branch ms1
```

And then check it out using the command:

```
$ git checkout ms1
```

As you work you can add and commit as normal, i.e.:

```
$ git add . 
$ git commit -a -m "A description of what changed"
```

Any commits you make will be made on the feature branch `ms1`, not your main branch. 

## Pushing Feature Branches to GitHub

At this point, your feature branch, and any of its commits, are only on your _local_ machine.  If you want to make them available on your origin (GitHub) repository, you'll need to push them there.  You can do this with the command:

```
$ git push origin ms1
```

This creates a corresponding branch, `ms1` in your GitHub repository, and pushes all the changes from your local `ms1` branch to your GitHub one (which is often referred to as `origin/ms1`).

{{% notice warning %}}
The `git push` command pushes the _currently checked out_ local branch to the specified branch of the specified remote repository.  So if you have the local `ms1` branch checked out and push to the `origin` repo `ms1` branch, your two branches will be in sync.  

But if you have a different branch checked out, i.e. `ms2` and issue the command `git push origin ms1`, your local `ms2` changes will be applied to your remote `ms1` branch!

Likewise, if you specify a _different_ remote branch to push to, i.e. you have `ms1` checked out but use the command `git push origin master`, the changes from your local `ms1` branch will be applied to your remote `master` branch.

Thus, you should always be certain you are pushing to the correct branch.  You can check what branch is currently checked out with the command:

```
$ git branch  
```

This will list all local branches, and the currenlty checked out one will have an astrisk next to it (*).

{{% /notice %}}

Pushing a feature branch named in accordance with the guidelines (i.e. `ms1`, `ms2`) to your `origin` repository will trigger an evaluation by the Pendant tool if you have webhooks set up.  You can visit the tool at: <a href="https://pendant.cs.ksu.edu" target="_blank">https://pendant.cs.ksu.edu</a> to see the results.

### Pulling a Remote Feature Branch to Another Local Machine

The other big benefit to pushing your feature branches to GitHub is that you can then pull them into other local repos you have cloned on other machines.  For example, if you pushed your changes from a lab computer, you can pull those changes into a corresponding branch on your home PC.

However, there is one more step invovled the _first_ time you pull a new branch, as you will need a _local_ branch to correspond to it.  You can create that branch, _and_ set it up to track the remote branch, with a single command:

```
$ git checkout -b ms1 origin/ms1
```

This command creates a local branch `ms1` that _tracks_ the remote branch `origin/ms1`.  Because the local `ms1` branch now tracks `origin/ms1`, when you have it checked out, you can use the command:

```
$ git pull 
```

And git will pull from `origin/ms1` into the local `ms1` branch.  Alternatively, you can use the full command:

```
$ git pull origin ms1 
```

But you must again be careful that you are pulling the right corresponding branch.

### Merging your Feature Branch into Master

Finally, when you have finished the milestone, you'll want to merge your new changes from the feature branch into the main branch:

```
$ git checkout main 
$ git merge ms1 
```

And push the newly expanded main branch to GitHub:

```
$ git push origin main
```

After which you'll need to [create a release]({{<ref "b-git-and-github/11-release">}}) to turn in.