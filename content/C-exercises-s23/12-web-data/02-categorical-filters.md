---
title: "Adding Categorical Filters to the Movie Site"
pre: "b. "
weight: 2
date: 2018-08-24T10:53:26-05:00
---

Let's add some filters to the page as well.  We'll start with _categorical_ filters, i.e. filtering by category.  Let's start by filtering for MAA Rating.  We know that there are only a handful of ratings issued by the Motion Picture Association of America - G, PG, PG-13, R, and NC-17.  We might be tempted to use an enumeration to represent these values, but in C# an enumeration cannot have strings for values.  Nor can we use the hyphen (`-`) in an enumeration name.  

## Defining the MPAA Ratings

So let's define a string array with our MPAA values, and make it accessible from our `MovieDatabase` class:


```csharp 
    /// <summary>
    /// Gets the possible MPAARatings
    /// </summary>
    public static string[] MPAARatings
    {
        get => new string[]
        {
            "G",
            "PG",
            "PG-13",
            "R",
            "NC-17"
        };
    }
```

Now in our `<form>` in _Index.cshtml_ we can add a checkbox for each of these possible values:

```html
<form>
    @foreach  (string rating in MovieDatabase.MPAARating) 
    {
        <label>
            <input type="checkbox" name="MPAARatings" value="@rating"/>
            @rating
        </label>
    }
    
    <input type="text" name="SearchTerms" value="@Model.SearchTerms"/>
    <input type="submit" value="Search">
</form>
```

If you try running the project now, and check a few boxes, you'll see the query string results look something like:

```
?SearchTerms=&MPAARatings=G&MPAARatings=PG-13
```

Notice how the key _MPAARatings_ is repeated twice?  What would that look like in our PageModel?  We can find out; declare a `var` to hold the value in the `OnGet()` method of _Index.cshtml.cs_:

```csharp
    var MPAARatings = Request.Query["MPAARatings"];
``` 

If we add a breakpoint on this line, and run our code, then check several boxes (you'll have to _continue_ the first time you hit the breakpoint), then step over the line, we'll see that the var `MPAA` rating is set to a _string collection_.  We could therefore store it in an array property in _Index.cshtml.cs_, much like we did with our `SearchTerms`:

```csharp
    /// <summary>
    /// The filtered MPAA Ratings
    /// </summary>
    public string[] MPAARatings { get; set; }
```

And we can refactor the line we just added to `OnGet()` to use this new property:

```csharp
    MPAARatings = Request.Query["MPAARatings"];
```

Then, in our _Index.cshtml.cs_ Razor Page, we can refactor the checkbox to be checked if we filtered against this rating in our last request:

```html
    <input type="checkbox" name="MPAARating" value="@rating" checked="@Model.MPAARatings.Contains(rating)"/>
```

Now our filters stick around when we submit the search request.  That just leaves making the filters actually _work_.

## Applying MPAA Rating Filters

Let's add another method to our `MovieDatabase` class, `FilterByMPAARating()`:

```csharp 
    /// <summary>
    /// Filters the provided collection of movies
    /// </summary>
    /// <param name="movies">The collection of movies to filter</param>
    /// <param name="ratings">The ratings to include</param>
    /// <returns>A collection containing only movies that match the filter</returns>
    public static IEnumerable<Movie> FilterByMPAARating(IEnumerable<Movie> movies, IEnumerable<string> ratings)
    {
        // TODO: Filter the list

    }
```

Notice that in _this_ method, we accept an `IEnumerable<Movie>` parameter.  This is the list of movies we want to filter.  We use this, instead of the `All()` we did in the `Search()` method, as we would want to filter the _results_ of a search.

Let's do a null/empty check, and just return this shortlist if no filters are specified:

```csharp
    // If no filter is specified, just return the provided collection
    if (ratings == null || ratings.Count() == 0) return movies;
```

Otherwise, we'll use the same process we did before.  Start with an empty list of movies, and iterate over the collection seeing if any match.  However, as we have _two_ collections (the movies _and_ the ratings), we'll see if the ratings collection contains the supplied movie's rating.

```csharp
    // Filter the supplied collection of movies
    List<Movie> results = new List<Movie>();
    foreach(Movie movie in movies)
    {
        if(movie.MPAARating != null && ratings.Contains(movie.MPAARating))
        {
            results.Add(movie);
        }
    }
```

Finally, we'll return our results:

```csharp
    return results;
```

Now, back in our PageModel _Index.cshtml.cs_, we'll apply our filter to the results of our search.  The refactored `OnGet()` should then be:

```csharp
    public void OnGet()
    {
        SearchTerms = Request.Query["SearchTerms"];
        MPAARatings = Request.Query["MPAARatings"];
        Movies = MovieDatabase.Search(SearchTerms);
        Movies = MovieDatabase.FilterByMPAARating(Movies, MPAARatings);        
    }
```

Now we can run a search with filters applied.  For example, searching for the word "Love" and movies that are PG or PG-13 yields:

![Filtered Search Results](/images/6.8.4.png)

You might be wondering why _Cloverfield_ is listed.  But remember, we're searching by substring, and C __LOVE__ rfield contains love!

## Filtering by Genre 

Let's add filters for genre next.  But what genres should be included?  This is not as clear-cut as our MPAA rating, as there is no standards organization that says "these are the only offical genres that exist."  In fact, new genres emerge from time to time.  So a better source of this info might just be to see what Genres are defined in our data, i.e.:

```csharp 
    HashSet<string> genres = new HashSet<string>();
    foreach(Movie movie in All) {
        if(movie.MajorGenre != null) 
        {
            genres.Add(movie.MajorGenre);
        }
    }
```

Here we use a [HashSet](https://docs.microsoft.com/en-us/dotnet/api/system.collections.generic.hashset-1?view=netframework-4.8) instead of a list, as it only adds each unique item once.  Duplicates are ignored.

But where would this code go?  We could place it in a getter for `MovieDatabase.Genres`:

```csharp 
    public IEnumerable<string> Genres 
    {
        get 
        {
            HashSet<string> genres = new HashSet<string>();
            foreach(Movie movie in All) {
                if(movie.MajorGenre != null) 
                {
                    genres.Add(movie.MajorGenre);
                }
            }
        }
    }
```

But this means that every time we want to access it, we'll search through all the movies... This is an O(n) operation, and will make our website slower.  

Instead, let's create a private static variable in the `MovieDatabase` class to _cache_ this collection as an array of strings:

```csharp 
    // The genres represented in the database
    private static string[] _genres;
```

And expose it with a public static property:

```csharp 
    /// <summary>
    /// Gets the movie genres represented in the database 
    /// </summary>
    public static string[] Genres => _genres;
```

And finally, we'll populate this array in the static constructor of `MovieDatabase`, after the JSON file has been processed:

```csharp 
    HashSet<string> genreSet = new HashSet<string>();
    foreach(Movie movie in _movies) {
        if(movie.MajorGenre != null) 
        {
            genreSet.Add(movie.MajorGenre);
        }
    }
    _genres = genreSet.ToArray();
```

This approach means the finding of genres only happens once, and getting the `Genre` property is a constant-time O(1) operation.

We can implement the filters for the genres in the same way as we did for the MPAA filters; I'll leave that as an exercise for the reader.