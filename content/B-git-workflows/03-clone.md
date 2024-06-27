---
title: "Clone"
pre: "3. "
weight: 30
date: 2018-08-24T10:53:26-05:00
---
Cloning a project creates a local copy of the repository where you can make changes to the source code.

# Step 1 - Copy the Clone URI
First, you need to have the URI of the repository you want to clone. For repositories on GitHub, this link can be reached from the "Clone or Download" dropdown on GitHub:

![Clone or Download Dropdown](images/b.3.1.png)

## Step 2 - Perform the Clone Operation
Then, on your local machine, clone the remote repository with the command:

```
$ git clone [repository uri];
```

where `[repository uri]` is the URI you copied in step 1. This copies the remote repository onto your local machine, creating a folder containing the repository.


## Notes
Because the repository was cloned from the remote repository, it automatically sets up a remote repository named _origin_, that points at this repository.

You can [push push your changes to origin]({{% ref "B-git-workflows/06-push" %}}.

Further, because the repository was cloned from a repository forked from the class project repository, you can [set that project to be a remote upstream repository]({{% ref "B-git-workflows/04-upstream" %}}).