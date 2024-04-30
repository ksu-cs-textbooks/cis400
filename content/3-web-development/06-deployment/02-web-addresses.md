---
title: "Web Addresses"
pre: "2. "
weight: 20
date: 2018-08-24T10:53:26-05:00
---

## IP Addresses

As we discussed previously, when we visit web pages in our browser, the browser makes a HTTP or HTTPS request against the web server for the resource.  For this request to be sent to the right server, we must first determine the server's _address_.  This address takes the form of an Internet Protocol (IP) address.  There are currently two ways these IP addresses are specified, IPv4 and IPv6.  An IPv4 address consists of 32 bits split into 8 bit chunks, and is typically expressed as four integers between 0 and 255 separated by periods.  For example, the IP address for Kansas State University is:

```text
129.130.200.56
```

Consider that an IPv4 address consists of 32 bits.  This means we can represent `2^{32}` unique values, or `4,294,967,296` different addresses.  You can see how many websites are currently online at [https://www.internetlivestats.com/watch/websites/](https://www.internetlivestats.com/watch/websites/), as of this writing it was nearly 2 million.  Combine that with the fact that _every computer connecting to the interent_, not just those hosting, _must have an ip address_, and you can see that we are running out of possible addresses.

This is the issue that IPv6 was created to counter.  IPv6 addresses are 128 bits, so we can represent `2^{128}` different values, or `340,282,366,920,938,463,463,374,607,431,768,211,456` possible addresses (quite a few more than IPv4)!  An IPv6 address is typically expressed as eight groups of four hexidecimal digits, each representing 16 bits.  For example, Google's IPv6 address is:

```text
2607:f8b0:4000:813::200e
```

IPv6 adoption requires changes to the internet infrastructure as well as all connected machines, and is typically done on a volunteer basis.  Thus, it is a gradual process.  The United States is at rougly a 47% adoption level; you can see current adoption statistics for all countries at [Akamai's IPv6 Adoption Tool](https://www.akamai.com/us/en/resources/our-thinking/state-of-the-internet-report/state-of-the-internet-ipv6-adoption-visualization.jsp).

## Ports

In addition to the address, requests are sent to a _port_, a specific communication endpoint for the computer.  Different applications "listen" at specific ports on your computer - this allows your computer to have multiple applications communicating across the network or interent at the same time.  You might think of your computer as an apartment complex; the IP address is its street address, and the ports are individual apartment numbers.  Different applications then live in different apartments.  Many of these ports are unused (the apartments are vacant), as most computers are only running a few network-facing applications at any given time.

Many applications and communication services have a "default" port they are expected to use.  This makes it easy to connect to a remote computer.  For example, a webserver uses port 80 by default for HTTP requests, and port 433 for HTTPS requests.  If your server is listening at these ports, there is no need to specify the port number in HTTP/HTTPS requests targeting your IP address.  You can also run a program on a non-standard port.  For example, with our Razor Page applications, we have typically been running our debug version on port `44344` (with IIS Express) or `5001` (when running as a console application).  If you know the IP address of your computer, you can visit your running debug server by using the address **http://[ip address]:[port]** from another computer on your network. 

Some of the most common services and thier associated default ports are:

<table>
    <tr>
        <th>Port</th><th>Protocol</th><th>Use</th>
    </tr>
    <tr>
        <td>22</td>
        <td>Secure Shell (ssh)</td> 
        <td>Used to communicate between computers via a comand line interface</td>
    </tr>
    <tr>
        <td>25</td>
        <td>Simple Mail Transfer Protocol (SMTP)</td>
        <td>A common email routing protocol</td>
    </tr>
    <tr>
        <td>53</td>
        <td>Domain Name System (DNS) Service</td>
        <td>IP lookup by domain name</td>
    </tr>
    <tr>
        <td>80</td>
        <td>Hyper-Text Transfer Protocol (HTTP)</td>
        <td>Servicing WWW requests</td>
    </tr>
    <tr>
        <td>143</td>
        <td>Post Office Protocol (POP)</td>
        <td>Retrieving email</td>
    </tr>
    <tr>
        <td>143</td>
        <td>Interent Message Access Protocol (IMAP)</td>
        <td>Managing email</td>
    </tr>
    <tr>
        <td>193</td>
        <td>Interent Relay Chat (IRC)</td>
        <td>Chat messages</td>
    </tr>
    <tr>
        <td>443</td>
        <td>Secure Hyper-Text Transfer Protocol (HTTPS)</td>
        <td>Servicing secure WWW requests</td>
    </tr>
</table>

## Domain Names

Of course, you don't normally type `129.130.200.56` into your browser to visit K-State's website.  Instead, you type **k-state.edu** or **ksu.edu**, which are _domain names_ owned by the university.  A _Domain Name_ is simply a human-readable name that maps to an IP address.  This mapping is accomplished by the _Domain Name System_ (DNS), a lookup service composed of a hierarchial network of servers, with the root servers maintained by the Internet Corporation for Assigned Names and Numbers (ICANN).  

When you enter a domain name into your browser, it requests the corresponding IP address from its local DNS server (typically maintained by your ISP). If it does not know it, this server can make a request against the broader DNS system.  If a matching IP address exists, it is returned to the local DNS server and through that server, your browser.  Then your browser makes the request using the supplied IP address.  Your browser, as well as your local DNS server, cache these mappings to minimize the amount of requests made against the DNS system.

To get a domain name, you must purchase it from a domain name reseller.  These resellers work with ICANN to establish ownership of specific domain names - each domain name can have only one owner, and map to an IP address.  Once you've purchased your domain name (which is actually leased on an annual basis), you work with the reseller to target the domain name at your preferred IP address(es).  This entire process is typically handled through a web application.


{{% notice info %}}
The **localhost** domain name is a special _loopback_ domain.  It always points at IP address `127.0.0.1`, which is always the local machine (i.e. the computer you are using).  
{{% /notice %}}