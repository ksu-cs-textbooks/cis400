---
title: "Running Tests"
pre: "6. "
weight: 6
date: 2018-08-24T10:53:26-05:00
---

Tests are usually run with a _test runner_, a program that will execute the test code against the code to be tested.  The exact mechanism invovled depends on the testing framework.  

The xUnit framework is offered as a set of Nuget packages:
* The `xunit` package contains the library code defining the `Assertion` class as well as the `[Fact]` and `[Test]` attributes.
* The `xunit.runner.visualstudio` package contains the actual test runner

As with other aspects of the .NET framework, the tools can be used at either the command line, or though Visual Studio integrations.  The [xunit documentation](https://xunit.net/docs/getting-started/netcore/cmdline) describes the command line approach thoroughly, so we won't belabor it here.  But be aware, if you want to do development in a Linux or Unix environment, you _must_ use the command line, as there is no version of Visual Studio available for those platforms (there is however, a version available for the Mac OS).

When building tests with Visual Studio, you will typically begin by adding an xUnit Test Project to your existing solution.  Using the wizard will automatically incorporate the necessary Nuget packages into the project.  However, you will need to add the project to be test to the Dependencies list of the test project to give it access to the assembly to be tested.  You do this by right-clicking the 'Dependencies' entry under the Test Project in Visual Studio, choosing "Add Project Reference", and in the dialog that pops up, checking the checkbox next to the name of the project you are testing:

![Adding the project reference]({{<static "images/1.4.6.1.gif">}})

To explore and run your tests, you can open the [Test Explorer](https://docs.microsoft.com/en-us/visualstudio/test/run-unit-tests-with-test-explorer?view=vs-2019) from the "Test" menu.  If no tests appear, you may need to build the test project. This can be done by right-clicking the test project in the Solution Explorer and selecting "Build", or by clicking the "Run All" button in the Test Explorer.  The "Run All" button will run every test in the suite.  Alternatively, you can run individual tests by clicking on them, and clicking the "Run" button.

![Run and Run All buttons]({{<static "images/1.4.6.2.png">}})

As tests complete, the will report thier status - pass or fail - indicated by a green checkmark or red x next to the test name, as well as the time it took to run the test.  There will also be a summary available with details about any failures that can be accessed by clicking the test name.

![Test Detail Summary]({{<static "images/1.4.6.3.png">}})

Occasionally, your tests may not seem to finish, but get stuck running. If this happens, check the output panel, switching it from "build" to "tests".  Most likley your test process crashed because of an error in your test code, and the output reporting that error will be reported there.

![Test Ouput in the Output Panel]({{<static "images/1.4.6.4.png">}})