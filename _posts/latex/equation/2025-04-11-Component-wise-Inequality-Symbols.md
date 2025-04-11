---
title: "LaTeX Component-wise Inequality Symbols: $\\preceq$ and $\\succeq$ etc."
toc: false
categories:
 - LaTeX
 - Mathematics
tags:
 - LaTeX Equation
 - Markdown
 - Matrix
date: 2025-04-11 13:04:11 +0800
last_modified_at: 2025-04-11 13:04:11 +0800
---

In reference[^1], when talking about “polyhedron (polyhedra)”, the mathematical symbol $\preceq$ is used to denote <i class="term">component-wise inequality</i>. Specifically, for two vectors $\boldsymbol{\mathrm{x}},\boldsymbol{\mathrm{y}}\in\mathbb{R}^n$,

- $\boldsymbol{\mathrm{x}}\preceq\boldsymbol{\mathrm{y}}$ denotes that each element of $\boldsymbol{\mathrm{x}}$ is less than or equal to the corresponding element in $\boldsymbol{\mathrm{y}}$.

and similarly we have:

- $\boldsymbol{\mathrm{x}}\succeq\boldsymbol{\mathrm{y}}$ ... greater than or equal to ...
- $\boldsymbol{\mathrm{x}}\prec\boldsymbol{\mathrm{y}}$ ... less than...
- $\boldsymbol{\mathrm{x}}\succ\boldsymbol{\mathrm{y}}$ ... greater than...

Sometimes, “$\le$”, “$\ge$”, “$<$”, and “$>$” can be used in place of above symbols to denote the same meanings, but the both sides of the symbol should be vectors, such as $\boldsymbol{\mathrm{x}}\le\boldsymbol{\mathrm{y}}$ and $\boldsymbol{\mathrm{x}}\ge\boldsymbol{\mathrm{y}}$.

In LaTeX, above component-wise inequality symbols can be typed using following commands, respectively[^2]:

- `\preceq` (precedes or equals[^3]): $\preceq$
- `\succeq` (succeeds or equals) : $\succeq$
- `\prec` (precedes): $\prec$
- `\succ` (succeeds): $\succ$

and other similar ones[^4]:

- `\nprec` (does not precede): $\nprec$
- `\npreceq` ( neither precedes nor equals): $\npreceq$
- `\precneqq`: $\precneqq$
- `\precnsim`: $\precnsim$
- `\precnapprox`: $\precnapprox$
- `\nsucc` (does not succeed): $\nsucc$
- `\nsucceq` (neither succeeds nor equals): $\nsucceq$
- `\succneqq`: $\succneqq$
- `\succnsim`: $\succnsim$
- `\succnapprox`: $\succnapprox$

Of course, these symbols can be used in Markdown files as well.

<br>

**References**

[^1]: [Review Notes and Supplementary Notes CS229 Course Machine Learning Standford University](https://www.ctanujit.org/uploads/2/5/3/9/25393293/mathematics_for_machine_learning__cs229__1.pdf), Convex Optimization Overview, p. 2.
[^2]: [LaTeX Math Symbols](https://www.math.uci.edu/~xiangwen/pdf/LaTeX-Math-Symbols.pdf), p.2.
[^3]: [preceq (LaTeX symbol)](https://latex-programming.fandom.com/wiki/Preceq_\(LaTeX_symbol\)).
[^4]: [List of LaTeX mathematical symbols](https://oeis.org/wiki/List_of_LaTeX_mathematical_symbols).