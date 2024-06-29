---
layout: single
title: Specify Typeface and Font Size in Markdown Files and Web Pages by HTML `<font>` Tag
categories:
 - Web Development
tags:
 - HTML
 - Jekyll
drafted_at: 2024-04-19 23:33:17 +0800
date: 2024-04-21 15:39:18 +0800
last_modified_at: 2024-06-20 12:49:18 +0800
modification_history:
 - 2024-04-21 15:39:18 +0800
 - 2024-06-16 03:11:51 +0800
 - 2024-06-20 12:49:18 +0800
---

# Introduction

I ever wrote a blog[^1] to record how to use `color` attribute of HTML `<font>`  to color text in `.md` files and HTML web pages. Actually, in addition to `color`, there are two other attributes `face` and `size` of `<font>` element[^2], which the former is used to set font name, and the latter is to change font size. I would take some notes about them in this post.

<br>

# Font name settings (`face` attribute)

## Chinese fonts

There are many Chinese fonts available in `.md` files and HTML web pages (see reference[^3]), here are four commonly used of them.

**楷体 (Kaiti)**

`<font face="楷体">阿拉斯加海湾</font>`: <font face="楷体">阿拉斯加海湾</font>

`<font face="Kaiti">阿拉斯加海湾</font>`: <font face="Kaiti">阿拉斯加海湾</font>

**黑体 (SimHei)**

`<font face="黑体">阿拉斯加海湾</font>`: <font face="黑体">阿拉斯加海湾</font>

`<font face="SimHei">阿拉斯加海湾</font>`: <font face="SimHei">阿拉斯加海湾</font>

**仿宋 (FongSong)**

`<font face="仿宋">阿拉斯加海湾</font>`: <font face="仿宋">阿拉斯加海湾</font>

`<font face="FangSong">阿拉斯加海湾</font>`: <font face="FangSong">阿拉斯加海湾</font>

**新宋体 (NSimSun)**

`<font face="新宋体">阿拉斯加海湾</font>`: <font face="新宋体">阿拉斯加海湾</font>

`<font face="NSimSun">阿拉斯加海湾</font>`: <font face="NSimSun">阿拉斯加海湾</font>

## English fonts

The followings are the available English fonts from Ofnoname's blog[^4]. His blog provides more information about these fonts, including their origins and short histories, as well as some straight usage suggestions. 

**Times New Roman**

`<font face="Times New Roman">Gulf of Alaska</font>`: <font face="Times New Roman">Gulf of Alaska</font>

**Arial**

`<font face="Arial">Gulf of Alaska</font>`: <font face="Arial">Gulf of Alaska</font>

**Arial Black**

`<font face="Arial Black">Gulf of Alaska</font>`: <font face="Arial Black">Gulf of Alaska</font>

**Arial Narrow**

`<font face="Arial Narrow">Gulf of Alaska</font>`: <font face="Arial Narrow">Gulf of Alaska</font>

**Verdana**

`<font face="Verdana">Gulf of Alaska</font>`: <font face="Verdana">Gulf of Alaska</font>

**Georgia**

`<font face="Georgia">Gulf of Alaska</font>`: <font face="Georgia">Gulf of Alaska</font>

**Trebuchet MS**

`<font face="Trebuchet MS">Gulf of Alaska</font>`: <font face="Trebuchet MS">Gulf of Alaska</font>

**Courier New**

`<font face="Courier New">Gulf of Alaska</font>`: <font face="Courier New">Gulf of Alaska</font>

**Impact**

`<font face="Impact">Gulf of Alaska</font>`: <font face="Impact">Gulf of Alaska</font>

**Comic Sans MS**

`<font face="Comic Sans MS">Gulf of Alaska</font>`: <font face="Comic Sans MS">Gulf of Alaska</font>

**Tahoma**

`<font face="Tahoma">Gulf of Alaska</font>`: <font face="Tahoma">Gulf of Alaska</font>

**Courier**

`<font face="Courier">Gulf of Alaska</font>`: <font face="Courier">Gulf of Alaska</font>

**Lucida Sans Unicode**

`<font face="Lucida Sans Unicode">Gulf of Alaska</font>`: <font face="Lucida Sans Unicode">Gulf of Alaska</font>

**Lucida Console**

`<font face="Lucida Console">Gulf of Alaska</font>`: <font face="Lucida Console">Gulf of Alaska</font>

