---
title: "Parsing API Data"
pre: "4. "
weight: 40
date: 2018-08-24T10:53:26-05:00
---

Web APIs typically provide their data in a structured format, i.e. XML or JSON.  To use this within a C# program you'll need to either parse it or convert it into an object or objects.  

The Joke of the Day API can provide either - we just need to specify our preference with a `Accept` header in our HTTP request. This header lets the server know what format(s) of data we are ready to process.  XML is signified by the MIME type `application/xml` and JSON by `application/json`.

To set this (or any other header) in our `WebRequest` object, we use the `Header` property's `Add()` method:

```csharp
WebRequest request = WebRequest.Create("http://api.jokes.one/jod");
request.Headers.Add("Accept", "application/json");
```

For JSON, or:

```csharp
WebRequest request = WebRequest.Create("http://api.jokes.one/jod");
request.Headers.Add("Accept", "application/xml");
```

For XML.

#### Parsing XML 

Let's start by examining the older format, XML.  Assuming you have set the `Accept` header as discussed above, you will receive a response similar to (but with a different joke):

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

We can parse this response with C#'s [XmlDocument Class](https://docs.microsoft.com/en-us/dotnet/api/system.xml.xmldocument?view=net-6.0) from the `System.Xml` namespace.  First, we create an instance of the class, using our response text.  We can use one of the `XmlDocument.Load()` overrides, which takes a stream, to process our response stream directly:

```csharp
using Stream responseStream = response.GetStream() 
{
  XmlDocument xDoc = new XmlDocument();
  xDoc.Load(responseStream);
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

#### Parsing JSON

JavaScript Object Notation (JSON) has become a popular format for web APIs, as it usually requires less characters than the corresponding XML, and is natively serializable from JavaScript making it extremely compatible with client-side web applications.

Assuming you have set the `Accept` header as discussed above, you will receive a response similar to (but with a different joke):

```json
{
  "success":{
    "total":1
  },
  "contents":{
    "jokes":[
      {
        "description":"Joke of the day ",
        "language":"en",
        "background":"",
        "category":"jod",
        "date":"2021-11-30",
        "joke":{
          "title":"Class With Claus",
          "lang":"en",
          "length":"78",
          "clean":null,
          "racial":null,
          "date":"2021-11-30",
          "id":"LuVeRJsEIzCzvTnRmBTHXweF",
          "text":"Q: What do you say to Santa when he's taking attendance at school?\nA: Present."
        }
      }
    ],
    "copyright":"2019-20 https:\/\/jokes.one"
  }
}
```

The C# system libraries provide JSON support in the `System.Text.Json` namespace using the [JsonSerializer](https://docs.microsoft.com/en-us/dotnet/api/system.text.json.jsonserializer?view=net-6.0) class. The default behavior of the deserializer is to deserialize into a `JsonDocument` composed of nested `JsonElement` objects - essentially, dictionaries of dictionaries.  As with the `XDocument`, we can deserialize JSON directly from a `Stream`:

```csharp
using Stream responseStream = response.GetStream() 
{
  JsonDocument jDoc = JsonSerializer.Deserialize(responseStream);
  // TODO: get our joke!
}
```

Then we can navigate from the root element (a `JsonElement` instance) down the nested path of key/value pairs, by calling `GetProperty()` to access each successive property, and then print the joke text to the console:

```csharp
  var contents = jDoc.RootElement.GetProperty("contents");
  var jokes = contents.GetProperty("jokes");
  var jokeData = jokes[0];
  var joke = jokeData.GetProperty("joke");
  var text = joke.GetProperty("text");
  Console.WriteLine(text);
```


<!-- 
This approach can be cumbersome, but there is another possibility - to deserialize the JSON directly into a C# object.  Let's look at that next.


#### Deserializing JSON into a C# Object

The `JsonSerializer` also allows us to deserialize JSON directly into a corresponding C# object.  For this to work, we have to define the structure of this object to match our expected response.  Since our JSON is a nested structure, we'll actually need _multiple_ classes to represent it.  Let's start with the innermost one - the joke itself, which has a structure like:

```json
{
  "title":"Class With Claus",
  "lang":"en",
  "length":"78",
  "clean":null,
  "racial":null,
  "date":"2021-11-30",
  "id":"LuVeRJsEIzCzvTnRmBTHXweF",
  "text":"Q: What do you say to Santa when he's taking attendance at school?\nA: Present."
}
```

We need to reproduce this as a C# class, converting the JSON properties into C# equivalents i.e.:

```csharp
public class Joke
{
  [JsonPropertyName("title")]
  public string Title {get; set;}

  [JsonPropertyName("lang")]
  public string Lang {get; set;}

  [JsonPropertyName("length")]
  public int Length {get; set;}

  [JsonPropertyName("clean")]
  public bool? Clean {get; set;}

  [JsonPropertyName("racial")]
  public bool? Racial {get; set;}

  [JsonPropertyName("date")]
  public DateTime Date {get; set;}

  [JsonPropertyName("id")]
  public string Id {get; set;}

  [JsonPropertyName("text")]
  public string Text {get; set;}
}
```

Note that for JSON, the standard naming convention is to use Camel Case property names, not the Pascal Case we use in C#.  The `[JsonPropertyName()]` attribute from the `System.Text.Json.Serialization` namespace allows us to indicate how the name needs to be transformed when we transform to and from a JSON string to match both naming conventions.

The `Joke` is then nested in a second object that provides additional metadata describing the joke:

```json
{
  "description":"Joke of the day ",
  "language":"en",
  "background":"",
  "category":"jod",
  "date":"2021-11-30",
  "joke":{...}
}
```

All we really care about here is the joke itself.  But the `JsonSerializer` will throw an error unless all properties are accounted for.  However, it does allow a bit of a wildcard in the form of a `Dictionary<string, JsonElement>` property - if we provide one named `ExtensionData`, then any property not otherwise present in the object will be mapped to it.  Let's take advantage of this to simplify our next class:

-->