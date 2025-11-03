---
title: A LaTeX Error Caused by the `graphics` Package --- `Argument of \Gin@iii has an extra }` (Use `graphicx` Package Instead to Solve)
toc: false
categories:
 - LaTeX
tags:
 - LaTeX Figure
 - LaTeX graphics
 - LaTeX graphicx
 - LaTeX Warnings and Errors
location: Buffalo, United States
date: 2025-10-21 23:27:37 -0400
last_modified_at: 2025-11-02 22:18:50 -0500
---

When writing blog[^1], I found an error caused by the LaTeX `graphics` package:

```
doc.tex: error: 10: Argument of \Gin@iii has an extra }. ...cludegraphics[width=\linewidth]{fig1.jpg}}
```

and I imported the `graphicx` package instead to solve this problem. These two packages are sort of different, although both of them are to display figures, and `graphicx` is preferred[^2]:

<div class="quote--left" markdown="1">

`graphicx` is an extension of `graphics`. Moreover, while `graphics` sticks to the original TeX conventions concerning arguments, `graphicx` allows optional arguments according to the more transparent `key=value` scheme.

</div>

**References**

[^1]: [Organize Multiple Subfigures Like MATLAB `tiledlayout` Function in LaTeX](/2025-10-22/10-36-42.html).
[^2]: [https://tex.stackexchange.com/a/23076/306224](https://tex.stackexchange.com/a/23076/306224).

