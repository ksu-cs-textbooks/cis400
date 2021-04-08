---
title: "Cascading Style Sheets"
pre: "4. "
weight: 40
date: 2018-08-24T10:53:26-05:00
---

Cascading Style Sheets (CSS) is the second core web technology of the web.  It defines the _appearance_ of web pages by applying stylistic rules to matching HTML elements.  CSS is normally declared in a file with the _.css_ extension, separate from the HTML files it is modifying, though it can also be declared within the page using the [&lt;style&gt;](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/style) element, or directly on an element using the `style` attribute.

## CSS Rules

A CSS rule consists of a _selector_ and a _definition block_, i.e.:

```css
h1
{
    color: red;
    font-weight: bold;
}
```

### CSS Selectors
A CSS selector determines which elements the associated _definition block_ apply to.  In the above example, the `h1` selector indicates that the style definition supplied applies to _all_ `<h1>` elements.  The selectors can be:

* By element type, indicated by the name of the element.  I.e. the selector `p` applies to all `<p>` elements.
* By the element id, indicated by the id prefixed with a `#`.  I.e. the selector `#foo` applies to the element `<span id="foo">`.
* By the element class, indicated by the class prefixed with a `.`.  I.e. the selector `.bar` applies to the elements `<div class="bar">`, `<span class="bar none">`, and `<p class="alert bar warning">`.

CSS selectors can also be combined in a number of ways, and pseudo-selectors can be applied under certain circumstances, like the `:hover` pseudo-selector which applies only when the mouse cursor is over the element.

You can read more on [MDN's CSS Selectors Page](https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_Selectors).

### CSS Definition Block
A CSS definition block is bracketed by curly braces and contains a series of key-value pairs in the format `key=value;`.  Each key is a property that defines how an HTML Element should be displayed, and the value needs to be a valid value for that property.  

Measurements can be expressed in a number of units, from pixels (px), points (pt), the font size of the parent (em), the font size of the root element (rem), a percentage of the available space (%), or a percentage of the viewport width (vw) or height (vh). See [MDN's CSS values and units](https://developer.mozilla.org/en-US/docs/Learn/CSS/Building_blocks/Values_and_units) for more details.

Other values are specific to the property.  For example, the [cursor](https://developer.mozilla.org/en-US/docs/Web/CSS/cursor) property has possible values `help`, `wait`, `crosshair`, `not-allowed`, `zoom-in`, and `grab`.  You should use the MDN documentation for a reference.

### Styling Text
One common use for CSS is to change properties about how the text in an element is rendered.  This can include changing attributes of the [font](https://developer.mozilla.org/en-US/docs/Web/CSS/font) (`font-style`, `font-weight`, `font-size`, `font-family`), the [color](https://developer.mozilla.org/en-US/docs/Web/CSS/color), and the [text](https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_Text) (`text-align`, `line-break`, `word-wrap`, `text-indent`, `text-justify`).  These are just a sampling of some of the most commonly used properties.

### Styling Elements
A second common use for CSS is to change properties of the element itself.  This can include setting dimensions ([width](https://developer.mozilla.org/en-US/docs/Web/CSS/width), [height](https://developer.mozilla.org/en-US/docs/Web/CSS/height)), adding [margins](https://developer.mozilla.org/en-US/docs/Web/CSS/margin), [borders](https://developer.mozilla.org/en-US/docs/Web/CSS/border), and [padding](https://developer.mozilla.org/en-US/docs/Web/CSS/padding).

These values provide additional space around the content of the element, following the [CSS Box Model](https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_Box_Model/Introduction_to_the_CSS_box_model):

![CSS Box Model]({{<static "images/boxmodel.png">}})

### Providing Layout
The third common use for CSS is to change how elements are laid out on the page.  By default HTML elements follow the [flow model](https://developer.mozilla.org/en-US/docs/Learn/CSS/CSS_layout/Normal_Flow), where each element appears on the page after the one before it.  Some elements are _block_ level elements, which stretch across the entire page (so the next element appears below it), and others are _inline_ and are only as wide as they need to be to hold their contents, so the next element can appear to the right, if there is room.

The [float](https://developer.mozilla.org/en-US/docs/Web/CSS/float) property can make an element float to the left or right of its container, allowing the rest of the page to flow around it.  

Or you can swap out the layout model entirely by changing the [display](https://developer.mozilla.org/en-US/docs/Web/CSS/display) property to `flex` (for flexbox, similar to the XAML `StackPanel`) or `grid` (similar to the XAML `Grid`).  For learning about these two display models, the CSS-Tricks [A Complete Guide to Flexbox](https://css-tricks.com/snippets/css/a-guide-to-flexbox/) and [A Complete Guide to Grid](https://css-tricks.com/snippets/css/complete-guide-grid/) are recommended reading.  These can provide quite powerful layout tools to the developer.

### Learning More

This is just the tip of the iceberg of what is possible with CSS.  Using [CSS media queries](https://developer.mozilla.org/en-US/docs/Web/CSS/Media_Queries/Using_media_queries) can change the rules applied to elements based on the size of the device it is viewed on, allowing for _responsive design_.  [CSS Animation](https://developer.mozilla.org/en-US/docs/Web/CSS/animation) can allow properties to change over time, making stunning visual animations easy to implement.  And CSS can also carry out calculations and store values, leading some computer scientists to argue that it is a Turing Complete language.

The [MDN Cascading Stylesheets Docs](https://developer.mozilla.org/en-US/docs/Web/CSS) and [CSS Tricks](https://css-tricks.com/) are recommended reading to learn more about CSS and its uses.
