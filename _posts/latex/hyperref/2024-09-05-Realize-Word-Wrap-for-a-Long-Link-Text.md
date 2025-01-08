---
title: Realize Word Wrap for a Long Link Text When Using Commands of LaTeX `hyperref` Package
toc: false
categories:
 - LaTeX
tags:
 - LaTeX hyperref
date: 2024-09-05 05:37:22 +0800
last_modified_at: 2025-01-02 20:20:42 +0800
---

There are three commands provided in LaTeX `hyperref` package[^1], `\href`, `\url`, and `\nolinkurl` , to make references to URLs:

<div class="quote--left" markdown="1">
`\href[options]{URL}{text}`

The *text* is made into a hyperlink to the `URL`; this must be a full URL (relative to the base URL, if that is defined). The special characters `#` and `%` do not need to be escaped in any way (unless the command is used in the argument of another command).

The optional argument *options* recognizes the `hyperref` options `pdfremotestartview`, `pdfnewwindow` and the following key value options:

- `page`: Specifies the start page number of remote PDF documents. First page is 1.
- `ismap`: Boolean key, if set to `true`, the URL should be appended by the coordinates as query parameters by the PDF viewer.
- `nextactionraw`: The value of key `/Next` of action dictionaries, see PDF specification.

<br>

`\url{URL}`

Similar to `\href{URL}{\nolinkurl{URL}}`. Depending on the driver `\href` also tries to detect the link type. Thus the result can be a url link, file link, …. The implementation makes use of the `url` package and its commands can be used to format and fine tune the url, but the behaviour of `\url` is different to the behaviour in the `url` package: Most importantly the hyperref `\url` expands commands. If the behaviour or the original `\url` is needed, the `url` package should be loaded first and the command should be copied into some alias command.

<br>

`\nolinkurl{URL}`

Write `URL` in the same way as `\url` described above, without creating a hyperlink.

</div>

The `\url` command recognizes the input text as a URL and link the text to the specified URL, whereas `\nolinkurl` also does recognize but doesn’t create such a link. For both `\url` and `\nolinkrul`, the link text displays as the same as URL, while the `\href` command can change the link text by the second option. 

```latex
\documentclass{article}
\usepackage{showframe}
\usepackage{lipsum}
\usepackage[
colorlinks=true,
urlcolor=blue]{hyperref}

\begin{document}
\lipsum[1][1-2] \url{http://google.com}. 

\lipsum[1][1-2] \nolinkurl{http://google.com}. 

\lipsum[1][1-2] \href{http://google.com}{google.com}.

\lipsum[1][1-2] \href{http://google.com}{\nolinkurl{google.com}}.
\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501021916648.png" alt="image-20250102191603412" style="width:67%;" />

<div class="notice--primary" markdown="1">

By the way, as can be seen, if we use `\url` and `\nolinkurl`, the text will show as monospaced font. We can use `\urlstyle` command to keep the text the same as main text[^2].

```latex
\documentclass{article}

% ...

\urlstyle{same}

\begin{document}
% ...
\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501021921432.png" alt="image-20250102192118292" style="width:67%;" />

</div>

There is one problem for these commands: the link text won’t be automatically wrapped when it is too long.

```latex
\documentclass{article}
\usepackage{showframe}
\usepackage{lipsum}
\usepackage[
colorlinks=true,
urlcolor=blue]{hyperref}

\begin{document}
\lipsum[1][1-2] \url{http://googlegooglegooglegooglegooglegooglegooglegooglegoogle.com}. 

\lipsum[1][1-2] \nolinkurl{http://googlegooglegooglegooglegooglegooglegooglegooglegoogle.com}. 

\lipsum[1][1-2] \href{http://google.com}{http://googlegooglegooglegooglegooglegooglegooglegooglegoogle.com}.

\lipsum[1][1-2] \href{http://google.com}{\nolinkurl{http://googlegooglegooglegooglegooglegooglegooglegooglegoogle.com}}.
\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501021928660.png" alt="image-20250102192810516" style="width:67%;" />

About this point, blog[^3] provides a solution, that is modifying the macro `\UrlBreaks` of `hyperref` package.

{% raw %}

```latex
\documentclass{article}
\usepackage{showframe}
\usepackage{lipsum}
\usepackage[
colorlinks=true,
urlcolor=blue]{hyperref}

