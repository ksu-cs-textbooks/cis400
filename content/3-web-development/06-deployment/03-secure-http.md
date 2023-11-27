---
title: "Secure HTTP"
pre: "3. "
weight: 30
date: 2018-08-24T10:53:26-05:00
---

We have talked several times about HTTP and HTTPS, without really discussing what is different about these two approaches other than HTTPS is "secure".  Essentially, HTTPS uses the same protocol as HTTP, but requests and responses are _encrypted_ rather than being sent as plain text.  This encryption is handled at a level below HTTP, in the communication layer (currently this uses [TLS - Transport Layer Security](https://en.wikipedia.org/wiki/Transport_Layer_Security)).  This encryption is done through symmetric crypography using a shared secret.  You may remember studying this approach in CIS 115.  Remember this Computerphile video demonstrating a Diffie-Hellman key exchange by mixing paint colors?

<iframe width="560" height="315" src="https://www.youtube.com/embed/NmM9HA2MQGI" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

By using this encryption scheme, we make it impossible (or at least very difficult) for third parties intercepting our HTTP requests and responses to determine exactly what they contain.  Hence, credit card information, passwords, and other personal information is protected, as are search terms, etc.  However, this is only half of the process of HTTPS.  The second half involves establishing that the web server you are making requests to is the one you want, and not an impersonator.  This requires an _authentication_ process, to ensure you are communicating to the correct server.

This authentication aspect of TLS is managed through _security certificates_.  These are built around public/private key encryption and the [X.509](https://en.wikipedia.org/wiki/X.509) certificate standard.  A certificate provides proof the server serving the certificate is the one of the domain address in question.  Think of it as a driver's license or your student ID card - it lists identifying information, and you carry it with you to prove you are who you say you are.  And much like a drivers' license or a student ID card, it is issued by an authoritative source - one of several "trusted" certificate authorites, or an authority whose own certificate is signed by one of these authorities.

Anyone can issue a security certificate, but only one with a chain of signed certificates that goes back to a root trusted certificate authority will be considered "trusted" by your browser.  This is why you may have had issues running your web applications using HTTPS - when launching the project in debug mode, it uses a self-signed certificate (i.e. your application creates its own certificate), which the browser reports as untrustworthy.  Depending on your browser, you may be able to allow this "untrusted" site to be served, or it may be disallowed completely.  Visual Studio and ASP.NET projects typically offer to install a "dev certificate" that allows your localhost communications to treated as trusted.

{{% notice info %}}
Traditionally, security certificates are issued from a trusted authority using annual fees, and often accompanied by insurance that pays for legal issues if the certificate is ever violated.  However, the Let's Encrypt Security Group, launched in April 2016, offers free security certificates with the goal of making HTTPS ubiquitious on the web.  This easy availablility means there is no reason to not host your websites using HTTPS instead of vulnerable HTTP.  You can visit the Let's Encrypt website at [letsencrypt.org](https://letsencrypt.org/).
{{% /notice %}}