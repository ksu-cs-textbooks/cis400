---
title: "Hyper-Text Markup Language"
pre: "2. "
weight: 2
date: 2018-08-24T10:53:26-05:00
---
Hyper-Text Markup Language (HTML), is one of the three core technologies of the world-wide-web, along with Cascading Style Sheets (CSS) and Javascript (JS).  Each of these technologies has a specific role to play in delivering a website.  HTML defines the _structure_ and _contents_ of the web page.  It is a markup language, similar to XML and the XAML you have been working with (indeed, HTML is based on the SGML (Standardized General Markup Language) standard, which XML is also based on, and XAML is an extension of XML).  

## HTML Elements

Thus, it uses the same kind of elment structure, consisting of tags.  For example, a button in HTML looks like this:

```html
<button onclick="doSomething">
    Do Something
</button>
```

You likely notice how similar this definition is to buttons in XAML.  As with XAML elements, HTML elements have and opening and closing tag, and can have additional HTML content nested inside these tags.  HTML tags can also be self-closing, as is the case with the line break tag: 

```html
<br/>
```

Let's explore the parts of an HTML element in more detail.

![HTML Element Structure]({{<static "images/html-element-structure.svg">}})

### The Start Tag

The start tag is enclosed in angle brackets (`<` and `>`).  The angle brackets differentiate the text inside them as being HTML elements, rather than text.  This guides the browser to interpret them correctly.  

