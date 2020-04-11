---
title: "Razor Pages"
pre: "6. "
weight: 6
date: 2018-08-24T10:53:26-05:00
---

In the introduction, we indicated that modern websites are more often full-fledged applications than collections of static files.  So how do we move from the basic HTML, CSS, and JavaScript files we've just discussed into a dynamic web application?

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

It generates the HTML of a page shownig the current date and time.  Remember too that HTTP responses are simply text, so we can generate a response as a string as well:

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

The resulting string could then be streamed back to the requesting web client.  This is the basic technique used in all server-side web frameworks: they dynamically assemble the response to a request by assembling strings into an HTML page.  Where the differ is what language they use to do so, and how much of the process they've abstracted.

You might have looked at the above examples and shuddered.  After all, who wants to assemble text like that?  And when you assemble HTML using raw string concatenation, you don't have the benefit of syntax higlighting, code completion, or any of the other modern development tools we've grown to rely on.  Thankfully, most web development frameworks provide some abtraction around this process, and by and large have adopted some form of _template syntax_ to make the process of writing a page easier.

## Razor Pages 
Microsoft's latest template syntax is called [Razor](https://docs.microsoft.com/en-us/aspnet/core/mvc/views/razor?view=aspnetcore-3.1), and it allows you to write your HTML largely as HTML, and insert the result of arbitrary C# code execution.  For example, the page we generated above would be written:

```html 
<!DOCTYPE html>
<html>
    <head>
        <title>My Dynamic Page</title>
    </head>
    <body>
        <h1>Hello World</h1>
        <p>Time on the server is @DateTime.Now</p>
    </body>
</html>
```

The `@` symbol is used to preface any statement that is C# code - the statement is executed, and the result is concatenated into the HTML body.  Razor syntax can be used to define full pages, or just snippets of HTML.  Razor syntax is saved in a file with the _.cshtml_ or _.razor_ extension.

