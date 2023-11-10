---
title: "HTTP Forms"
date: 2018-08-24T10:53:05-05:00
weight: 20
pre: "<b>2. </b>"
---

One of the earliest (and still widely used) mechanisms for transferring data from a browser (client) to the server is a _form_.  The `<form>` is a specific HTML element that contains input fields and buttons the user can interact with.

### The `<input>` Element

Perhaps the most important - and versatile - of these is the <a href="https://developer.mozilla.org/en-US/docs/Web/HTML/Element/input" target="_blank">`<input>`</a> element.  By setting its `type` attribute, we can represent a wide range of possible inputs, as is demonstrated by this table [taken from the MDN Web Docs](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/input):

<table class="standard-table">
 <colgroup>
  <col>
  <col style="width: 50%;">
  <col>
 </colgroup>
 <thead>
  <tr>
   <th>Type</th>
   <th>Description</th>
   <th colspan=2>Basic Examples</th>
  </tr>
 </thead>
 <tbody>
  <tr>
    <td><a href="https://developer.mozilla.org/en-US/docs/Web/HTML/Element/input/button" title="<input> elements of type button are rendered as simple push buttons, which can be programmed to control custom functionality anywhere on a webpage as required when assigned an event handler function (typically for the click event).">button</a></td>
    <td>A push button with no default behavior displaying the value of the <a href="#htmlattrdefvalue">value</a> attribute, empty by default.</td>
    <td>
      <pre><code class="html">&lt;input type="button" name="ExampleButton" value="Click Me!"/&gt;</code></pre>
    </td>
    <td>
      <input type="button" name="ExampleButton" value="Click Me!"/>
    </td>
  </tr>
  <tr>
    <td><a href="https://developer.mozilla.org/en-US/docs/Web/HTML/Element/input/checkbox" title="<input> elements of type checkbox are rendered by default as boxes that are checked (ticked) when activated, like you might see in an official government paper form. The exact appearance depends upon the operating system configuration under which the browser is running. Generally this is a square but it may have rounded corners. A checkbox allows you to select single values for submission in a form (or not).">checkbox</a></td>
    <td>A check box allowing single values to be selected/deselected.</td>
    <td>
      <pre><code class="html">&lt;label&gt;&lt;input type="checkbox" name="ExampleCheckbox"/&gt;&lt;label&gt;</code></pre></td>
    <td>
      <label><input type="checkbox" name="ExampleCheckbox"/>
    </td>
  </tr>
  <tr>
    <td><a href="https://developer.mozilla.org/en-US/docs/Web/HTML/Element/input/color" title="<input> elements of type color provide a user interface element that lets a user specify a color, either by using a visual color picker interface or by entering the color into a text field in #rrggbb hexadecimal format.">color</a></td>
    <td>A control for specifying a color; opening a color picker when active in supporting browsers.</td>
    <td>
      <pre><code class="html">&lt;input type="color" name="ExampleColor" style="width: 40px; height: 40px;"/&gt;</code></pre>
    </td>
    <td>
      <input type="color" name="ExampleColor" style="width: 40px; height: 40px;"/>
    </td>
  </tr>
  <tr>
    <td><a href="https://developer.mozilla.org/en-US/docs/Web/HTML/Element/input/date" title="<input> elements of type=&quot;date&quot; create input fields that let the user enter a date, either with a textbox that validates the input or a special date picker interface.">date</a></td>
    <td>A control for entering a date (year, month, and day, with no time). Opens a date picker or numeric wheels for year, month, day when active in supporting browsers.</td>
    <td>
     <pre><code class="html">&lt;input type="date" name="ExampleDate"/&gt;</code></pre>
   </td>
   <td>
    <input type="date" name="ExampleDate"/>
   </td>
  </tr>
  <tr>
    <td><a href="https://developer.mozilla.org/en-US/docs/Web/HTML/Element/input/datetime-local" title="<input> elements of type datetime-local create input controls that let the user easily enter both a date and a time, including the year, month, and day as well as the time in hours and minutes.">datetime-local</a></td>
    <td>A control for entering a date and time, with no time zone. Opens a date picker or numeric wheels for date- and time-components when active in supporting browsers.</td>
    <td>
      <pre><code class="html">&lt;input type="datetime-local" name="ExampleDatetimeLocal"/&gt;</code></pre>
    </td>
    <td>
      <input type="datetime-local" name="ExampleDatetimeLocal"/>
    </td>
  </tr>
  <tr>
  <tr>
    <td><a href="https://developer.mozilla.org/en-US/docs/Web/HTML/Element/input/email" title="<input> elements of type email are used to let the user enter and edit an e-mail address, or, if the multiple attribute is specified, a list of e-mail addresses.">email</a></td>
    <td>A field for editing an email address. Looks like a <code>text</code> input, but has validation parameters and relevant keyboard in supporting browsers and devices with dynamic keyboards.</td>
    <td>
      <pre><code class="html">&lt;input type="email" name="ExampleEmail"/&gt;</code></pre>
    </td>
    <td>
      <input type="email" name="ExampleEmail"/>
    </td>
  </tr>
  <tr>
    <td><a href="https://developer.mozilla.org/en-US/docs/Web/HTML/Element/input/file" title="<input> elements with type=&quot;file&quot; let the user choose one or more files from their device storage. Once chosen, the files can be uploaded to a server using form submission, or manipulated using JavaScript code and the File API.">file</a></td>
    <td>A control that lets the user select a file. Use the <a href="#htmlattrdefaccept">accept</a> attribute to define the types of files that the control can select.</td>
    <td>
      <pre><code style="html">&lt;input type="file" name="ExampleFile"/&gt;</code></pre>
    </td>
    <td>
      <input type="file" name="ExampleFile"/>
    </td>
  </tr>
  <tr>
   <td><a href="https://developer.mozilla.org/en-US/docs/Web/HTML/Element/input/hidden" title="<input> elements of type hidden let web developers include data that cannot be seen or modified by users when a form is submitted. For example, the ID of the content that is currently being ordered or edited, or a unique security token. Hidden inputs are completely invisible in the rendered page, and there is no way to make it visible in the page's content.">hidden</a></td>
    <td>A control that is not displayed but whose value is submitted to the server. There is an example in the last column, but it's hidden!</td>
    <td>
      <pre><code class="html">&lt;input type="hidden" name="ExampleHidden" value="f0321dc35"/&gt;</code></pre>
    </td>
    <td>
      <input type="hidden" name="ExampleHidden" value="f0321dc35"/> ← It’s here!
    </td>
  </tr>
  <tr>
    <td><a href="https://developer.mozilla.org/en-US/docs/Web/HTML/Element/input/image" title="<input> elements of type image are used to create graphical submit buttons, i.e. submit buttons that take the form of an image rather than text.">image</a></td>
    <td>A graphical <code>submit</code> button. Displays an image defined by the <code>src</code> attribute. The <a href="#htmlattrdefalt">alt</a> attribute displays if the image <a href="#htmlattrdefsrc">src</a> is missing.</td>
    <td>
      <pre><code class="html">&lt;input type="image" name="ExampleImage" src="/images/button.png">}}"/&gt;</code></pre>
    </td>
    <td>
      <input type="image" name="ExampleImage" src="/images/button.png">}}"/>
    </td>
  </tr>
  <tr>
    <td><a href="https://developer.mozilla.org/en-US/docs/Web/HTML/Element/input/number" title="<input> elements of type number are used to let the user enter a number. They include built-in validation to reject non-numerical entries.">number</a></td>
    <td>A control for entering a number. Displays a spinner and adds default validation when supported. Displays a numeric keypad in some devices with dynamic keypads.</td>
    <td>
      <pre><code class="html">&lt;input type="number" name="ExampleNumber" min=0 max=10 step=1/&gt;</code></pre>
    </td>
    <td>
      <input type="number" name="ExampleNumber" min=0 max=10 step=1/>
    </td>
  </tr>
  <tr>
    <td><a href="https://developer.mozilla.org/en-US/docs/Web/HTML/Element/input/password" title="<input> elements of type password provide a way for the user to securely enter a password.">password</a></td>
    <td>A single-line text field whose value is obscured. Will alert user if site is not secure.</td>
    <td>
      <pre><code class="html">&lt;input type="password"&gt;</code></pre>
    </td>
    <td>
      <input type="password"/>
    </td>
  </tr>
  <tr>
    <td><a href="https://developer.mozilla.org/en-US/docs/Web/HTML/Element/input/radio" title="<input> elements of type radio are generally used in radio groups—collections of radio buttons describing a set of related options.">radio</a></td>
    <td>A radio button, allowing a single value to be selected out of multiple choices with the same <a href="#htmlattrdefname">name</a> value.</td>
    <td>
      <pre><code class="html">
