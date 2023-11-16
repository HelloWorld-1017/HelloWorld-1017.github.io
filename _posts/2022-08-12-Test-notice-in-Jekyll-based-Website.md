---
layout: single
title: "Test `{: .notice}` in Jekyll-based Website" 
date: 2022-08-12 17:03:13 +0800
categories: 
 - Jekyll
toc: false
classes: wide
last_modified_at: 2023-11-16 09:55:06 +0800
---

<br>

注意1：在段落后 `Shift + Enter` 并添加代码 `{: .notice} `
{: .notice} 



注意2：在段落后 `Shift + Enter` 并添加代码 `{: .notice--primary} `
{: .notice--primary}



注意3：在段落后 `Shift + Enter` 并添加代码 `{: .notice--info} `
{: .notice--info}



注意4：在段落后 `Shift + Enter` 并添加代码 `{: .notice--warning} `
{: .notice--warning}



注意5：在段落后 `Shift + Enter` 并添加代码 `{: .notice--danger} `
{: .notice--danger}



注意6：在段落后 `Shift + Enter` 并添加代码 `{: .notice--success} `
{: .notice--success}

<br>

If want to wrap several paragraphs and more elements in a notice, we could use liquid to capture the content and then filter it with `markdownify` [3].

{% raw %}

```
{% capture notice-2 %}

#### Fourth-level caption in notice

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202311160939895.png" alt="image-20231116093909824" style="zoom:50%;" />
{% endcapture %}

<div class="notice">{{ notice-2 | markdownify }}</div>
```

{% endraw %}

{% capture notice-2 %}

#### Fourth-level caption in notice

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202311160939895.png" alt="image-20231116093909824" style="zoom:50%;" />
{% endcapture %}

<div class="notice">{{ notice-2 | markdownify }}</div>

<br>

**References**

[1] [Markup: HTML Tags and Formatting - Minimal Mistakes](https://mmistakes.github.io/minimal-mistakes/markup/markup-html-tags-and-formatting/#top).

[2] [Layout: Post with Sticky Table of Contents - Minimal Mistakes](https://mmistakes.github.io/minimal-mistakes/layout-table-of-contents-sticky/).

[3] [Post: Notice - Minimal Mistakes](https://mmistakes.github.io/minimal-mistakes/post%20formats/post-notice/).

[4] [解决Jekyll代码块无法正常显示Liquid代码问题 - CSDN博客](https://blog.csdn.net/JireRen/article/details/52197045).