**Garamond**

`<font face="Garamond">Gulf of Alaska</font>`: <font face="Garamond">Gulf of Alaska</font>

**MS Sans Serif**

`<font face="MS Sans Serif">Gulf of Alaska</font>`: <font face="MS Sans Serif">Gulf of Alaska</font>

**MS Serif**

`<font face="MS Serif">Gulf of Alaska</font>`: <font face="MS Serif">Gulf of Alaska</font>

**Palatino Linotype**

`<font face="Palatino Linotype">Gulf of Alaska</font>`: <font face="Palatino Linotype">Gulf of Alaska</font>

**Symbol**

`<font face="Symbol">Gulf of Alaska</font>`: <font face="Symbol">Gulf of Alaska</font>

**Bookman Old Style**

`<font face="Bookman Old Style">Gulf of Alaska</font>`: <font face="Bookman Old Style">Gulf of Alaska</font>

<br>

# Font size settings (`size` attribute)

The `size` attribute is used to change font size, but it should be noted that, its acceptable values only range from `1` to `7`[^2]. Besides, the relative values, related to default value `3`, can be specified for setting size[^2]. However, in my actual use, I found that, relative values in numeric form works well in `.md` files but not functional in web pages (shows as follows); it is a solution to put them in `""` to convert to text form. 

**Font Size = 1**

`<font size=1>阿拉斯加海湾, Gulf of Alaska</font>`: <font size=1>阿拉斯加海湾, Gulf of Alaska</font>

`<font size="-2">阿拉斯加海湾, Gulf of Alaska</font>`: <font size="-2">阿拉斯加海湾, Gulf of Alaska</font>

`<font size=-2>阿拉斯加海湾, Gulf of Alaska</font>`: <font size=-2>阿拉斯加海湾, Gulf of Alaska</font>
{: .notice--warning}


**Font Size = 3** (default value)

`<font size=3>阿拉斯加海湾, Gulf of Alaska</font>`: <font size=3>阿拉斯加海湾, Gulf of Alaska</font>

`<font size="+0">阿拉斯加海湾, Gulf of Alaska</font>`: <font size="+0">阿拉斯加海湾, Gulf of Alaska</font>

`<font size="-0">阿拉斯加海湾, Gulf of Alaska</font>`: <font size="-0">阿拉斯加海湾, Gulf of Alaska</font>

`<font size=+0>阿拉斯加海湾, Gulf of Alaska</font>`: <font size=+0>阿拉斯加海湾, Gulf of Alaska</font>
{: .notice--warning}

`<font size=-0>阿拉斯加海湾, Gulf of Alaska</font>`: <font size=-0>阿拉斯加海湾, Gulf of Alaska</font>
{: .notice--warning}

**Font Size = 5**

`<font size=5>阿拉斯加海湾, Gulf of Alaska</font>`: <font size=5>阿拉斯加海湾, Gulf of Alaska</font>

`<font size="+2">阿拉斯加海湾, Gulf of Alaska</font>`: <font size="+2">阿拉斯加海湾, Gulf of Alaska</font>

`<font size=+2>阿拉斯加海湾, Gulf of Alaska</font>`: <font size=+2>阿拉斯加海湾, Gulf of Alaska</font>
{: .notice--warning}

**Font Size = 7**

`<font size=7>阿拉斯加海湾, Gulf of Alaska</font>`: <font size=7>阿拉斯加海湾, Gulf of Alaska</font>

`<font size="+4">阿拉斯加海湾, Gulf of Alaska</font>`: <font size="+4">阿拉斯加海湾, Gulf of Alaska</font>

`<font size=+4>阿拉斯加海湾, Gulf of Alaska</font>`: <font size=+4>阿拉斯加海湾, Gulf of Alaska</font>
{: .notice--warning}

<br>

# References

[^1]: [Colorize Text in Markdown File and Web Pages - What a starry night~](https://helloworld-1017.github.io/2023-04-20/10-49-37.html).
[^2]: [`<font>` - HTML: HyperText Markup Language \| MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/font).
[^3]: [CSS font-family中文字体对应的英文名称整理表 » 张鑫旭-鑫空间-鑫生活](https://www.zhangxinxu.com/study/201703/font-family-chinese-english.html).
[^4]: [网页设计中常用的Web英文安全字体 - Ofnoname - 博客园](https://www.cnblogs.com/ofnoname/p/16559956.html).
