---
title: "Making Requests"
pre: "2. "
weight: 20
date: 2018-08-24T10:53:26-05:00
---

Making a HTTP request is a multi-step process.  First you must establish a connection with the server, then create the request data, then you must stream that data to your server through the connection.  Once the server has received and processed your request data, it should stream a response back to you.

You can write code to handle each step, but most programming languages provide one or more libraries that provide a level of abstraction to this process. The C# language actually offers several options in its system libraries, and there are multiple open-source options as well.

### WebRequest

The simplest of these is the `WebRequest` object.  It represents and carries out a single HTTP request and provides the response.  Let's take a look at an example, which retrieves a "Joke of the Day" from a web API at https://jokes.one:

```csharp
WebRequest request = WebRequest.Create("http://api.jokes.one/jod");
```

This one line of code creates the `WebRequest` object.  Notice that we are **not using a constructor**.  Instead, we invoke a `Create()` method.  This is an example of the [Factory Method Pattern](https://en.wikipedia.org/wiki/Factory_method_pattern), which you will learn more about in CIS 501.  But to briefly introduce the concept, the `WebRequest` class is actually a _base class_ for a multiple different classes, each representing a _specific kind_ of web request (i.e. using HTTP, HTTPS, FTP and so on).  Based on the URI supplied to `WebRequest.Create(Uri uri)`, the method will determine the appropriate kind of request to make, and create and return the corresponding object.

Now that we have our request, we can send it and obtain a response with:

```csharp
WebResponse response = request.GetResponse();
```

This opens the connection to the server, streams the request to it, and then captures the sever's response.  We can access this response as a stream (similar to how we would read a file):

```csharp
using Stream responseStream = response.GetStream() 
{
  StreamReader reader = new StreamReader(responseStream);
  string responseText= reader.ReadToEnd();
  Console.WriteLine(responseText);
}
```

You likely are wondering what the `using` and curly braces `{}` are doing in this code.  They are there because the `Stream` object implements the `IDisposable` interface.  We'll discuss this in detail in the next section.  But for now, let's focus on how we use the stream.  First we create a `StreamReader` to read it:

```csharp 
  StreamReader reader = new StreamReader(responseStream);
```

Then read to the end of the stream:

```csharp
  string responseFromServer = reader.ReadToEnd();
```

And write the response's text to the console:

```csharp
  Console.WriteLine(responseText);
```

Finally, we must close the `WebResponse` object's connection to the server once we are done:

```csharp
  response.Close();
```

This last step is important, as the open connection is actually managed by our operating system, and unless we close it, our system resources will be tied up, making our computer slower and potentially unable to make web requests for other programs (including your browser)!