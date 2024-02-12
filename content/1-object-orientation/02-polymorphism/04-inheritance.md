---
title: "Object Inheritance"
pre: "4. "
weight: 4
date: 2018-08-24T10:53:26-05:00
---
In an object-oriented language, inheritance is a mechanism for deriving part of a class definition from another existing class definition.  This allows the programmer to "share" code between classes, reducing the amount of code that must be written.

Consider a **Student** class:  

```csharp
/// <summary>
/// A class representing a student
/// </summary>
public class Student {

  // private backing variables
  private double hours;
  private double points;

  /// <summary>
  /// Gets the students' GPA
  /// </summary>
  public double GPA {
    get {
      return points / hours;
    }
  }

  /// <summary>
  /// Gets or sets the first name
  /// </summary>
  public string First { get; set; }

  /// <summary>
  /// Gets or sets the last name
  /// </summary>
  public string Last { get; set; }

  /// <summary>
  /// Constructs a new instance of Student
  /// </summary>
  /// <param name="first">The student's first name </param>
  /// <param name="last">The student's last name</param>
  public Student(string first, string last) {
    this.First = first;
    this.Last = last;
  }

  /// <summary>
  /// Adds a new course grade to the student's record.
  /// </summary>
  /// <param name="creditHours">The number of credit hours in the course </param>
  /// <param name="finalGrade">The final grade earned in the course</param>
  ///
  public void AddCourseGrade(uint creditHours, Grade finalGrade) {
    this.hours += creditHours;
    switch(finalGrade) {
      case Grade.A:
        this.points += 4 * creditHours;
        break;
      case Grade.B:
        this.points += 3 * creditHours;
        break;
      case Grade.C:
        this.points += 2 * creditHours;
        break;
      case Grade.D:
        this.points += 1 * creditHours;
        break;
    }
  }
}
```

This would work well for representing a student.  But what if we are representing multiple _kinds_ of students, like undergraduate and graduate students?  We'd need separate classes for each, but both would still have names and calculate their GPA the same way.  So it would be handy if we could say "an undergraduate is a student, and has all the properties and methods a student has" and "a graduate student is a student, and has all the properties and methods a student has."  This is exactly what inheritance does for us, and we often describe it as a *is a* relationship.  We distinguish this from the interface mechanism we looked at earlier by saying it is a **strong is a** relationship, as an `Undergraduate` student is, for all purposes, _also_ a `Student`.

Let's define an undergraduate student class:

```csharp
/// <summary>
/// A class representing an undergraduate student
/// </summary>
public class UndergraduateStudent : Student {

  /// <summary>
  /// Constructs a new instance of UndergraduateStudent
  /// </summary>
  /// <param name="first">The student's first name </param>
  /// <param name="last">The student's last name</param>
  public UndergraduateStudent(string first, string last) : base(first, last) {
  }
}
```

In C#, the `:` indicates inheritance - so `public class UndergraduateStudent : Student` indicates that `UndergraduateStudent` inherits from (is a) `Student`.  Thus, it has properties `First`, `Last`, and `GPA` that are inherited from `Student`.  Similarly, it inherits the `AddCourseGrade()` method.

In fact, the only method we need to define in our `UndergraduateStudent` class is the constructor - and we only need to define this because the base class has a defined constructor taking two parameters, `first` and `last` names.  This `Student` constructor must be invoked by the `UndergraduateStudent` constructor - that's what the `:base(first, last)` portion does - it invokes the `Student` constructor with the `first` and `last` parameters passed into the `UndergraduateStudent` constructor.

## Inheritance, State, and Behavior
Let's define a `GraduateStudent` class as well.  This will look much like an `UndergraduateStudent`, but all graduates have a bachelor's degree:

```csharp
/// <summary>
/// A class representing an undergraduate student
/// </summary>
public class GraduateStudent : Student {

  /// <summary>
  /// Gets the student's bachelor degree
  /// </summary>
  public string BachelorDegree {
    get; private set;
  }

  /// <summary>
  /// Constructs a new instance of UndergraduateStudent
  /// </summary>
  /// <param name="first">The student's first name </param>
  /// <param name="last">The student's last name</param>
  /// <param name="degree">The student's bachelor degree</param>
  public GraduateStudent(string first, string last, string degree) : base(first, last) {
    BachelorDegree = degree;
  }
}
```

Here we add a property for `BachelorDegree`.  Since it's setter is marked as `private`, it can only be written to by the class, as is done in the constructor.  To the outside world, it is treated as read-only.  

Thus, the `GraduateStudent` has all the state and behavior encapsulated in `Student`, _plus_ the additional state of the bachelor's degree title.

## The `protected` Keyword
What you might not expect is that any fields declared `private` in the base class are inaccessible in the derived class.  Thus, the private fields `points` and `hours` cannot be used in a method defined in `GraduateStudent`.  This is again part of the _encapsulation_ and _data hiding_ ideals - we've encapsulated and hid those variables within the base class, and any code outside that assembly, even in a derived class, is not allowed to mess with it.

