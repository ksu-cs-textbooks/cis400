---
title: "Feature Branches"
pre: "10. "
weight: 100
date: 2018-08-24T10:53:26-05:00
---

This section summarizes the git commands you will need when creating feature branches for your semester-long project.

## 1. Create and check out a local branch for the current milestone

When you start a new milestone, you need to create a local branch to hold your work. For example, if you wanted to create a feature branch for Milestone 0, you would do:

```
$ git branch ms0
```

Next, check out your new branch. For our Milestone 0, we would do:

```
$ git checkout ms0
```

## 2. Work on the new branch

As you make progress on the current milestone, it is a good idea to add your changes to the remote repository. First, make sure you are on your milestone branch by doing:

```
$ git branch
```

You will see a list of all local branches, with a `*` next to the currently checked out branch. You should see that the branch for the current milestone has a `*`. Then, add, commit, and push the changes for your branch to the remote repository:

```
$ git add .
$ git commit -m "description of changes"
$ git push
```

The first time you do this, it will automatically create a remote branch with the same name.

{{% notice info %}}
Depending on your `git` configuration, you may get this error when you `git push` or `git pull` on a local branch that has no remote counterpart:

```
fatal: The current branch <branchName> has no upstream branch.
To push the current branch and set the remote as upstream, use

    git push --set-upstream origin <branchName>

To have this happen automatically for branches without a tracking
upstream, see 'push.autoSetupRemote' in 'git help config'.
```

If you get this error, you can update your git configuration as follows:

```
git config --global push.autoSetupRemote true
```

At that point you should be able to use `git push` and have it go automatically to the corresponding remote branch.


(If you still have errors, you will first need to update your version of git to get a version that is at least 2.37 -- you can check the version number with `git --version`.)

```
git push origin <branchName>
```

On subsequent pushes of that branch, you should be able to simply the command to: `git push`.
{{% /notice %}}



## 3. Continuing work on a different computer

Suppose you followed the steps above to start a milestone on your home computer (including pushing the latest changes for your milestone branch) and wanted to continue working on a lab computer.

### First time working with the repository
If this was your FIRST time working on this repository on the new computer, you would need to clone the repository to the new local machine. You can do this with Visual Studio's _File->Clone Repository_ or from the terminal with `git clone [repoURL]`. In this case, ALL branches of your remote repository would be cloned to the new local machine.

### First time working with current branch
If you have worked with this repository before on the current local computer but have not worked with the new milestone branch, you must first create the new branch:

```
$ git branch ms0
```

Replacing `ms0` with the current milestone branch. If the branch had already been created, you will see an error message (but nothing will happen).

### In all cases
Next, checkout the current milestone branch:

```
$ git checkout ms0
```

Again, replacing `ms0` with the current milestone branch. Then, pull the latest changes for that branch from the remote repository to the local repository. If you do:

```
$ git pull origin ms0
```

It will pull from the remote `ms0` branch into the local `ms0` branch.

## Merging your feature branch into main

Finally, when you have finished the milestone, you'll want to merge your new changes from the feature branch into the main branch:

```
$ git checkout main 
$ git merge ms0
```

(Again, replacing `ms0` with the current milestone branch name). Next, push the newly expanded main branch to GitHub:

```
$ git push origin main
```

After that, you'll need to [create a release]({{<ref "b-git-and-github/12-release">}}) to turn in.