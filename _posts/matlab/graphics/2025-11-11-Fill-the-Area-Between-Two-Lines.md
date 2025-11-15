---
title: Fill the Area Between Two Lines in MATLAB --- A helper function for `fill` and `fill3`
toc: false
categories:
 - MATLAB
tags:
 - MATLAB Graphics
location: Buffalo, United States
date: 2025-11-11 15:35:11 -0500
last_modified_at: 2025-11-15 13:17:50 -0500
---

In a previous blog[^1], I ever recorded a method to fill the interval area using MATLAB `fill` function. Actually, this `fill` function[^2] is not specially designed for filling the area between two lines (it's for plotting shapes, by specifying and then connecting the end points one by one. It makes sense). So, recently when I used `fill` function to fill the area between two lines, I found the syntax is not that direct, because I have to make an end-to-end connection between two curves, with the help of `flipud` or `fliprl` function (depending on whether column or row vector). So, in this blog, I want to record a small helper function here, which takes the x- and y-coordinates of two lines, a more straightforward syntax, to help me use `fill` function (and similar `fill3` function [^3] that is used in 3D plot) in the future.

(1) `fill` version

```matlab
function helperFill(xU, yU, xL, yL, Color)
data = [xU, yU; flipud([xL, yL])];
fill(data(:, 1), data(:, 2), Color, 'EdgeColor', 'none', 'FaceAlpha', 0.2, 'HandleVisibility', 'off');
end
```

(2) `fill3` version

```matlab
function helperFill3(xU, yU, zU, xL, yL, zL, Color)
data = [xU, yU, zU; flipud([xL, yL, zL])];
fill3(data(:, 1), data(:, 2), data(:, 3), Color, 'EdgeColor', 'none', 'FaceAlpha', 0.2, 'HandleVisibility', 'off');
end
```

and we can use it like (note that all coordinate variables should be column vector):

```matlab
clc, clear, close all

figure('Color', 'w', 'Position', [1000,736,863,501])
tiledlayout(1, 2, 'TileSpacing', 'tight')

nexttile
hold(gca, 'on')
x = linspace(0, 2*pi, 200);
y1 = sin(x);
y2 = sin(x)+1;

x = x';
y1 = y1';
y2 = y2';

plot(x, y1, 'LineWidth', 1.5, 'Color', 'r')
plot(x, y2, 'LineWidth', 1.5, 'Color', 'r')
helperFill(x, y1, x, y2, 'r')

nexttile
view(3)
hold(gca, 'on')
t = linspace(0, 10*pi, 2e3);
x = cos(t);
y = sin(t);
z1 = t;
z2 = t+2;

x = x';
y = y';
z1 = z1';
z2 = z2';

plot3(x, y, z1, 'LineWidth', 1.5, 'Color', 'r')
plot3(x, y, z2, 'LineWidth', 1.5, 'Color', 'r')
helperFill3(x, y, z1, x, y, z2, 'r')

exportgraphics(gcf, 'fig.jpg', 'Resolution', 600)

function helperFill(xU, yU, xL, yL, Color)
data = [xU, yU; flipud([xL, yL])];
fill(data(:, 1), data(:, 2), Color, 'EdgeColor', 'none', 'FaceAlpha', 0.2, 'HandleVisibility', 'off');
end

function helperFill3(xU, yU, zU, xL, yL, zL, Color)
data = [xU, yU, zU; flipud([xL, yL, zL])];
fill3(data(:, 1), data(:, 2), data(:, 3), Color, 'EdgeColor', 'none', 'FaceAlpha', 0.2, 'HandleVisibility', 'off');
end
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/20251112210435058.jpg" alt="fig" style="width:75%;" />

<br>

**References**

[^1]: [Fill the Interval Area Between Two Curves by MATLAB `fill` Function](/2022-10-06/17-22-29.html).
[^2]: [MATLAB `fill`: Create filled 2-D patches](https://www.mathworks.com/help/matlab/ref/fill.html).
[^3]: [MATLAB `fill3`: Create filled 3-D patches](https://www.mathworks.com/help/matlab/ref/fill3.html).
