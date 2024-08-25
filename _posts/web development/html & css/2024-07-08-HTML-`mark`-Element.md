---
title: Highlight Text in HTML Webpages by `<mark>` Element
toc: false
categories:
 - Web Development
tags:
 - HTML
 - Markdown
date: 2024-07-08 10:09:07 +0800
last_modified_at: 2024-08-25 18:49:30 +0800
---

In Markdown files, we can use markup `==` to wrap text to highlight the content. However, Jekyll (at least for Markdown renderer kramdown[^1][^2] which my website use) doesn’t support converting this markup syntax to the HTML element for highlighting, for example:

```markdown
==This is highlighted text.==
```

==This is highlighted text.==

So, to make highlight the text in HTML webpages, we should use `<mark>` element[^3], whose basic syntax is like:

```html
<mark>This is highlighted text.</mark>
```

<mark>This is highlighted text.</mark>

Based on it we can specify the `style` attribute to customize style:

```html
<mark style="background:blue;color:white;font-weight:bold;padding:7px;border-radius:3px;">This is highlighted text.</mark>
```

<mark style="background:blue;color:white;font-weight:bold;padding:7px;border-radius:3px;">This is highlighted text.</mark>

Of course, the same effect can be achieved by CSS style:

```css
.mark-example {
    color: white;
    background-color: blue;
    font-weight: bold;
    padding: 7px;
    border-radius: 3px;
}
```

```html
<mark class="mark-example">This is highlighted text.</mark>
```

<mark class="mark-example">This is highlighted text.</mark>

<br>

**References**

[^1]: [Markdown Options \| Jekyll • Simple, blog-aware, static sites](https://jekyllrb.com/docs/configuration/markdown/).
[^2]: [Home \| kramdown](https://kramdown.gettalong.org/).
[^3]: [`<mark>`: The Mark Text element - HTML: HyperText Markup Language \| MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/mark).

