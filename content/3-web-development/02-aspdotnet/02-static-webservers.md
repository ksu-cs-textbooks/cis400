---
title: "Static Webservers"
pre: "2. "
weight: 20
date: 2018-08-24T10:53:26-05:00
---

The earliest web servers simply served files held in a directory. If you think back to your web development assignment from CIS 115, this is exactly what you did - you created some HTML, CSS, and JS files and placed them in the _public_html_ directory in your user directory on the CS Linux server.  Anything placed in this folder is automatically served by an instance of the Apache web server running on the Linux server, at the address `https://people.cs.ksu.edu/~[eid]/` where `[eid]` is your K-State eid.

[Apache](https://www.apache.org/) is one of the oldest and most popular open-source web servers in the world.  Microsoft introduced their own web server, [Internet Information Services (IIS)](https://www.iis.net/) around the same time.  Unlike Apache, which can be installed on most operating systems, IIS only runs on the Windows Server OS.  

While Apache installations typically serve static files from either a _html_ or _public_html_ directory, IIS serves files from a _wwwroot_ directory.  

As the web grew in popularity, there was tremendous demand to supplement static pages with pages created on the fly in response to requests - allowing pages to be customized to a user, or displaying the most up-to-date information from a database.  In other words, _dynamic_ pages.  We'll take a look at these next.

