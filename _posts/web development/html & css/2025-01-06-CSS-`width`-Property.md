---
title: CSS `width` Property
toc: false
categories:
 - Web Development
tags:
 - CSS
date: 2025-01-06 16:33:09 +0800
last_modified_at: 2025-01-06 16:33:09 +0800
---

<style>
    .example1 {
    color: white;
    background-color: gold;
    padding: 10px;
    border-radius: 5px;
}
    .example2 {
    color: white;
    background-color: gold;
    padding: 10px;
    border-radius: 5px;
    width: fit-content;
}
</style>

```html
<style>
    .example1 {
    color: white;
    background-color: gold;
    padding: 10px;
    border-radius: 5px;
}
    .example2 {
    color: white;
    background-color: gold;
    padding: 10px;
    border-radius: 5px;
    width: fit-content;
}
</style>
```

<br>

With no setting `width` property (default value):

```html
<div class="example1">
    Lorem ipsum dolor sit amet, consectetur adipiscing elit.
</div>
```

<div class="example1">
    Lorem ipsum dolor sit amet, consectetur adipiscing elit.
</div>
<br>

`width: fit-content`:

```html
<div class="example2">
    Lorem ipsum dolor sit amet, consectetur adipiscing elit.
</div>
```

<div class="example2">
    Lorem ipsum dolor sit amet, consectetur adipiscing elit.
</div>

<br>

**References**

- [CSS `width` property](https://www.w3schools.com/cssref/pr_dim_width.php).
- [`width` - CSS: Cascading Style Sheets](https://developer.mozilla.org/en-US/docs/Web/CSS/width).