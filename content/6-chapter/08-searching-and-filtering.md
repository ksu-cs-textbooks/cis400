---
title: "Searching and Filtering"
pre: "8. "
weight: 8
date: 2018-08-24T10:53:26-05:00
---

We're going to continue our exploration of Razor pages and HTML by adding searching and filtering to our previous movie site project.

## Initial Project
We'll start with the movie website that we worked on in the previous lesson [Going Dynamic]({{<ref "6-chapter/07-going-dynamic">}}).  It is a simple ASP.NET web app using Razor Pages to display a database of movies.  This app consists of a single page, `Index` displaying the details of the movies in the database.  It also contains classes representing an individual movie (`Movie`) and the movie database (`MovieDatabase`).

You can clone the starting project from the previous starter in GitHub Classroom url provided in the Canvas Assignment (for students in the CIS 400 course), or directly from the GitHub [repo](https://github.com/ksu-cis/movie-site.git) (for other readers), and apply the changes from [Going Dynamic]({{<ref "6-chapter/07-going-dynamic">}}).

## Adding a Search Form

We want to add more functionality to our MoveDatabase website, allowing us to filter and search.  Let's start with the search functionality.  To search the database, we first need to know what to search _for_.  Let's add a form to our _Index.cshtml_ page, just above our `<h1>` elements:

```html
    <form>
        <input type="text" name="SearchTerms"/>
        <input type="submit" value="Search">
    </form>
    <h1>Movie Results</h1>
```

We'll also change the `<h1>` contents to "Movie Results".  

Try typing a search term into the search box, and click the _search_ button.  Has anything changed?

### The HTTPS GET Request 

When you click the _search_ button, the browser serializes your form, and makes a request against your server including the search terms.  By default this request is a __GET__ request, and the contents of the form are serialized using [urlencoding (aka percent encoding)](https://developer.mozilla.org/en-US/docs/Glossary/percent-encoding), a special string format.  This string is then appended to the requested url as the [query string (aka search string)](https://developer.mozilla.org/en-US/docs/Web/API/Location/search) - a series of key-value pairs proceeded by the question mark symbol(`?`) and separated by the ampersand (`&`).

This data is made available to us in our PageModel _Index.cshtml.cs_ by ASP.NET.  Let's take a look at it now.  Notice the method `public void OnGet()`?  This method is invoked _every time the page is requested using a GET request_.  Thus, if we need to do some initialization and/or processing, this would be the place to do it.  

Inside the PageModel, we can access the request data using the `Request` object.  The exact string can be accessed with `Request.QueryString`, or the parsed and deserialized results can be accessed from `Request.Query`.  Let's use the latter to pull out the search terms:

```csharp 
    public void OnGet() 
    {
        String terms = Request.Query["SearchTerms"];
    }
```

The dictonary key (which is the key from the query string) corresponds to the `name` property of our input field, `"SearchTerms"`.  Thus, if you type the search term "Love", it will be serialized as the querystring `"?SearchTerms=Love"`, and stored in our dictionary as "Love" under the key "SearchTerms".


Like other codebehind approaches, we can make this data available to our UI by placing it into a property.  Let's refactor our PageModel slightly to do so:

```csharp 

    public string SearchTerms { get; set; }

    public void OnGet() 
    {
        SearchTerms = Request.Query["SearchTerms"];
    }
```

Now we can refactor our input element to use the the property from our model as its default value:

```html
    <input type="text" name="SearchTerms" value="@Model.SearchTerms"/>
```

If you run the program now, and add a search term, you'll see it appear in the search box when the page reloads.  Now we just need to search for those terms...

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
    if(SearchTerms == null) return All;
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

We'll use [String.Contains()] to determine if our terms are a _substring_ within the title, ignoring case differences.  If we find it, we'll add the movie to our `results` list.

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

If we try running the project again, and seaching for the term "Love"... it crashes?  What is going on?

![The Encountered Exception]({{<static "images/6.8.2.png">}})

Notice that the error is a `NullReferenceException`, and occurs in our `if` statement checking the title.

### Bad Data 

If we think about what variables are invovled in the line `if(movie.Title.Contains(terms, StringComparison.InvariantCultureIgnoreCase))`, we have:

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

If we dig deeper into the JSON file, we can find other issues.  For example, the JSON identifies the contraversial film [Birth of a Nation](https://en.wikipedia.org/wiki/The_Birth_of_a_Nation) as being released in 2015, when it was actually the first full-length theatrical film ever released, in _1915_!  Most likely the original database from which these entries were derived only used two digits for the year, i.e. `15`, and the scripter who converted it to JSON chose a threshold date to determine if it was released in the 20 or 21st century, i.e.:

```csharp
if(date < 28) 
{
    date += 2000;
}
else {
    date += 1900;
}
```

The earliest movie release date in the JSON is 1928, for "The Broadway Melodoy", which suggests that _all_ the movies released between 1915 and 1928 have been mislabeled as being released in the 21st century!

Unfortunately, these kinds of errors are rampant in databases, so as software developers we must be aware that our data may well be _dirty_ - containing erroneous values, and anticipate these errors much like we do with user input.  It is a good idea to clean up and fix these errors in our database so that it will be more reliable, but we also need to check for potential errors in our own code, as the database could be updated with more junk data in the future.  Thus, we'll add a `null` check to our `if` statement in _MovieDatabase.cs_:

```csharp
if(movie.Title != null && movie.Title.Contains(terms, StringComparison.InvariantCultureIgnoreCase)) 
```

This will protect us against a `NullReferenceException` when our movie titles are null.  Now if you try the search again, you should see the results:

![The Search Results for "Love"]({{<static "images/6.8.3.png">}})

## Filtering Results

Let's add some filters to the page as well.  Let's start by filtering for MAA Rating.  We know that there are only a handful of ratings issued by the Motion Picture Association of America - G, PG, PG-13, R, and NC-17.  We might be tempted to use an enumeration to represent these values, but in C# an enumeration cannot have strings for values.  Nor can we use the hyphen (`-`) in an enumeration name.  

### Defining the Filters

So let's define a string array with our MPAA values, and make it accessble from our `MovieDatabase` class:


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
    @foreach  (String rating in MovieDatabase.MPAARating) 
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

### Applying MPAA Rating Filters

Let's add another method to our `MoveDatabase` class, `FilterByMPAARating()`:

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

![Filtered Search Results]({{<static "images/6.8.4.png">}})

You might be wondering why _Cloverfield_ is listed.  But remember, we're searching by substring, and C __LOVE__ rfield contains love!

## Filtering by Genere 

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
    public IEnumerable<String> Genres 
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
    private static string[] genres;
```

And expose it with a public static property:

```csharp 
    /// <summary>
    /// Gets the movie genres represented in the database 
    /// </summary>
    public static string[] Genres => genres;
```

And finally, we'll populate this array in the static constructor of `MovieDatabase`, after the JSON file has been processed:

```csharp 
    HashSet<string> genreSet = new HashSet<string>();
    foreach(Movie movie in movies) {
        if(movie.MajorGenre != null) 
        {
            genreSet.Add(movie.MajorGenre);
        }
    }
    genres = genreSet.ToArray();
```

This approach means the finding of genres only happens once, and getting the `Genre` property is a constant-time O(1) operation.

Implementing the filters follows the same process as we used for the MPAA filters; I'll leave that as an exercise for the reader.

## Filter by IMDB Rating

Let's tackle one of the critical ratings next.  While we could create categories and use checkboxes, this doesn't capture the incremental values (i.e. 4.3), and it would be a _lot_ of checkboxes for Rotten Tomatoes ratings!  Instead, let's use a minimum and maximum value.  Moreover, let's clean up our Index page, as we have a lot of filters, and are adding more.

### Refactoring the Index Page
Let's move the filters to a column on the left, leave the search bar above, and show our results on the right.  This will require refactoring our _Index.cshtml_ file:

```csharp
    <form id="movie-database">

        <div id="search">
            <input type="text" name="SearchTerms" value="@Model.SearchTerms" />
            <input type="submit" value="Search">
        </div>

        <div id="filters">

            <h4>MPAA Rating</h4>
            @foreach (String rating in MovieDatabase.MPAARating)
            {
                <label>
                    <input type="checkbox" name="MPAARatings" value="@rating" checked="@Model.MPAARatings.Contains(rating)" />
                    @rating
                </label>
            }

            <h4>Genre</h4>
            @foreach (String genre in MovieDatabase.Genres)
            {
                <label>
                    <input type="checkbox" name="Genres" value="@genre" />
                    @genre
                </label>
            }

            <h4>IMDB Rating</h4>
            <div>
                Between
                <input name="IMDBMin" type="number" min="0" max="10" step="0.1" placeholder="min"/>
                and
                <input name="IMDBMax" type="number" min="0" max="10" step="0.1" placeholder="min"/>
            </div>

        </div>

        <div id="results">
            <h1>Movie Results</h1>

            <ul class="movie-list">
                @foreach (Movie movie in @Model.Movies)
                {
                    <li>
                        <div class="details">
                            <h3 class="title">@movie.Title</h3>
                            <div class="mpaa">@movie.MPAARating</div>
                            <div class="genre">@movie.MajorGenre</div>
                        </div>
                        <div class="ratings">
                            @if (movie.IMDBRating != null)
                            {
                                <div class="imdb">
                                    @movie.IMDBRating
                                </div>
                            }
                            @if (movie.RottenTomatoesRating != null)
                            {
                                <div class="rotten-tomatoes">
                                    @movie.RottenTomatoesRating
                                </div>
                            }
                        </div>
                    </li>
                }
            </ul>
        </div>
        
    </form>
```

Most of this is simply moving elements around the page, but note that we are using inputs of `type=number` to represent our range of imdb values.  We can specify a minimum and maximum for this range, as well as an allowable increement.  Also, we use the `placeholder` attribute to put text into the `input` until a value is added.

### Adding More Styles
Now we'll need to add some rules to our _wwwroot/css/styles.css_.  First, we'll use a `grid` for the layout of the form:

```css
form#movie-database {
    display: grid;
    grid-template-columns: 1fr 3fr;
    grid-template-rows: auto auto;
}
```

The right column will be three times as big as the right.

We can make our search bar span both columns with `grid-column-start` and `grid-column-end`:

```css
#search {
    grid-column-start: 1;
    grid-column-end: 3;
    text-align: center;
}
```

Notice too that for CSS, we start counting at 1, not 0.  The filters and the results will fall in the next row automatically, each taking up thier own respective grid cell.  You can read more about the grid layout in [A Complete Guide to Grid](https://css-tricks.com/snippets/css/complete-guide-grid/).

Let's go ahead and use flexbox to lay out our filters in a column:

```css
#filters {
    display: flex;
    flex-direction: column;
}
```

And make our number inputs smaller:

```css
#filters input[type=number] {
    width: 3rem;
}
```

Notice the use of square brackets in our CSS Selector to only apply to inputs with type number.

Also, let's remove most of the margin below our `<h4>` elements:

```css
#filters h4 {
    margin-bottom: 0.2rem;
}
``` 

The resulting page looks much cleaner:

![The Styled Page]({{<static "images/6.8.5.png">}})

### Capturing the Filter Values

Now we need to get the filter values from our GET request query string.  We could do this like we've been doing before, with:

```csharp 
    Request.Query["IMDBMin"];