[Razor Pages](https://docs.microsoft.com/en-us/aspnet/core/razor-pages/?view=aspnetcore-3.1&tabs=visual-studio) were introduced in the ASP.NET Core platform, and use Razor syntax and several other handy abstractions to make the process of setting up a web application organized around indivdiual pages as easy as possible.  Consider the example above.  Let's assume we want that page to be hosted on [http://oursite.com/Time]().  We would create a razor page file in our solution at _pages/Time.cshtml_ with contents:

```csharp
@page

<h1>Hello world!</h1>
<p>Time on the server is @DateTime.Now</p>
```

The `@page` indicates that this Razor template is intended to be used as a full webpage.  This is all we need to add to get the page up and running!

Let's see this in action.

## Creating a Razor Pages Project 

First, open Visual Studio and create a new project.   Pick the _ASP.NET Core Web Application_ 

![Create Project Dialog]({{<static "images/6.6.1.png">}})

Give your project a name (I'm using "HelloWeb") and then click the **Create** button.  

On the next screen, choose the _Web Application_ option:

![Create ASP.NET Core web application]({{<static "images/6.6.2.png">}})

This creates a starter Razor Pages application.

If you look at the run button options, you'll see that there are two configurations, _IIS Express_ and _HelloWeb_ (or whatever you named your project).  You can actually add multiple run configurations to _any_ Visual Studio project, but these have been automatically created for you to leverage two different deployment options, IIS Express and Kestrel (the one with your project name).  

> [IIS (Internet Information Service](https://www.iis.net/) is Microsoft's orginal flagship web server.  It started as a static web server for serving static web assets (HTML, CSS, JS, and Media) and then was adapted to serve dynamic content generated by ASP.NET programs.  IIS runs on Windows Server; IIS Express is a lightweight version used for development.

> [Kestrel](https://docs.microsoft.com/en-us/aspnet/core/fundamentals/servers/kestrel?view=aspnetcore-3.1) is Microsoft's new cross-platform web server.  It was created so that ASP.NET programs could be hosted on Linux machines as well as containerized virtual platforms like Docker.

It doesn't matter which you choose now, but if you were developing a web app with the intent of deploying it, you would want to choose the server that corresponds to your intended deployment environment.

You can also choose which browser you want Visual Studio to open and display your webpage on when you click the __run__ button.

Go ahead and run your project.  You will likely be asked to accept a SSH certificate - you'll need to do so to visit your site without being warned by the browser that it might be dangerous.  This is because your Razor Pages application uses _secure HTTP (HTTPS)_ instead of HTTP (as should all modern web applications).  Secure HTTP encrypts the communication between web server and web browser, to protect your private information as it travels across the internet.  An SSL certificate is needed for the encryption process.  These are traditionally issued by trusted third parties that provide assurance that your website is legitamate.  During development, you will be using a self-signed certificate instead (one your program issues to itself).  Browsers don't trust self-signed certificates for good reason - as anyone, including nefarious agents, can create one.  To make life easier on us, Visual Studio offers to cache approval of this self-signed certificate so that our browser will happily open the web page.

Once the project launches, it should open the web page in the browser you selected (Microsoft Edge by default):

![The Web Application]({{<static "images/6.6.4.png">}})

The project creation wizard created a lot of parts for us already, including two pages (home and privacy), a navigation menu, and a footer.  Click around and see what you can do in the page.

### The Project Structure

Let's turn our attention back to our code.  Looking at the Solution Explorer, we have several files and folders that have been created for us:

![The project structure]({{<static "images/6.6.5.png">}})

Let's walk through these parts one at a time.

#### Program.cs

The entry point for our project is the _Program.cs_ file.  It contains the `Main()` method:

```csharp
    public static void Main(string[] args)
    {
        CreateHostBuilder(args).Build().Run();
    }
```

Which creates our hosting server with `CreateHostBuilder()`, builds it with `Build()`, and then starts it with `Run()`.  The resulting process is our web server, and it listens for and responds to incoming HTTPS requests until we close it or it crashes.

The `CreateHostBuilder()` is also defined in the same class:

```csharp
public static IHostBuilder CreateHostBuilder(string[] args) =>
            Host.CreateDefaultBuilder(args)
                .ConfigureWebHostDefaults(webBuilder =>
                {
                    webBuilder.UseStartup<Startup>();
                });
```

This is an implementation of the Factory pattern, and basically configures the web host based on the configuration supplied by the `Startup` class.  Let's look at that next.

#### Startup.cs

There are two workhorse methods in this class: `ConfigureServices()` and `Configure()`.  These are used to launch services used by the server, and to configure the server itself.  Currenly we are only using one service - Razor Pages:

```csharp
    services.AddRazorPages();
```

In configuring our web application, we use different error page strategies if we are running as a development or production mode:

```csharp
    if (env.IsDevelopment())
    {
        app.UseDeveloperExceptionPage();
    }
    else
    {
        app.UseExceptionHandler("/Error");
        // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
        app.UseHsts();
    }
```

The developer exception page gives us a lot of information about any errors that occur - including the stack trace.  This is information you should _never_ give out in a production environment, as it lets hackers know the internal structure of your server code.

We enable HTTPS redirection (which redirects any HTTP request against our server to become HTTPS requests):

```csharp
    app.UseHttpsRedirection();
``` 

We automatically serve any requested static files (we'll talk about where these would go shortly):

```csharp 
    app.UseStaticFiles();
```

We turn on routing (which allows requests to be mapped to the corresponding page):

```csharp
    app.UseRouting();
```

And allow for authorization checks:

```csharp 
    app.UseAuthorization();
```

And finally, create the routes from requests to our razor pages:

```csharp
    app.UseEndpoints(endpoints =>
    {
        endpoints.MapRazorPages();
    });
```

The nice thing about this default configuration is that we probably won't need to change any aspects of it - it has all the peices we need to start building a Razor Pages site.

#### wwwroot 

This directory contains all the _static_ files - the files that we just want to serve as-is.  Typically our CSS and JavaScript files will go here, in  the corresponding _css_ and _js_ folders.  The _lib_ folder is for third-party JS and CSS libraries.  The popular [JQuery](https://jquery.com/) and [Bootstrap](https://getbootstrap.com/) libraries are pre-loaded for you.

You can add aditional files here as needed.  Say we wanted to add an image file - _clown.png_.  We might add  folder to _wwwroot_, _images_, and put the file into there.  Then, with our website running, we could access the file with the route _/images/clown.png_.  Similarly, in our Razor pages, we could reference the image:

```html
<img src="/images/clown.png" alt="A clown"/>
```

#### Pages 

The _Pages_ folder is where our razor pages live.  You probably notice that the pages already there bear the _.cshtml_ extension.  These are our _Razor Pages_.  Some also have a second file - with the _.cshtml.cs_ extension.  These are _Page Model_ files, and play the same role as the _View Model_ we used in WPF.

There are a couple of special pages here that we should note.  

* _ViewImports.cshtml_ - this file is imported into our other pages, and provides a single spot for loading resources you want to use in all of your pages.  For example, you might put all of your _using_ statements here.

* _ViewStart.cshtml_ - is likewise used to configure settings on each page.  Currently, this one sets the default layout to `"_Layout"`, which brings us to...

* *Shared/_Layout.cshtml* - This is the layout for the site.  It contains the "boilerplate" - the HTML portion that is shared by all of our pages.  Notice the `@RenderBody()` method invocation, which injects the contents of the actual razor page into this layout as the page is rendered.  Similarly, the `@RenderSection()` renders specficially labeled sections.

The *_Layout.cstml* file is what we call a _partail_, because it only defines part of a page.  The convention is to prefix partial names with an underscore (`_`).

We can use a layout by setting a page's `Layout` property to it.  That is what the _ViewStart.cshtml_ is doing, but we can also override this in any of our own pages.  Say we want our page to use the `_ArticleLayout.cshtml` file.  We would just add:

```html 
@{
    Layout = "_ArticleLayout.cshtml"
}
```

somewhere on the page.  We'll get into more detail on layouts and partials in our next few lessons.  But for now, let's add the page we proposed at the start of this section.

### Adding our New Page

Right-click on the _Pages_ folder in the context menu, and select " Add > Razor Page".  Select the "Razor Page" option in the dialog.

![Razor Page dialog]({{<static "images/6.6.6.png">}})

Then name your new page "Time" and uncheck the "Generate PageModel class" option.

![Add Razor Page dialog]({{<static "images/6.6.7.png">}})

This should generate a _Time.cshtml_ file that contains:

```html
@page
@{
    ViewData["Title"] = "Time";
}

<h1>Time</h1>
```

The line `ViewData["Title"] = "Time";` sets the title of the page (displayed on the browser tab) to "Time".

Now add this line to the end of the page:

```html
<p>The current time on the server is @DateTime.Now</p>
```

If you run the server and navigate to _/time_, you should see our message!.  

However, most users wouldn't know to look for a page there, so let's add it to our navigation.

### Adding Time to the Navigation Menu
The navigation bar is defined in the *Shared/_Layout.cshtml* file, so open it.  The actual navigation bar is created using [Bootstrap's Navbar](https://getbootstrap.com/docs/4.0/components/navbar/) - that's what all the `class` attributes are referring to.  Bootstrap creates navbars as an unorderd list - find the `<ul class="navbar-nav flex-grow-1>` element.  We're going to add another list item (`<li>`) to it to provide a link to our new page.  Add this code as a child of the `<ul>` element:

```html
<li class="nav-item">
    <a class="nav-link text-dark" asp-area="" asp-page="/Time">Time</a>
</li>
```

The `asp-area` and `asp-page` are attributes specific to ASP.NET - they aren't part of the HTML standard.  The `asp-page` indicates we want this achor tag (`<a>`) to navigate to a specific Razor page - the one named "Time".

Now if we run our program again, you should see the "Time" link in the navbar, and clicking it should take us to our new page!

![Time in Navbar]({{<static "images/6.6.8.png">}})