---
title: "Form Data"
pre: "3. "
weight: 30
date: 2018-08-24T10:53:26-05:00
---

Form data is simply serialized key/value pairs pulled from a form and encoded using one of the three possible encoding strategies.  Let's look at each in turn.

### x-www-form-urlencoded

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


### multipart/form-data 

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

`<form enctype="multipart/form-data" method="POST">`
