---
title: "LINQ"
pre: "3. "
weight: 30
date: 2018-08-24T10:53:26-05:00
---

One solution that Microsoft has developed to tackle the disconnect between relational databases and C# is Language Integrated Query (LINQ).  This technology integrates querying directly into the C# language.  It can act as a bridge to a MS SQL server, replacing the need for writing SQL queries and processing the results.  But it can _also_ be used to query collections that implement the `IEnumerable` interface, as well as XML files.  As such, we can design the logic of our program to use LINQ, and change out the data source for any of these options with minimal refactoring.

LINQ queries are written as either _query expressions_ or by using _query operators_.  Let's examine the two.

### Query Expressions 

LINQ query expressions appear much like SQL statements.  For example, the query from the last section, selecting the names of students whose GPA is greater than 3.0 as a LINQ query expression would be:

```csharp
var highGPAStudents = from student in students where student.GPA > 3.0 select new { First = student.First, Last = student.Last};
```

This format looks much like SQL, and is often more comfortable for programmers who come from a SQL background.

### Query Operators

LINQ queries are actually implemented through C# operators.  Query expressions, like the one above, are compiled into an equivalent series of query operators.  Programmers can also use these operators directly.  For example, the above query expressed using operators would be:

```csharp
var highGPAStudents = students.Where(student => student.GPA > 3.0).Select(student => new {First = student.First, Last = student.Last});
```

Programmers from an object-oriented background often find the operators (which are essentially methods that take lambda expressions as parameters) more comfortable.

### Query Execution

Queries are not actually executed until you start iterating over their results.  This allows you to chain additional queries on an existing query, and allows the compiler to optimize queries by grouping query expressions together.  Consider this compound query to select half of low-performing students to assign to an advisor:

```csharp
var strugglingStudents = from student in students where student.GPA < 2.0 select student;
var strugglingStudentsAtoN = from strugglingStudents where student.Last.CharAt(0) >= 'A' && student.Last.CharAt(0) < 'N' select student;
```

If we wrote this as C# algorithm, we might do something like:

```csharp
var strugglingStudents = new List<Student>();
foreach(var student in students) {
    if(student.GPA < 2.0) strugglingStudents.Add(student);
}
var strugglingStudentsAtoN = new List<Student>();
foreach(var student in strugglingStudents) {
    if(student.Last.CharAt(0) >= 'A' && student.Last.CharAt(0) < 'N') strugglingStudentsAtoN.Add(student);
}
```

As you can see, this results in _two_ iterations over lists of students. In the worst case (when every student is struggling) this requires 2*n operations.

On the other hand, by delaying the execution of the query until the first time its values are used, LINQ can refactor the query into a form like:

```csharp
var strugglingStudentsAtoN = new List<Student>();
foreach(var student in students) {
    if(student.GPA < 2.0 && student.Last.CharAt(0) >= 'A' && student.Last.CharAt(0) < 'N') 
        strugglingStudents.Add(student);
}
```

With this refactoring, we only need one iteration over our list - our query would run twice as fast!  Also, if we never _use_ `strugglingStudentsAtoN`, the query is never executed, so the cost is constant time.  This might seem nonsensical, but consider if we have some kind of conditional, i.e.:

```csharp
switch(advisor.Number) {
    case 1:
        ReportStudents(strugglingStudentsAtoN);
        break;
    case 2: 
        ReportStudents(strugglingStudentsNtoZ);
        break;
}
```

We only end up executing the query necessary for the logged-in advisor.

{{% notice info %}}
LINQ uses a programming pattern known as [_method chaining_](https://en.wikipedia.org/wiki/Method_chaining), where each query method returns an object upon which additional query operations can be performed.  Thus, it is perfectly legal to write a query like:

```csharp
var query = students.Where(s => s.GPA > 2.0).Where(s => s.Age > 25).Where(s => s.Last.CharAt(0) == 'C');
```

While this may seem silly (as we could have expressed this with one where clause), it makes more sense when we have user interface filters that may or may not have a value, i.e.:

```csharp
var query = students.All();
if(minGPA != null) query = query.Where(s => s.GPA >= minGPA);
if(maxGPA != null) query = query.Where(s => s.GPA <= maxGPA);
if(first != null) query = query.Where(s => s.First == first);
if(last != null) query = query.Where(s => s.Last == last);
```
{{% /notice %}}

### Query Results 

The result of the query is therefore a specialized object created by LINQ that implements the `IEnumerable<T>` interface.  The type of `T` depends on the query (queries are always strongly typed, though the type can be inferred).  For example, in our `strugglingStudents` query, the result type is `IEnumerable<Student>`:

```csharp
var strugglingStudents = from student in students where student.GPA < 2.0 select student;
```

In contrast, the `highGPAStudents` result uses an [_anonymous type_](https://docs.microsoft.com/en-us/dotnet/csharp/programming-guide/classes-and-structs/anonymous-types):

```csharp
var highGPAStudents = from student in students where student.GPA > 3.0 select new { First = student.First, Last = student.Last};
```

The anonymous type is created by the expression `new { First = student.First, Last = student.Last}`.  Basically, it's an object with a `First` and `Last` property (and no methods or other properties).  Anonymous types are created by the interpreter at runtime (much like an auto-Property's backing field).  As such, we aren't able to use its type in our code.  

If we want the query to return a specific type, we can instead declare a struct or object to return, i.e.:

```csharp 
class StudentName {
    public string First;
    public string Last;
    public StudentName(string first, string last) {
        First = first;
        Last = last;
    }
}
```

And then set this as the projection type:

```csharp
var highGPAStudents = from student in students where student.GPA > 3.0 select new StudentName(student.First, student.Last);
```

Let's take a deeper look at LINQ syntax next.