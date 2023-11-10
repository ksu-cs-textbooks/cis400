---
title: "Form Data"
pre: "3. "
weight: 30
date: 2018-08-24T10:53:26-05:00
---

Form data is simply serialized key/value pairs pulled from a form and encoded using one of the three possible encoding strategies, and submitted using the specified method (usually GET or POST).  

So when we submit a form containing two text inputs for first and last name:

```html
<form method="post">
    <label for="First">First Name:</label>
    <input type="text" name="First"/>
    <label for="Last">Last Name:</label>
    <input type="text" name="Last"/>
    <input type="Submit" value="Save Name"/>
</form>
```

And enter the values "Frank" and "Jones", the form is serialized as the key-value pairs:

```json
{
    "First": "Frank",
    "Last": "Jones"
}
```

{{% notice info %}}
Here we are displaying the key-value pairs as JSON for legibility, but how the pairs ar encoded depends on the encoding strategy as discussed below.
{{% /notice %}}

If a form contains _multiple_ inputs with the same name, they are serialized as an array, i.e. the form:

```html
<form method="post">
    <label>Enter three numbers:</label>
    <input type="number" name="Number"/>
    <input type="number" name="Number"/>
    <input type="number" name="Number"/>
    <input type="Submit" value="Save Numbers"/>
</form>
```

Would be serialized as:

```json
{
    "Number" : [2, 3, 4]
}
```

Finally, toggle inputs like checkboxes and radio buttons _only_ submit a value when checked, i.e. given the following form:

```html
<form method="post">
    <label>Do the thing:</label>
    <input type="checkbox" name="DoTheThing" value="thing"/>
    <input type="Submit" value="Save Numbers"/>
</form>
```

Would serialize as:

```json
{}
```

When the checkbox is **not** checked, or:

```json
{
    "DoTheThing": "thing"
}
```

When the checkbox **is** checked.  

Now that we've discussed how inputs are serialized into key/value or key/array of value pairs, let's turn our attention to the method used to submit the form, and then look at each encoding strategy in turn.

### Method
The HTTP method determines if the form data is sent as part of the _url_ of the request, or in the _body_ of the request. 

#### GET Requests
With a GET request, the serialized form data is appended to the url as a _query_ or _search_ parameter. This takes the form of a question mark: `?` followed by the serialized form data.  In addition, the serialized data must be url-encoded to ensure the URL remains valid, as it may contain reserved characters (i.e. the characters `:`,`/`,`?`,`#`, `&`, and `=`) have special meanings in URLs, so the encoded data can't contain them). 

For example, searching using Google uses a GET request, so when we type "Razor Pages" into Google and click search, it makes a request against the URL: `https://www.google.com/search?q=razor+pages` (Note it adds additional form data fields for a variety of purposes).

A GET request is appropriate when the data you are submitting is small, like search terms or filter values.  Once you start submitting larger amounts of data (like parameters to build an object from), you'll probably want to switch to POST requests.  Also, remember the form data for GET requests are visible in the URL, so you'll want to use POST requests when seeing those values might be confusing or annoying to users.  

Finally, passwords should **NEVER** be sent using a GET request, as doing so makes them visible in the URL.

{{% notice tip %}}
The default method for form submission is a GET request, so if you don't specify the `method` parameter, the form will be submitted using this method.
{{% /notice %}}

#### POST Requests

A POST request is submitted as the _body_ of the request.  This is the most appropriate method for large submissions, submissions with data you don't want visibly displayed in the browser, and it is the _only_ way to submit form data including files (which must be encoded using "multipart/form-data" as described below).

### Encoding Strategies

There are two primary strategies for submitting data to a server _from HTML forms_ (note that you can submit data to servers using other strategies when submitting from a program - we'll discuss some of these in the next chapter).  These strategies are `x-www-form-urlencoded` and `multipart/form-data`.  We'll take a look at how these encode data next.

#### x-www-form-urlencoded

The default encoding method is `application/x-www-form-urlencoded`, which encodes the form data as a string consisting of key/value pairs.  Each pair is joined by a `=` symbol, and pairs are in turn joined by `&` symbols.  The key and value strings are further encoded using [percent encoding (URL encoding)](https://developer.mozilla.org/en-US/docs/Glossary/percent-encoding), which replaces special characters with a code beginning with a percent sign (i.e. `&` is encoded to `%26`).  This prevents misinterpretations of the key and value as additional pairs, etc.  Percent encoding is also used to encode URL segments (hence the name URL encoding).

Thus, the form:

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

Would be encoded as:

```
Name=Grover&Color=Blue&Age=36
```

The [HTTPUtility](https://docs.microsoft.com/en-us/dotnet/api/system.web.httputility.urlencode?view=netcore-3.1) class in the `System.Web` namespace contains helpful methods for encoding and decoding URL strings.

URL-Encoded form data can be submitted with either a GET or POST request.  With a GET request, the form data is included in the URL's query (search) string, i.e. our form above might be sent to:

```
www.sesamestreet.com/muppets/find?Name=Grover&Color=Blue&Age=36
```

Which helps explain why the entire seralized form data needs to be URL encoded - it is included as part of the url!

When submitted as a post request, the string of form data is the body of the request.


#### multipart/form-data 

The encoding for `multipart/form-data` is a bit more involved, as it needs to deal with encoding both regular form values and binary file data.  It deals with this challenge by separating each key/value pair by a sequence of bytes known as a _boundary_, which does not appear in any of the files.  This boundary can then be used to split the body back into its constituent parts when parsing.  Each part of the body consists of its own _head_ and _body_ sections, with the body of most elements simply their value, while the body of file inputs is the file data encoded in base64.  Thus, the form:

```html
<form>
    <input type="text" name="Name" value="Grover"/>
    <select name="Color">
        <option value="Red">Red</option>
        <option selected="true" value="Blue">Blue</option>
        <option value="Green">Green</option>
    </select>
    <input type="number" name="Age" value="36"/>
    <input type="file" name="Image" value="Grover.jpg" />
</form>
```

Would be encoded into a POST request as:

```
POST /test HTTP/1.1 
Host: foo.example
Content-Type: multipart/form-data;boundary="boundary" 

--boundary 
Content-Disposition: form-data; name="Name" 

Grover
--boundary 
Content-Disposition: form-data; name="Color" 

Blue
--boundary 
Content-Disposition: form-data; name="Age" 

36
--boundary 
Content-Disposition: form-data; name="Image"; filename="Grover.jpg" 

/9j/4AAQSkZJRgABAQEAYABgAAD/2wBDAAgGBgcGBQgHBwcJCQgKDBQNDAsLDBkSEw8UHRofHh0aHBwgJC4nICIsIxwcKDcpLDAxNDQ0Hyc5PTgyPC4zNDL/2wBDAQkJCQwLDBgNDRgyIRwhMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjI...
--boundary--
```

Files can _only_ be submitted using `multipart/form-data` encoding.  If you attempt to use `application/x-www-form-urlencoded`, only the file name will be submitted as the value.  Also, as `multipart/form-data` is always submitted as the body of the request, it can only be submitted as part of a POST request, never a GET.  So a form containing a `file` input should always specify:

```html
<form enctype="multipart/form-data" method="POST">
```
