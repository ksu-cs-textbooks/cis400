---
title: "Web Frameworks"
date: 2018-08-24T10:53:05-05:00
weight: 50
pre: "<b>5. </b>"
---

As web _sites_ became web _applications_, developers began looking to use ideas and techniques drawn from traditional software development.  These included architectural patterns like [Model-View-Controller (MVC)](https://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93controller) and [Pipeline](https://en.wikipedia.org/wiki/Pipeline_(software)) that simply were not possible with the server page model.  The result was the development of a host of web frameworks across multiple programming languages, including:

* [Ruby on Rails](https://rubyonrails.org/), which uses the [Ruby](https://www.ruby-lang.org/en/) programming language and adopts a MVC architecture
* [Laravel](https://laravel.com/), which uses the [PHP](https://www.php.net/) programming language and adopts a MVC architecture
* [Django](https://www.djangoproject.com/), which uses the [Python](https://www.python.org/) programming language and adopts a MVC architecture
* [Express](https://expressjs.com/), which uses the [Node implementation of the JavaScript](https://nodejs.org/en/) programming language and adopts the Pipeline architecture
* [Revel](https://revel.github.io/), which uses the [Go](https://golang.org/) programming language and adopts a Pipeline architecture
* [Cowboy](https://github.com/ninenines/cowboy), which uses the [erlang](https://www.erlang.org/) programming language and adopts a Pipeline architecture
* [Phoenix](https://www.phoenixframework.org/), which uses the [elixir](https://elixir-lang.org/) programming language, and adopts a Pipeline architecture

### ASP.NET Frameworks

This is only a sampling of the many frameworks and languages used in the modern web.  Microsoft adapted to the new approach by creating their own frameworks within the ASP.NET family:

* [ASP.NET MVC](https://dotnet.microsoft.com/apps/aspnet/mvc) uses C# (or Visual Basic) for a language and adopts a MVC architecture
* [ASP.NET Razor Pages](https://docs.microsoft.com/en-us/aspnet/core/tutorials/razor-pages/?view=aspnetcore-3.1), which also uses C# (or Visual Basic) for its language, and adopts a Pipeline architecture
* [ASP.NET API](https://dotnet.microsoft.com/apps/aspnet/apis) is a web framework focused on creating RESTful web APIs (i.e. a web application that serves data instead of HTML)

### IIS and ASP.NET Core

While ASP.NET applications are traditionally hosted on IIS running on the Windows Server operating system, the introduction of .NET Core made it possible to run .NET programs on Linux machines.  As Linux operating systems are typically free and dominate the web server market (W3Cook^[w3cook] reports 98.1% of web servers worldwide run on a Linux OS).

$[w3cook]: [W3Cook OS Summary](https://web.archive.org/web/20150806093859/http://www.w3cook.com/os/summary/)

Microsoft has accordingly migrated its ASP.NET family to a new implementation can run on .NET Core _or_ IIS: [ASP.NET Core](https://docs.microsoft.com/en-us/aspnet/core/?view=aspnetcore-3.1).  When you build a ASP.NET Core application, you can choose your deployment target: IIS, .NET Core, or even Microsoft's cloud service, Azure.  The same application can run on _any_ of these platforms.