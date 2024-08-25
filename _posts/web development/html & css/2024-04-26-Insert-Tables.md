---
title: Insert Tables in Jekyll Website
toc: false
categories:
 - Web Development
 - LaTeX
tags:
 - LaTeX Table
 - Markdown
 - HTML
 - CSS
 - Jekyll
date: 2024-04-26 11:31:06 +0800
last_modified_at: 2024-08-25 18:39:23 +0800
---

For the website built based on Jekyll, if we insert a table in `.md` source file, static website generator Jekyll will render it into an HTML table while deploying. For example, a table created by Markdown syntax: 

```latex
| Variable | Value | Example        |
| -------- | ----- | -------------- |
| $a$      | $2$   | $2a+4=8$       |
| $b$      | $5$   | $b-3=2$        |
| $c$      | $8$   | $2c\times4=64$ |
| $d$      | $7$   | $8d/4=14$      |
```

will be showed as follows:

| Variable | Value | Example        |
| -------- | ----- | -------------- |
| $a$      | $2$   | $2a+4=8$       |
| $b$      | $5$   | $b-3=2$        |
| $c$      | $8$   | $2c\times4=64$ |
| $d$      | $7$   | $8d/4=14$      |

which is an HTML `table` element in webpage. We can modify its style using CSS language (actually change the `table` style **globally**). For the Jekyll theme which my blog website[^1] uses, "minimal-mistakes"[^2], the corresponding `.scss` file is `./assets/css/main.scss`[^3], and the `table` style I specify right now is from an answer of StackExchange user "ROOT"[^4]:

```scss
// Table style from: https://stackoverflow.com/a/61547802/22763127
// Fill the whole webpage width
table {
    color: black;
    background-color: white;
    border-color: black;
    border-style: solid;
    border-width: 0 1px 1px 1px;
    border-radius: 5px;
    border-collapse: separte;
    border-spacing: 2;
    display: table; // NOTE HERE: Realize filling the whole webpage width.
    overflow: auto;
    width: 100%;
  }
  table thead th {
    color: white;
    background-color: black;
    font-weight: bold;
    font-size: 0.8em;
    // padding: 5px 10px;
    vertical-align: bottom;
  }
  table thead th:first-child {
    border-top-left-radius: 5px;
  }
  table thead th:last-child {
    border-top-right-radius: 5px;
  }
  table tbody td {
    // border-top: 1px solid gray;
    border-top: 1px solid black;
    padding: 5px 10px;
    vertical-align: top;
  }
  table tbody tr:nth-child(2n) {
    background-color: lightgray;
  }
```

<br>

It's kind of difficult, at least for me, to create an HTML table using HTML syntax (i.e., HTML `table` tag), so above Jekyll feature, that is converting tables created by Markdown markup language to HTML `table`, is friendly for users. 

However, a simple need of mine is to center the tables, to look more academic as in the publications. There are many on-line references providing solutions, but none of them works well for my website. Due to the lack of understanding of website-building language, like HTML, CSS or whatever, I have no idea how to solve it. Maybe some other settings go wrong. It's a choice to directly design tables in the Markdown file by HTML `<table>` tag, but the same, it's too difficult for me.

Finally, I choose a style that makes tables fill the whole webpage width, as shown before. Coming to centering the tables, I find a compromise, that is creating table in the MathJax `array` environment, which is functional in both Markdown files and webpages, like:

```latex
\begin{array}{ccc}
\hline
\hspace{1cm}\text{Variable}\hspace{1cm} & \hspace{1cm}\text{Value}\hspace{1cm} &\hspace{1cm}\text{Example}\hspace{1cm}\\ 
\hline
a&2&2a+4=8\\
b&5&b-3=2\\
c&8&2c\times4=64\\
d&7&8d/4=14\\
\hline
\end{array}\notag
```

$$
\begin{array}{ccc}
\hline
\hspace{1cm}\text{Variable}\hspace{1cm}&\hspace{1cm}\text{Value}\hspace{1cm}&\hspace{1cm}\text{Example}\hspace{1cm}\\ 
\hline
a&2&2a+4=8\\
b&5&b-3=2\\
c&8&2c\times4=64\\
d&7&8d/4=14\\
\hline
\end{array}\notag
$$

where `\hspace{1cm}` put in the table head is to adjust the column width, making it more good-looking. Besides `\hspace` command, `\quad`, `\qquad` also can be used to create blank space, but `\hspace` is more flexible to use. 

That being said, there are some limitations for this method. 

The first one is that we can't create a row/column that spans multiple rows/columns, which is feasible in LaTeX `array` environment but not supported by MathJax rendering engine[^5][^6][^8]:

```latex
\begin{array}{|c|r|r|}
	\hline
	\multirow{2}*{Name} & \multicolumn{2}{c|}{\text{Scores}} \\ \cline{2-3}
	& \text{Chinese} & \text{Mathematics} \\ \hline
	\text{Zhang} & 87 & 100 \\ \hline
\end{array}
```

$$
\begin{array}{|c|r|r|}
\hline
\multirow{2}*{姓名} &
\multicolumn{2}{c|}{成绩} \\ \cline{2-3}
& 语文 & 数学 \\ \hline
张三 & 87 & 100 \\ \hline
\end{array}
$$

<div class="notice--primary" markdown="1">


It works in LaTeX system by `\multirow` and `\multicolumn` commands after importing the `multirow` package[^7]:

```latex
\documentclass{article}
\usepackage{amsmath,multirow}

\begin{document}

\begin{equation*}
\begin{array}{|c|r|r|}
	\hline
	\multirow{2}*{Name} & \multicolumn{2}{c|}{\text{Scores}} \\ \cline{2-3}
	& \text{Chinese} & \text{Mathematics} \\ \hline
	\text{Zhang} & 87 & 100 \\ \hline
\end{array}
\end{equation*}

\end{document}
```

![image-20240426113640413](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202404261136654.png)

</div>

Another one is that this kind of table can't be automatically adjusted as webpage zooms in and out.

<br>

**References**

[^1]: [What a starry night~](https://helloworld-1017.github.io/).
[^2]: [mmistakes/minimal-mistakes: Jekyll theme for building a personal site, blog, project documentation, or portfolio.](https://github.com/mmistakes/minimal-mistakes)
[^3]: [HelloWorld-1017.github.io/assets/css/main.scss at main · HelloWorld-1017/HelloWorld-1017.github.io](https://github.com/HelloWorld-1017/HelloWorld-1017.github.io/blob/main/assets/css/main.scss).
[^4]: [https://stackoverflow.com/a/61547802/22763127](https://stackoverflow.com/a/61547802/22763127).

[^5]: [multicolumn, cline in mathjax array?](https://groups.google.com/g/mathjax-users/c/zjsFEPtcXMs)
[^6]: [support for columnspan and rowspan attributes](https://groups.google.com/g/mathjax-users/c/jD01t0ZBrJ8).
[^7]: 刘海洋编著. LaTeX入门. 北京: 电子工业出版社, 2013.6, available at: [LaTeX入门.pdf](https://yun.weicheng.men/Book/LaTeX%E5%85%A5%E9%97%A8.pdf).
[^8]: [html - how to draw a Mathjax table using array with row span? - Stack Overflow](https://stackoverflow.com/questions/65716016/how-to-draw-a-mathjax-table-using-array-with-row-span).
