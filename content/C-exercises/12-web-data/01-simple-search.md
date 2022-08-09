---
title: "Adding Search to the Movie Site"
pre: "a. "
weight: 1
date: 2018-08-24T10:53:26-05:00
---

Let's add a search form and functionality to our movie website.  We'll add this to our _Index.cshtml_ page, just above the `<h1>` element:

```html
    <form>
        <input type="text" name="SearchTerms"/>
        <input type="submit" value="Search">
    </form>
    <h1>Movie Results</h1>
```

We'll also change the `<h1>` contents to "Movie Results".  

Try typing a search term into the search box, and click the _search_ button.  Has anything changed?


### The Request Object 

When you click the _search_ button, the browser serializes your form, and makes a request against your server including the search terms.  By default this request is a __GET__ request, and the contents of the form are serialized using [urlencoding (aka percent encoding)](https://developer.mozilla.org/en-US/docs/Glossary/percent-encoding), a special string format.  This string is then appended to the requested url as the [query string (aka search string)](https://developer.mozilla.org/en-US/docs/Web/API/Location/search) - a series of key-value pairs proceeded by the question mark symbol(`?`) and separated by the ampersand (`&`).

This data is made available to us in our PageModel _Index.cshtml.cs_ by ASP.NET.  Let's take a look at it now.  Notice the method `public void OnGet()`?  This method is invoked _every time the page is requested using a GET request_.  Thus, if we need to do some initialization and/or processing, this would be the place to do it.  

Inside the PageModel, we can access the request data using the `Request` object.  The exact string can be accessed with `Request.QueryString`, or the parsed and deserialized results can be accessed from `Request.Query`.  Let's use the latter to pull out the search terms:

```csharp 
    public void OnGet() 
    {
        String terms = Request.Query["SearchTerms"];
    }
```

We can store that value, and make it available to the page itself, by creating a public property.  Let's create one named `SearchTerms`:

```csharp 
    public string SearchTerms { get; set; }
```

And we'll refactor our `OnGet()` to store the search terms coming in from the request:

```csharp
    public void OnGet() 
    {
        SearchTerms = Request.Query["SearchTerms"];
    }
```

Now we can refactor our input element to use that public property from our model as its default value:

```html
    <input type="text" name="SearchTerms" value="@Model.SearchTerms"/>
```

The first time we visit the index page, the `SearchTerms` value will be null, so our input would have `value=""`.  The browser interprets this as empty.  If we add a search term and click the _search_ button, we'll see the page reload.  And since `@Model.SearchTerms` has a value this time, we'll see that string appear in search box!

Now we just need to search for those terms...

### Adding Search to the Database 

We'll start by defining a new static method in our _MovieDatabase.cs_ file to search for movies using the search terms:

```csharp 
    /// <summary>
    /// Searches the database for matching movies
    /// </summary>
    /// <param name="terms">The terms to search for</param>
    /// <returns>A collection of movies</returns>
    public static IEnumerable<Movie> Search(string terms)
    {
        // TODO: Search database
    }
```

We'll need a collection of results that implements the `IEnumerable<T>` interface.  Let's use the familiar `List<T>`:

```csharp
    List<Movie> results = new List<Movie>();
```

Now, there is a chance that the search terms we recieve are `null`.  If that's the case, we would either 1) return _all_ the movies, or 2) return _no_ movies.  You can choose either option, but for now, I'll return all movies

```csharp 
    // Return all movies if there are no search terms
    if(terms == null) return All;
```

If we _do_ have search terms, we need to add any movies from our database that include those terms in the title.  This requires us to check _each movie_ in our database:

```csharp 
    // return each movie in the database containing the terms substring
    foreach(Movie movie in All)
    {
        if(movie.Title.Contains(terms, StringComparison.InvariantCultureIgnoreCase)) 
        {
            results.Add(movie);
        }
    }   
```

We'll use [String.Contains()](https://docs.microsoft.com/en-us/dotnet/api/system.string.contains?view=netframework-4.8) to determine if our terms are a _substring_ within the title, ignoring case differences.  If we find it, we'll add the movie to our `results` list.

Finally, we'll return that list:

```csharp
    return results;
```

Now, we can refactor our _Index.cshtml.cs_ to use this new search method:

```csharp
    /// <summary>
    /// The movies to display on the index page 
    /// </summary>
    public IEnumerable<Movie> Movies { get; protected set; }

    /// <summary>
    /// The current search terms 
    /// </summary>
    public string SearchTerms { get; set; }

    /// <summary>
    /// Gets the search results for display on the page
    /// </summary>
    public void OnGet() 
    {
        SearchTerms = Request.Query["SearchTerms"];
        Movies = MovieDatabase.Search(SearchTerms);
    }
```

We'll also need ot refactor our _Index.cshtml.cs_ to use the search results, instead of the entire database:

```html
<ul class="movie-list">
    @foreach(Movie movie in @Model.Movies)
    {
        <li>
            <div class="details">
                <h3 class="title">@movie.Title</h3>
                <div class="mpaa">@movie.MPAARating</div>
                <div class="genre">@movie.MajorGenre</div>
            </div>
            <div class="ratings">
                @if(movie.IMDBRating != null)
                {
                    <div class="imdb">
                        @movie.IMDBRating
                    </div>
                }
                @if(movie.RottenTomatoesRating != null)
                {
                    <div class="rotten-tomatoes">
                        @movie.RottenTomatoesRating
                    </div>
                }
            </div>
        </li>
    }
</ul>
```

If we try running the project again, and searching for the term "Love"... it crashes?  What is going on?

![The Encountered Exception](/images/6.8.2.png")

Notice that the error is a `NullReferenceException`, and occurs in our `if` statement checking the title.

### Bad Data 

If we think about what variables are involved in the line `if(movie.Title.Contains(terms, StringComparison.InvariantCultureIgnoreCase))`, we have:

* `movie`
* `movie.Title`
* `terms`

Which of these three values can be null?  We know for certain `terms` is not, as we test for the null value and return if it exists just before this portion of our code.  Similarly, `movie` cannot be null, as it is an entry in the list provided by `All`, and if it were null, our page would have crashed before we added searching.  That leaves `movie.Title` as a possibility.

If we comb through the data in _movies.json_, we find on line 54957 a movie with `null` for a title:

```json
  {
    "Title": null,
    "USGross": 26403,
    "WorldwideGross": 3080493,
    "USDVDSales": null,
    "ProductionBudget": 3700000,
    "ReleaseDate": "Nov 03 2006",
    "MPAARating": "Not Rated",
    "RunningTime": 85,
    "Distributor": "IFC Films",
    "Source": "Original Screenplay",
    "MajorGenre": "Thriller/Suspense",
    "CreativeType": "Contemporary Fiction",
    "Director": null,
    "RottenTomatoesRating": 39,
    "IMDBRating": 6.6,
    "IMDBVotes": 11986
  },
```

Working from the provided metadata, we can eventually identify the film as one titled [Unknown](https://en.wikipedia.org/wiki/Unknown_(2006_film)).  It would seem that whomever wrote the script to create this JSON file interpreted "Unknown" to mean the title was unknown (hence null), rather than the literal word "Unknown".  

If we dig deeper into the JSON file, we can find other issues.  For example, the JSON identifies the controversial film [Birth of a Nation](https://en.wikipedia.org/wiki/The_Birth_of_a_Nation) as being released in 2015, when it was actually the first full-length theatrical film ever released, in _1915_!  Most likely the original database from which these entries were derived only used two digits for the year, i.e. `15`, and the scripter who converted it to JSON chose a threshold date to determine if it was released in the 20 or 21st century, i.e.:

```csharp
if(date < 28) 
{
    date += 2000;
}
else {
    date += 1900;
}
```

The earliest movie release date in the JSON is 1928, for "The Broadway Melody", which suggests that _all_ the movies released between 1915 and 1928 have been mislabeled as being released in the 21st century!

Unfortunately, these kinds of errors are rampant in databases, so as software developers we must be aware that our data may well be _dirty_ - containing erroneous values, and anticipate these errors much like we do with user input.  It is a good idea to clean up and fix these errors in our database so that it will be more reliable, but we also need to check for potential errors in our own code, as the database could be updated with more junk data in the future.  Thus, we'll add a `null` check to our `if` statement in _MovieDatabase.cs_:

```csharp
if(movie.Title != null && movie.Title.Contains(terms, StringComparison.InvariantCultureIgnoreCase)) 
```

This will protect us against a `NullReferenceException` when our movie titles are null.  Now if you try the search again, you should see the results:

![The Search Results for "Love"](/images/6.8.3.png)