---
title: "Parsing API Data"
pre: "4. "
weight: 40
date: 2018-08-24T10:53:26-05:00
---

Web APIs typically provide their data in a structured format, i.e. XML or JSON.  To use this within a C# program you'll need to either parse it or convert it into an object or objects.

#### Parsing XML 

The Joke of the Day site we are using returns XML by default.  The response will look something like:

```xml
<response>
  <success>
    <total>1</total>
  </success>
  <contents>
    <jokes>
      <description>Joke of the day </description>
      <language>en</language>
      <background/>
      <category>jod</category>
      <date>2021-11-29</date>
      <joke>
        <title>Signs for every job</title>
        <lang>en</lang>
        <length>1749</length>
        <clean>0</clean>
        <racial>0</racial>
        <date>2021-11-29</date>
        <id>HqJ1i9L1ujVCcZmS5C4nhAeF</id>
        <text>
        In the front yard of a funeral home, "Drive carefully, we'll wait." On an electrician's truck, "Let us remove your shorts." Outside a radiator repair shop, "Best place in town to take a leak." In a non-smoking area, "If we see you smoking, we will assume you are on fire and take appropriate action." On a maternity room door, "Push, Push, Push." On a front door, "Everyone on the premises is a vegetarian except the dog." At an optometrist's office, "If you don't see what you're looking for, you've come to the right place." On a taxidermist's window, "We really know our stuff." On a butcher's window, "Let me meat your needs." On a butcher's window, "You can beat our prices, but you can't beat our meat." On a fence, "Salesmen welcome. Dog food is expensive." At a car dealership, "The best way to get back on your feet - miss a car payment." Outside a muffler shop, "No appointment necessary. We'll hear you coming." In a dry cleaner's emporium, "Drop your pants here." On a desk in a reception room, "We shoot every 3rd salesman, and the 2nd one just left." In a veterinarian's waiting room, "Be back in 5 minutes. Sit! Stay!" At the electric company, "We would be delighted if you send in your bill. However, if you don't, you will be." In a Beauty Shop, "Dye now!" In a Beauty Shop, "We curl up and Dye for you." On the side of a garbage truck, "We've got what it takes to take what you've got." (Burglars please copy.) In a restaurant window, "Don't stand there and be hungry, come in and get fed up." Inside a bowling alley, "Please be quiet. We need to hear a pin drop." In a cafeteria, "Shoes are required to eat in the cafeteria. Socks can eat any place they want.
        </text>
      </joke>
    </jokes>
    <copyright>2019-20 https://jokes.one</copyright>
  </contents>
</response>
```

We can parse this response with C#'s [XmlDocument Class](https://docs.microsoft.com/en-us/dotnet/api/system.xml.xmldocument?view=net-6.0).  First, we create an instance of the class, using our response text.  We can use one of the `XmlDocument.Load()` overrides, which takes a stream:

```csharp
using Stream responseStream = response.GetStream() 
{
  XmlDocument xDoc = new XmlDocument();
  xDoc.LoadStream(responseStream);
  // TODO: get our joke!
}
```

Then we can query the `XmlDocument` for the tag we care about, i.e. _response > contents > jokes > joke > text_ (the text of the joke).  We use XPath syntax for this:

```csharp
  var node = xDoc.SelectSingleNode("/response/contents/jokes/joke/text");
```

[XPath](https://en.wikipedia.org/wiki/XPath) is a query language, much like CSS selectors, which allow you to navigate a XML document in a lot of different ways.  In this case, we are just finding the exact element based on its path.  Then we can pull its value, and do something with it (such as logging it to the console):

```csharp
  Console.WriteLine(node.InnerText);
```


