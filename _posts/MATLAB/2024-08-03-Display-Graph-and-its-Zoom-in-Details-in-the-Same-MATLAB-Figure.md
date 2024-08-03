---
title: Display Graph and Its Zoom-in Details in the Same MATLAB Figure
toc: false
categories:
 - MATLAB
tags:
 - MATLAB Graphics
date: 2024-08-03 23:23:58 +0800
last_modified_at: 2024-08-03 23:23:58 +0800
---

```matlab
clc, clear, close all

x = 1e-3:1e-3:2;
y = 1./x;

fig = figure("Color","w");
ax = axes;
plot(x, y, "LineWidth", 1.5, "Color", "b")
box(gca, "off")
xlabel("x")
ylabel("y")

copy_of_ax = copyobj(ax, fig);
ax_position = ax.Position;
copy_of_ax.Position = [0.23, ax_position(2)*2, 0.65, ax_position(4)/3]; 
copy_of_ax.YLim = [0, 10];
copy_of_ax.XLabel = [];
copy_of_ax.YLabel = [];

exportgraphics(fig, "fig.jpg", "Resolution", 900)
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202408032334903.jpg" alt="fig" style="width:67%;" />

<br>

**References**

[1] [MATLAB `copyobj`: Copy graphics objects and their descendants](https://www.mathworks.com/help/matlab/ref/copyobj.html).