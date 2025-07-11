---
title: Center Images in the `README.md` File of A GitHub Repository
toc: false
categories:
 - GitHub
 - Web Development
tags:
 - HTML
 - Markdown
date: 2025-07-09 18:53:41 +0800
last_modified_at: 2025-07-11 11:42:32 +0800
---

In the `README.md` file of a GitHub repository, we can center images --- by default they are aligned left --- by using HTML `<p>` element with specification `align="center"`[^1]:

```html
<p align="center">
  <img src="xxxx.jpg" width="500"/>
</p>
```

or a `<div>` element with `align="center"`[^2]:

```html
<div align="center">
  <img src="xxxx.jpg" width="500"/>
</div>
```

By the way, directly specifying `align="center"` for the `<img>` element, like:

```html
<img src="xxxx.jpg" width="500" align="center"/>
```

is not functional.

<br>

**References**

[^1]: [Guide to aligning images in github readme.md files.](https://gist.github.com/DavidWells/7d2e0e1bc78f4ac59a123ddf8b74932d)
[^2]:[Github的readme文件上传图片并进行排列（居中、同行等）](https://blog.csdn.net/weixin_44684139/article/details/116210708).