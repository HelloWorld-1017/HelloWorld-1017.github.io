---
title: LaTeX `\phantom`, `\vphantom`, and `\hphantom` Commands
categories:
 - LaTeX
tags:
 - LaTeX Box
 - LaTeX Equation
date: 2025-05-18 16:53:12 +0800
last_modified_at: 2025-05-23 16:17:00 +0800
---

# `\phantom` command

<div class="quote--left" markdown="1">

`\phantom{subformula}`: The `\phantom` command creates a box with the same height, depth, and width as subformula, but empty. That is, this command causes LaTeX to typeset the space but not fill it with the material.[^1]

</div>

**Example 1**[^1]

```latex
\documentclass{article}

\begin{document}

\begin{displaymath}
\int x^2\,dx=\mbox{\underline{$\phantom{(1/3)x^3+C}$}}
\end{displaymath}

\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202505191321682.png" alt="image-20250519132114621" style="width:50%;" />

**Example 2**

```latex
\documentclass{article}

\begin{document}

\noindent
Thequickbrownfoxjumpsoverthelazydog\\
Thequick\phantom{brownfox}jumps\phantom{over}thelazydog.

\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202505191321129.png" alt="image-20250519132159079" style="width:50%;" />

**Example 3**[^2]

```latex
\documentclass{article}
\usepackage{amsmath}

\begin{document}

\begin{align}
&\mathrel{\phantom{=}} (a+b)(a^2-ab+b^2) \notag \\
&= a^3 - a^2b + ab^2 + a^2b - ab^2 + b^2 \notag \\
&= a^3 + b^3 
\end{align}

\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202505191330062.png" alt="image-20250519133020002" style="width:50%;" />

**Example 4**[^2]

```latex
\documentclass{article}
\usepackage{amsmath}

\begin{document}

$A_m^n$, $A_m{}^n$ or $A_m^{\phantom{m}n}$ 

\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202505191333695.png" alt="image-20250519133344633" style="width:50%;" />

**Example 5**[^4]

```latex
\documentclass{article}
\usepackage{amsmath}

\begin{document}

\begin{equation}
\Gamma^{\phantom{i}j}_{i\phantom{j}k},\ 
\begin{bmatrix}
1 & -1\\
2 & \phantom{-}3\\
\end{bmatrix}
\end{equation}

\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202505191346284.png" alt="image-20250519134610207" style="width:50%;" />

<br>

# `\vphantom` command

<div class="quote--left" markdown="1">

`\vphantom{subformula}`: The `\vphantom` variant produces an invisible box with the same vertical size as `subformula`, the same height and depth, but having zero width.[^1]

</div>

**Example 1**[^2]

```latex
\documentclass{article}
\usepackage{amsmath}

\begin{document}

\begin{equation}
\sqrt{\frac 12} < \sqrt{\vphantom{\frac12}2},\quad
\sqrt{\frac 12} < \sqrt{2}
\end{equation}
\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202505191328400.png" alt="image-20250519132808266" style="width:50%;" />

**Example 2**[^1]

```latex
\documentclass{article}

\begin{document}

\begin{displaymath}
    \sum_{j\in\{0,\ldots\, 10\}\vphantom{3^{3^{3^j}}}}
      \sum_{i\in\{0,\ldots\, 3^{3^{3^j}}\}} i\cdot j
\end{displaymath}

\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202505191337398.png" alt="image-20250519133759341" style="width:50%;" />

**Example 3**[^3]

```latex
\documentclass{article}
\usepackage{amsmath}

\begin{document}

\begin{equation}
\sqrt{\sum_{0\leq k< n} f(k)}
\sqrt{\vphantom{\sum}\smash{\sum_{0\leq k< n}} f(k)}
\quad\text{vs.}\quad
\sqrt{\sum_{0\leq k< n} f(k)}
\sqrt{\sum\sum_{0\leq k< n} f(k)}
\end{equation}

\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202505191342711.png" alt="image-20250519134214592" style="width:50%;" />

<br>

# `\hphantom` command

<div class="quote--left" markdown="1">

`\hphantom{subformula}`: `\hphantom` makes a box with the same width as `subformula` but with zero height and depth.[^1]

</div>

**Example 1**

```latex
\documentclass{article}

\begin{document}

\noindent
Thequickbrownfoxjumpsoverthelazydog\\
Thequick\hphantom{brownfox}jumps\hphantom{over}thelazydog.

\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202505191335182.png" alt="image-20250519133515112" style="width:50%;" />

<br>

**References**

[^1]: [`\phantom` & `\vphantom` & `\hphantom` (LaTeX2e unofficial reference manual (January 2025))](https://latexref.xyz/_005cphantom-_0026-_005cvphantom-_0026-_005chphantom.html).
[^2]: [LaTeX入门](https://yun.weicheng.men/Book/LaTeX入门.pdf), 刘海洋编著, pp. 228, 233, 265.
[^3]: [`\smash` (LaTeX2e unofficial reference manual (January 2025))](https://latexref.xyz/_005csmash.html).
[^4]: [LaTeX Phantom Command](https://www.tutorialspoint.com/tex_commands/phantom.htm).