---
title: "Validation"
pre: "5. "
weight: 50
date: 2018-08-24T10:53:26-05:00
---

Validation refers to the process of making sure the submitted data matches our expectations.  Validation can be done client-side or server-side.  For example, we can use the built-in HTML form validation properties to enforce rules, like a number that must be positive:

```html
<input type="number" min="0" name="Age" required>
```

If a user attempts to submit a form containing this input is submitted, and the value is less than 0, the browser will display an error message instead of submitting.  In addition, the psuedo-css class `:invalid` will be applied to the element.

We can also mark inputs as required using the `required` attribute.  The browser will refuse to submit the form until all required inputs are completed. Inputs with a `required` attribute also receive the `:required` pseudo-class, allowing you to assign specific styles to them.

You can read more about HTML Form validation on [MDN](https://developer.mozilla.org/en-US/docs/Learn/Forms/Form_validation).

Client-side validation is a good idea, because is minimizes invalid requests against our web application.  However, we cannot always depend on it, so we _also_ need to implement server-side validation.  We can write custom logic for doing this, but Razor Pages also supports special validation decorators for bound properties.  For example, the corresponding validation for the input above would be:

```csharp
[BindProperty]
[Required]
[Range(0, int.MaxValue)]
public int Age { get; set; }
```

The available validation decorators are:
* `[CreditCard]`: Validates that the property has a credit card format. Requires jQuery Validation Additional Methods.
* `[Compare]`: Validates that two properties in a model match.
* `[EmailAddress]`: Validates that the property has an email format.
* `[Phone]`: Validates that the property has a telephone number format.
* `[Range]`: Validates that the property value falls within a specified range.
* `[RegularExpression]`: Validates that the property value matches a specified regular expression.
* `[Required]`: Validates that the field is not null. See [Required] attribute for details about this attribute's behavior.
* `[StringLength]`: Validates that a string property value doesn't exceed a specified length limit.
* `[Url]`: Validates that the property has a URL format.

If validation fails, then the `PageModel`'s `IsValid` attribute is false.

You can read more about server-side validation with Razor pages in the [Microsoft Documentation](https://docs.microsoft.com/en-us/aspnet/core/mvc/models/validation?view=aspnetcore-3.1).