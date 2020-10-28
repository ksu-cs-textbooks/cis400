---
title: "Numerical Filters"
pre: "c. "
weight: 3
date: 2018-08-24T10:53:26-05:00
---

Let's tackle one of the critics ratings next.  While we could create categories and use checkboxes, this doesn't capture the incremental values (i.e. 4.3), and it would be a _lot_ of checkboxes for Rotten Tomatoes ratings!  Instead, we'll use a _numerical filter_, which limits our possible results to a range - between a minimum and maximum value.  

Moreover, let's clean up our Index page, as it is getting difficult to determine what filter(s) go together, and and are adding more.

## Refactoring the Index Page
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

## Adding More Styles
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

## Capturing the Filter Values

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
    [BindProperty()]
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

{{% notice note %}}

You only need to do _one_ binding approach per property in a PageModel.  I.e. you can just use the property decorator:
```csharp 
public class SomePageModel : PageModel 
{
    [BindProperty]
    public float SomeProperty { get; set; }

    public void OnGet() {
        DoSomething(SomeProperty);
    }
}
```

_or_ you might use the argument binding:

```csharp 
public class SomePageModel : PageModel 
{
    public void OnGet(float SomeProperty) {
        DoSomething(SomeProperty);
    }
}
```

_or_ you can parse it from the request:

```csharp 
class SomePageModel : PageModel 
{
    public void OnGet() {
        var someProperty = float.Parse(Request.Query["SomeProperty"]);
        DoSomething(someProperty);
    }
}
```
These are all _different means_ of accessing the _same data_ from the incoming request.  The use of the `[BindProperty]` decorator is often the most concise if you need to be able to access the property in the page itself.  If not, arguement binding is a good alternative.  
{{% /notice %}}

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

{{% notice warning %}}

You should now be able to run your code and see the ratings.  Unfortuantely, the version of ASP.NET that this project was originally built with (.NET Core 2.2) does not convert the nullable doubles correctly - it always sets them to `null`.  You could either upgrade the project (which is messy - much easier to create a new project and copy your code across), or use a workaround like this one:

```csharp
    /// <summary>
    /// Gets and sets the search terms
    /// </summary>
    [BindProperty]
    public string SearchTerms { get; set; }

    /// <summary>
    /// Gets and sets the MPAA rating filters
    /// </summary>
    [BindProperty]
    public string[] MPAARating { get; set; }

    /// <summary>
    /// Gets and sets the IMDB minimium rating
    /// </summary>
    public float IMDBMin { get; set; }

    /// <summary>
    /// Gets and sets the IMDB maximum rating
    /// </summary>
    public float IMDBMax { get; set; }

    /// <summary>
    /// Does the response initialization for incoming GET requests
    /// </summary>
    public void OnGet(double? IMDBMin, double? IMDBMax)
    {
        // Nullable conversion workaround
        this.IMDBMin = IMDBMin;
        this.IMDBMax = IMDBMax;
        Movies = MovieDatabase.Search(SearchTerms);
        Movies = MovieDatabase.FilterByMPAARating(Movies, MPAARatings);
        Movies = MovieDatabase.FilterByGenre(Movies, Genres);
        Movies = MovieDatabase.FilterByIMDBRating(Movies, IMDBMin, IMDBMax);
    }
```

Here we take the `IMDBMin` and `IMDBMax` values as arguments (which _does_ convert them correctly), and then assign them to the properties of the same name.  This sidesteps the conversion problem with the `[BindProperty]` decorator.  

In later versions of .NET Core, such as your milestone will be using, this shouldn't be necessary.  You should be able to use the `[BindProperty]` decorator with nullable types as well.

{{% /notice %}}

Now we can filter by IMDB rating:

![Filtering By IMDB]({{<static "images/6.8.6.png">}})

## Finishing Up

Since we're displaying the Rotten Tomatoes rating, we should probably also have a filter for it.  This will work almost exactly like the IMDB rating - but with the range from 0 to 100.  I'll leave this as an exercise for the reader.