---
title: An \"Automatic-Switching-Slides\" Problem in Microsoft PowerPoint
toc: false
categories:
 - Windows
tags:
 - Microsoft PowerPoint
date: 2025-01-01 13:58:12 +0800
last_modified_at: 2025-01-06 11:50:37 +0800
---

Recently when I made slides in Microsoft PowerPoint, I found some slides would automatically jump to the next one if I right click the mouse button. At the beginning, I though my mouse had a fault, with a problem of multiple clicks, but it’s not. The real reason was that an automatic switching was set in `Trasitions > Advance Slide` panel[^1], like `After: 00:01.00` in the following case:

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501061142153.png" alt="image-20250106114206085" style="zoom:50%;" />

and I didn't know when and how I set. So, just uncheck it to resolve this problem.

<br>

**References**

[^1]: [ppt放映自动跳转下一页是怎么回事](https://jingyan.baidu.com/article/25648fc18534a8d091fd00c8.html).