\makeatletter
\def\UrlAlphabet{%
      \do\a\do\b\do\c\do\d\do\e\do\f\do\g\do\h\do\i\do\j%
      \do\k\do\l\do\m\do\n\do\o\do\p\do\q\do\r\do\s\do\t%
      \do\u\do\v\do\w\do\x\do\y\do\z\do\A\do\B\do\C\do\D%
      \do\E\do\F\do\G\do\H\do\I\do\J\do\K\do\L\do\M\do\N%
      \do\O\do\P\do\Q\do\R\do\S\do\T\do\U\do\V\do\W\do\X%
      \do\Y\do\Z}
\def\UrlDigits{\do\1\do\2\do\3\do\4\do\5\do\6\do\7\do\8\do\9\do\0}
\g@addto@macro{\UrlBreaks}{\UrlOrds}
\g@addto@macro{\UrlBreaks}{\UrlAlphabet}
\g@addto@macro{\UrlBreaks}{\UrlDigits}
\makeatother

%\urlstyle{same}

\begin{document}
\lipsum[1][1-2] \url{http://googlegooglegooglegooglegooglegooglegooglegooglegoogle.com}. 

\lipsum[1][1-2] \nolinkurl{http://googlegooglegooglegooglegooglegooglegooglegooglegoogle.com}. 

\lipsum[1][1-2] \href{http://google.com}{http://googlegooglegooglegooglegooglegooglegooglegooglegoogle.com}.

\lipsum[1][1-2] \href{http://google.com}{\nolinkurl{http://googlegooglegooglegooglegooglegooglegooglegooglegoogle.com}}.
\end{document}
```

{% endraw %}

The `\g@addto@macro{macro}{code}` command is to “appends `code` to the definition of `macro`”[^5].
{: .notice--primary}

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501021936457.png" alt="image-20250102193630389" style="width:67%;" />

It can be seen that, if we use `\href` command, we should use it in conjunction with `\nolinkurl`.

To realize word wrap, reference[^4] also gives a method, simply by specifying the `breaklinks` option of `hyperref` package as `true`. But it seem not work for my case.

```latex
\documentclass{article}
\usepackage{showframe}
\usepackage{lipsum}
\usepackage[
breaklinks=true,
colorlinks=true,
urlcolor=blue]{hyperref}

%\urlstyle{same}

\begin{document}
\lipsum[1][1-2] \url{http://googlegooglegooglegooglegooglegooglegooglegooglegoogle.com}. 

\lipsum[1][1-2] \nolinkurl{http://googlegooglegooglegooglegooglegooglegooglegooglegoogle.com}. 

\lipsum[1][1-2] \href{http://google.com}{http://googlegooglegooglegooglegooglegooglegooglegooglegoogle.com}.

\lipsum[1][1-2] \href{http://google.com}{\nolinkurl{http://googlegooglegooglegooglegooglegooglegooglegooglegoogle.com}}.
\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501021943481.png" alt="image-20250102194344408" style="width:67%;" />

<br>

**References**

[^1]: [CTAN: Package `hyperref`](https://ctan.org/pkg/hyperref?lang=en).
[^2]: [How to change the font of an URL link in Latex](https://latex.org/forum/viewtopic.php?t=35509).
[^3]: [使 LaTeX 文稿中的 URL 正确换行](https://liam.page/2017/05/17/help-the-url-command-from-hyperref-to-break-at-line-wrapping-point/).
[^4]: [https://tex.stackexchange.com/a/20769/306224](https://tex.stackexchange.com/a/20769/306224).
[^5]: [CTAN: Package `macros2e`](https://ctan.org/pkg/macros2e).