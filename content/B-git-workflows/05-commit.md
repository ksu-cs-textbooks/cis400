---
title: "Committing Changes"
pre: "5. "
weight: 50
date: 2018-08-24T10:53:26-05:00
---
As you modify your source code, either by editing existing files or creating new ones, you'll want to have git keep track of the changes.

## Step 1 - Committing Changes
To save your changes in git, you need to add any new files and then commit all new and edited files.  To do this, you will typically want to use the commands:

```
$ git add .
$ git commit -a -m "<a message about the commit>"
```

Additionally, you may want to [push your changes to origin]({{% ref "b-git-workflows/06-push"%}}) so that you can later [pull them into other local repositories]({{%ref "b-git-workflows/07-pull"%}}) or turn in an assignment by [creating a release]({{%ref "b-git-workflows/09-release" %}}).

## Notes
To git, all files fall into one of four categories: ignored, unstaged, staged, and committed.  

### Ignored Files
An _ignored_ file matches a pattern in the __.gitignore__ file, and git effectivley pretends it does not exist (however, if it is staged _before_ the pattern is [added to the __.gitignore__ file]({{% ref "b-git-workflows/10-ignoring-files" %}}), git will track it).

### Unstaged Files
An _unstaged_ file is a new file that git is not currently tracking, or an existing file that has been changed.  You can add such a file to those ready to be committed with the command:

```
$ git add [filename]
```

where `[filename]` is the name of the file to add.  Alternatively, you can add _all new files_ with the command:

```
$ git add .
```

the period (`.`) serves as a wildcard, including all new unstaged files in the directory.

### Staged Files
The _staged_ files are those which have uncommitted changes (changes that haven't been backed up with git).   You can commit those changes with the command:

```
$ git commit -a -m "[a message about the commit]"
```

The `[a message about the commit]` should be a descriptive message about what changes were made.  If you don't include a message (by leaving off the `-m` flag), git will open the default text editor for you to type a message into.  This is often the [vim](https://www.vim.org/) editor.  You can learn how to use it, or if you need to quickly exit, you can use the command:

```
:q!
```

to quit it without saving.

### Committed Files
Committed files have their current state saved in your git repo, and will be pushed to remote repositories if you use the [push command]({{% ref "b-git-workflows/06-push" %}}).