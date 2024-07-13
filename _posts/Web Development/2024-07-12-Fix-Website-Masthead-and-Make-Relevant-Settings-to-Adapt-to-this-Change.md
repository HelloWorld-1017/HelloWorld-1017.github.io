---
title: Fix Website Masthead and Make Relevant Settings to Adapt to this Change
toc: false
categories:
 - Web Development
tags:
 - HTML
 - CSS
 - JavaScript
date: 2024-07-12 23:12:20 +0800
last_modified_at: 2024-07-12 23:12:20 +0800
---

As shown in post title. Take Jekyll theme [minimal-mistakes](https://github.com/mmistakes/minimal-mistakes) as an example.

(1) Fix website masthead

[`..\_sass\minimal-mistakes\_masthead.scss`](https://github.com/mmistakes/minimal-mistakes/blob/master/_sass/minimal-mistakes/_masthead.scss#L6)

```scss
.masthead {
  position: fixed;
  }
```

(2) Prevent website masthead from blocking webpage content

[`..\_includes\masthead.html`](https://github.com/mmistakes/minimal-mistakes/blob/master/_includes/masthead.html#L2)

```html
<div style="height:74px"></div>
```

(3) Prevent website masthead from blocking `<a>` element whose `href` attribute begins with `#` when jumping to it

[`..\_layouts\single.html`](https://github.com/mmistakes/minimal-mistakes/blob/master/_layouts/single.html)

```html
<head>
<!-- Prevent website masthead from blocking `<a>` element whose `href` attribute begins with `#` when jumping to it -->
  <script type="text/javascript">
    $(document).ready(function () {
      $('a[href^="#"][href!="#"]').click(function (e) {
        e.preventDefault();
        var hash = this.hash;
        var target = document.getElementById(hash.slice(1));
        if (!target) return;

        history.pushState(null, null, hash);

        var targetOffset = $(target).offset().top - 77;
        $('html,body').animate({ scrollTop: targetOffset }, 5);
      });

      window.addEventListener('popstate', function (event) {
        if (location.hash) {
          var target = document.getElementById(location.hash.slice(1));
          if (target) {
            var targetOffset = $(target).offset().top - 77;
            $('html,body').animate({ scrollTop: targetOffset }, 5);
          }
        }
      });
    });
  </script>
</head>
```
