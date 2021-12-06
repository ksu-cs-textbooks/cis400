---
title: "Asynchronous Requests"
pre: "5. "
weight: 50
date: 2018-08-24T10:53:26-05:00
---

Now that we're more comfortable with `using` statements, let's return to our request-making code:

```csharp
WebRequest request = WebRequest.Create("http://api.jokes.one/jod");
using Stream responseStream = response.GetStream() 
{
  StreamReader reader = new StreamReader(responseStream);
  string responseText= reader.ReadToEnd();
  Console.WriteLine(responseText);
}
response.Close();
```

The `response.GetStream()` triggers the http request, which hits the API and returns its result.  Remember a HTTP request is streamed across the internet, then processed by the server, and the response streamed back.  That can take some time (at least to a computer).  While the program waits on it to finish, it cannot do anything else.  For some programs, like one that only displays jokes, this is fine. But what if our program needs to also be responding to the user's events - like typing or moving the mouse? While the program is waiting, it is effectively paused, and nothing the user does will cause the program to change.

#### Asynchronous Methods
This is where asynchronous methods come in. An asynchronous method operates on a separate thread, allowing execution of the program to continue.  

let's revisit our `WebRequest` example:

```csharp
WebRequest request = WebRequest.Create("http://api.jokes.one/jod");
```

We can then make the request _asynchronously_ by calling the asynchronous version of `GetResponse()` - `GetResponseAsync()`:

```csharp
WebResponse response = await request.GetResponseAsync();
```

The `await` keyword effectively pauses this thread of execution until the response is received.  Effectively, the subsequent code is set aside to be processed when the asynchronous method finishes or encounters an error.  This allows the main thread of the program to continue responding to user input and other events.  The rest of the process is handled exactly as before:

```csharp
using Stream responseStream = response.GetStream() 
{
  StreamReader reader = new StreamReader(responseStream);
  string responseText= reader.ReadToEnd();
  Console.WriteLine(responseText);
}
```

#### Writing Asynchronous Methods

Normally we would wrap the asynchronous method calls within our own asynchronous method.  Thus, we might define a method, `GetJoke()`:

```csharp
public string async GetJoke()
{
  WebRequest request = WebRequest.Create("http://api.jokes.one/jod");
  WebResponse response = await request.GetResponseAsync();
  using Stream responseStream = response.GetStream() 
  {
    XmlDocument xDoc = new XmlDocument();
    xDoc.Load(responseStream);
    var node = xDoc.SelectSingleNode("/response/contents/jokes/joke/text");
    return node.InnerText;
  }
  return "";
}
```

#### Asynchronous ASP Request/Response Methods

ASP.Net includes built-in support for asynchronous request handling.  You just need to add the `async` keyword to your `OnGet()` or `OnPost()` method, and the ASP.NET server will process it asynchronously.

For example, we could invoke our `GetJoke()` method in a `OnGet()`:

```csharp
public class JokeModel : PageModel 
{
    public async IActionResult OnGet()
    {
        var joke = await GetJoke();
        return Content(joke);
    }
}
```

This will cause the text of the joke to be sent as the response, and allow other pages to be served while this one request is awaiting a response from the Joke API.