---
title: "Web Hosting"
pre: "4. "
weight: 40
date: 2018-08-24T10:53:26-05:00
---

To host your website, you will need:

1. A computer connected to the Internet 
2. A web server program listening at port 80 and/or 433 (depending on if you are using secure communications)
3. If you are using secure communications, a security certificate issued by a valid authority.  [Let's Encrypt](https://letsencrypt.org/) offers free certificates, and is a good source for startign web developers
4. A domain name (while this is technically optional, if you expect users to visit your website you'll probably need one)

While you have been running your website in debug mode on your develpment computer, you probably won't use it to host your actual website on the Internet. First, you machine would need to be running the web server application constantly.  Any time your computer was turned off, or the web server was not running, your website would be inaccessible.

Also, in most residental setups, you probably won't be able to access the running program across the Internet anyway.  This is especially if you have multiple computers connected through a router.  In that case, only your router has a unique IP address, and all communications are routed through it using that address.  The router also assigns "internal" addresses to the computers networked to it, and handles distributing request results to those computers that made them (kind of like a mailroom for a very large institution).  To make your website available, you would probably need to set up port forwarding or a similar technique with your router to have it forward requests to the computer running your web server.  You probably would also need to modify your firewall settings (firewalls prevent connections against ports that you don't mean to have open to the Internet).

A third challenge is that you most likely do not have a _static_ IP address, i.e. one that will always point to your computer.  Most Internet Service Providers instead typically assign a _dynamic IP_ address to your router or modem when you estabish a connection, drawn from a pool of IP addresses they maintain for this purpose.  This address is yours until the next time you connect (i.e. after a power loss or rebooting your router), at which point the ISP assigns you a different IP address from the pool.  This simplifies the configuration for their network, and allows them to share IP addresses amongst infrequently-connecting users.  Further, most residential ISP plans specifically forbid hosting web applications using thier connection - instead you must sign up for a commercial plan that includes a static IP address. 

## Remote Machines

Instead, you will probably host your websites on a remote machine running in a server farm (similar to how the CIS Linux servers that you put your personal web pages on in CIS 115).  There are several benefits to using a machine in a server farm: typically they are very good machines, optimized for hosting web applications, the server farm has ideal operating conditions (good air conditioning, a backup power system), better uptime, and on-staff IT professionals that keep the equipment in good repair.  Of course, you will have to pay fees to have access to a machine.  There are typically several options offered by these service providers:

1. A machine you own (in this case, you would purchase your server hardware, and you would own it).  The service maintains your machine and its connection to the internet.  This is typically the most expensive option, but is sometimes used when information security is espeically paramount.
2. A machine you rent.  In this case, it is owned by the service but made available to you.  You get the entire machine for your use.
3. A shared machine - in this case you are granted access to only part of the computer, where you can store files.  In this approach, web hosting is often acccomplished with an Apache server, and each user has a special file (i.e. `public_html` where they can place files to be served statically).  This is the approach our department uses for your access to the CS Linux server.
4. A virtual machine - this is also a shared access to a computer, but mediated through a _virtual machine_ - a virtual computer running in the real computer.  A computer can host an arbitrary number of virtual machines.  In this case, you have complete access to your virtual machine.
5. A containerized approach - this approach separates your application from the environment in which it runs.  In essence, you package up everything your application needs to run in a single image file, which can then be run from within a container environment (like Docker).  The beauty of this approach is that the same container can be deployed multiple times on different kinds of machines running a conatiner environment. This is also a virtual machine approach, only the virutal machine is different.

We'll take a deeper look at virutal machines next.

