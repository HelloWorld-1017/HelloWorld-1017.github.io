---
title: Realize Opening a New Tab when Clicking a Link in Webpage by JavaScript
toc: false
categories:
 - Web Development
tags:
 - JavaScript
date: 2024-07-13 18:36:02 +0800
last_modified_at: 2024-08-25 18:26:35 +0800
---

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

