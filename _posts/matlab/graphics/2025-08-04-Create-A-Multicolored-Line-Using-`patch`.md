---
title: Create A Multicolored Line (A Line with Gradual Color) Using MATLAB `patch` Function
toc: false
categories:
 - MATLAB
tags:
 - MATLAB Graphics
date: 2025-08-04 13:48:36 +0800
last_modified_at: 2025-08-05 22:03:58 +0800
---

In the official documentation of MATLAB `path` function[^1], there is a method introduced to create a multicolored line, whose color of each point is determined by the point value (or, the line color is gradual, rather than a single color), with markers by the `patch` function:

```matlab
clc, clear, close all

% Create a multicolored line with markers at each vertex. 
% Interpolate the colors and use a colorbar to show how the values map to the colormap.

x = linspace(1, 10, 15);
y = sin(x);
y(end) = NaN; % Set the last entry of y to NaN so that patch creates a line instead of a closed polygon.
c = y; % Define a color for each vertex using the y values. The values in c map to colors in the colormap.

patch(x, y, c, ...
    "EdgeColor", "interp", ... % Show markers at each vertex and set the EdgeColor to 'interp' to interpolate the colors between vertices
    "Marker", "o", ...
    "MarkerSize", 5, ...
    "MarkerFaceColor","flat");
colorbar
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202508041405322.png" alt="image-20250804140502250" style="width:50%;" />

If we increase the number of points, we’ll have:

```matlab
% ...

x = linspace(1, 10, 2000);

% ...
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202508041406910.png" alt="image-20250804140612860" style="width:50%;" />

At this time, the plot looks like a smooth “line” (that is without markers) with gradual color.

Actually, it should be noted that, the core of this method is setting `"EdgeColor"` as `"interp"`, rather than markers --- we can just specify the `"LineWidth"` property to realize a similar effect[^2]:

```matlab
clc, clear, close all

x = linspace(1,10, 2000);
y = sin(x);
y(end) = NaN; 
c = y;

patch(x, y, c, "EdgeColor", "interp", "LineWidth", 5)
colorbar
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202508041415372.png" alt="image-20250804141512323" style="width:50%;" />

<br>

**References**

[^1]: [MATLAB `patch`: Create patches of colored polygons](https://www.mathworks.com/help/matlab/ref/patch.html).
[^2]: [https://www.mathworks.com/matlabcentral/answers/845215-color-gradient-for-graph-in-a-for-loop#answer\_714510](https://www.mathworks.com/matlabcentral/answers/845215-color-gradient-for-graph-in-a-for-loop#answer_714510).