``` 

But the returned value would be a string, so we'd need to parse it:

```csharp
    IMDBMin = double.Parse(Request.Query["IMDBMin"]);
```

If the query was `null`, then this would evaluate to `NAN`, which we wouldn't want to set our `<input>` to...

Instead, we'll look at a couple of more options built into the PageModel.  The first is we can define arguments to our `OnGet()` method to be parsed out of the Request automatically, i.e.:

```csharp 
    OnGet(string SearchTerms, string[] MPAARatings, string[] Genre, double IMDBMin, double IMDBMax) {
        ...
    }
```

We just need to make sure the argument name matches the name property from the HTML element, and ASP.NET will take care of converting the values automatically.  This is especially useful when you'll only use the value within the `OnGet()` or `OnPost()` method.  However, if you plan on using these values in the page itself, there is an even more concise way - we can add the `[BindProperty]` decorator to the properties, i.e.:

```csharp 
    /// <summary>
    /// The current search terms 
    /// </summary>
    [BindProperty]
    public string SearchTerms { get; set; } = "";

    /// <summary>
    /// The filtered MPAA Ratings
    /// </summary>
    [BindProperty]
    public string[] MPAARatings { get; set; }

    /// <summary>
    /// The filtered genres
    /// </summary>
    [BindProperty]
    public string[] Genres { get; set; }

    /// <summary>
    /// The minimum IMDB Rating
    /// </summary>
    [BindProperty]
    public double? IMDBMin { get; set; }

    /// <summary>
    /// The maximum IMDB Rating
    /// </summary>
    [BindProperty]
    public double? IMDBMax { get; set; }
