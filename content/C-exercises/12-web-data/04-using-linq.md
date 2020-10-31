---
title: "Using LINQ"
pre: "d. "
weight: 4
date: 2018-08-24T10:53:26-05:00
---

In our movie website, we've been using a custom "database" object, `MovieDatabase` to provide the movie data and search and filter functionality.  In professional practice, we would probably replace this with an external database program.  These programs have been developed specifically for persisting and accessing data, and leverage specialized data structures like B+ trees that allow them to do searches and filters much more efficiently.

Some of the most widely adopted database programs are _relational databases_ like MySQL, MsSQL, Postgres, and SQLLite.  These predate object-orientation, and accept requests for data in the form of SQL (Structured Query Language).  You will learn more about these databases and how to use them in CIS560.

## LINQ
Microsoft, inspired by SQL, introduced Language Integrated Query (LINQ) in 2007 to bring the concept of a query language into .NET.  LINQ allows you to construct queries in either chained method calls or in a syntax similar to SQL that can operate on collections or relational databases.  

For relational databases, LINQ queries are converted internally to SQL queries, and dispatched to the database.  But their real power is that they can also be used with any collection that supports either the `IEnumerable` or `IEnumerable<T>` interfaces.  LINQ can be used to replace the kinds of filter and search functions we wrote for our `MovieDatabase`.  Let's try it out with our movie website.

LINQ operates through extension methods, so we need to be sure to add the LINQ namespace to our CS files where we are going to employ them.  We'll be adding our LINQ commands to our page model, so sure that is the case with your _Pages/Index.cshtml.cs_:

```csharp
using System.Linq;
```

Adding this using statement will bring in all the extension methods for LINQ, and will also prompt Visual Studio to recognize the query-style syntax.

## Searching with LINQ

One of the most useful extension methods in LINQ is [Where()](https://docs.microsoft.com/en-us/dotnet/api/system.linq.enumerable.where?view=netcore-3.1).  It can be invoked on any `IEnumerable` and accepts a `Func` (a delegate type).  This delegate takes a single argument - the current item being enumerated over, and its body should return a boolean value - `true` if the item should be included in the results, and `false` if it should not.

We can thus use our existing `SearchTerms` property as the basis for our test: `movie => movie.Title != null && movie.Title.Contains(SearchTerms)` (note that with lambda expressions, if the result is single expression we can omit the `{}` and the `return` is implied).  Also note that we incorporate the null check directly into the expression using the boolean and `&&` operator.

We can replace our current search with a `Where()` call invoking this method:

```csharp
Movies = MovieDatabase.All.Where(movie => movie.Title != null && movie.Title.Contains(SearchTerms, String));
```
However if we run the program we will encounter a null exception.  On our first GET request, the value of `SearchTerms` is null, which is _not_ a legal argument for `String.Contains()`.

## Making Search Conditional

If the `SearchTerms` is null, that indicates that the user did not enter a search term - accordingly, we probably don't want to search.  We can wrap our filter in an `if` test to prevent applying the filter when there is no search term.  Thus, we would refactor our filtering expression to:

```csharp
Movies = MovieDatabase.All;
// Search movie titles for the SearchTerms
if(SearchTerms != null) {
    Movies = Movies.Where(movie => movie.Title != null && movie.Title.Contains(SearchTerms, StringComparison.InvariantCultureIgnoreCase));
}
```

Now if we run the program, and search for a specific term, we'll see our results is modified to contain _only_ those movies with the terms in thier title!

We can also use the query syntax instead of the extension method syntax, which is similar to SQL:

```csharp
Movies = MovieDatabase.All;
// Search movie titles for the SearchTerms
if(SerchTerms != null)
{
    Movies = from movie in Movies
        where movie.Title != null && movie.Title.Contains(SearchTerms, StringComparison.InvariantCultureIgnoreCase)
        select movie;
}
```

This syntax is converted by the C# compiler to use the extension methods as part of the compilation process.

You can use either form for writing your queries, though it is best to stay consistent within a single program.

## Filtering with LINQ

Filtering is also accomplished through the [Where()](https://docs.microsoft.com/en-us/dotnet/api/system.linq.enumerable.where?view=netcore-3.1).  We can add additional tests within our search `Where()`, but it is more legible to add _additional_ `Where` calls:

```csharp
Movies = MovieDatabase.All
    // Search movie titles for the SearchTerms
    if(SearchTerms != null) {
        Movies = Movies.Where(movie => movie.Title != null && movie.Title.Contains(SearchTerms, StringComparison.InvariantCultureIgnoreCase));
    }
    // Filter by MPAA Rating
    if(MPAARatings != null && MPAARatings.Length != 0)
    {
        Movies = Movies.Where(movie =>
            movie.MPAARating != null &&
            MPAARatings.Contains(movie.MPAARating)
            );
    }
```

{{% notice todo %}}
The numerical filters are handled the same way - with additional `Where` clauses.  I leave this as an exercise for the reader to complete.
{{% /notice %}}

## Benefits of LINQ

While LINQ is a bit less code for us to write, there is another big benefit - the actual filtering is only applied _when we start iterating through the results_.  This means that LINQ queries with multiple `Where()` invocations can combine them into a single iteration.

Consider our movie website example.  We have four filters - the search, the MPAA Ratings, the IMDB Ratings, and the Rotten Tomato Rating.  In the worst case, each movie in the database would pass each filter, so that our list never got smaller.  With the filter functions we wrote in `MovieDatabase`, we would have to iterate over that full list _four times_.  In terms of complexity, that's **O(4n)**.  

In contrast, because LINQ doesn't actually run the filters until we start iterating, it can combine all the `While` tests into a single boolean expression.  The result is it only has to iterate through the list _once_.  Hence, its complexity becomes **O(n)**.  There is a little additional overhead for holding onto the query information that way, but it's small compared to the benefit.  

Also, we could have done the same kind of optimization ourselves, but it takes a lot of work to set up, and may not be worth it for a single web app.  But LINQ provides us that benefit for free.
