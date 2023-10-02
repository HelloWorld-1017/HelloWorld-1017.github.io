---
layout: single
title: Colorize the Text in Markdown File and HTML
date: 2023-04-20 10:49:37 +0800
categories: 
 - GitHub 
 - LaTeX
toc: false
---

在HTML中，可以使用标签`<font color='red'></font>`来给文字上色，例如：

```html
<font color='red'>red</font>
```

<font color='red'>red</font>

其中`red`是色彩名，现代浏览器均支持140中颜色名称 [1]。`color`属性除了接受定义好的**颜色名**作为参数以外，还支持**十六进制的色彩值**作为参数：

```html
<font color='FF0000'>red</font>
```

<font color='FF0000'>red</font>

<br>

如果想要给公式中的内容添加颜色，可以使用]`\color`命令：

```latex
\color{red}{b=c+d}+a
```

$$
\color{red}{b=c+d}+a\notag
$$

但是，从上面可以看到，`\color`命令后面的文字都会着色，使用`\textcolor`可以避免这样的问题 [2]：

```latex
\textcolor{red}{b=c+d}+a
```

$$
\textcolor{red}{b=c+d}+a
$$

<br>

**References**

[1] [HTML 颜色名](https://www.w3school.com.cn/tags/html_ref_colornames.asp).

[2] [LaTeX知识分享: 如何设置字体颜色 - 知乎](https://zhuanlan.zhihu.com/p/426780029).