```

This approach will automatically pull the values for these properties from the Request, doing whatever conversion is necessary.  Note that we use a nullable double, `double?` for the minimum and maximum of the IMDB rating range.  This way the field can be left blank (`null`).

This further simplifies our `OnGet()` method:

```csharp 
    /// <summary>
    /// Gets the search results for display on the page
    /// </summary>
    public void OnGet()
    {
        Movies = MovieDatabase.Search(SearchTerms);
        Movies = MovieDatabase.FilterByMPAARating(Movies, MPAARatings);
        Movies = MovieDatabase.FilterByGenre(Movies, Genres);
        Movies = MovieDatabase.FilterByIMDBRating(Movies, IMDBMin, IMDBMax);
    }
```

Now all we need to do is implement the actual filter.

### Implementing the IMDB Rating Filter 

We'll define the new filter in our `MovieDatabase` class as another static method:

```csharp 
    /// <summary>
    /// Filters the provided collection of movies 
    /// to those with IMDB ratings falling within 
    /// the specified range
    /// </summary>
    /// <param name="movies">The collection of movies to filter</param>
    /// <param name="min">The minimum range value</param>
    /// <param name="max">The maximum range value</param>
    /// <returns>The filtered movie collection</returns>
    public static IEnumerable<Movie> FilterByIMDBRating(IEnumerable<Movie> movies, double? min, double? max)
    {
        // TODO: Filter movies
    }
