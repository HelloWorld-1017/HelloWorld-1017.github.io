---
title: CSS Selectors
categories:
 - Web Development
tags:
 - CSS
 - HTML
date: 2024-09-12 08:27:59 +0800
last_modified_at: 2024-09-12 08:27:59 +0800
published: false
---

# CSS selectors

A <i class="term">CSS rule</i> consists of a <i class="term">selector</i> and a <i class="term">declaration block</i>[^1], 

- The selector points to the HTML element that is to style.
- The declaration block contains one or more declarations separated by semicolons.
- Each declaration includes a CSS property name and a value, separated by a colon.
- Multiple CSS declarations are separated with semicolons, and declaration blocks are surrounded by curly braces.

e.g.

```css
h1 {color:blue; font-size:12px;}
```

wherein `h1` is a selector, and `{color:blue; font-size:12px;}` is a declaration block.

In this process, CSS selectors are used to "find" (or select) the HTML elements we want to style, and they can be classified into following five categories[^2].

**(1) Simple selectors[^2] (select elements based on name, id, class)**

| Selector                                                     | Example      | Example description                                 |
| ------------------------------------------------------------ | ------------ | --------------------------------------------------- |
| [`#id`](https://www.w3schools.com/cssref/sel_id.asp)         | `#firstname` | Selects the element with `id="firstname"`           |
| [`.class`](https://www.w3schools.com/cssref/sel_class.asp)   | `.intro`     | Selects all elements with `class="intro"`           |
| [`element.class`](https://www.w3schools.com/cssref/sel_element_class.asp) | `p.intro`    | Selects only `<p>` elements with `class="intro"`    |
| [`*`](https://www.w3schools.com/cssref/sel_all.asp)          | `*`          | Selects all elements                                |
| [`element`](https://www.w3schools.com/cssref/sel_element.asp) | `p`          | Selects all `<p>` elements                          |
| [`element,element,..`](https://www.w3schools.com/cssref/sel_element_comma.asp) | `div, p`     | Selects all `<div>` elements and all `<p>` elements |

<br>

**(2) Combinator selectors[^3] (select elements based on a specific relationship between them)**

| Selector                                                     | Example   | Example description                                          |
| ------------------------------------------------------------ | --------- | ------------------------------------------------------------ |
| [`element element`](https://www.w3schools.com/cssref/sel_element_element.asp) | `div p`   | Selects all `<p>` elements inside `<div>` elements           |
| [`element>element`](https://www.w3schools.com/cssref/sel_element_gt.asp) | `div > p` | Selects all `<p>` elements where the parent is a `<div>` element |
| [`element+element`](https://www.w3schools.com/cssref/sel_element_pluss.asp) | `div + p` | Selects the first `<p>` element that are placed immediately after `<div>` elements |
| [`element1~element2`](https://www.w3schools.com/cssref/sel_gen_sibling.asp) | `p ~ ul`  | Selects every `<ul>` element that are preceded by a `<p>` element |

<br>

**(3) Pseudo-class selectors[^4] (select elements based on a certain state)**

| Selector                                                     | Example                 | Example description                                          |
| ------------------------------------------------------------ | ----------------------- | ------------------------------------------------------------ |
| [`:active`](https://www.w3schools.com/cssref/sel_active.asp) | `a:active`              | Selects the active link                                      |
| [`:checked`](https://www.w3schools.com/cssref/sel_checked.asp) | `input:checked`         | Selects every checked `<input>` element                      |
| [`:disabled`](https://www.w3schools.com/cssref/sel_disabled.asp) | `input:disabled`        | Selects every disabled `<input>` element                     |
| [`:empty`](https://www.w3schools.com/cssref/sel_empty.asp)   | `p:empty`               | Selects every `<p>` element that has no children             |
| [`:enabled`](https://www.w3schools.com/cssref/sel_enabled.asp) | `input:enabled`         | Selects every enabled `<input>` element                      |
| [`:first-child`](https://www.w3schools.com/cssref/sel_firstchild.asp) | `p:first-child`         | Selects every `<p>` elements that is the first child of its parent |
| [`:first-of-type`](https://www.w3schools.com/cssref/sel_first-of-type.asp) | `p:first-of-type`       | Selects every `<p>` element that is the first `<p>` element of its parent |
| [`:focus`](https://www.w3schools.com/cssref/sel_focus.asp)   | `input:focus`           | Selects the `<input>`element that has focus                  |
| [`:hover`](https://www.w3schools.com/cssref/sel_hover.asp)   | `a:hover`               | Selects links on mouse over                                  |
| [`:in-range`](https://www.w3schools.com/cssref/sel_in-range.asp) | `input:in-range`        | Selects `<input>` elements with a value within a specified range |
| [`:invalid`](https://www.w3schools.com/cssref/sel_invalid.asp) | `input:invalid`         | Selects all `<input>` elements with an invalid value         |
| [`:lang(language)`](https://www.w3schools.com/cssref/sel_lang.asp) | `p:lang(it)`            | Selects every `<p>` element with a `lang` attribute value starting with `"it"` |
| [`:last-child`](https://www.w3schools.com/cssref/sel_last-child.asp) | `p:last-child`          | Selects every `<p>` elements that is the last child of its parent |
| [`:last-of-type`](https://www.w3schools.com/cssref/sel_last-of-type.asp) | `p:last-of-type`        | Selects every `<p>` element that is the last `<p>` element of its parent |
| [`:link`](https://www.w3schools.com/cssref/sel_link.asp)     | `a:link`                | Selects all unvisited links                                  |
| [`:not(selector)`](https://www.w3schools.com/cssref/sel_not.asp) | `:not(p)`               | Selects every element that is not a `<p>` element            |
| [`:nth-child(n)`](https://www.w3schools.com/cssref/sel_nth-child.asp) | `p:nth-child(2)`        | Selects every `<p>` element that is the second child of its parent |
| [`:nth-last-child(n)`](https://www.w3schools.com/cssref/sel_nth-last-child.asp) | `p:nth-last-child(2)`   | Selects every `<p>` element that is the second child of its parent, counting from the last child |
| [`:nth-last-of-type(n)`](https://www.w3schools.com/cssref/sel_nth-last-of-type.asp) | `p:nth-last-of-type(2)` | Selects every `<p>` element that is the second `<p>` element of its parent, counting from the last child |
| [`:nth-of-type(n)`](https://www.w3schools.com/cssref/sel_nth-of-type.asp) | `p:nth-of-type(2)`      | Selects every `<p>` element that is the second `<p>` element of its parent |
| [`:only-of-type`](https://www.w3schools.com/cssref/sel_only-of-type.asp) | `p:only-of-type`        | Selects every `<p>` element that is the only `<p>` element of its parent |
| [`:only-child`](https://www.w3schools.com/cssref/sel_only-child.asp) | `p:only-child`          | Selects every `<p>` element that is the only child of its parent |
| [`:optional`](https://www.w3schools.com/cssref/sel_optional.asp) | `input:optional`        | Selects `<input>` elements with no `"required"` attribute    |
| [`:out-of-range`](https://www.w3schools.com/cssref/sel_out-of-range.asp) | `input:out-of-range`    | Selects `<input>` elements with a value outside a specified range |
| [`:read-only`](https://www.w3schools.com/cssref/sel_read-only.asp) | `input:read-only`       | Selects `<input>` elements with a `"readonly"` attribute specified |
| [`:read-write`](https://www.w3schools.com/cssref/sel_read-write.asp) | `input:read-write`      | Selects `<input>` elements with no `"readonly"` attribute    |
| [`:required`](https://www.w3schools.com/cssref/sel_required.asp) | `input:required`        | Selects `<input>` elements with a `"required"` attribute specified |
| [`:root`](https://www.w3schools.com/cssref/sel_root.asp)     | `root`                  | Selects the document's `root` element                        |
| [`:target`](https://www.w3schools.com/cssref/sel_target.asp) | `#news:target`          | Selects the current active `#news` element (clicked on a URL containing that anchor name) |
| [`:valid`](https://www.w3schools.com/cssref/sel_valid.asp)   | `input:valid`           | Selects all `<input>` elements with a valid value            |
| [`:visited`](https://www.w3schools.com/cssref/sel_visited.asp) | `a:visited`             | Selects all visited links                                    |

<br>

**(4) Pseudo-elements selectors[^5] (select and style a part of an element)**

| Selector                                                     | Example           | Example description                                          |
| ------------------------------------------------------------ | ----------------- | ------------------------------------------------------------ |
| [`::after`](https://www.w3schools.com/cssref/sel_after.asp)  | `p::after`        | Insert something after the content of each `<p>` element     |
| [`::before`](https://www.w3schools.com/cssref/sel_before.asp) | `p::before`       | Insert something before the content of each `<p>` element    |
| [`::first-letter`](https://www.w3schools.com/cssref/sel_firstletter.asp) | `p::first-letter` | Selects the first letter of each `<p>` element               |
| [`::first-line`](https://www.w3schools.com/cssref/sel_firstline.asp) | `p::first-line`   | Selects the first line of each `<p>` element                 |
| [`::marker`](https://www.w3schools.com/cssref/sel_marker.asp) | ` ::marker`       | Selects the markers of list items                            |
| [`::selection`](https://www.w3schools.com/cssref/sel_selection.asp) | `p::selection`    | Selects the portion of an element that is selected by a user |

<br>

**(5) Attribute selectors[^6] (select elements based on an attribute or attribute value)**

| Selector                                                     | Example                | Example description                                          |
| ------------------------------------------------------------ | ---------------------- | ------------------------------------------------------------ |
| [`[attribute]`](https://www.w3schools.com/cssref/sel_attribute.php) | `[target]`             | Selects all elements with a `target` attribute               |
| [`[attribute=value]`](https://www.w3schools.com/cssref/sel_attribute_value.php) | `[target="_blank"]`    | Selects all elements with `target="_blank"`                  |
| [`[attribute~=value]`](https://www.w3schools.com/cssref/sel_attribute_value_contains.php) | `[title~="flower"]`    | Selects all elements with a title attribute that contains a space-separated list of words, one of which is `"flower"` |
| [`[attribute|=value]`](https://www.w3schools.com/cssref/sel_attribute_value_lang.php) | `[lang|="en"]`         | Selects all elements with a `lang` attribute value starting with `"en"` |
| [`[attribute^=value]`](https://www.w3schools.com/cssref/sel_attr_begin.php) | `a[href^="https"]`     | Selects all `<a>` elements with a `href` attribute value starting with `"https"` |
| [`[attribute$=value]`](https://www.w3schools.com/cssref/sel_attr_end.php) | `a[href$=".pdf"]`      | Selects all `<a>` elements with a `href` attribute value ending with `".pdf"` |
| [`[attribute*=value]`](https://www.w3schools.com/cssref/sel_attr_contain.php) | `a[href*="w3schools"]` | Selects all `<a>` elements with a `href` attribute value containing the substring `"w3schools"` |

<br>

# Simple selectors

## Element selector

The <i class="term">element selector</i> selects HTML elements with a specific element name[^2], [`html1.html`](/webpages/2024-09-12/html1.html):

```html
<!DOCTYPE html>
<html>

<head>
    <style>
        p {
            text-align: center;
            color: red;
        }
    </style>
</head>

<body>
    <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
</body>

</html>
```

## Id selector

The <i class="term">id selector</i> selects HTML element with a specific `id` attribute. The `id` of an element is unique within a page, so the `id` selector is used to select one unique element, [`html2.html`](/webpages/2024-09-12/html2.html):

```html
<!DOCTYPE html>
<html>

<head>
    <style>
        #para1 {
            text-align: center;
            color: red;
        }
    </style>
</head>

<body>
    <p id="para1">Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
</body>

</html>
```

## Class selector

The <i class="term">class selector</i> selects HTML elements with a specific class attribute, [`html3.html`](/webpages/2024-09-12/html3.html):

```html
<!DOCTYPE html>
<html>

<head>
    <style>
        .center {
            text-align: center;
            color: red;
        }
    </style>
</head>

<body>
    <p class="center">Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
</body>

</html>
```

You can also specify that only specific HTML elements should be affected by a class. Like in the following example, only `<p>` elements with `class="center"` will be red and center-aligned, [`html4.html`](/webpages/2024-09-12/html4.html):

```html
<!DOCTYPE html>
<html>

<head>
    <style>
        p.center {
            text-align: center;
            color: red;
        }
    </style>
</head>

<body>
    <p class="center">Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
    <div class="center">Lorem ipsum dolor sit amet, consectetur adipiscing elit.</div>
</body>

</html>
```

HTML elements can also refer to more than one class, [`html5.html`](/webpages/2024-09-12/html5.html):

```html
<!DOCTYPE html>
<html>

<head>
    <style>
        .center {
            text-align: center;
            color: red;
        }

        .large {
            font-size: xx-large;
            font-family: 'Times New Roman', Times, serif;
        }
    </style>
</head>

<body>
    <p class="center">Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
    <p class="center large">Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
</body>

</html>
```

## Universal selector

The <i class="term">universal selector</i> `*` selects all HTML elements on the page, [`html6.html`](/webpages/2024-09-12/html6.html):

```html
<!DOCTYPE html>
<html>

<head>
    <style>
        * {
            text-align: center;
            color: red;
        }
    </style>
</head>

<body>
    <h1>Lorem Ipsum</h1>
    <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
    <div>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</div>
</body>

</html>
```

## Grouping selector

The <i class="term">grouping selector</i> selects all the HTML elements with the same style definitions. It will be better to group the selectors, to minimize the code, [`html7.html`](/webpages/2024-09-12/html7.html):

```html
<!DOCTYPE html>
<html>

<head>
    <style>
        h1,
        h2,
        p {
            text-align: center;
            color: red;
        }
    </style>
</head>

<body>
    <h1>Lorem Ipsum</h1>
    <h2>Lorem Ipsum</h2>
    <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
    <div>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</div>
</body>

</html>
```

<br>

# Combinator selectors

A CSS selector can contain more than one simple selector. Between the simple selectors, we can include a combinator.[^3]

There are four different combinators in CSS:

- descendant selector (space)
- child selector (>)
- adjacent sibling selector (+)
- general sibling selector (~)

## Descendant selector vs. Child selector (`>`)

The <i class="term">descendant selector</i> matches <i class="emphasize">all</i> elements that are descendants of a specified element, [`html8.html`](/webpages/2024-09-12/html8.html):

```html
<!DOCTYPE html>
<html>

<head>
    <style>
        div p {
            color: red;
            background-color: yellow;
        }
    </style>
</head>

<body>
    <div>
        <h1>Lorem Ipsum</h1>
        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
        <span>
            <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
        </span>
    </div>
</body>

</html>
```

The <i class="term">child selector</i> selects all elements that are the <i class="emphasize">children</i> of a specified element, [`html9.html`](/webpages/2024-09-12/html9.html):

```html
<!DOCTYPE html>
<html>

<head>
    <style>
        div>p {
            color: red;
            background-color: yellow;
        }
    </style>
</head>

<body>
    <div>
        <h1>Lorem Ipsum</h1>
        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
        <span>
            <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
        </span>
    </div>
</body>

</html>
```

## Adjacent sibling selector (`+`) vs. General sibling selector (`~`)

The <i class="term">adjacent sibling selector</i> is used to select an element that is <i class="emphasize">directly after</i> another specific element; "adjacent" means "immediately following", [`html10.html`](/webpages/2024-09-12/html10.html):

```html
<!DOCTYPE html>
<html>

<head>
    <style>
        div+p {
            color: red;
            background-color: yellow;
        }
    </style>
</head>

<body>
    <h1>Lorem Ipsum</h1>
    <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
    <div>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</div>
    <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
    <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
</body>

</html>
```

The <i class="term">general sibling selector</i> selects <i class="emphasize">all</i> elements that are next siblings of a specified element, [`html11.html`](/webpages/2024-09-12/html11.html):

```html
<!DOCTYPE html>
<html>

<head>
    <style>
        div~p {
            color: red;
            background-color: yellow;
        }
    </style>
</head>

<body>
    <h1>Lorem Ipsum</h1>
    <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
    <div>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</div>
    <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
    <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
</body>

</html>
```

<br>

# Pseudo-class selectors

A pseudo-class is used to define a special state of an element.[^4]

For example, it can be used to:

- Style an element when a user mouses over it;
- Style visited and unvisited links differently;
- Style an element when it gets focus.

The syntax of pseudo-classes:

```scss
selector:pseudo-class {
    property: value;
}
```

## Anchor pseudo-classes

Links can be displayed in different ways, [`html12.html`](/webpages/2024-09-12/html12.html):

```html
<!DOCTYPE html>
<html>

<head>
    <style>
        /* unvisited link */
        a:link {
            color: #FF0000;
        }

        /* visited link */
        a:visited {
            color: #00FF00;
        }

        /* mouse over link */
        a:hover {
            color: #FF00FF;
        }

        /* selected link */
        a:active {
            color: #0000FF;
        }
    </style>
</head>

<body>
    <h1><a href="https://www.lipsum.com/">Lorem Ipsum</a></h1>
</body>

</html>
```

**Note:** `a:hover` MUST come after `a:link` and `a:visited` in the CSS definition in order to be effective! `a:active` MUST come after `a:hover` in the CSS definition in order to be effective! Pseudo-class names are not case-sensitive.

## Pseudo-classes and HTML classes

<i class="term">Pseudo-classes</i> can be combined with only a specific HTML class, [`html13.html`](/webpages/2024-09-12/html13.html):

```html
<!DOCTYPE html>
<html>

<head>
    <style>
        a.highlight:hover {
            color: #ff0000;
        }
    </style>
</head>

<body>
    <h1><a href="https://www.lipsum.com/">Lorem Ipsum</a></h1>
    <h1><a class="highlight" href="https://www.lipsum.com/">Lorem Ipsum</a></h1>
</body>

</html>
```

only functional for the second `<a>` tag.

## Hover on `<div>`

An example of using the `:hover` pseudo-class on a `<div>` element, [`html14.html`](/webpages/2024-09-12/html14.html):

```html
<!DOCTYPE html>
<html>

<head>
    <style>
        div {
            background-color: green;
            color: white;
            padding: 25px;
            text-align: center;
        }

        div:hover {
            background-color: blue;
        }
    </style>
</head>

<body>
    <div>Mouse Over Me</div>
</body>

</html>
```

## Simple tooltip hover

Hover over a `<div>` element to show a `<p>` element (like a tooltip), [`html15.html`](/webpages/2024-09-12/html15.html):

```html
<!DOCTYPE html>
<html>

<head>
    <style>
        p {
            display: none;
            background-color: yellow;
            padding: 20px;
        }

        div:hover p {
            display: block;
        }
    </style>
</head>

<body>
    <h1>Tada! Here I am!</h1>
    <p>Tada! Here I am!</p>
    <div>Hover over this div element to show the p element
        <p>Tada! Here I am!</p>
    </div>
</body>

</html>
```

The text wrapped in the `<p>` tag outside the `<div>` block is not, and never, visible.

## The `:first-child` pseudo-class

The `:first-child` pseudo-class matches a specified element that is the first child of another element.[^7]

**(1) Match the first `<p>` element**

In the following example, the selector matches any `<p>` element that is the first child of any element, [`html16.html`](/webpages/2024-09-12/html16.html):

```html
<!DOCTYPE html>
<html>

<head>
    <style>
        p:first-child {
            color: blue;
            background-color: yellow;
        }
    </style>
</head>

<body>
    <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
    <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
    <div>
        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
    </div>
</body>

</html>
```

**(2) Match the `<i>` element in all `<p>` elements**

In the following example, the selector matches all `<i>` elements in `<p>` elements that are the first child of another element, [`html17.html`](/webpages/2024-09-12/html17.html):

```html
<!DOCTYPE html>
<html>

<head>
    <style>
        p:first-child i {
            color: blue;
            background-color: yellow;
        }
    </style>
</head>

<body>
    <p>
        <i>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</i>
        <i>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</i>
    <div>
        <i>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</i>
        <i>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</i>
    </div>
    </p>

    <div>
        <i>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</i>
        <i>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</i>
    </div>
</body>

</html>
```

## The `:lang` pseudo-class

The `:lang` pseudo-class is used to define special rules for different languages. In the following example, `:lang` defines the quotation marks for `<q>` elements with `lang="no"` [^8], [`html18.html`](/webpages/2024-09-12/html18.html):

```html
<!DOCTYPE html>
<html>

<head>
    <style>
        q:lang(no) {
            quotes: "~" "~";
        }
    </style>
</head>

<body>
    <p>Some text <q lang="no">A quote in a paragraph</q> Some text.</p>
    <p>Some text <q>A quote in a paragraph</q> Some text.</p>
</body>

</html>
```

<br>

# Pseudo-elements

A CSS pseudo-element is used to style specified parts of an element.[^5]

For example, it can be used to:

- Style the first letter, or line, of an element
- Insert content before, or after, the content of an element

The syntax of pseudo-elements:

```css
selector::pseudo-element {
    property: value;
}
```

## The `::first-line` and `::first-letter` pseudo-element

The `::first-line` pseudo-element is used to add a special style to the first line of a text.

The `::first-letter` pseudo-element is used to add a special style to the first letter of a text, [`html20.html`](/webpages/2024-09-12/html20.html):

```html
<!DOCTYPE html>
<html>

<head>
    <style>
        p::first-line {
            color: #ff0000;
            font-variant: small-caps;
        }

        p::first-letter {
            color: blue;
            font-size: xx-large;
        }
    </style>
</head>

<body>
    <p>
        Lorem ipsum dolor sit amet, consectetur adipiscing elit.
        Integer molestie sapien lorem, pulvinar sollicitudin risus tincidunt a.
        Aliquam lacus justo, sollicitudin nec eleifend in, sagittis non mi. Donec quis cursus diam.
    </p>
</body>

</html>
```

**Note:** The `::first-line` and `::first-letter` pseudo-element can only be applied to block-level elements.

<div class="notice--warning" markdown="1">

**Notice the double colon notation -** `::first-line` versus `:first-line`

The double colon replaced the single-colon notation for pseudo-elements in CSS3. This was an attempt from W3C to distinguish between **pseudo-classes** and **pseudo-elements**.

The single-colon syntax was used for both pseudo-classes and pseudo-elements in CSS2 and CSS1.

For backward compatibility, the single-colon syntax is acceptable for CSS2 and CSS1 pseudo-elements.

</div>

## Pseudo-elements and HTML classes

Pseudo-elements can be combined with HTML classes, [`html21.html`](/webpages/2024-09-12/html21.html):

```html
<!DOCTYPE html>
<html>

<head>
    <style>
        p::first-line {
            color: #ff0000;
            font-variant: small-caps;
        }

        p.intro::first-letter {
            color: #ff0000;
            font-size: 200%;
        }
    </style>
</head>

<body>
    <p>
        Lorem ipsum dolor sit amet, consectetur adipiscing elit.
        Integer molestie sapien lorem, pulvinar sollicitudin risus tincidunt a.
        Aliquam lacus justo, sollicitudin nec eleifend in, sagittis non mi. Donec quis cursus diam.
    </p>

    <p class="intro">
        Lorem ipsum dolor sit amet, consectetur adipiscing elit.
        Integer molestie sapien lorem, pulvinar sollicitudin risus tincidunt a.
        Aliquam lacus justo, sollicitudin nec eleifend in, sagittis non mi. Donec quis cursus diam.
    </p>
</body>

</html>
```

The example above will display the first letter of paragraphs with `class="intro"`, in red and in a larger size.

## The `::before` and  `::after` pseudo-element

The `::before` pseudo-element can be used to insert some content before the content of an element.

The `::after` pseudo-element can be used to insert some content after the content of an element, [`html22.html`](/webpages/2024-09-12/html22.html):

```html
<!DOCTYPE html>
<html>

<head>
    <style>
        h1::before {
            content: "\"";
        }

        h1::after {
            content: "\"";
        }
    </style>
</head>

<body>
    <h1>Lorem ipsum</h1>

    <p>
        Lorem ipsum dolor sit amet, consectetur adipiscing elit.
        Integer molestie sapien lorem, pulvinar sollicitudin risus tincidunt a.
        Aliquam lacus justo, sollicitudin nec eleifend in, sagittis non mi. Donec quis cursus diam.
    </p>

    <h1>Lorem ipsum</h1>
</body>

</html>
```

## The `::marker` pseudo-element

The `::marker` pseudo-element selects the markers of list items, functional for both unordered and ordered lists, [`html23.html`](/webpages/2024-09-12/html23.html):

```html
<!DOCTYPE html>
<html>

<head>
    <style>
        ::marker {
            color: red;
            font-size: 23px;
        }
    </style>
</head>

<body>
    <ul>
        <li>Coffee</li>
        <li>Tea</li>
        <li>Milk</li>
    </ul>

    <ol>
        <li>First</li>
        <li>Second</li>
        <li>Third</li>
    </ol>
</body>

</html>
```

## The `::selection` pseudo-element

The `::selection` pseudo-element matches the portion of an element that is selected by a user.

The following CSS properties can be applied to `::selection`: `color`, `background`, `cursor`, and `outline`, [`html24.html`](/webpages/2024-09-12/html24.html):

```html
<!DOCTYPE html>
<html>

<head>
    <style>
        ::selection {
            color: red;
            background: yellow;
        }
    </style>
</head>

<body>
    <h1>Lorem ipsum</h1>
    <p>
        Lorem ipsum dolor sit amet, consectetur adipiscing elit.
        Integer molestie sapien lorem, pulvinar sollicitudin risus tincidunt a.
        Aliquam lacus justo, sollicitudin nec eleifend in, sagittis non mi. Donec quis cursus diam.
    </p>
</body>

</html>
```

<br>

# Attribute selectors

It is possible to style HTML elements that have specific attributes or attribute values.[^6]

## `[attribute]` selector

The `[attribute]` selector is used to select elements with a specified attribute, [`html25.html`](/webpages/2024-09-12/html25.html):

```html
<!DOCTYPE html>
<html>

<head>
    <style>
        a[target] {
            background-color: yellow;
        }
    </style>
</head>

<body>
    <a href="https://www.lipsum.com/">Lorem ipsum</a>
    <a href="https://www.lipsum.com/" target="_blank">Lorem ipsum</a>
    <a href="https://www.lipsum.com/" target="_top">Lorem ipsum</a>
</body>

</html>
```

## `[attribute="value"]` selector

The `[attribute="value"]` selector is used to select elements with a specified attribute and value, [`html26.html`](/webpages/2024-09-12/html26.html):

```html
<!DOCTYPE html>
<html>

<head>
    <style>
        a[target="_blank"] {
            background-color: yellow;
        }
    </style>
</head>

<body>
    <a href="https://www.lipsum.com/">Lorem ipsum</a>
    <a href="https://www.lipsum.com/" target="_blank">Lorem ipsum</a>
    <a href="https://www.lipsum.com/" target="_top">Lorem ipsum</a>
</body>

</html>
```

## `[attribute~="value"]` selector

The `[attribute~="value"]` selector is used to select elements with an attribute value containing a specified word, [`html27.html`](/webpages/2024-09-12/html27.html):

```html
<!DOCTYPE html>
<html>

<head>
    <style>
        [title~="lipsum"] {
            border: 5px solid yellow;
        }
    </style>
</head>

<body>
    <h1>Lorem ipsum</h1>
    <p>
        Lorem ipsum dolor sit amet, consectetur adipiscing elit.
        Integer molestie sapien lorem, pulvinar sollicitudin risus tincidunt a.
        Aliquam lacus justo, sollicitudin nec eleifend in, sagittis non mi. Donec quis cursus diam.
    </p>

    <p title="lipsum">
        Lorem ipsum dolor sit amet, consectetur adipiscing elit.
        Integer molestie sapien lorem, pulvinar sollicitudin risus tincidunt a.
        Aliquam lacus justo, sollicitudin nec eleifend in, sagittis non mi. Donec quis cursus diam.
    </p>
</body>

</html>
```

## `[attribute|="value"]` selector

The `[attribute|="value"]` selector is used to select elements with the specified attribute, whose value can be exactly the specified value, or the specified value followed by a hyphen `-`.

**Note:** The value has to be <i class="emphasize">a whole word</i>, either alone, like `class="top"`, or followed by a hyphen `-`, like `class="top-text"`, [`html28.html`](/webpages/2024-09-12/html28.html):

```html
<!DOCTYPE html>
<html>

<head>
    <style>
        [class|="top"] {
            background: yellow;
        }
    </style>
</head>

<body>
    <h1>Lorem ipsum</h1>
    <p class="top">Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
    <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
    <p class="top-text">Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
</body>

</html>
```

## `[attribute^="value"]`, `[attribute$="value"]`, and `[attribute*="value"]` selector

The `[attribute^="value"]` selector is used to select elements with the specified attribute, whose value starts with the specified value. (A simple application[^9])

The `[attribute$="value"]` selector is used to select elements whose attribute value ends with a specified value.

The `[attribute*="value"]` selector is used to select elements whose attribute value contains a specified value.

**Note:** The value does NOT have to be a whole word, [`html29.html`](/webpages/2024-09-12/html29.html):

```html
<!DOCTYPE html>
<html>

<head>
    <style>
        [class^="top"] {
            background: yellow;
        }

        [class$="op"] {
            background: green;
            color: white;
        }

        [class*="tom"] {
            background: blue;
            color: white;
        }
    </style>
</head>

<body>
    <h1>Lorem ipsum</h1>
    <p class="top-text">Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
    <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
    <p class="top-top-text">Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
    <p class="text-top">Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>

    <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
    <p class="bottom-text">Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
    <p class="bo-tom-text">Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
    <p class="text-bot-tom">Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
</body>

</html>
```

## Styling forms

The attribute selectors can be useful for styling forms without class or ID, [`html30.html`](/webpages/2024-09-12/html30.html):

```html
<!DOCTYPE html>
<html>

<head>
    <style>
        input[type="text"] {
            width: 150px;
            display: block;
            margin-bottom: 10px;
            background-color: yellow;
        }

        input[type="button"] {
            width: 120px;
            margin-left: 35px;
            display: block;
        }
    </style>
</head>

<body>
    <h2>Styling Forms</h2>

    <form name="input" action="" method="get">
        Firstname:<input type="text" name="Name" value="Peter" size="20">
        Lastname:<input type="text" name="Name" value="Griffin" size="20">
        <input type="button" value="Example Button">
    </form>
</body>

</html>
```

<br>

**References**

[^1]: [CSS Syntax](https://www.w3schools.com/css/css_syntax.ASP).

[^2]: [CSS Selectors](https://www.w3schools.com/css/css_selectors.asp).
[^3]: [CSS Combinators](https://www.w3schools.com/css/css_combinators.asp).
[^4]: [CSS Pseudo-classes](https://www.w3schools.com/css/css_pseudo_classes.asp).
[^5]: [CSS Pseudo-elements](https://www.w3schools.com/css/css_pseudo_elements.asp).
[^6]: [CSS Attribute Selector](https://www.w3schools.com/css/css_attribute_selectors.asp).
[^7]: [CSS `:first-child` Selector](https://www.w3schools.com/cssref/sel_firstchild.php).
[^8]: [HTML Global `lang` Attribute](https://www.w3schools.com/tags/att_global_lang.asp).
[^9]: [Realize Opening a New Tab when Clicking a Link in Webpage by JavaScript - WHAT A STARRY NIGHT~](https://helloworld-1017.github.io/2024-07-13/18-36-02.html).
