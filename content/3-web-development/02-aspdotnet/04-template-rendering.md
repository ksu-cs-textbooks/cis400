---
title: "Template Rendering"
date: 2018-08-24T10:53:05-05:00
weight: 40
pre: "<b>4 . </b>"
---

It was not long before new technologies sprang up to replace the ad-hoc string concatenation approach to creating dynamic pages.  These template approaches allow you to write a page using primarily HTML, but embed snippets of another language to execute and concatenate into the final page.  This is very similar to the template strings we have used in C#, i.e.:

```csharp
string time = $"The time is {DateTime.Now}";
```

Which concatenates the invoking of the [DateTime.Now]() property's `ToString()` method into the string `time`.  While the C# template string above uses curly braces to call out the script snippets, most HTML template libraries initially used some variation of angle brackets + additional characters.  As browsers interpret anything within angle brackets (`<>`) as HTML tags, these would not be rendered if the template was accidentally served as HTML without executing and concatenating scripts.  Two early examples are:

* `<?php echo "This is a PHP example" ?>`
* `<% Response.Write("This is a classic ASP example) %>`

And abbreviated versions:

* `<?= "This is the short form for PHP" ?>`
* `<%= "This is the short form for classic ASP" %>`

Template rendering proved such a popular and powerful tool that rendering libraries were written for most programming languages, and could be used for more than just HTML files - really _any_ kind of text file can be rendered with a template.  Thus, you can find template rendering libraries for JavaScript, Python, Ruby, and pretty much any language you care to (and they aren't that hard to write either).  

Microsoft's classic ASP implementation was limited to the Visual Basic programming language.  As the C# language gained in popularity, they replaced classic ASP with ASP.NET web pages.  Like classic ASP, each page file (named with a _.aspx_ extension) generates a corresponding HTML page.  The script could be either Visual Basic or C#, and a new syntax using the at symbol (`@`) to proceed the code snippets was adopted.  Thus the page:

```aspx
<html>
    <body>
        <h1>Hello Web Pages</h1>
        <p>The time is @DateTime.Now</p>
    </body>
</html>
```

Would render the current time.  You can run (and modify) this example on the [w3schools.com](https://www.w3schools.com/asp/showfile_c.asp?filename=try_webpages_cs_001).  

This template syntax is the [Razor syntax](https://en.wikipedia.org/wiki/ASP.NET_Razor), and used throughout Microsoft's ASP.NET platform.  Additionally it can be used outside of ASP.NET with the open-source [RazorEngine](https://antaris.github.io/RazorEngine/).

Classic PHP, Classic ASP, and ASP.NET web pages all use a single-page model, where the client (the browser) requests a specific file, and as that file is interpreted, the dynamic page is generated.  This approach worked well in the early days of the world-wide-web, where web sites were essentially a collection of pages.  However, as the web grew increasingly interactive, many web sites grew into full-fledged _web applications_, full-blown programs that did lend themselves to a page-based structure.  This new need resulted in new technologies to fill the void - web frameworks.  We'll talk about these next.
