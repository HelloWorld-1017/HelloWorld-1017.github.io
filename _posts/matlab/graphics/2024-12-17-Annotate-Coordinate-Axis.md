---
title: Annotate Coordinate Axis when Plotting in MATLAB
toc: false
categories:
 - LaTeX
 - MATLAB
tags:
 - MATLAB Graphics
 - LaTeX Box
date: 2024-12-17 21:05:34 +0800
last_modified_at: 2024-12-18 09:59:38 +0800
---

{% raw %}

```matlab
clc, clear, close all

ax = gca();
hold(ax,"on"), box(ax, "on"), grid(ax, "on")
set(ax, "Units", "points")
x = 0:.1:5;
y = x.^2;
plot(x, y, "LineWidth", 1.5, "Color", "b")
xlim([0,5])
xt = 0:5;
set(ax, "xtick", xt, "XTickLabel", sprintfc("$T_{%d}$",xt), "TickLabelInterpreter", "latex")

for i = 1:5
    txt = sprintf("\\raisebox{-5pt}{$\\underbrace{\\hspace{54.5pt}}_{M_{%d}}$}", i);
    text(i-1, 0, txt, "Interpreter", "latex", "FontSize", 12, "Color", "r")
end

exportgraphics(gca, "fig.jpg", "Resolution", 600)
```

{% endraw %}

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202412180958778.jpg" alt="fig" style="width:50%;" />

<br>

**References**

- [matlab画图坐标轴标注问题，画红圈的地方应该怎么画？ - 知乎用户的回答](https://www.zhihu.com/question/39510261/answer/81738771).
- [LaTeX help 1.1 - `\raisebox`](https://www.emerson.emory.edu/services/latex/latex_148.html).