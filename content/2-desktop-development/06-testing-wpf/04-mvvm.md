---
title: "MVVM Architecture"
pre: "4. "
weight: 4
date: 2018-08-24T10:53:26-05:00
---

Compared to automated tests, using a testing plan with human testers is both slow and expensive.  It should not be surprising then that Microsoft developers sought ways to shift as much of the testing burden for WPF projects to automated tests.  Their solution was to develop a new architectural approach known as [Model-View-ViewModel](https://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93viewmodel). 

![MVVM Pattern](/images/MVVMPattern.png)

This approach expands upon the usual Model-View relationship in a GUI.  A _Model_ class is a class that represents some data, i.e. a `Student`, and the View is the GUI exposing that object's data, i.e. a WPF `<StudentControl>`. Thus, we might have our `Student` class:

```csharp
public class Student : INotifyPropertyChanged
{
    /// <summary>Notifies when a property changes</summary>        
    public event PropertyChangedEventHandler? PropertyChanged;

    /// <summary>The student's course-taking history</summary>
    private List<CourseRecord> _courseRecords = new();

    /// <summary>The student's first name</summary>
    public string FirstName { get; init; }

    /// <summary>The student's last name</summary>
    public string LastName { get; init; }

    /// <summary>The student's course records</summary>
    /// <remarks>We return a copy of the course records to prevent modifications</remarks>
    public IEnumerable<CourseRecord> CourseRecords => _courseRecords.ToArray();

    /// <summary>The student's GPA</summary>
    public double GPA
    {
        get
        {
            var points = 0.0;
            var hours = 0.0;
            foreach (var cr in CourseRecords)
            {
                points += (double)cr.Grade * cr.CreditHours;
                hours += cr.CreditHours;
            }
            return points / hours;
        }
    }

    /// <summary>
    /// Adds <paramref name="cr"/> to the students' course history
    /// </summary>
    /// <param name="cr">The course record to add</param>
    public void AddCourseRecord(CourseRecord cr)
    {
        _courseRecords.Add(cr);
        PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(nameof(CourseRecords))); 
        PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(nameof(GPA)));
    }

    /// <summary>
    /// Constructs the student object
    /// </summary>
    /// <param name="firstName">The student's first name</param>
    /// <param name="lastName">The student's last name</param>
    public Student(string firstName, string lastName)
    {
        FirstName = firstName;
        LastName = lastName;
    }
}
```

And our `<ComputerScienceStudentControl>`:

```xml
<UserControl x:Class="MvvmExample.ComputerScienceStudentControl"
             xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
             xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
             xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006" 
             xmlns:d="http://schemas.microsoft.com/expression/blend/2008" 
             xmlns:local="clr-namespace:MvvmExample"
             mc:Ignorable="d" 
             d:DesignHeight="450" d:DesignWidth="300">
    <StackPanel Orientation="Vertical">
        <StackPanel Orientation="Horizontal">
            <TextBlock FontWeight="Bold" Margin="0,0,10,0">Name</TextBlock>
            <TextBlock Text="{Binding Path=FirstName}"/>
            <TextBlock Text="{Binding Path=LastName}"/>
        </StackPanel>
        <StackPanel Orientation="Horizontal">
            <TextBlock Margin="0,0,10,0" FontWeight="Bold">GPA</TextBlock>
            <TextBlock Text="{Binding Path=GPA, StringFormat={}{0:N2}}"/>
        </StackPanel>
        <TextBlock FontWeight="Bold">Course History</TextBlock>
        <ListView ItemsSource="{Binding Path=CourseRecords}" Margin="2,0,2,0"/>
    </StackPanel>
</UserControl>
```

Now, this control is simply a thin layer using data binding to connect it to the model class.  But what if we needed to add some complex logic?  Let's say we want to display the student's GPA calculated _for only their computer science courses_.  We could put this in the `Student` class, but if every department in the university added their own custom logic and properties to that class, it would get very bloated very quickly.  Instead, we might create a `<ComputerScienceStudentControl>` that would be used for this purpose, and compute the Computer Science GPA in its codebehind, but now we have complex logic that we'd prefer to test using automated tests.  

Instead, we could create _two_ new classes, our `<ComputerScienceStudentControl>` (a new View), and a `ComputerScienceStudentViewModel` (a ViewModel), as well as our existing `Student` (the Model).

Our `ViewModel` can now incorporate the custom logic for calculating a students' computer science GPA, as well holding a reference to the `Student` class it is computed from:

```csharp
public class ComputerScienceStudentViewModel : INotifyPropertyChanged
{
    /// <summary>
    /// The PropertyChanged event reports when properties change
    /// </summary>
    public event PropertyChangedEventHandler? PropertyChanged;

    /// <summary>
    /// The student this model represents
    /// </summary>
    /// <remarks>
    /// We require the student to be set in the constructor, and use 
    /// the init accessor to prevent changing out the student object
    /// </remarks>
    public Student Student { get; init; }

    /// <summary>
    /// THe first name of the student
    /// </summary>
    public string FirstName => Student.FirstName;

    /// <summary>
    /// The last name of the student
    /// </summary>
    public string LastName => Student.LastName;

    /// <summary>
    /// The course history of the student
    /// </summary>
    public IEnumerable<CourseRecord> CourseRecords => Student.CourseRecords;

    /// <summary>
    /// The university GPA of the student
    /// </summary>
    public double GPA => Student.GPA;

    /// <summary>
    /// The student's Computer Science GPA
    /// </summary>
    public double ComputerScienceGPA
    {
        get
        {
            var points = 0.0;
            var hours = 0.0;
            foreach (var cr in Student.CourseRecords)
            {
                if (cr.CourseName.Contains("CIS"))
                {
                    points += (double)cr.Grade * cr.CreditHours;
                    hours += cr.CreditHours;
                }
            }
            return points / hours;
        }
    }

    /// <summary>
    /// An event handler for passing forward PropertyChanged events from the student object
    /// </summary>
    /// <param name="sender">The student object</param>
    /// <param name="e">The eventargs describing the property that is changing</param>
    private void HandleStudentPropertyChanged(object sender, PropertyChangedEventArgs e)
    {
        switch (e.PropertyName)
        {
            // Both first and last names map to properties of the same name,
            // so we can reuse the PropertyChangedEventARgs
            case nameof(FirstName):
            case nameof(LastName):
                PropertyChanged?.Invoke(this, e);
                break;
            // The Student.GPA maps to GPA, and changes to it may
            // also signal a change to the CIS GPA
            case nameof(Student.GPA):
                PropertyChanged?.Invoke(this, e);
                PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(nameof(ComputerScienceGPA)));
                break;
            // We don't care about any other properites of the Student, as they
            // are not present in this ViewModel, so ignore them
            default:
                break;
        }
    }

    /// <summary>
    /// Constructs a new ComputerScienceStudentViewModel, which wraps around the
    /// <paramref name="student"/> object and provides some additional functionality.
    /// </summary>
    /// <param name="student">The student who is this view model</param>
    public ComputerScienceStudentViewModel(Student student)
    {
        Student = student;
        Student.PropertyChanged += HandleStudentPropertyChanged;
    }
}
```

And a control to display it:

```xml
<UserControl x:Class="MvvmExample.StudentControl"
             xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
             xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
             xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006" 
             xmlns:d="http://schemas.microsoft.com/expression/blend/2008" 
             xmlns:local="clr-namespace:MvvmExample"
             mc:Ignorable="d" 
             d:DesignHeight="450" d:DesignWidth="300">
    <StackPanel Orientation="Vertical">
        <StackPanel Orientation="Horizontal">
            <TextBlock FontWeight="Bold" Margin="0,0,10,0">Name</TextBlock>
            <TextBlock Text="{Binding Path=FirstName}"/>
            <TextBlock Text="{Binding Path=LastName}"/>
        </StackPanel>
        <StackPanel Orientation="Horizontal">
            <TextBlock Margin="0,0,10,0" FontWeight="Bold">GPA</TextBlock>
            <TextBlock Text="{Binding Path=GPA, StringFormat={}{0:N2}}"/>
        </StackPanel>
        <TextBlock FontWeight="Bold">Course History</TextBlock>
        <ListView ItemsSource="{Binding Path=CourseRecords}" Margin="2,0,2,0"/>
    </StackPanel>
</UserControl>
```

The `ComputerScienceViewModel` can then be used interchangeably with the `Student` model class, as both have the same properties (though the view model has one additional one). We could then either tweak the student control or create a new one that binds to this new property, i.e.:

```xml
<StackPanel Orientation="Horizontal">
    <TextBlock Margin="0,0,10,0" FontWeight="Bold">Computer Science GPA</TextBlock>
    <TextBlock Text="{Binding Path=ComputerScienceGPA, StringFormat={}{0:N2}}"/>
</StackPanel>
```

This represents just one of the ways a ViewModel can be used.  A View Model can also be leveraged to combine multiple data classes into a single object that can serve as a `DataContext`.  One can also be utilized to create a wrapper object around a web-based API or other data source to provide the ability to data bind that source to GUI controls.  

Finally, because a ViewModel is simply another data class, it can be unit tested just like any other. This helps make sure that complex logic which we want thoroughly tested is not embedded in a GUI component, and simplifies our testing strategies. 

{{% notice info %}}
We've really only scratched the surface of the MVVM architecture as it is used in WPF applications. In addition to providing properties to bind to, a WPF MVVM can also define [commands](https://learn.microsoft.com/en-us/archive/msdn-magazine/2013/may/mvvm-commands-relaycommands-and-eventtocommand) that decouple event handlers from their effects.  When using commands, the GUI event handler simply signals the command, which is consumed by a ViewModel to perform the requested action. 

Commands are outside the scope of this course, but you can refer to the Microsoft documentation and books from the O'Riley Learning Library if you would like to explore this concept in more depth.
{{% /notice %}}

