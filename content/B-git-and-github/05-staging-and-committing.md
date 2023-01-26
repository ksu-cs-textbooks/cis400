---
title: "Staging and Committing"
pre: "5. "
weight: 5
date: 2018-08-24T10:53:26-05:00
---

{{<youtube isp3dsbZjss>}}

It is important to understand that Git doesn't save the changes to _every_ file in the directory when you create a commit - it only saves those files you have _staged_ to be committed. This extra step often confuses new Git users, but it exists to give you full control over what gets committed into your repository.

![Staging Diagram](/images/b.5.3.png)

It may help to understand how Git thinks about files.  Files in your repository directory fall into one of five categories - _untracked_, _unstaged_, _staged_, _committed_, and _ignored_.  

_Untracked_ files are those that have never been added to the repository.  As far as the repository is concerned, they don't exist.  If you were to delete one, you cannot restore it, as the repository has no saved version of it.  Mostly these are files that have recently been created.

_Unstaged_ files are those that are tracked, but have at least some changes that have not been committed.  These are either new files that have just been added to the repository's index with a **git add** command, or files that have been altered since the last commit.

_Staged_ files are those that will be included in the next commit.  They are added to the list of staged files with the **git add** command, and will be committed with the **git commit** command.

_Committed_ files are those whose current state has been saved as a commit.  In other words, they are "safe" as they can be restored from that commit with a **git checkout** command.

_Ignored_ files are those whose path matches the pattern in the _.gitignore_ file.  We'll come back to this idea shortly.

You can check for the status of your files in the repository at any time with the **git status** command:

```
$ git status 
```

This will print the status of all uncommitted files:

![The output of git status](/images/b.5.1.png)

There are four files in the _ff_ directory: _example0.txt_, _example1.txt_, _example2.txt_, and _example3.txt_. In the output above, we see:

* _example0.txt_ was committed at some point, but now has changes.  Git helpfully lets us know we can undo those changes and restore the committed version with the command `$ git checkout -- example0.txt`, or add this file to those staged with `$ git add example0.txt`.
* _example1.txt_ does not appear in the status message, as it is already committed and has no changes.
* _example2.txt_ is a new file (it has never been committed), and is staged to be committed.
* _example3.txt_ is also a new file, but is not staged to be committed.

Interestingly, you can still change a staged file.  If you do so, Git keeps track of the staged but not committed changes, _and_ the new, unstaged modifications.  For example, if we change _example2.txt_ and run **git status** again, we'll see:

![The output of git status](/images/b.5.2.png)

Notice _example2.txt_ now has _two_ statuses - corresponding to the staged and unstaged changes!

### Committing Changes 

With this understanding in mind, the standard way of committing changes is to combine a **git add** command and a **git commit** command:

```
$ git add .
$ git commit -a -m "<a message about the commit>"
```

The `git add .` adds _all_ untracked and unstaged files (making them _staged_), and `git commit -a` commits all staged or unstaged files.  If you only want to add _some_ files, you can add them individually as we did above, by specifying the path (i.e. `git commit path/to/a/file.txt`) and omit the `-a` in the commit command so only those staged will be committed.  