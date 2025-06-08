---
title: Use Relative Coordinates in LaTeX TikZ --- `++` vs. `+`
toc: false
categories:
 - LaTeX
tags:
 - LaTeX TikZ
date: 2025-06-06 14:21:37 +0800
last_modified_at: 2025-06-06 14:21:37 +0800
---

<div class="quote--left" markdown="1">

You can prefix coordinates by `++` to make them “relative”. A coordinate such as `++(1cm,0pt)` means “1cm to the right of the previous position, making this the new current position”.

Instead of `++` you can also use a single `+`. This also specifies a relative coordinate, but it does not “update” the current point for subsequent usages of relative coordinates. Thus, you can use this notation to specify numerous points, all relative to the same “initial” point.[^1]

</div>

```latex
\documentclass[border=5pt,tikz]{standalone}
\usepackage{tikz}

\begin{document}

\begin{tikzpicture}
% Use `++` to specify relative coordinates
\draw[->] (0,0) -- ++(1,0);
\draw[->] (2,0) -- ++(1,0) -- ++(0,1);
\draw[->] (4,0) -- ++(1,0) -- ++(0,1) -- ++(-1,0);
\draw[->] (6,0) -- ++(1,0) -- ++(0,1) -- ++(-1,0) -- cycle;

% Use `+` to specify relative coordinates
\draw[->] (0,-2) -- +(1,0);
\draw[->] (2,-2) -- +(1,0) -- +(1,1);
\draw[->] (4,-2) -- +(1,0) -- +(1,1) -- +(0,1);
\draw[->] (6,-2) -- +(1,0) -- +(1,1) -- +(0,1) -- cycle;
\end{tikzpicture}

\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202506061426053.png" alt="img-1" style="width:67%;" />

<br>

**References**

- [Confused at `+` and `++` in TikZ](https://tex.stackexchange.com/questions/113283/confused-at-and-in-tikz).

[^1]: [Specifying Coordinates: Specifying Relative Coordinates](https://tikz.dev/tikz-coordinates#sec-13.4.1).



