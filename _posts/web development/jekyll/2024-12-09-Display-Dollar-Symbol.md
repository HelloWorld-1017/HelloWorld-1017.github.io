---
title: Prevent Jekyll's MathJax Engine from Identifying Dollar Symbol as a Delimiter of an Inline Equation
toc: false
categories:
 - Web Development
tags:
 - Jekyll
 - Markdown
 - Typora
date: 2024-12-09 14:52:08 +0800
last_modified_at: 2024-12-09 14:52:08 +0800
---

| The way of typing dollar symbol                     | Display                                       | Markdown file (in Typora)    | Jekyll (kramdown + MathJax)  |
| --------------------------------------------------- | --------------------------------------------- | ---------------------------- | ---------------------------- |
| `between $10 and $20`                               | between $10 and $20                           | Delimiter of inline equation | Delimiter of inline equation |
| `between \$10 and \$20`                             | between \$10 and \$20                         | Dollar symbol                | Delimiter of inline equation |
| `between &dollar;10 and &dollar;20`                 | between &dollar;10 and &dollar;20             | Dollar symbol                | &dollar;                     |
| `between &#36;10 and &#36;20`                       | between &#36;10 and &#36;20                   | Dollar symbol                | Delimiter of inline equation |
| `between \\$10 and \\$20`[^1]                       | between \\$10 and \\$20                       | Delimiter of inline equation | **Dollar symbol**            |
| `between <span>$</span>10 and <span>$</span>20`[^1] | between <span>$</span>10 and <span>$</span>20 | Delimiter of inline equation | **Dollar symbol**            |

As shown, to prevent Jekyll's MathJax engine from identifying dollar symbol as a delimiter of an inline equation, we can use the last two methods, although they would otherwise make an inline equation in the Markdown file (at least in Typora).

<br>

**References**

[^1]: [How do you type the dollar sign when you have mathjax installed?](https://stackoverflow.com/questions/36030033/how-do-you-type-the-dollar-sign-when-you-have-mathjax-installed).

