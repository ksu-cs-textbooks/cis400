---
title: "Feature Branches"
pre: "10. "
weight: 100
date: 2018-08-24T10:53:26-05:00
---

## Using Remote-Tracking Feature Branches

In the previous sections, we talked about both feature branches _and_ remote repositories.  It is important to understand that when you create a branch, you do so in the _local_ (i.e. on your machine) repository.  

For example, if you wanted to create a feature branch for milestone 0, you would use this Git command on your development machine:

```
$ git branch ms0
```

And then check it out using the command:

```
$ git checkout ms0
```

As you work you can add and commit as normal, i.e.:

```
$ git add . 
$ git commit -m "A description of what changed"
```

Any commits you make will be made on the feature branch `ms0`, not your main branch. 

## Pushing Feature Branches to GitHub

At this point, your feature branch, and any of its commits, are only on your _local_ machine.  If you want to make them available on your origin (GitHub) repository, you'll need to push them there.  You can do this with the command:

```
$ git push origin ms0
```

This creates a corresponding branch, `ms0` in your GitHub repository, and pushes all the changes from your local `ms0` branch to your GitHub one (which is often referred to as `origin/ms0`).

{{% notice warning %}}
The `git push` command pushes the _currently checked out_ local branch to the specified branch of the specified remote repository.  So if you have the local `ms0` branch checked out and push to the `origin` repo `ms0` branch, your two branches will be in sync.  

But if you have a different branch checked out, i.e. `ms1` and issue the command `git push origin ms0`, your local `ms1` changes will be applied to your remote `ms0` branch!

Likewise, if you specify a _different_ remote branch to push to, i.e. you have `ms0` checked out but use the command `git push origin main`, the changes from your local `ms0` branch will be applied to your remote `main` branch.

Thus, you should always be certain you are pushing to the correct branch.  You can check what branch is currently checked out with the command:

```
$ git branch  
```

This will list all local branches, and the currenlty checked out one will have an astrisk next to it (*).
{{% /notice %}}

### Pulling a Remote Feature Branch to Another Local Machine

The other big benefit to pushing your feature branches to GitHub is that you can then pull them into other local repos you have cloned on other machines.  For example, if you pushed your changes from a lab computer, you can pull those changes into a corresponding branch on your home PC.

However, there is one more step involved the _first_ time you pull a new branch, as you will need a _local_ branch to correspond to it.  You can create that branch, _and_ set it up to track the remote branch, with a single command:

```
$ git checkout -b ms0 origin/ms0
```

This command creates a local branch `ms0` that _tracks_ the remote branch `origin/ms0`.  Because the local `ms0` branch now tracks `origin/ms0`, when you have it checked out, you can use the command:

```
$ git pull 
```

And git will pull from `origin/ms0` into the local `ms0` branch.  Alternatively, you can use the full command:

```
$ git pull origin ms0
```

But you must again be careful that you are pulling the right corresponding branch.

### Merging your Feature Branch into Master

Finally, when you have finished the milestone, you'll want to merge your new changes from the feature branch into the main branch:

```
$ git checkout main 
$ git merge ms0
```

And push the newly expanded main branch to GitHub:

```
$ git push origin main
```

After which you'll need to [create a release]({{<ref "b-git-and-github/13-release">}}) to turn in.