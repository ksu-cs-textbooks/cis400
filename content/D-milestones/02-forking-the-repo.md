---
title: "Setting Up Your Repo"
pre: "2. "
weight: 20
date: 2018-08-24T10:53:26-05:00
---

Unlike the regular assignments which you will be accepting from GitHub classroom, we will be using GitHub directly for the milestone assignments.  This will be more consistent with the way you might find yourself using Git and GitHub professionally, and allows us to experience using multiple remote repositories.

I have created a single repository with the starting code for our project at {{<link "https://github.com/ksu-cis/bleakwind-buffet">}} .  This is our first remote repository, which we'll call **upstream** in this class.

You will be using GitHub's [fork](https://docs.github.com/en/github/getting-started-with-github/fork-a-repo) to create a clone of that repository under your own GitHub account.  As this one is also hosted on GitHub, it will be your second remote repository.  We'll call this one **origin** in the class.

You will then clone that repository to your development machine (or machines).  Each of these clones would be a local repository.  And because it was cloned from your personal fork on GitHub, it will automatically assign the name **origin** to that repository.  We will also add the **upstream** repository to your local repository, so you can pull changes made to either remote repository into your local branch.  A diagram of this relationship between your repositories appears below:

![The relationship between Git repositories in this project]({{<static "images/d.2.1.png">}})

You can find intructions for forking a repository [here]({{<ref "b-git-workflows/02-fork">}}).