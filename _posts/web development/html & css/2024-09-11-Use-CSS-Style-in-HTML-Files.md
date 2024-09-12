---
title: Use CSS in HTML Files
toc: false
categories:
 - Web Development
tags:
 - CSS
 - HTML
date: 2024-09-11 15:09:48 +0800
last_modified_at: 2024-09-11 15:09:48 +0800
---

There are three ways of using CSS in HTML files[^1].

**(1) External CSS**

[`style.css`](/webpages/2024-09-11/style.css):

```css
h1 {
    text-align: center;
    color: red;
}

h2 {
    text-align: center;
    color: blue;
}

p {
    text-align: center;
    color: green;
}
```

[`html0.html`](/webpages/2024-09-11/html0.html):

```html
<!DOCTYPE html>
<html>

<head>
    <link rel="stylesheet" href="style.css">
</head>

<body>
    <h1>Heading 1</h1>
    <h2>Heading 2</h2>
    <p>Paragraph</p>
</body>

</html>
```

where `style.css` and `html0.html` are in the same directory. The `<link>` tag is used to[^2]:

<div class="quote--left" markdown="1">

The `<link>` tag defines the relationship between the current document and an external resource.

The `<link>` tag is most often used to link to external style sheets or to add a [favicon](https://www.w3schools.com/html/html_favicon.asp) to your website.

The `<link>` element is an empty element, it contains attributes only.

</div>

where `rel` property “(required) specifies the relationship between the current document and the linked document”, and `href` property “specifies the location of the linked document”.

**(2) Internal CSS**

[`html1.html`](/webpages/2024-09-11/html1.html):

```html
<!DOCTYPE html>
<html>

<head>
    <style>
        h1 {
            text-align: center;
            color: red;
        }

        h2 {
            text-align: center;
            color: blue;
        }

        p {
            text-align: center;
            color: green;
        }
    </style>
</head>

<body>
    <h1>Heading 1</h1>
    <h2>Heading 2</h2>
    <p>Paragraph</p>
</body>

</html>
```

where `<style>` tag[^3]:

<div class="quote--left" markdown="1">

The `<style>` tag is used to define style information (CSS) for a document.

Inside the `<style>` element you specify how HTML elements should render in a browser.

The `<style>` element must be included inside the `<head>` section of the document.

</div>

**(3) Inline CSS**

[`html2.html`](/webpages/2024-09-11/html2.html):

```html
<!DOCTYPE html>
<html>

<body>
    <h1 style="text-align:center;color:red;">Heading 1</h1>
    <h2 style="text-align:center;color:blue;">Heading 2</h2>
    <p style="text-align:center;color:green;">Paragraph</p>
</body>

</html>
```

As for the cascading order when there is more than one style definition for the same HTML tag[^1]:

<div class="quote--left" markdown="1">

All the styles in a page will "cascade" into a new "virtual" style sheet by the following rules, where number one has the highest priority:

1. Inline style (inside an HTML element)
2. External and internal style sheets (in the head section)
3. Browser default

So, an inline style has the highest priority, and will override external and internal styles and browser defaults.

</div>

**Reference**

[^1]: [How to add CSS](https://www.w3schools.com/css/css_howto.asp).

[^2]: [HTML `link` tag](https://www.w3schools.com/tags/tag_link.asp).
[^3]: [HTML `style` tag](https://www.w3schools.com/tags/tag_style.asp).
