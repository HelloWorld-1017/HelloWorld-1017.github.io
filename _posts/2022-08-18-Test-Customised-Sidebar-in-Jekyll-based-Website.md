---
layout: single
title: Test Customised Sidebar in Jekyll-based
date: 2022-08-18 12:42:07 +0800
categories: 
 - Jekyll
toc: false
classes: wide
sidebar:
  - title: "Title"
    image: "/images/PeakyBlinders1.jpg"
    image_alt: "image"
    text: "Some text here."
  - title: "Another Title"
    text: "More text here."
    nav: sidebar-sample
---

在 YAML Front Matter 中写入：

```yaml
sidebar:
  - title: "Title"
    image: "/images/PeakyBlinders1.jpg"
    image_alt: "image"
    text: "Some text here."
  - title: "Another Title"
    text: "More text here."
    nav: sidebar-sample
```

其中 `nav` 的参数 `sidebar-sample` 的设置参考：[Layout: Sidebar with Navigation List - Minimal Mistakes (mmistakes.github.io)](https://mmistakes.github.io/minimal-mistakes/layout-sidebar-nav-list/)

<br>

**References**

[1] [https://mmistakes.github.io/minimal-mistakes/layout-sidebar-custom/](https://mmistakes.github.io/minimal-mistakes/layout-sidebar-custom/)