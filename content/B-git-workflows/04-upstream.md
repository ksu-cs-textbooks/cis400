---
title: "Pull from Upstream"
pre: "4. "
weight: 40
date: 2018-08-24T10:53:26-05:00
---

As the semester progresses, I will be releasing updates to the original repository, _upstream_ for our project.  You can _pull_ these changes into your own local repository, merging the updates into your code.

## Step 1 - Link to the Upstream Repository
Unlike the _origin_ remote repository, your local repositories won't have a default link to the _upstream_ repository.  We'll have to manually add it (but only once per local repository) with the command:

```
$ git remote add upstream https://github.com/ksu-cis/bleakwind-buffet.git
```

## Step 2 - Pull from the Upstream Repository
Once the _upstream_ repository has been established, you can pull its changes using the command:

```
$ git pull upstream master
```

This merges the upstream master branch into the local repository.  As with any merge, this may result in _merge conflicts_, which will need to be [resolved]({{% ref "b-git-workflows/08-merge-conflicts" %}}).