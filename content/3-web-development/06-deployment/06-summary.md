---
title: "Summary"
pre: "6. "
weight: 60
date: 2018-08-24T10:53:26-05:00
---

In this chapter we discussed what is necessary for hosting a web application: a computer running your web server, a static Internet Protocol address, a domain name that maps to your IP addresss, and a security certificate for using HTTPS. Each of these concepts we explored in some detail.  We saw how using HTTPS allows encrypted end-to-end communication between the web client and server, as well as providing assurance that the server we are communicating with is the one we intended to make requests from.  We also discussed the differences between self-signed certificates and those signed by a certificate authority, and introduced the nonprofit [letsencrypt.org](https://letsencrypt.org/) which provides free certificates to help secure the web.

We also described several options for the computing environment running your web server: a dedicated machine in your home or office, a dedicated machine in a server farm, a virutal machine, or a containerized cloud service.  We discussed the benefits and drawbacks of each approach.  As you prepare to host your own applications, you'll want to consider these, along with the costs of the various services, to decide how you want to deploy your production application.