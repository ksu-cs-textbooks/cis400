---
title: "Ignoring Files"
pre: "6. "
weight: 6
date: 2018-08-24T10:53:26-05:00
---

{{<youtube LjUpxnmgdOQ>}}

Typically there are some files in a project that we _never_ want to commit.  For example, compilers often create temporary or intermediate files during the compilation process, and these will be recreated every time we re-compile. We also usually don't want to commit the compiled binary files either, as we can always compile our code to get a fresh copy.  Not saving these files means our repository takes up less memory, and Git operations are faster.  

And if our project involves some configuration files with sensitive information (passwords, shared secrets, etc), we don't want to commit these to our repository either - especially if it will be publicly visible on GitHub.

We can specify the patterns of files Git should ignore with a special text file named _.gitignore_.  Inside that file, we specify file path patterns.  Any file matching one of these patterns is effectively ignored by Git.  However, if we have already _committed_ a file to the repository, and then added our _.gitignore_ file, the committed file remains in the repository.  For this reason, we _always_ want to add our _.gitignore_ as we create the repository.

{{% notice info %}}
While it is technically possible to completely remove a file accidentally committed to a Git repository, the process is not easy to complete correctly, and a mistake often means the file is still accessible to a skilled adversary.  In those situations, it may be best to delete the _.git_ folder and create a new repository.
{{% /notice %}}

GitHub provides a [helpful repository of _.gitignore_ files](https://github.com/github/gitignore) for specific programming languages and platforms.  An easy trick is to find the one for the language you are interested in, open it in its raw form, and copy/paste its text into your _.gitignore_ file.  For this class, you'll want to use the [Visual Studio .gitignore](https://raw.githubusercontent.com/github/gitignore/master/VisualStudio.gitignore).


