---
title: "LINQ Syntax"
pre: "4. "
weight: 40
date: 2018-08-24T10:53:26-05:00
---

Let's discuss some of the more common operations we might want to perform with LINQ.  Please note that this is _not an exhaustive list_ - just some of the most common operations you will be encountering at this time.  

## Data Source 

For these examples, we'll be using a data source consisting of `Student` objects.  These are defined by the class:

```csharp
public class Student {
    public string EID;
    public string First;
    public string Last;
    public double GPA;
    public int Age;    
    public string Major;
}
```

And the variable `students` is a `List<Student>` that we can assume is populated with initialized student objects.

We select this as our data source with the LINQ `from` operator.  In query syntax, this would be:

```csharp
var query = from student in students ...
```

And with method syntax, we would simply use the `students` list:

```csharp
var query = students.SomeQueryMethod(student => ...)
```

To create a query from a data source using method syntax without applying any query methods (useful for chaining optional queries), we can invoke `All()` on the collection:

```csharp
var query = students.All();
```

To use a different data source, we would just swap `students` for that source, an object that supports either the `IEnumerable` (usually data structures) or `IQueryable` (typically SQL or XML data sources) interface.


## Projecting

Projecting refers to selecting specific data from a data source.  For example, if we wanted to select the full name of every  `Student`, we could do so with this query syntax:

```chsarp
var studentNames = from student in students select $"{student.First} {student.Last}";
```

Or with method syntax:

```csharp 
var studentNames = students.Select(student => $"{student.First} {student.Last}");
```

As the name is simply a string, the select above simply constructs the string, and the type of `studentNames` is inferred to be `IEnumerable<string>`.

