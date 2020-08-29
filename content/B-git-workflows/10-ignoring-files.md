---
title: "Ignoring Files"
pre: "10. "
weight: 100
date: 2018-08-24T10:53:26-05:00
---
Git can be asked to ignore specific files by adding a pattern matching the file to a special text file named __.gitignore__.  This file should be placed in the top level of the project directory.  We typically use this to ignore temporary files, build files, and files whose contents we don't want posted on GitHub (i.e. configuration files with passwords and secrets).

GitHub offers a collection of prepared _.gitignore_ files for popular languages and platforms, at [https://github.com/github/gitignore](https://github.com/github/gitignore).  You can find the one you are interested in, click the "raw" button to get the raw text, and copy it into your _.gitignore_ file.

For this class, you would want to use the [VisualStudio .gitignore](https://raw.githubusercontent.com/github/gitignore/master/VisualStudio.gitignore)