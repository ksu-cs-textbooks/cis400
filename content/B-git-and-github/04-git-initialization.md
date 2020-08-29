---
title: "Git Initialization"
pre: "4. "
weight: 4
date: 2018-08-24T10:53:26-05:00
---

Git converts an ordinary directory (folder) on our computer into a _git repository_, allowing you to save different versions of the directory's contents as you make changes to that directory.  Invoking the **git init** command within the top directory of your project starts this process:

```js
$ git init 
```

The data describing these changes and how to switch to them is stored in a subdirectory the Git client creates in the top project directory named _.git_.  This folder is normally hidden from the user on most operating systems, though you can reveal it by tweaking your OS settings.  All the `git` commands modify the contents of that folder.  This approach has one really great benefit - if you copy your project folder into a new location, your repository information goes with it!

If you're curious about the structure of the _.git_ folder, Pierre DeWulf has a [good post discussing it](https://www.daolf.com/posts/git-series-part-1/) on his blog. [^daolf2019] Esentially, every time you _commit_ (save your current changes), Git creates a new entry representing the state of your files at that point, including an identifying hash (to identify the commit), the previous (parent) commit's hash, a comment describing the commit, the date and time of the commit, and the identity of the user making the commit. We can use this information to restore the project directory to _any one of the commits we've made_.

[^daolf2019]: Pierre DeWulf, ["Git series 1/3: Understanding git for real by exploring the .git directory"](https://www.daolf.com/posts/git-series-part-1/), _daolf.com_, Jan 1, 2019.

{{% notice warning %}}
Because Git places all of its repository information in the _.git_ folder, deleting it will make the directory no longer be a repository.  All committed changes will be lost, and you will no longer be able to revert your project files to earlier versions.  
{{% /notice %}}
