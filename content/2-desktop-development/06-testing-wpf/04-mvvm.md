---
title: "MVVM Architecture"
pre: "4. "
weight: 4
date: 2018-08-24T10:53:26-05:00
draft: true
---

Compared to automated tests, using a testing plan with human testers is both slow and expensive.  It should not be surprising then that Microsoft developers sought ways to shift as much of the testing burden for WPF projects to automated tests.  Their solution was to develop a new architectural approach known as [_ModelView-View-Model_](https://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93viewmodel). 

![MVVM Pattern]({{<static "images/MVVMPattern.png">}})

This approach expands upon the usual Model-View relationship in a GUI.  A _Model_ class is a class that represents some data, i.e. a `Student`, and the View is the GUI exposing that object's data, i.e. a WPF `<StudentControl>`. Thus, we might have our `Student` class:

```csharp
public class Student 
{
    /// <summary>The student's first name</summary>
    public string FirstName { get; protected set; }

    /// <summary>The student's last name</summary>
    public string LastName { get; protected set; }

    /// <summary>The student's course records</summary>
    public IEnumerable<CourseRecord> CourseRecords { get; }

    /// <summary>The student's GPA</summary>
    public double GPA 
    {
        var points = 0.0;
        var hours = 0.0;
        foreach(var cr in CourseRecords)
        {
            points += cr.GradePoints;
            hours += cr.CreditHours;
        }
        return points/hours;
    }
}
```

And our `<StudentControl>`:

```xml
<UserControl x:Class="Example.StudentControl"
         xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
         xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
         xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006" 
         xmlns:d="http://schemas.microsoft.com/expression/blend/2008" 
         mc:Ignorable="d" 
         d:DesignHeight="300" d:DesignWidth="300">
    <StackPanel Orientation="Vertical">
        <Label>Name</Label>
        <TextBlock Text="{Binding Path=First"/>
        <TextBlock Text="{Binding Path=Last"/>
        <Label>GPA</Label>
        <TextBlock Text="{Binding Path=GPA, StringFormat={0,D:2}"/>
    </StackPanel>
</UserControl> 
```

Now, this control is simply a thin layer using data binding to connect it to the model class.  But what if we needed to add some complex logic?  Let's say we want to display the student's GPA calculated _for only their computer science courses_.  We could put this in the `Student` class, but if every department in the university added their own custom logic and properties to that class, it would get very bloated very quickly.  Instead, we might create a `<ComputerScienceStudentControl>` that would be used for this purpose, and compute the Computer Science GPA in its codebehind, but now we have complex logic that we'd prefer to test using automated tests.  

Instead, we could create _two_ new classes, our `<ComputerScienceStudentControl>` (a new View), and a `ComputerScienceStudentControlVM` (a ViewModel), as well as our existing `Student` (the Model).

Our `ViewModel` can now 