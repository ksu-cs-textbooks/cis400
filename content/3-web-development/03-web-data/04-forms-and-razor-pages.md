---
title: "Razor Pages and Form Data"
pre: "4. "
weight: 40
date: 2018-08-24T10:53:26-05:00
---

While C# does provide utilities for parsing URL-encoded strings, the functionality of parsing incoming form data is built into the ASP.NET response handling.  Thus, when writing a Razor page application, we don't need to perform decoding on the form data - it has already been done for us.  There are several strategies built into Razor Pages to access this information:

### The Request Object 

The first of these is the [HttpRequest](https://docs.microsoft.com/en-us/dotnet/api/system.web.httprequest?view=netframework-4.8) object, which is available as the `Request` property within a `Page`.  This object provides access to the `QueryString` and `Form`, as well as `Cookies`, `ServerVariables` and more.

If the form was submitted as a GET request, then the `Request.QueryString` is a collection of key-value pairs used like a dictionary, i.e. to access the value of the input with name "Color", we would use: `Request.QueryString["Color"]`.

Similarly, the `Form` also exposes the form content as a collection key-value pairs, so we could access a POST request's input with the name "Color" value with `Request.Form["Color"]`.

Finally, the request also allows for checking _both_ collections using its own accessor property, i.e. `Request["Color"]` would provide the submitted value for the input "Color" if it was send with _either_ a GET or POST request.

### Parameter Binding 

A second approach to accessing form data in ASP.NET is [Parameter Binding](https://docs.microsoft.com/en-us/aspnet/web-api/overview/formats-and-model-binding/parameter-binding-in-aspnet-web-api).  You've already seen the `OnGet()` method of the `PageModel` class.  This is invoked every time a GET request to our server matches the page it is associated with.  We can also supply methods for other HTTP actions, i.e. POST, PUT, DELETE map to `OnPost()`, `OnPut()`, and `OnDelete()` respectively.  For each of these methods, we can use parameter binding to automatically parse and convert form data into parameter variables.

In its simplest form, we simply declare parameters whose type and name match those of our form.  Thus, for the form: 

```html
<form>
    <input type="text" name="Name" value="Grover"/>
    <select name="Color">
        <option value="Red">Red</option>
        <option selected="true" value="Blue">Blue</option>
        <option value="Green">Green</option>
    </select>
    <input type="number" name="Age" value="36"/>
</form>
```

We could add several parameters to our `OnGet()` corresponding the names and types of the form fields:

```csharp
OnGet(string Name, string Color, int Age){
    // Name would be "Grover"
    // Color would be "Blue"
    // Number would be 36
}
```

The form values are automatically converted and bound to the corresponding parameters of the `OnGet` method.  If the form does not contain the corresponding parameter, then it is assigned the default value (for value types) or null (for reference types).  

{{% notice info %}}
There are times you may not want to use default values for value types.  For example, in the form above, if the `Age` property is not specified, it will default to `0`.  If we instead wanted it to be `null`, we could use the [`Nullable<T>`](https://docs.microsoft.com/en-us/dotnet/csharp/language-reference/builtin-types/nullable-value-types) type: 

```csharp
OnGet(string Name, string Color, Nullable<int> Age) {...}
```

This allows `Age` to be `null`, in addition to all its normal possible values.  You can also specify a nullable type with the `?` shorthand, i.e.:

```csharp
OnGet(string Name, string Color, int? Age) {...}
```
{{% /notice %}}

### Model Binding

A third approach is [Model Binding](https://docs.microsoft.com/en-us/aspnet/core/mvc/models/model-binding?view=aspnetcore-3.1), where decorators are used on public properties of the `PageModel` class to indicate that they should be bound to form data, i.e.:

```csharp
public class Muppet : PageModel {

    /// <summary>The muppet's name</summary>
    [BindProperty]
    public string Name { get; set; }

    /// <summary>The muppet's color</summary>
    [BindProperty]
    public string Color { get; set; }

    ///<summary>The muppet's age</summary>
    [BindProperty]
    public int Age {get; set;}    
}
```

When set up this way, the properties will be populated with the corresponding form data on POST, PUT, and PATCH requests.  By default, they will _not_ be populated on GET requests, though you can override this behavior with `SupportsGet`:

```csharp
    /// <summary>The muppet's name</summary>
    [BindProperty(SupportGet = true)]
    public string Name { get; set; }
```

Finally, we can indicate _all_ properties of the model class should be bound with a single `[BindsProperties]` decorator on the class, i.e.:

```csharp
[BindProperties(SupportsGet = true)]
public class Muppet : PageModel {

    /// <summary>The muppet's name</summary>
    [BindProperty]
    public string Name { get; set; }

    /// <summary>The muppet's color</summary>
    [BindProperty]
    public string Color { get; set; }

    ///<summary>The muppet's age</summary>
    [BindProperty]
    public int Age {get; set;}    
}
```

You might be wondering why ModelBinding does not work with GET requests by default.  To understand that it is useful to understand how web applications working with data have come to represent working with that data.  We'll look at one of these approaches, RESTful routes, next.