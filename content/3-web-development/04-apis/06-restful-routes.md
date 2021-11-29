---
title: "RESTful Routes"
pre: "6. "
weight: 60
date: 2018-08-24T10:53:26-05:00
---

Many web applications deal with some kind of _resource_, i.e. people, widgets, records.  Much like in object-orientation we have organized the program around objects, many web applications are organized around resources.  And as we have specialized ways to construct, access, and destroy objects, web applications need to create, read, update, and destroy resource records (we call these CRUD operations).

In his 2000 PhD. dissertation, Roy Fielding defined [Representational State Transfer (REST](https://en.wikipedia.org/wiki/Representational_state_transfer)), a way of mapping HTTP routes to the CRUD operations for a specific resource.  This practice came to be known as RESTful routing, and has become one common strategy for structuring a web application's routes.  Consider the case where we have an online directory of students.  The students would be our resource, and we would define routes to create, read, update and destroy them by a combination of HTTP action and route:

<table>
  <tr>
    <th>CRUD Operation</th>
    <th>HTTP Action</th>
    <th>Route</th>
  </tr>
  <tr>
    <td>Create</td>
    <td>POST</td>
    <td>/students</td>
  </tr>
  <tr>
    <td>Read (all)</td>
    <td>GET</td>
    <td>/students</td>
  </tr>
  <tr>
    <td>Read (one)</td>
    <td>GET</td>
    <td>/students/[ID]</td>
  </tr>
  <tr>
    <td>Update</td>
    <td>PUT or POST</td>
    <td>/students/[ID]</td>
  </tr>  
  <tr>
    <td>Destroy</td>
    <td>DELETE</td>
    <td>/students/[ID]</td>
  </tr>
</table>

Here the `[ID]` is a unique identifier for the individual student.  Note too that we have _two_ routes for reading - one for getting a list of _all_ students, and one for getting the details of an individual student.

REST is a remarkably straightforward implementation of very common functionality, no doubt driving its wide adoption.  Razor pages supports REST implicitly - the RESTful resource _is the PageModel object_.  This is the reason model binding does not bind properties on GET requests by default - because a GET request is used to retrieve, not update a resource.  However, properties derived from the route (such as `:ID` in our example, _will_ be bound and available on GET requests).

With Razor Pages, you can specify a route parameter after the `@page` directive.  I.e. to add our `ID` parameter, we would use:

```cshtml
@page "{ID?}"
```

We can use any parameter name; it doesn't have to be `ID` (though this is common).  The `?` indicates that the ID parameter is optional - so we can still visit `/students`.  Without it, we only can visit specific students, i.e. `/students/2`.

Route parameters can be bound using any of the binding methods we discussed previously - parameter binding, model binding, or be accessed directly from the `@RouteData.Values` dictionary.  When we _are_ using these parameters to create or update new resources, we often want to take an additional step - _validating_ the supplied data.


