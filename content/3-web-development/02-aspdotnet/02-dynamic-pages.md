---
title: "Dynamic Pages"
pre: "2. "
weight: 20
date: 2018-08-24T10:53:26-05:00
---

Modern websites are more often full-fledged applications than collections of static files.  But these applications remain built upon the foundations of the core web technologies of HTML, CSS, and JavaScript.  In fact, the client-side application is typically built of _exactly_ these three kinds of files!  So how can we create a dynamic web application?

One of the earliest approaches was to write a program to _dynamically create_ the HTML file that was being served.  Consider this method:

```csharp
public string GeneratePage()
{
    StringBuilder sb = new StringBuilder();
    sb.Append("<!DOCTYPE html>");
    sb.Append("<html>");
    sb.Append("<head>");
    sb.Append("<title>My Dynamic Page</title>");
    sb.Append("</head>");
    sb.Append("<body>");
    sb.Append("<h1>Hello, world!</h1>");
    sb.Append("<p>Time on the server is ");
    sb.Append(DateTime.Now);
    sb.Append("</p>");
    sb.Append("</body>");
    sb.Append("</html>");
    return sb.ToString();
}
```

It generates the HTML of a page showing the current date and time.  Remember too that HTTP responses are simply text, so we can generate a response as a string as well:

```csharp
public string GenerateResponse()
{
    string page = GeneratePage();
    StringBuilder sb = new StringBuilder();
    sb.AppendLine("HTTP/1.1 200");
    sb.AppendLine("Content-Type: text/html; charset=utf-8");
    sb.AppendLine("ContentLength:" + page.Length);
    sb.AppendLine("");
    sb.Append(page);
    return sb.ToString();
}
```

The resulting string could then be streamed back to the requesting web browser.  This is the basic technique used in all server-side web frameworks: they dynamically assemble the response to a request by assembling strings into an HTML page.  Where the differ is what language they use to do so, and how much of the process they've abstracted.

You might have looked at the above examples and shuddered.  After all, who wants to assemble text like that?  And when you assemble HTML using raw string concatenation, you don't have the benefit of syntax highlighting, code completion, or any of the other modern development tools we've grown to rely on.  Thankfully, most web development frameworks provide some abstraction around this process, and by and large have adopted some form of _template syntax_ to make the process of writing a page easier.
