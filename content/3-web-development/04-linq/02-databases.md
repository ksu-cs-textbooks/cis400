---
title: "Databases"
pre: "2. "
weight: 20
date: 2018-08-24T10:53:26-05:00
---

We use the term "Database" to describe a program primarily designed to efficiently store and retrieve data.  These are often used in conjunction with other kinds of applications - such as web applications or desktop applications.  Why use a separate program rather than building this storage and retrieval into the application we are building?  There are a lot of possible reasons, but some common ones are:

1. Centralized access.  Consider a desktop application that tracks inventory for a large company.  You might want to have the application installed on every computer in the sales department, and you want the inventory to stay up-to-date for all of these.  If each desktop app connects to the same centralized database, they will all be kept up-to-date.

2. Efficiency of specialization.  By designing a database program for the sole purpose of storing and retrieving data, it can be designed by programmers who specialize in this area, and be designed to be as efficient as possible... often far more than we would be able to build into our own applications.

### Relational Databases

The most common type of database in use today are _relational databases_.  These are databases that organize data into structured _tables_ consisting of columns with a specific data type.  Each record is therefore a row in the database.  Visually, such a database appears much like a spreadsheet.  These databases are typically communicated with using _Structured Query Language (SQL)_.  This is a special programming language developed specifically to express the kinds of operations we need to carry out on these databases.  

For example, to retrieve the first and last names of all students in the _students_ table who are earning above a 3.0, we would use the query:

```SQL
SELECT first, last FROM students WHERE gpa > 3.0;
```

And the results would be provided as a stream of text:

```
first | last
Mike | Rowe
Jan | Herting
Sam | Sprat
```

You'll learn more about these databases in CIS 560.

### Object-Oriented Databases

Relational databases were developed in the 60's and 70's to deal with the specific challenges of computer systems in those days.  The way they organize data lends itself to large, flat files, and SQL and its results are handled as streams of data.  When object-orientation became a popular programming language paradigm, object-oriented databases - databases that store data as objects, were also developed.  However, while object-oriented programming languages became quite popular, the corresponding databases failed to.  As a result, object-oriented databases remain quite niche.

### Document-Based Databases

The popularity of JSON and XML with the web led to another category of databases being developed, document-based databases (sometimes called No-SQL databases).  These databases store records in a serialized format like JSON or XML, and downplay relationships between records.  Unlike relational databases, document-based databases can be flexible in what data exists for an individual record.  

For example, if we were to create a Student table in a relational database, and wanted to hold the student's degree plan, we'd need two columns to represent a dual-major.  All students in the table would have two columns, even if they only had one degree plan.  In contrast, with a document-based database most students would only have one degree plan, but dual major would have two, and if we had a rare triple major, they could have three!  

Thus, document-based databases add flexibility at the cost of some efficiency in retrieval.   

### Object-Relational Mapping

Despite the growing popularity of Document-Based Databases, the vast majority of databases remain relational (MySql, MSSQL, PostgreSQL, Oracle, SQLite).  Yet, most of the programs that utilize them are now object-oriented.  This creates a bit of a disconnect for many programmers working with both.  One of the solutions devised to help with this challenge are object-relational mappers (ORMs).  These are libraries that are written for object-oriented languages that facilitate talking to the relational database.  When a query is run against the database with an ORM, the results are provided as a collection of objects instead of the normal text (basically, the ORM parses the results and transforms them into an object representation).  This simplifies working with databases for the programmer.
