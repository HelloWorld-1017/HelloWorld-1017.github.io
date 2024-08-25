---
title: Host Font Awesome by CDN or by Local Files
toc: false
categories:
 - Web Development
tags:
 - CSS
date: 2024-07-31 16:09:23 +0800
last_modified_at: 2024-07-31 16:09:23 +0800
---

Official website: [Font Awesome](https://fontawesome.com/).

<br>

<i class="fa-solid fa-1"></i> **Host Font Awesome by CDN, remotely**

Add following CDN link in the `<head>` part of template file or webpages where Font Awesome to be used: 

```html
<head>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" rel="stylesheet" >
</head>
```

<br>

<i class="fa-solid fa-2"></i> **Host Font Awesome by local file, locally**

- Download: [Download Font Awesome Free or Pro \| Font Awesome](https://fontawesome.com/download).
- Instructions
  - Method 1 (which I prefer): [Web Fonts + CSS](https://docs.fontawesome.com/web/setup/host-yourself/webfonts).
  - Method 2: [SVG + JS](https://docs.fontawesome.com/web/setup/host-yourself/svg-js/).