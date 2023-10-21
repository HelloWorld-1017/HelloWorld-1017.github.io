---
layout: single
title: Cross Reference in the Jekyll-based Web Page
date: 2023-10-10 16:37:25 +0800
categories:
 - Jekyll
toc: false
---

The cross reference in the Jekyll-based website could be realised by adding HTML `<div>` tag (and whose `id` property) in the `.md` file [[1]](#ref-1).

Firstly, use `<div id="xxx"></div>` to create a "division" in the specified position [[2]](#ref-2), like:

```markdown
**References**
<div id="ref-1"></div>
[1] [Markdown 添加文献引用 - 别再闹了 - 博客园](https://www.cnblogs.com/jiading/articles/12966059.html).
<div id="ref-2"></div>
[2] [HTML div tag - w3schools](https://www.w3schools.com/tags/tag_div.ASP).
```

We could use adding hyperlink for text to refer division with a certain `id`: 

```markdown
This is reference [[1]](#ref-1).

This is reference [[2]](#ref-2).
```

This is reference [[1]](#ref-1).

This is reference [[2]](#ref-2).

After deploying web page, it will direct to the referred division when we clicking the text content with hyperlink, and the website address of the division is like:

![image-20231010165147365](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/image-20231010165147365.png)

however, this function is not available in the original `.md` file. 

<br>

**References**

<div id="ref-1"></div>
[1] [Markdown 添加文献引用 - 别再闹了 - 博客园](https://www.cnblogs.com/jiading/articles/12966059.html).

<div id="ref-2"></div>

[2] [HTML div tag - w3schools](https://www.w3schools.com/tags/tag_div.ASP).