However, we often will want to allow access to such variables in a derived class.  C# uses the access modifier `protected` to allow for this access in derived classes, but not the wider world.

## Inheritance and Memory
What happens when we construct an instance of `GraduateStudent`?  First, we invoke the constructor of the `GraduateStudent` class:

```csharp
GraduateStudent bobby = new GraduateStudent("Bobby", "TwoSocks", "Economics");
```

This constructor then invokes the constructor of the base class, `Student`, with the arguments `"Bobby"` and `"TwoSocks"`.  Thus, we allocate space to hold the state of a student, and populate it with the values set by the constructor.  Finally, execution returns to the derived class of `GraduateStudent`, which allocates the additional memory for the reference to the `BachelorDegree` property.  Thus, the memory space of the `GraduateStudent` _contains_ an instance of the `Student`, somewhat like nesting dolls.

Because of this, we can treat a `GraduateStudent` object as a `Student` object.  For example, we can store it in a list of type `Student`, along with `UndergraduateStudent` objects:

```csharp
List<Student> students = new List<Student>();
students.Add(bobby);
students.Add(new UndergraduateStudent("Mary", "Contrary"));
```

Because of their relationship through inheritance, both `GraduateStudent` class instances and `UndergraduateStudent` class instances are considered to be of type `Student`, as well as their supertypes.

## Nested Inheritance
We can go as deep as we like with inheritance - each base type can be a superclass of another base type, and has all the state and behavior of all the inherited base classes.

This said, having too many levels of inheritance can make it difficult to reason about an object.  In practice, a good guideline is to limit nested inheritance to two or three levels of depth.

## Abstract Classes
If we have a base class that only exists to inherit from (like our `Student` class in the example), we can mark it as _abstract_ with the `abstract` keyword.  An abstract class _cannot be instantiated_ (that is, we cannot create an instance of it using the `new` keyword).  It can still define fields and methods, but you can't construct it.  If we were to re-write our `Student` class as an abstract class:

```csharp
/// <summary>
/// A class representing a student
/// </summary>
public abstract class Student {

  // private backing variables
  private double hours;
  private double points;

  /// <summary>
  /// Gets the students' GPA
  /// </summary>
  public double GPA {
    get {
      return points / hours;
    }
  }

  /// <summary>
  /// Gets or sets the first name
  /// </summary>
  public string First { get; set; }

  /// <summary>
  /// Gets or sets the last name
  /// </summary>
  public string Last { get; set; }

  /// <summary>
  /// Constructs a new instance of Student
  /// </summary>
  /// <param name="first">The student's first name </param>
  /// <param name="last">The student's last name</param>
  public Student(string first, string last) {
    this.First = first;
    this.Last = last;
  }

  /// <summary>
  /// Adds a new course grade to the student's record.
  /// </summary>
  /// <param name="creditHours">The number of credit hours in the course </param>
  /// <param name="finalGrade">The final grade earned in the course</param>
  ///
  public void AddCourseGrade(uint creditHours, Grade finalGrade) {
    this.hours += creditHours;
    switch(finalGrade) {
      case Grade.A:
        this.points += 4 * creditHours;
        break;
      case Grade.B:
        this.points += 3 * creditHours;
        break;
      case Grade.C:
        this.points += 2 * creditHours;
        break;
      case Grade.D:
        this.points += 1 * creditHours;
        break;
    }
  }
}
```

Now with `Student` as an abstract class, attempting to create a `Student` instance i.e. `Student mark = new Student("Mark", "Guy")` would fail with an exception.  However, we can still create instances of the derived classes `GraduateStudent` and `UndergraduateStudent`, and treat them as `Student` instances.  It is best practice to make any class that serves only as a base class for derived classes and will never be created directly abstract.

## Sealed Classes
Conversely, C# also offers the `sealed` keyword, which can be used to indicate that a class should *not* be inheritable.  For example:

```csharp
/// <summary>
/// A class that cannot be inherited from
/// </summary>
public sealed class DoNotDerive {

}
```

Derived classes can _also_ be sealed.  I.e., we could seal our `UndergraduateStudent` class to prevent further derivation:

```csharp
/// <summary>
/// A sealed version  of the class representing an undergraduate student
/// </summary>
public sealed class UndergraduateStudent : Student {

  /// <summary>
  /// Constructs a new instance of UndergraduateStudent
  /// </summary>
  /// <param name="first">The student's first name </param>
  /// <param name="last">The student's last name</param>
  public UndergraduateStudent(string first, string last) : base(first, last) {
  }
}
```

Many of the library classes provided with the C# installation are sealed.  This helps prevent developers from making changes to well-known classes that would make their code harder to maintain.  It is good practice to seal classes that you expect will never be inherited from.

## Interfaces and Inheritance 
A class can use both inheritance and interfaces.  In C#, a class can only inherit _one_ base class, and it should always be the first after the colon (`:`).  Following that we can have as many interfaces as we want, all separated from each other and the base class by commas (`,`):

```csharp
public class UndergraduateStudent : Student, ITeachable, IEmailable 
{
  // TODO: Implement student class 
}
```