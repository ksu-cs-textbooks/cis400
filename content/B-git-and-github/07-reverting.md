---
title: "Reverting Changes"
pre: "7. "
weight: 7
date: 2018-08-24T10:53:26-05:00
---

As we suggested earlier in the chapter, one of the most important uses of a version control system is to allow you to revert to an earlier version of your code.  To ask Git to list the available commits, you can use the **git log** command:

```
$ git log
```

This should print a list of the commits and their details, with the newest commit first:

![git log output]({{<static "images/b.7.1.png">}})

Notice each commit is identified by a hash, date, and commit message. This is why a good commit message is important - it helps to let us know what we changed (and therefore what changes we would be undoing if we reverted to that commit).  If we wanted to revert to an earlier version, we would use the **git checkout** command:

```
$ git checkout [hash]
```

Where `[hash]` is the hash of the commit, i.e. `cec94d9078c036b6ebd374cde0d7e400a8a94ebd` for the initial commit in the example. 

This reverts your files to that point, and reports you are in a 'detached HEAD' state, i.e. the commit loaded is not the latest one on this branch.  Carlos Schults has an [excellent post describing this condition](https://www.cloudbees.com/blog/git-detached-head). If you want to start working from this point (leaving your later changes out), best practice is to create a new branch to hold this commit.  We'll look at branches next.