&lt;label&gt;
  &lt;input type="radio" name="ExampleRadio" value="1"/&gt;
  Choice One
&lt;/label&gt;
&lt;label&gt;
  &lt;input type="radio" name="ExampleRadio" value="2"/&gt;
  Choice Two
&lt;/label&gt;
&lt;label&gt;
  &lt;input type="radio" name="ExampleRadio" value="3"/&gt;
  Choice Three
&lt;/label&gt;
      </code></pre>
    </td>
    <td>
      <label>
        <input type="radio" name="ExampleRadio" value="1"/>
        Choice One</label>
      <label>
        <input type="radio" name="ExampleRadio" value="2"/>
        Choice Two</label>
      <label>
        <input type="radio" name="ExampleRadio" value="3"/>
        Choice Three</label>
    </td>
  </tr>
  <tr>
    <td><a href="https://developer.mozilla.org/en-US/docs/Web/HTML/Element/input/range" title="<input> elements of type range let the user specify a numeric value which must be no less than a given value, and no more than another given value. The precise value, however, is not considered important. This is typically represented using a slider or dial control rather than a text entry box like the number input type.">range</a></td>
    <td>A control for entering a number whose exact value is not important. Displays as a range widget defaulting to the middle value. Used in conjunction <a href="#htmlattrdefmin">min</a> and <a href="#htmlattrdefmax">max</a> to define the range of acceptable values.</td>
    <td>
      <pre><code class="html">&lt;input type="range" name="ExampleRange" min="0" max="25"/&gt;</code></pre>
    </td>
    <td>
      <input type="range" name="ExampleRange" min="0" max="25"/>
    </td>
  </tr>
  <tr>
    <td><a href="https://developer.mozilla.org/en-US/docs/Web/HTML/Element/input/reset" title="<input> elements of type reset are rendered as buttons, with a default click event handler that resets all of the inputs in the form to their initial values.">reset</a></td>
    <td>A button that resets the contents of the form to default values. Not recommended.</td>
    <td>
      <pre><code class="html">&lt;input type="reset" name="ResetExample"/&gt;</code></pre>
    </td>
    <td>
      <input type="reset" name="ResetExample"/>
    </td>
  </tr>
  <tr>
    <td><a href="https://developer.mozilla.org/en-US/docs/Web/HTML/Element/input/search" title="<input> elements of type search are text fields designed for the user to enter search queries into. These are functionally identical to text inputs, but may be styled differently by the user agent. ">search</a></td>
    <td>A single-line text field for entering search strings. Line-breaks are automatically removed from the input value. May include a delete icon in supporting browsers that can be used to clear the field. Displays a search icon instead of enter key on some devices with dynamic keypads.</td>
    <td>
      <pre><code class="html">&lt;input type="search" name="ExampleSearch"/&gt;</code></pre>
    </td>
    <td>
      <input type="search" name="ExampleSearch"/>
    </td>
  </tr>
  <tr>
    <td><a href="https://developer.mozilla.org/en-US/docs/Web/HTML/Element/input/submit" title="<input> elements of type submit are rendered as buttons. When the click event occurs (typically because the user clicked the button), the user agent attempts to submit the form to the server.">submit</a></td>
    <td>A button that submits the form.</td>
    <td>
      <pre><code class="html">&lt;input type="submit" name="ExampleSubmit" value="Save Changes"/&gt;</code></pre>
    </td>
    <td>
      <input type="submit" name="ExampleSubmit" value="Save Changes"/>
    </td>
  </tr>
  <tr>
    <td><a href="https://developer.mozilla.org/en-US/docs/Web/HTML/Element/input/tel" title="<input> elements of type tel are used to let the user enter and edit a telephone number. Unlike <input type=&quot;email&quot;> and <input type=&quot;url&quot;> , the input value is not automatically validated to a particular format before the form can be submitted, because formats for telephone numbers vary so much around the world.">tel</a></td>
    <td>A control for entering a telephone number. Displays a telephone keypad in some devices with dynamic keypads.</td>
    <td>
      <pre><code class="html">&lt;input type="tel" name="ExampleTel"/&gt;</code></pre>
    </td>
    <td>
      <input type="tel" name="ExampleTel"/>
    </td>
  </tr>
  <tr>
    <td><a href="https://developer.mozilla.org/en-US/docs/Web/HTML/Element/input/text" title="<input> elements of type text create basic single-line text fields.">text</a></td>
    <td>The default value. A single-line text field. Line-breaks are automatically removed from the input value.</td>
    <td>
      <pre><code class="html">&lt;input type="text" name="ExampleText"/&gt;</code></pre>
    </td>
    <td>
      <input type="text" name="ExampleText"/>
    </td>
  </tr>
  <tr>
    <td><a href="https://developer.mozilla.org/en-US/docs/Web/HTML/Element/input/time" title="<input> elements of type time create input fields designed to let the user easily enter a time (hours and minutes, and optionally seconds).">time</a></td>
    <td>A control for entering a time value with no time zone.</td>
    <td>
      <pre><code class="html">&lt;input type="time" name="ExampleTime"/&gt;</code></pre>
    </td>
    <td>
      <input type="time" name="ExampleTime"/>
    </td>
  </tr>
  <tr>
    <td><a href="https://developer.mozilla.org/en-US/docs/Web/HTML/Element/input/url" title="<input> elements of type url are used to let the user enter and edit a URL.">url</a></td>
    <td>A field for entering a URL. Looks like a <code>text</code> input, but has validation parameters and relevant keyboard in supporting browsers and devices with dynamic keyboards.</td>
    <td>
      <pre><code class="html">&lt;input type="url" name="ExampleUrl"&gt;</code></pre>
    </td>
    <td>
      <input type="url" name="ExampleUrl">
    </td>
  </tr>
 </tbody>
