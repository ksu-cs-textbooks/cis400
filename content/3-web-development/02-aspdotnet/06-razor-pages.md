---
title: "Razor Pages"
date: 2018-08-24T10:53:05-05:00
weight: 60
pre: "<b>6. </b>"
---

ASP.NET Core adds a project type to Visual Studio's new project wizard, _ASP.NET Core web application_ which uses _Razor Pages_.  The Razor Page approach represents a hybrid approach between a MVC and Pipeline architecture and leverages some of the ideas of component-based design that we saw with WPF applications.

The program entry point is _Program.cs_, which creates the web server our application will run on.  In it, we initialize and configure the server based on the _Startup.cs_ class, which details what aspects of the ASP.NET program we want to use.  The wizard does the initial configuration for us, and for now we'll leave the defaults:

* Adding the Razor Pages service (which allows us to use Razor Pages)
* Enabling HTTPS redirection (which instructs browsers making HTTP requests against our server to make HTTPS requests instead)
* Enabling the use of static files, which means files in the _wwwroot_ folder will be served as they are, in as efficient a manner of possible
* Mapping requests to razor pages (this makes a request against a route like _/index_ map to the _Pages/Index.cshtml_ razor page)

Under this architecture, any file we want to serve as-is (i.e. our CSS and JavaScript files), we'll place in _wwwroot_ folder.  Any route we want to serve dynamically, we'll create a corresponding Razor page for in the _Pages_ folder.

## Razor Page Syntax

Let's look at an example Razor page, _index.cshtml_, and then break down its components:

```razor 
@page 
@model IndexModel
@{
    ViewData["Title"] = "Home page";
}
<div class="text-center">
    <h1 class="display-4">Welcome</h1>
    <p>Learn about <a href="https://docs.microsoft.com/aspnet/core">building Web apps with ASP.NET Core</a>.</p>
</div>
```

The `@page` line indicates to the compiler that this file represents a Razor page.  This is necessary for the page to be interpreted correctly, and for setting up the mapping from a request for the route _/index_ to be mapped to this page (_Index.cshtml_).

The `@model` line indicates the _model_ class to use with this page.  Conventionally, the model class has the same name as the Razor page, plus a _.cs_ extension, though we can use a different model file if needed.  If we follow the convention, the model file is grouped with the Razor page file, much like the codebehind files in WPF and Forms. The model class provides the data for the web page, in a manner somewhat like the ViewModel classes we worked with in WPF.  We'll talk more about model classes shortly.

The `@{}` section is a place to define variables.  In this case, we add a key/value pair to the `ViewData` dictionary.  This dictionary is available in both the page and the layout, and is an easy way to pass values between them (in this case, we are providing a title to the layout). The layout is discussed below.

Finally, the page content itself is presented in Razor syntax - a mixture of HTML and embedded C# proceeded by the `@` symbol.  Note that we do not need to provide termination to the C# code - the compiler will automatically determine when we switch from code back to HTML based on the grammar of the C# language.

## Layouts

If you remember from our discussions of HTML, a valid HTML page must have a `<!DOCTYPE html>` element, and `<html>`, `<head>`, `<title>`, and `<body>` elements.  But where are these in our Razor page?  It exists in the _Pages/Shared/_Layout.cshtml_ file:

```cshtml
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>@ViewData["Title"] - ExampleWebApplication</title>
    <link rel="stylesheet" href="~/lib/bootstrap/dist/css/bootstrap.min.css" />
    <link rel="stylesheet" href="~/css/site.css" />
</head>
<body>
    <header>
        <nav class="navbar navbar-expand-sm navbar-toggleable-sm navbar-light bg-white border-bottom box-shadow mb-3">
            <div class="container">
                <a class="navbar-brand" asp-area="" asp-page="/Index">ExampleWebApplication</a>
                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target=".navbar-collapse" aria-controls="navbarSupportedContent"
                        aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="navbar-collapse collapse d-sm-inline-flex flex-sm-row-reverse">
                    <ul class="navbar-nav flex-grow-1">
                        <li class="nav-item">
                            <a class="nav-link text-dark" asp-area="" asp-page="/Index">Home</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link text-dark" asp-area="" asp-page="/Privacy">Privacy</a>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>
    </header>
    <div class="container">
        <main role="main" class="pb-3">
            @RenderBody()
        </main>
    </div>

    <footer class="border-top footer text-muted">
        <div class="container">
            &copy; 2020 - ExampleWebApplication - <a asp-area="" asp-page="/Privacy">Privacy</a>
        </div>
    </footer>

    <script src="~/lib/jquery/dist/jquery.min.js"></script>
    <script src="~/lib/bootstrap/dist/js/bootstrap.bundle.min.js"></script>
    <script src="~/js/site.js" asp-append-version="true"></script>

    @RenderSection("Scripts", required: false)
</body>
</html>
```

Using a layout file allows us to place boilerplate HTML (code that is repeated on every page of our site) in a single location, and share it amongst all pages in our application.  The `@RenderBody()` line indicates where the content of the Razor page will be rendered.

Note that we also implement a navigation menu in this layout.  Instead of giving the links in this navigation page a `href` element, we use `asp-page`, which converts into an appropriate `href` linking to one of our Razor pages on compilation.  Thus `asp-page="/Index"` will point to our _Index.cshtml.cs_ page.  The `asp-page` is an example of a [TagHelper](https://docs.microsoft.com/en-us/aspnet/core/mvc/views/tag-helpers/intro?view=aspnetcore-3.1), syntax that provides extra details to be processed by the Razor rendering engine. 

We can include other sections within the layout with `@RenderSection()` For example, the `@RenderSection("Scripts", required: false)` will render a "Scripts" section, if there is one defined in our Razor page.  We define such sections with the `@section` syntax, i.e.:

```cshtml
@section Scripts{
    <script src="my-script.js"></script>
}
```

Would place the additional `<script>` element in the rendered Razor page.  You can define as many sections as you want.

While the _Pages/Shared/_Layout.cshtml_ file is the default layout, you can define your own layout files.  These should also be placed in the _Pages/Shared_ folder, and their name should begin with an underscore.  You can then set it to be used as the layout for your page by setting the page's `Layout` property:

```cshtml
@{
    Layout = "_YourLayout";
}
```

Where the string you set the property to is the name of your layout.

## Model Classes 

The model class serves a similar role to the codebehind classes of your WPF and Windows Forms applications.  Any public properties defined in the model class are accessible in the Razor page.  I.e. if we defined a property:

```csharp
public class IndexModel:PageModel {

    public DateTime CurrentTime 
    {
        get 
        {
            return DateTime.Now;
        }
    }

    public IActionResult OnGet()
    {

    }
}
```

We could use it in the corresponding Razor page:

```csharp
@page 
@model IndexModel 

<p>The current time is @Model.CurrentTime</p>
```

In addition, the model class can define a method to be triggered on each HTTP Request, i.e. the `OnGet()` method will be triggered with each HTTP GET request, and `OnPost()` will be called with each HTTP POST request.  You can define a method for any of the valid HTTP request verbs that will be invoked on each corresponding request.