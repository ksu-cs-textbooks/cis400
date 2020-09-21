---
title: "Documentation"
pre: "2. "
weight: 2
date: 2018-08-24T10:53:26-05:00
---

Documentation refers to the written materials that accompany program code.  Documentation plays multiple, and often critical roles.  Broadly speaking, we split documentation into two categories based on the intended audience:

* _User Documentation_ is meant for the end-users of the software 
* _Developer Documentation_ is meant for the developers of the software

As you might expect, the goals for these two styles of documentation are very different.  User documentation instructs the user on how to use the software.  Developer documentation helps orient the developer so that they can effectively create, maintain, and expand the software.

Historically, documentation was printed separately from the software.  This was largely due to the limited memory available on most systems.  For example, the EPIC software we discussed had two publications associated with it: a [User Manual](http://agrilife.org/epicapex/files/2015/10/EPIC.0810-User-Manual-Sept-15.pdf), which explains how to use it, and [Model Documentation](http://agrilife.org/epicapex/files/2015/05/EpicModelDocumentation.pdf) which presents the mathematic models that programmers adapted to create the software. There are a few very obvious downsides to printed manuals: they take substantial resources to produce and update, and they are easily misplaced.

## User Documentation
As memory became more accessible, it became commonplace to provide digital documentation to the users.  For example, with Unix (and Linux) systems, it became commonplace to distribute _digital_ documentation alongside the software it documented.  This documentation came to be known as [man pages](https://en.wikipedia.org/wiki/Man_page) based on the `man` command (short for manual) that would open the documentation for reading.  For example, to learn more about the linux search tool `grep`, you would type the command:

```
$ man grep 
```

Which would open the documentation distributed with the `grep` tool.  Man pages are written in a specific format; you can read more about it [here](https://liw.fi/manpages/).

While a staple of the Unix/Linux filesystem, there was no equivalent to man pages in the DOS ecosystem (the foundations of Windows) until Powershell was introduced, which has the `Get-Help` tool.  You can read more about it [here](https://docs.microsoft.com/en-us/powershell/scripting/learn/ps101/02-help-system?view=powershell-7).

However, once software began to be written with graphical user interfaces (GUIs), it became commonplace to incorporate the user documentation directly into the GUI, usually under a "Help" menu.  This served a similar purpose to man pages of ensuring user documentation was always available with the software.  Of course, one of the core goals of software design is to make the software so intuitive that users don't need to reference the documentation. It is equally clear that developers often fall short of that mark, as there is a thriving market for books to teach certain software.

![Example Software Books]({{<static "images/2.2.1.png">}})

Not to mention the thousands of YouTube channels devoted to teaching specific programs!

## Developer Documentation 

Developer documentation underwent a similar transformation. Early developer documentation was often printed and placed in a three-ring binder, as Neal Stephenson describes in his novel _Snow Crash_: [^stephenson1992]

[^stephenson1992]: Neal Stephenson, "Snow Crash." Bantam Books, 1992.  

<blockquote>
Fisheye has taken what appears to be an instruction manual from the heavy black suitcase. It is a miniature three-ring binder with pages of laser-printed text. The binder is just a cheap unmarked one bought from a stationery store. In these respects, it is perfectly familiar to Him: it bears the earmarks of a high-tech product that is still under development. All technical devices require documentation of a sort, but this stuff can only be written by the techies who are doing the actual product development, and they absolutely hate it, always put the dox question off to the very last minute. Then they type up some material on a word processor, run it off on the laser printer, send the departmental secretary out for a cheap binder, and that's that.
</blockquote>

Shortly after the time this novel was written, the internet became available to the general public, and the tools it spawned would change how software was documented forever.  Increasingly, web-based tools are used to create and distribute developer documentation.  Wikis, bug trackers, and autodocumentation tools quickly replaced the use of lengthy, and infrequently updated word processor files.

