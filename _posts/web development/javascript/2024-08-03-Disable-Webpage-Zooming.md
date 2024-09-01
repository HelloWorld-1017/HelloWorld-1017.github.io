---
title: Disable Webpage Zooming by JavaScript
toc: false
categories:
 - Web Development
tags:
 - JavaScript
 - HTML
date: 2024-08-03 23:52:55 +0800
last_modified_at: 2024-09-01 12:46:38 +0800
---

```html
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" />
<script>
    document.addEventListener('wheel', function (e) {
      if (e.ctrlKey) {
        e.preventDefault();
      }
    }, {
      capture: false,
      passive: false 
    });

    document.addEventListener('keydown', function (event) {
      const zoomKeys = ['=', '+', '-', '_'];
      if ((event.ctrlKey || event.metaKey) && zoomKeys.includes(event.key)) {
        event.preventDefault();
      }
    }, false);  
</script>
```

<div class="quote--left" markdown="1">

**Viewport `meta` tag**[^1]

The browser's <i class="term">viewport</i> is the area of the window in which web content can be seen. This is often not the same size as the <i class="term">rendered page</i>, in which case the browser provides scrollbars for the user to scroll around and access all the content.

Some <i class="emphasize">mobile devices</i> and <i class="emphasize">other narrow screens</i> render pages in a <i class="term">virtual window</i> or <i class="term">viewport</i>, which is usually <i class="emphasize">wider</i> than the screen, and then <i class="emphasize">shrink</i> the rendered result down so it <i class="emphasize">can all be seen at once</i>. Users can then zoom and pan to look more closely at different areas of the page. For example, if a mobile screen has a width of 640px, pages might be rendered with a virtual viewport of 980px, and then it will be shrunk down to fit into the 640px space.

This is done because not all pages are optimized for mobile and break (or at least look bad) when rendered at a small viewport width. This virtual viewport is a way to make <i class="emphasize">non-mobile-optimized sites</i> in general look better on narrow screen devices.

However, this mechanism is not so good for <i class="emphasize">pages that are optimized for narrow screens</i> using <i class="term">media queries</i> -- if the virtual viewport is 980px for example, media queries that kick in at 640px or 480px or less will never be used, <i class="emphasize">limiting</i> the effectiveness of such <i class="term">responsive design techniques</i>. The viewport `meta` element mitigates this problem of virtual viewport on narrow screen devices.

</div>

**References**

- [PC端禁止用户缩放页面的实现方式\_pc页面禁止缩放-CSDN博客](https://blog.csdn.net/qq_36451496/article/details/120955798).
- [KeyboardEvent key Property](https://www.w3schools.com/jsref/event_key_key.asp).
- [`Array.prototype.includes()` - JavaScript \| MDN](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/includes).

[^1]: [Viewport `meta` tag - HTML: HyperText Markup Language \| MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Viewport_meta_tag).