```

Notice that here too we use the nullable double value.  So our first step is probably to do a `null` check:

```csharp
    if (min == null && max == null) return movies;
```

But what if only one is null?  Should we filter for that part of the range?  It wouldn't be hard to do:

```csharp
    var results = new List<Movie>();
            
    // only a maximum specified
    if(min == null)
    {
        foreach(Movie movie in movies)
        {
            if (movie.IMDBRating <= max) results.Add(movie);
        }
        return results;
    }
```

And the minimum would mirror that:

```csharp 
    // only a minimum specified 
    if(max == null)
    {
        foreach(Movie movie in movies)
        {
            if (movie.IMDBRating >= min) results.Add(movie);
        }
        return results;
    }
```

Finally, we could handle the case where we have both a min and max value to our range:

```csharp
    // Both minimum and maximum specified
    foreach(Movie movie in movies)
    {
        if(movie.IMDBRating >= min && movie.IMDBRating <= max)
        {
            results.Add(movie);
        }
    }
    return results;
```

Notice too, that in each of these cases we're treating the range as _inclusive_ (including the specified minimum and maximum).  This is the behavior most casual internet users will expect.  If the database and user expectations are different for your audience, you'd want your code to match that expectation.


## Bug Workarounds
You should now be able to run your code andn see the ratings.  Unfortuantely, the version of ASP.NET that this project was originally built with (.NET Core 2.2) does not convert the nullable doubles correctly - it always sets them to `null`.  You could either upgrade the project (which is messy - much easier to create a new project and copy your code across), or use a workaround like this one:

```csharp
    public void OnGet(double? IMDBMin, double? IMDBMax)
    {
        # Nullable conversion workaround
        this.IMDBMin = IMDBMin;
        this.IMDBMax = IMDBMax;
        Movies = MovieDatabase.Search(SearchTerms);
        Movies = MovieDatabase.FilterByMPAARating(Movies, MPAARatings);
        Movies = MovieDatabase.FilterByGenre(Movies, Genres);
        Movies = MovieDatabase.FilterByIMDBRating(Movies, IMDBMin, IMDBMax);
    }
```

Here we take the `IMDBMin` and `IMDBMax` values as arguments (which _does_ convert them correctly), and then assign them to the properties of the same name.  This sidesteps the conversion problem with the `[BindProperty]` decorator.  In later versions of .NET Core, this shouldn't be necessary.

Now we can filter by IMDB rating:

![Filtering By IMDB]({{<static "images/6.8.6.png">}})

## Finishing Up

Since we're displaying the Rotten Tomatoes rating, we should probably also have a filter for it.  This will work almost exactly like the IMDB rating - but with the range from 0 to 100.  I'll leave this as an exercise for the reader.