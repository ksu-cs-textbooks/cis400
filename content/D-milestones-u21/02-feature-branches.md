---
title: "Feature Branches"
pre: "2. "
weight: 2
date: 2018-08-24T10:53:26-05:00
---

It is recommended practice that you use [feature branches]({{<ref "B-git-and-github/08-branches">}}) for each new milestone.  This will allow you to keep the new milestone work separate from your main branch until it is complete.  To create a feature branch for data milestone 1, you would use this Git command:

```
$ git branch data1
```

And then check it out using the command:

```
$ git checkout data1
```

As you work you can add and commit as normal, i.e.:

```
$ git add . 
$ git commit -a -m "A description of what changed"
```

Any commits you make will be made on the feature branch, not your main branch.  You can also push this branch to GitHub:

```
$ git push origin data1
```

Which allows you to pull it to another local repository:

``` 
$ git checkout data1 
$ git pull origin data1
```

Finally, when you have finished the milestone, you'll want to merge your new changes with the main branch:

```
$ git checkout main 
$ git merge data1 
```

And push the newly expanded main branch to GitHub:

```
$ git push origin main
```

Finally, you'll need to [create a release]({{<ref "b-git-and-github/11-release">}}) to turn in.