---
title: HTML `<article>` Tag
toc: false
categories:
 - Web Development
tags:
 - CSS
 - HTML
date: 2024-09-27 04:48:59 +0800
last_modified_at: 2025-01-09 11:25:46 +0800
---

HTML `<article>` tag[^1]:

<div class="quote--left" markdown="1">

The `<article>` tag specifies <i class="emphasize">independent</i>, <i class="emphasize">self-contained</i> content.

An article should make sense on its own and it should be possible to distribute it independently from the rest of the site.

Potential sources for the `<article>` element:

- Forum post
- Blog post
- News story

**Note:** The `<article>` element does not render as anything special in a browser. However, you can use CSS to style the `<article>` element (see example below).

</div>

Reference[^1] also provides two examples.

Example 1:

```html
<article>
<h2>Google Chrome</h2>
<p>Google Chrome is a web browser developed by Google, released in 2008. Chrome is the world's most popular web browser today!</p>
</article>

<article>
<h2>Mozilla Firefox</h2>
<p>Mozilla Firefox is an open-source web browser developed by Mozilla. Firefox has been the second most popular web browser since January, 2018.</p>
</article>

<article>
<h2>Microsoft Edge</h2>
<p>Microsoft Edge is a web browser developed by Microsoft, released in 2015. Microsoft Edge replaced Internet Explorer.</p>
</article>
```

[`html1.html`](/webpages/2024-09-27/html1.html).

Example 2:

```html
<html>
<head>
<style>
.all-browsers {
  margin: 0;
  padding: 5px;
  background-color: lightgray;
}

.all-browsers > h1, .browser {
  margin: 10px;
  padding: 5px;
}

.browser {
  background: white;
}

.browser > h2, p {
  margin: 4px;
  font-size: 90%;
}
</style>
</head>
<body>

<article class="all-browsers">
  <h1>Most Popular Browsers</h1>
  <article class="browser">
    <h2>Google Chrome</h2>
    <p>Google Chrome is a web browser developed by Google, released in 2008. Chrome is the world's most popular web browser today!</p>
  </article>
  <article class="browser">
    <h2>Mozilla Firefox</h2>
    <p>Mozilla Firefox is an open-source web browser developed by Mozilla. Firefox has been the second most popular web browser since January, 2018.</p>
  </article>
  <article class="browser">
    <h2>Microsoft Edge</h2>
    <p>Microsoft Edge is a web browser developed by Microsoft, released in 2015. Microsoft Edge replaced Internet Explorer.</p>
  </article>
</article>

</body>
</html>
```

[`html2.html`](/webpages/2024-09-27/html2.html).

<br>

**References**

[^1]: [HTML `article` Tag](https://www.w3schools.com/tags/tag_article.asp).