</table>

Regardless of the type, the `<input>` element also has a `name` and `value` property.  The `name` is similar to a variable name, in that it is used to identify the input's value when we serialize the form (more about that later), and the `value` is the value the input currently is (this starts as the value you specify in the HTML, but it changes when the user edits it).

Additionally, checkboxes and radio buttons have a boolean `ischecked` property.  These indicate if the box/button is checked or not (and that the box/button's `value` should be submitted).

### The `<textarea>` Element

The [`<textarea>`](https://developer.mozilla.orghttps://developer.mozilla.org/en-US/docs/Web/HTML/Element/textarea) element represents a multi-line text input.  Similar to terminal programs, this is represented by columns and rows, the numbers of which are set by the `cols` and `rows` attributes, respectively.  Thus:

```html
<textarea cols=40 rows=5></textarea>
```

Would look like:

<textarea cols=40 rows=5></textarea>

As with inputs, a `<textarea>` has a `name` and `value` attribute.

### The `<select>` Element

The [`<select>`](https://developer.mozilla.orghttps://developer.mozilla.org/en-US/docs/Web/HTML/Element/select) element, along with `<option>` and `<optgroup>` make drop-down selection boxes.  The `<select>` takes a name attribute, while each `<option>` provides a different value.  The `<options>` can further be nested in `<optgroup>`s with their own labels.  The `<select>` also has a `multiple` attribute (to allow selecting multiple options), and `size` which determines how many options should be displayed at once (with scrolling if more are available).

For example:

```html
<select id="dino-select">
    <optgroup label="Theropods">
        <option>Tyrannosaurus</option>
        <option>Velociraptor</option>
        <option>Deinonychus</option>
    </optgroup>
    <optgroup label="Sauropods">
        <option>Diplodocus</option>
        <option>Saltasaurus</option>
        <option>Apatosaurus</option>
    </optgroup>
</select>
```

Displays as: 

<select id="dino-select">
    <optgroup label="Theropods">
        <option>Tyrannosaurus</option>
        <option>Velociraptor</option>
        <option>Deinonychus</option>
    </optgroup>
    <optgroup label="Sauropods">
        <option>Diplodocus</option>
        <option>Saltasaurus</option>
        <option>Apatosaurus</option>
    </optgroup>
</select>


### The `<label>` Element

A [`<label>`](https://developer.mozilla.orghttps://developer.mozilla.org/en-US/docs/Web/HTML/Element/label) element represents a caption for an element in the form.  It can be tied to a specific input using its `for` attribute, by setting its value to the `id` attribute of the associated input.  This allows screen readers to identify the label as belonging to the input, and also allows browsers to give focus or activate the input element when the label is clicked.

For example, if you create a checkbox with a label:

```html
<fieldset style="display:flex; align-items:center;">
  <input type="checkbox" id="example"/>
  <label for="example">Is Checked</label>
</fieldset>
```

<fieldset style="display:flex; align-items:center;">
  <input type="checkbox" id="example"/>
  <label for="example">Is Checked</label>
</fieldset>

Clicking the label will toggle the checkbox!

### The `<fieldset>` Element

The `<fieldset>` element is used to group related form parts together, which can be captioned with a `<legend>`.  It also has a `for` attribute which can be set to the `id` of a form on the page to associate with, so that the fieldset will be serialized with the form (this is not necessary if the fieldset is inside the form).  Setting the fieldset's `disabled` attribute will also disable all elements inside of it.

For example:

```html
<fieldset>
  <legend>Who is your favorite muppet?</legend>
  <input type="radio" name="muppet" id="kermit">
    <label for="kermit">Kermit</label>
  </input>
  <input type="radio" name="muppet" id="animal">
    <label for="animal">Animal</label>
  </input>
  <input type="radio" name="muppet" id="piggy">
    <label for="piggy">Miss Piggy</label>
  </input>
  <input type="radio" name="muppet" id="gonzo">
    <label for="gonzo">Gonzo</label>
  </input>
</fieldset>
```

Would render:

<style>fieldset>label {display: inline; margin-right: 2rem;} </style>
<fieldset>
  <legend>Who is your favorite muppet?</legend>
  <input type="radio" name="muppet" id="kermit">
    <label for="kermit">Kermit</label>
  </input>
  <input type="radio" name="muppet" id="animal">
    <label for="animal">Animal</label>
  </input>
  <input type="radio" name="muppet" id="piggy">
    <label for="piggy">Miss Piggy</label>
  </input>
  <input type="radio" name="muppet" id="gonzo">
    <label for="gonzo">Gonzo</label>
  </input>
</fieldset>

### The `<form>` Element

Finally, the `<form>` element wraps around all the `<input>`, `<textarea>`, and `<select>` elements, and gathers them along with any contained within associated `<fieldset>`s to submit in a serialized form.  This is done when an `<input type="submit">` is clicked within the form, when the enter key is pressed and the form has focus, or by calling the `submit()` method on the form with JavaScript.

There are a couple of special attributes we should know for the `<form>` element:

* `action` - the URL this form should be submitted to.  Defaults to the URL the form was served from.
* `enctype` - the encoding strategy used, discussed in the next section.  Possible values are:
  * `application/x-www-form-urlencoded` - the default
  * `multipart/form-data` - must be used to submit files 
  * `text/plain` - useful for debugging
* `method` - the HTTP method to submit the form using, most often GET or POST

When the form is submitted, the form is serialized using the `enctype` attribute and submitted using the HTTP `method` to the URL specified by the `action` attribute.  Let's take a deeper look at this process next.