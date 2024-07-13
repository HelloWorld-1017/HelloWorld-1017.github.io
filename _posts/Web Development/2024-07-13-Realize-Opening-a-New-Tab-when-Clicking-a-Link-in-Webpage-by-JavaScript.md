---
title: Realize Opening a New Tab when Clicking a Link in Webpage by JavaScript
toc: false
categories:
 - Web Development
tags:
 - JavaScript
date: 2024-07-13 18:36:02 +0800
last_modified_at: 2024-07-13 18:36:02 +0800
---

As shown in post title. Take Jekyll theme [minimal-mistakes](https://github.com/mmistakes/minimal-mistakes), we can add following JavaScript code in the file [`..\_layouts\single.html`](https://github.com/mmistakes/minimal-mistakes/blob/master/_layouts/single.html#L4):

```html
<head>
  <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
  <script type="text/javascript">
    $(document).ready(function() {
      // For external links
      $('a[href^="http"]').each(function() {
        $(this).attr('target', '_blank');
      });
        
      // For internal links
      $('a[href^="/"]').each(function () {
        $(this).attr('target', '_blank');
      });
    });
  </script>
</head>
```

