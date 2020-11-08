---
title: "Media @ Rule"
pre: "1. "
weight: 10
date: 2018-08-24T10:53:26-05:00
---

The `@media` rule was originally introduced in CSS version 2.  It was used to differentiate between different kinds of devices, i.e. a computer screen, printer, etc.  Only the print type saw broad adoption, but it remains useful.  Let's see how we can use it.

If we look at our _Pages/Index.cshtml_ page, we can find an `<aside>` element that contains a banner advertisement for Bernie's. The `<aside>` element is a _semantic element_ - one that implies a specific meaning for what it contains.  The meaning it implies is something 'extra' to the page that isn't part of its main thrust - in this case, an advertisement.

Beyond implying a meaning, it's equivalent to a `<div>` element, it is simply a block-level element that divides up the page and can be used to attach CSS rules.  

Let's assume that we _don't_ want this to appear on the page when we print it.  Let's add a `class` of `"advertisement"` to it:

```html
<aside class="advertisement">
    <img src="~/img/ad.png" alt="Eat at Bernies!"/>
</aside>
```

And in our _wwwroot/css/site.css_, let's create an `@media` rule for printing:

```css
@media print {
    .advertisement {
        display: none;
    }
}
```

Any CSS enclosed in the curly braces following `@media print` will _only_ be applied when the page is printed.  In that case, we set any element wit the class `advertisement` to not display.  Try running the program, and in the browser, select _print preview_.

![The printed webpage]({{<static "images/3.3.2.1.png">}})

The advertisement does not appear!  But it still shows up in the browser.  

This simple technique can be used to easily create printer-friendly versions of your webpage by changing colors to gray tones, replacing fonts, and removing elements that will require a lot of in to print.  

But the media @ rule is also the basis for an even more powerful mechanism, _media queries_, which we'll look at next.
