---
title: Align the Text in Markdown Files and Web Pages
toc: false
categories:
 - Web Development
tags:
 - HTML
 - Markdown
date: 2024-04-21 19:08:48 +0800
last_modified_at: 2024-11-17 15:41:45 +0800
---

In Markdown files and web page, we can use `<p>` element and its `style` attribute to realize aligning the text, center, left, and right. For example, 

```html
<p style="text-align:center;">Ignorance is bliss.</p>
```

<p style="text-align:center;">Ignorance is bliss.</p>

```html
<p style="text-align:left;">Ignorance is bliss.</p>
```

<p style="text-align:left;">Ignorance is bliss.</p>

```html
<p style="text-align:right;">Ignorance is bliss.</p>
```

<p style="text-align:right;">Ignorance is bliss.</p>

<br>

This method is also suitable for multiple lines text, as long as using `<br>` to make a break:

```html
<p style="text-align:center;">No man is an island,<br>
Entire of itself;<br>
Every man is a piece of the continent,<br>
A part of the main.<br><br>
If a clod be washed away by the sea,<br>
Europe is the less,<br>
As well as if a promontory were:<br>
As well as if a manor of thy friend's<br>
Or of thine own were.<br><br>
Any man's death diminishes me,<br>
Because I am involved in mankind.<br>
And therefore never send to know for whom the bell tolls;<br>
It tolls for thee.<br>
<br>
by John Donne <br>
</p>
```

<p style="text-align:center;">No man is an island,<br>
Entire of itself;<br>
Every man is a piece of the continent,<br>
A part of the main.<br><br>
If a clod be washed away by the sea,<br>
Europe is the less,<br>
As well as if a promontory were:<br>
As well as if a manor of thy friend's<br>
Or of thine own were.<br><br>
Any man's death diminishes me,<br>
Because I am involved in mankind.<br>
And therefore never send to know for whom the bell tolls;<br>
It tolls for thee.<br>
<br>
by John Donne <br>
</p>

```html
<p style="text-align:left;">No man is an island,<br>
Entire of itself;<br>
Every man is a piece of the continent,<br>
A part of the main.<br><br>
If a clod be washed away by the sea,<br>
Europe is the less,<br>
As well as if a promontory were:<br>
As well as if a manor of thy friend's<br>
Or of thine own were.<br><br>
Any man's death diminishes me,<br>
Because I am involved in mankind.<br>
And therefore never send to know for whom the bell tolls;<br>
It tolls for thee.<br>
<br>
by John Donne <br>
</p>
```

<p style="text-align:left;">No man is an island,<br>
Entire of itself;<br>
Every man is a piece of the continent,<br>
A part of the main.<br><br>
If a clod be washed away by the sea,<br>
Europe is the less,<br>
As well as if a promontory were:<br>
As well as if a manor of thy friend's<br>
Or of thine own were.<br><br>
Any man's death diminishes me,<br>
Because I am involved in mankind.<br>
And therefore never send to know for whom the bell tolls;<br>
It tolls for thee.<br>
<br>
by John Donne <br>
</p>

```html
<p style="text-align:right;">No man is an island,<br>
Entire of itself;<br>
Every man is a piece of the continent,<br>
A part of the main.<br><br>
If a clod be washed away by the sea,<br>
Europe is the less,<br>
As well as if a promontory were:<br>
As well as if a manor of thy friend's<br>
Or of thine own were.<br><br>
Any man's death diminishes me,<br>
Because I am involved in mankind.<br>
And therefore never send to know for whom the bell tolls;<br>
It tolls for thee.<br>
<br>
by John Donne <br>
</p>
```

<p style="text-align:right;">No man is an island,<br>
Entire of itself;<br>
Every man is a piece of the continent,<br>
A part of the main.<br><br>
If a clod be washed away by the sea,<br>
Europe is the less,<br>
As well as if a promontory were:<br>
As well as if a manor of thy friend's<br>
Or of thine own were.<br><br>
Any man's death diminishes me,<br>
Because I am involved in mankind.<br>
And therefore never send to know for whom the bell tolls;<br>
It tolls for thee.<br>
<br>
by John Donne <br>
</p>

<br>

**References**

- [html段落居中命令](https://juejin.cn/s/html%E6%AE%B5%E8%90%BD%E5%B1%85%E4%B8%AD%E5%91%BD%E4%BB%A4).
- [No Man Is an Island by John Donne - Famous poems, famous poets.](https://allpoetry.com/No-man-is-an-island).