We can also project an [anonymous type](https://docs.microsoft.com/en-us/dotnet/csharp/programming-guide/classes-and-structs/anonymous-types).  This is a special kind of object whose type is created at runtime.  Anonymous types are basically collections of properties and nothing more (they cannot have methods).  For example, if we wanted just the student's full name and age, we would use this query syntax:

```csharp 
var studentInfo = from student in students select new {FullName = $"{student.First} {student.Last}", Age = student.Age};
```

or this method syntax:

```csharp
var studentInfo = students.Select(student => new {FullName = $"{student.First} {student.Last}", Age = student.Age});
```

Finally, we could also define a new data type (i.e. class) and create an instance of it as our projection:

```csharp 
class StudentInfo {
    public string FullName {get; set;}
    public int Age {get; set;}
    public StudentInfo(string fullName, int age)
    {
        FullName = fullName;
        Age = age;
    }
}
```

Using query syntax:

```csharp
var studentInfo = from student in students select new StudentInfo($"{student.First} {student.Last}", student.Age);
```

or this method syntax:

```csharp
var studentInfo = students.Select(student => new StudentInfo($"{student.First} {student.Last}", student.Age));
```

## Filtering

One of the most common operations you will do with a query is filter the data, so the results contains only part of the original data.  This is done with the `where` operator takes a statement that resolves to a boolean.  If this boolean expression resolves to true, then the data is included in the results; if it is false, it is excluded.  For example, to find all students older than 25, we would use this query syntax:

```csharp
var olderStudents = from student in students where student.Age > 25;
```

or this method syntax:

```csharp
var olderStudents = students.Where(student => student.Age > 25);
```

## Filtering By Type 

If we have a list that contains multiple types, we can filter for specific types with the `where` operator or the `OfType` operator (this is an instance where query and operator syntax vary more greatly).  Consider the case where our `Student` class is a base class to `GraduateStudent` and `UndergraduateStudent` classes.  If we wanted to get a list of only the undergraduates, we could use a `where` query syntax combined with an `is` casting test:

```csharp
var undergraduates = from student in students where student is UndergraduateStudent;
```

In this case, the result would be an `IEnumerable<UndergraduateStudent>`.  But the corresponding where in operator syntax would result in an `IEnumerable<Student>` that contained only `UndergraduateStudent` objects.  To perform a cast as part of the filtering, we would instead use the `OfType<T>()` method:

```csharp
var undergraduates = students.OfType<UndergraduateStudent>();
```

## Ordering

Often we want to apply some form of sorting to our results, i.e. we might want to sort students by GPA.  This can be done with an `orderby` operator.  In query syntax it would be:

```csharp 
var studentsByGPA = from student in students orderby student.GPA;
```

And in method syntax:

```csharp
var studentsByGPA = students.OrderBy(student => student.GPA);
```

The `orderby` operator sorts in _ascending_ order (so students with the lowest grades would come first in the list).  If we wanted to sort in _descending_ order, we would need to specify descending order in our query syntax:

```csharp 
var studentsByGPA = from student in students orderby student.GPA descending;
```

{{% notice tip %}}
There is also an _ascending_ keyword you can use.  This is helpful if you can't remember the default or want to make it clear to other programmers that the list will be sorted in ascending order:
```csharp 
var studentsByGPA = from student in students orderby student.GPA ascending;
```
{{% /notice %}}

However, in method syntax this is accomplished by a separate operator, the `OrderByDescending()` method:

```csharp
var studentsByGPA = students.OrderByDescending(student => student.GPA);
```

If we need to order by multiple properties, i.e. first and last names, this is accomplished by a comma-separated list in query syntax:

```csharp
var studentsByName = from student in students orderby student.Last, student.First;
```

But in method syntax, we need to use a `ThenBy()` operator for subsequent sorting options:

```csharp
var studentsByName = students.OrderBy(student => student.Last).ThenBy(student => student.First);
```

We can mix and match ascending and descending sorting as well - for example, to sort students by descending GPA, then by names in alphabetical order we would use the query syntax:

```csharp
var studentsByGPAAndName = from student in students orderby student.GPA ascending, student.Last, student.First;
```

The corresponding method syntax would need separate operators for each sorting:

```csharp
var studentsByGPAAndName = students.OrderByDescending(student => student.GPA).ThenBy(student => student.Last).ThenBy(student => student.First);
```

There is also a `ThenByDescending()` operator for chaining descending sorts.

Finally, there is also a `Reverse()` operator which simply reverses the order of items in the collection without sorting.

## Grouping

We often want to split our results into groups, which can be accomplished with the `group by` operator.  Consider the case where we want to split our students by the value of their `Major` field.  We can accomplish this with query syntax:

```csharp 
var studentsByMajor = from student in students select student group student by student.Major;
```

or using method syntax:

```csharp
var studentsByMajor = students.GroupBy(student => student.Major);
```

The result type of a grouping operation is an `IEnumerable<IGrouping<TKey, TSource>>`; the `IGrouping` is essentially a key/value pair with the key being the type we were grouping by.  In the example it would be `IEnumerable<IGrouping<string, Student>>` (Seeing this, you can probably begin to appreciate why we normally use `var` for query variables).

To print out each student in each category, we'd need to iterate over this collection, and then over the groupings:

```csharp
foreach(var group in studentsByMajor) {
    Console.WriteLine($"{group.Key} Students");
    foreach(var student in group) {
        Console.WriteLine($"{student.First} {student.Last}");
    }
}
```
## Paging

A common strategy with large data sets is to separate them into _pages_, i.e. the first 20 items might appear on page 1, and by clicking the page 2 link, the user could view the next twenty items, and so on.  This paging functionality is implemented in LINQ using the `Skip()` and `Take()` operators.  The `Skip()` operator specifies how many records to skip over, while the `Take()` operator indicates how many records to include.  Thus, to take the second page of students when each page displays twenty students, we would use:

```csharp
var pagedStudents = students.Skip(20).Take(20);
```

Note that there is no query syntax corresponding to the `Skip()` and `Take()` operations, so to use them with query syntax, we wrap the query in parenthesis and invoke the methods on the result.  I.e. sorting students alphabetically and then taking the third page of twenty would be:

```csharp
var pagedSortedStudents = (from student in students sort by last, first).Skip(40).Take(20);
```

## Existence Checks

Sometimes we want to know if a particular record exists in our data source.  The `Any()` operator can be used to perform such a check.  It evaluates to `true` if the query has any results, or `false` if it does not.  Like the `Skip()` and `Take()`, it does not have a query syntax form, so it must be invoked using the method syntax.  For example, to determine if we have at least one student named Bob Smith, we could use:

```csharp
var bobSmithExists = (from student in students where student.First == "Bob" && student.Last == "Smith").Any();
```

Or, in method syntax:

```csharp
var bobSmithExists = students.Any(student => student.First == "Bob" && student.Last == "Smith");
```

Alternatively, if we wanted to retrieve Bob Smith's record instead of simply determining if we had one, we could use `First()`:

```csharp
var bobSmith = (from student in students where student.First == "Bob" && student.Last == "Smith").First();
```

or in method syntax:

```csharp
var bobSmith = students.First(student => student.First == "Bob" && student.Last == "Smith");
```

This evaluates to the first matching result of the query (if we have multiple Bob Smiths, we'll only get the first one).  If there is no matching record, an `InvalidOperationException` is thrown.  Alternatively, we can use `FirstOrDefault()` which returns a default value corresponding to the query data type. For classes, this would be `null`, so given this query:

```csharp
var bobSmith = students.FirstOrDefault(student => student.First == "Bob" && student.Last == "Smith");
```

The value of `bobSmith` would be his record (if he is in the collection) or `null` (if he was not).

## Aggregating 

Sometimes we want to perform aggregate operations upon a data source, i.e. counting, summing, or averaging. As with paging, these are accomplished via method-only operators.  For example, to count all students in our data source, we could use:

```csharp
var studentCount = students.Count();
```

This can be combined with any LINQ query, i.e. the count of students with a GPA above 3.0 in query syntax would be:

```csharp
var studentsAbove3GPA = (from student in students where student.GPA > 3.0).Count();
```

or in method syntax:

```csharp 
var studentsAbove3GPA = students.Where(student => student.GPA > 3.0).Count();
```

Similarly, to compute the average GPA we would use the `Average()` method in conjunction with a projection.  In query syntax:

```csharp 
var averageGPA = (from student in students select student.GPA).Average();
```

or in method syntax:

```csharp
var averageGPA = students.Select(student => student.GPA).Average();
```

or we can move the selector Predicate into the `Average()` directly:

```csharp
var averageGPA = students.Average(student => student.GPA);
```

We can create more complex queries to address specific questions.  For example, with a `group by` we could compute the average GPA by major:

```csharp 
var gpaByMajor = from student in students group student by student.Major into majorGroup select new 
    { 
        Major = majorGroup.Key,
        AverageGPA = majorGroup.Average(student => student.GPA);
    }
```

The `Sum()` operator works similarly, summing a value.  To sum the ages of all students, we could use:

```csharp
var sumOfAges = (from student in students select student.Age).Sum();
```

or 

```csharp
var sumOfAges = students.Select(student => student.Age).Sum();
```

or 

```csharp
var sumOfAges = students.Sum(student => student.Age);
```

There are also `Min()` and `Max()` aggregate operators which select the minimum and maximum values, respectively.  For example, we could find the maximum and minimum earned GPAs with:

```chsarp
var minGPA = students.Min(student => student.GPA);
var maxGPA = students.Max(student => student.GPA);
```

Finally, there is a generic `Aggregate()` method which provides an aggregator variable that we can use to build any kind of aggregate function.  Let's first see how it can be used to duplicate the functionality of the `Sum()` method:

```csharp
var sumOfAges = students.Aggregate((sum, student) => sum + student.Age);
```

Here, `sum` is inferred to be an `int`, as `student.Age` is an int.  So it starts at `0`, and each time the `Aggregate` method processes a student, it adds that student's `Age` into the `sum`.

Now let's use this method for something new - generating a string of email addresses for a bulk mailing.  Assume our email application needs a list of semicolon-separated email addresses.  In that case, we could generate the emails for all students from:

```csharp
var emails = students.Aggregate((emails, student) => emails + $"; {student.EID}@k-state.edu");
```

If we had students with EIDs "mary", "brb30", and "stan", the resulting string would be:

```
mary@k-state.edu; brb30@k-state.edu; stan@ksu.edu
```

{{% notice info %}}
You may have heard the term [map/reduce](https://en.wikipedia.org/wiki/MapReduce) in the context of functional programming or big data.  This is an algorithmic approach to processing data.  This pattern can be duplicated in LINQ using a query as the mapping function, and `Aggregate()` as the reduce function.
{{% /notice %}}