---
title: "Test Code Coverage"
pre: "7. "
weight: 7
date: 2018-08-24T10:53:26-05:00
---

The term _test code coverage_ refers to how much of your program's code is executed as your tests run. It is a useful metric for evaluating the _depth_ of your test, if not necessarily the quality.  Basically, if your code is not executed in the test framework, it is not tested in any way. If it is executed, then at least _some_ tests are looking at it.  So aiming for a high code coverage is a good starting point for writing tests.

Much like Visual Studio provides a Test Explorer for running tests, it provides support for analyzing test coverage.  We can access this from the "Test" menu, where we select the "Analyze Code Coverage for All Tests".

![Code coverage command in the Test Menu](/images/1.4.7.1.png)

This will build and run all our tests, and as they run it will collect data about how many blocks of code are or are not executed.  The results appear in the Code Coverage Results panel:

![Code Coverage results panel](/images/1.4.7.2.png)

Be aware that there will always be some blocks that are not picked up in this analysis, so it is typical to shoot for a high percentage.  

While test code coverage is a good starting point for evaluating your tests, it is simply a measure of quantity, not quality. It is easily possible for you to have all of your code covered by tests, but still miss errors.  You need to carefully consider the edge cases - those unexpected and unanticipated ways your code might end up being used.