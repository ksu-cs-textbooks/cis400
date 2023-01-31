---
title: "Mutation Testing"
pre: "9. "
weight: 9
date: 2018-08-24T10:53:26-05:00
---

At this point you may be asking how to determine if your tests are good.  Mutation testing is one way of evaluating the quality of your tests.  Effectively, mutation testing is a strategy that _mutates_ your program, and then runs your tests.  If the test fails against the mutated code, this suggests your test is good.

As a simplistic example, take this extremely simple class:

```csharp
public void Doll
{
  public string Name {get;} = "Molly";
}
```

A mutation might change it to:

```csharp
public void Doll
{
  public string Name {get;} = "Mollycoddle";
}
```

We would expect that the test `TheDollsNameIsAlwaysMolly` would fail due to this mutation.  If it doesn't, we probably need to revisit our test.  Here is an example of a test that would both normally pass, and pass with this mutation.  See if you can spot the problem:

```csharp
[Fact]
public void TheDollsNameIsAlwaysMolly()
{
  Doll doll = new Doll();
  Assert.Contains(doll.Name, "Molly");
}
```

Mutation testing is done by a special testing tool that uses reflection to understand and alter the classes being tested in your unit tests.  In C#, we use [Stryker.NET](https://stryker-mutator.io/docs/stryker-net/introduction/).  

As with code coverage, mutation testing can't provide all the answers.  But it does help ensure that our programs and the tests we write of them are more robust.