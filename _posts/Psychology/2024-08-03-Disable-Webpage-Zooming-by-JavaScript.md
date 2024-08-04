---
title: Disable Webpage Zooming by JavaScript
toc: false
categories:
 - Web Development
tags:
 - JavaScript
date: 2024-08-03 23:52:55 +0800
last_modified_at: 2024-08-03 23:52:55 +0800
---

```html
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

<br>

**References**

[1] [PC端禁止用户缩放页面的实现方式\_pc页面禁止缩放-CSDN博客](https://blog.csdn.net/qq_36451496/article/details/120955798).

[2] [KeyboardEvent key Property](https://www.w3schools.com/jsref/event_key_key.asp).

[3] [Array.prototype.includes() - JavaScript \| MDN](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/includes).