> Note: Because angle brackets are intepreted as defining HTML tags, you cannot use those characters to represent greater than and less than signs.  Instead, HTML defines escape character sequences to represent these and other special characters.  Greater than is `&gt;`, less than is `&lt;`.  A full list can be found on [mdn](https://developer.mozilla.org/en-US/docs/Glossary/Entity).

#### The Tag Name

Immediately after the `<` is the tag name.  In HTML, tag names like `button` should be expressed in **lowercase letters** (unlike XAML where they are expressed in Pascal case - each word starting with a capital letter).  This is a convention (as most browsers will happily accept any mixture of uppercase and lowercase letters), but is very important when using popular modern web technologies like Razor and React, as these use Pascal case tag names to differentiate between HTML and components they inject into the web page.

#### The Attributes

After the tag name come optional attributes, which are key-value pairs expressed as `key="value"`.  Attributes should be separated from each other and the tag name by whitespace characters (any whitespace will do, but traditionally spaces are used).  As with XAML, different elements have different attributes available - and you can read up on what these are by visiting the MDN article about the specific element.  

However, several attributes bear special mention:

* The `id` attribute is used to assign a unique id to an element, i.e. `<button id="that-one-button">`.  The element can thereafter be referenced by that id in both CSS and JavaScript code.  _An element ID must be unique in an HTML page, or unexpected behavior may result!_

* The `class` attribute is also used to assign an identifier used by CSS and JavaScript.  However, classes don't need to be unique; many elements can have the same class.  Further, each element can be assigned _multiple_ classes, as a space-delimited string, i.e. `<button class="large warning">` assigns both the classes "large" and "warning" to the button.

Also, some web technologies (like Angular) introduce new attributes specific to their framework, taking advantage of the fact that a browser will ignore any attributes it does not recognize.

### The Tag Content 

The content nested inside the tag can be plain text, or another HTML element (or collection of elements).  Unlike XAML elements, which usually can have only one child, HTML elements can have multiple children.  Indentation should be used to keep your code legible by indenting any nested content, i.e.:

```html
<div>
    <h1>A Title</h1>
    <p>This is a paragraph of text that is nested inside the div</p>
    <p>And this is another paragraph of text</p>
</div>
```

### The End Tag 

The end tag is also enclosed in angle brackets (`<` and `>`).  Immediately after the `<` is a forward slash `/`, and then the tag name.  You do not include attributes in a end tag.

If the element has no content, the end tag can be combined with the start tag in a _self-closing tag_, i.e. the [&lt;input&gt;](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/input) tag is typically written as self-closing:

`<input id="first-name" type="text" placeholder="Your first name"/>`


## Text in HTML

Text in HTML works a bit differently than you might expect.  Most notably, all white space is converted into a single space.  Thus, the lines:

```html
<blockquote>
    If you can keep your head when all about you   
        Are losing theirs and blaming it on you,   
    If you can trust yourself when all men doubt you,
        But make allowance for their doubting too;   
    If you can wait and not be tired by waiting,
        Or being lied about, don’t deal in lies,
    Or being hated, don’t give way to hating,
        And yet don’t look too good, nor talk too wise:
    <i>-Rudyard Kipling, exerpt from "If"</i>
</blockquote>
```

Would be rendered:

<blockquote>
    If you can keep your head when all about you   
        Are losing theirs and blaming it on you,   
    If you can trust yourself when all men doubt you,
        But make allowance for their doubting too;   
    If you can wait and not be tired by waiting,
        Or being lied about, don’t deal in lies,
    Or being hated, don’t give way to hating,
        And yet don’t look too good, nor talk too wise:
    <i>-Rudyard Kipling, exerpt from "If"</i>
</blockquote>

If, for some reason you need to maintain formatting of the included text, you can use the [&lt;pre&gt;](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/pre) element (which indicates the text is preformatted):

```html
<blockquote>
    <pre>
If you can keep your head when all about you   
    Are losing theirs and blaming it on you,   
If you can trust yourself when all men doubt you,
    But make allowance for their doubting too;   
If you can wait and not be tired by waiting,
    Or being lied about, don’t deal in lies,
Or being hated, don’t give way to hating,
    And yet don’t look too good, nor talk too wise:
    </pre>
    <i>-Rudyard Kipling, exerpt from "If"</i>
</blockquote>
```

Which would be rendered:

<article>
    <pre style="background: none; color:darkgray">
If you can keep your head when all about you   
    Are losing theirs and blaming it on you,   
If you can trust yourself when all men doubt you,
    But make allowance for their doubting too;   
If you can wait and not be tired by waiting,
    Or being lied about, don’t deal in lies,
Or being hated, don’t give way to hating,
    And yet don’t look too good, nor talk too wise:
    </pre>
    <blockquote>-Rudyard Kipling, exerpt from "If"</blockquote>
</article>

Note that the &gt;pre&lt; preserves _all_ formatting, so it is necessary _not to indent_ its contents.

Alternatively, you can denote line breaks with `<br/>`, and non-breaking spaces with `&nbsp;`:

```html
<blockquote>        
    If you can keep your head when all about you<br/>
    &nbsp;&nbsp;&nbsp;&nbsp;Are losing theirs and blaming it on you,<br/>   
    If you can trust yourself when all men doubt you,<br/>
    &nbsp;&nbsp;&nbsp;&nbsp;But make allowance for their doubting too;<br/> 
    If you can wait and not be tired by waiting,<br/>
    &nbsp;&nbsp;&nbsp;&nbsp;Or being lied about, don’t deal in lies,<br/>
    Or being hated, don’t give way to hating,<br/>
    &nbsp;&nbsp;&nbsp;&nbsp;And yet don’t look too good, nor talk too wise:<br/>    
    <i>-Rudyard Kipling, exerpt from "If"</i>
</blockquote>
```

Which renders: 

<blockquote>        
    If you can keep your head when all about you<br/>
    &nbsp;&nbsp;&nbsp;&nbsp;Are losing theirs and blaming it on you,<br/>   
    If you can trust yourself when all men doubt you,<br/>
    &nbsp;&nbsp;&nbsp;&nbsp;But make allowance for their doubting too;<br/> 
    If you can wait and not be tired by waiting,<br/>
    &nbsp;&nbsp;&nbsp;&nbsp;Or being lied about, don’t deal in lies,<br/>
    Or being hated, don’t give way to hating,<br/>
    &nbsp;&nbsp;&nbsp;&nbsp;And yet don’t look too good, nor talk too wise:<br/><br/>    
    <i>-Rudyard Kipling, exerpt from "If"</i>
</blockquote>

Additionally, as a program you may want to use the the [&lt;code&gt;](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/code) element in conjunction with the [&lt;pre&gt;](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/pre) element to display preformatted code snippets in your pages.

## HTML Comments 

HTML comments are identical to XAML comments (as both inherited from SGML).  Comments start with the sequence `<!--` and end with the sequence `-->`, i.e.:

```html
<!-- This is an example of a HTML comment -->
```

## Basic Page Structure 

HTML5.0 (the current HTML standard) pages have an expected structure that you should follow.  This is:

```html
<!DOCTYPE html>
<html>
    <head>
        <title><!-- The title of your page goes here --></title>
        <!-- other metadata about your page goes here -->
    </head>
    <body>
        <!-- The contents of your page go here -->
    </body>
</html>
```

## HTML Elements
Rather than include an exhustive list of HTML elements, I will direct you to the list provided by [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Element).  However, it is useful to recognize that elements can serve different purposes:

* Some organize the page into sections like the header and footer - MDN calls these the [Content Section elements](https://developer.mozilla.org/en-US/docs/Web/HTML/Element#Content_sectioning)

* Some define the meaning, structure or style of text - MDN calls these the [Inline text semantics elements](https://developer.mozilla.org/en-US/docs/Web/HTML/Element#Inline_text_semantics)

* Some present images, audio, video, or other embedded multimeda content - MDN calls these the [Image and multimedia elements](https://developer.mozilla.org/en-US/docs/Web/HTML/Element#Image_and_multimedia) and [Embedded content elements](https://developer.mozilla.org/en-US/docs/Web/HTML/Element#Embedded_content)

* Tables are composed of [Table content elements](https://developer.mozilla.org/en-US/docs/Web/HTML/Table_content)

* User input is collected with [Forms](https://developer.mozilla.org/en-US/docs/Web/HTML/Element#Forms)

There are more tags than this, but these are the most commonly employed, and the ones you should be familiar with.

## Learning More

The [MDN HTML Docs](https://developer.mozilla.org/en-US/docs/Web/HTML) are recommended reading for learning more about HTML.

