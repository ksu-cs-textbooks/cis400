+++
title = "Web Data"
date = 2018-08-24T10:53:05-05:00
weight = 120
chapter = false
pre = "<b>12. </b>"
+++

Now that we've seen how to dynamically create the content of a Razor Page on the server, we should turn our attention to how we can do so based on our user's needs.  Consider the example application we have been developing - it exposes a database of movie information to the user.  How might a user want to use this database?  They might want to find the details for a specific movie - who directed it, when was it released, etc.  They might be looking for a movie they want to watch in a favorite genre.  They might be looking to find all the movies directed by a favorite director... there are a lot of possibilities.

As software developers, we need to anticipate how our users will likely want to use the software we are developing.  And with that in mind, we need to develop user interfaces that allow the user to communicate those needs to the software we are writing as concisely as possible.  Remember that in HTTP, all communication between the client (and its user) and the server (our web application), is mediated through the request-response mechanism:

![Request-Response Mechanism](/images/request-response-pattern.png)

Thus, any information the user wants to supply the server is typically communicated _through_ a request.  HTML provides a mechanism for enabling this communication in a structured way - forms.  A `<form>` element, when submitted, serializes the values of all `<input>` elements contained within it and submits them to the server in the request.

The values in the form are serialized (converted into text) and submitted with the request.  Exactly how this serialization happens depends on the kind of request.  For GET requests the serialized data is added to the url as the query string.  For POST requests, the serialized data is sent as the body of the request.  

You can usually use either form (except when uploading files, which must be POSTed).  However, you might think about the semantics of each action.  A GET request is for retrieving something _from_ the server, so any data your sending is about modifying that request.  Thus, search and filter requests make sense as a GET request.  A POST request is about sending something _to_ the server, thus account creation, blog posts, and so on make sense as a POST request.

{{% notice info %}}
When sent using secure HTTP (HTTPS), both the query string portion of the URL and the request body are encrypted, so there is no difference in the in-transit security.  However, browsers typically store the full URL in the history, so if sensitive information is being sent, you might want to use POST requests.
{{% /notice %}}
