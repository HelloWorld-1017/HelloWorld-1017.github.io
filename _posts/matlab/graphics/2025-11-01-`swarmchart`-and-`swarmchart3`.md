---
title: MATLAB `swarmchart` and `swarmchart3` --- Swarm scatter chart
categories:
 - Mathematics
 - MATLAB
tags:
 - MATLAB Graphics
location: Buffalo, United States
date: 2025-11-01 15:42:43 -0400
last_modified_at: 2025-11-03 18:36:01 -0500
---

# MATLAB `swarmchart` function

MATLAB provides a function `swarmchart`[^1] to plot a swarm scatter chart. 

<div class="quote--left" markdown="1">
`swarmchart(x,y)` displays a swarm chart, which is a <i class="emphasize">scatter plot with the points offset (jittered) in the `x`-dimension</i>. The points form distinct shapes, and the outline of each shape is similar to a violin plot. Swarm charts help you to visualize discrete `x` data with the distribution of the `y` data. At each location in `x`, the points are jittered based on the kernel density estimate of `y`.


- To plot one set of points, specify `x` and `y` as vectors of equal length.
- To plot multiple sets of points on the same set of axes, specify at least one of `x` or `y` as a matrix.

</div>

I feel interested about this function, because, as mentioned in blog[^3], I really like a Python graphic example, "Palmer Penguins exploration with violinplots in Matplotlib"[^4], and when I saw this example for the first time, I instantly loved the way how it realizes jittered data points; so when I saw "jitter" in the `swarmchart` function documentation, I really wanted to have a look in detail. So, I test some official examples as follows[^1].

## Example 1: Create swarm chart

```matlab
clc, clear, close all

x = [ones(1,500) 2*ones(1,500) 3*ones(1,500)];
y1 = 2 * randn(1,500);
y2 = 3 * randn(1,500) + 5;
y3 = 5 * randn(1,500) + 5;
y = [y1 y2 y3];
swarmchart(x,y)

exportgraphics(gca, 'fig1.jpg', 'Resolution', 600)
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/20251103174355891.jpg" alt="fig1" style="width:50%;" />

## Example 2: Plot Multiple data sets with custom marker size

```matlab
clc, clear, close all

x1 = ones(1,500);
x2 = 2 * ones(1,500);
x3 = 3 * ones(1,500);
y1 = 2 * randn(1,500);
y2 = [randn(1,250) randn(1,250) + 4];
y3 = 5 * randn(1,500) + 5;

swarmchart(x1,y1,5)
hold on
swarmchart(x2,y2,5)
swarmchart(x3,y3,5)
hold off

exportgraphics(gca, 'fig2.jpg', 'Resolution', 600)
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/20251103174522458.jpg" alt="fig2" style="width:50%;" />

From this example, we can see that we could create multiple swarm charts in the axes one by one, so we can customize each chart more easily.

## Example 3: Display filled markers with varied color & change jitter type and jitter width

```matlab
clc, clear, close all

tbl = readtable("BicycleCounts.csv");
daynames = ["Sunday" "Monday" "Tuesday" "Wednesday" "Thursday" "Friday" "Saturday"];
x = categorical(tbl.Day,daynames);
y = tbl.Total;
c = hour(tbl.Timestamp); % Specify the colors of the markers as vector c
s = swarmchart(x,y,5,c);

s.XJitter = 'rand';
s.XJitterWidth = 0.5;

exportgraphics(gca, 'fig3.jpg', 'Resolution', 600)
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/20251103174742888.jpg" alt="fig3" style="width:50%;" />

In this example, we can see how to specify markers color according to some certain values, `c = hour(tbl.Timestamp);` in this example. Also, it shows how to change the distribution of jitters.

There are three distributions supported[^1]:

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/20251101180641291.png" alt="image-20251101180641183" style="width:67%;" />

and corresponding algorithm to generate jitters:

<div class="quote--left" markdown="1">

The points in a swarm chart are jittered using uniform random values that are weighted by the Gaussian kernel density estimate of `y` and the relative number of points at each `x` location. This behavior corresponds to the default `'density'` setting of the `XJitter` property on the `Scatter` object when you call the `swarmchart` function.

The maximum spread of points at each `x` location is 90% of the smallest distance between adjacent `x` values by default:

```
spread = 0.9 * min(diff(unique(x)));
```

You can control the spread by setting the `XJitterWidth` property of the `Scatter` object.

Horizontal swarm charts are jittered using the same algorithm, but the points are jittered along the `y` dimension using the Gaussian kernel density estimate of `x`. In this case, you control the spread using the `YJitterWidth` property.

</div>

## Example 4: Specify filled markers with transparency

```matlab
clc, clear, close all

x1 = ones(1,500);
x2 = 2 * ones(1,500);
x = [x1 x2];
y1 = 2 * randn(1,500);
y2 = [randn(1,250) randn(1,250) + 4];
y = [y1 y2];
swarmchart(x,y,'filled','MarkerFaceAlpha',0.5,'MarkerEdgeAlpha',0.5)

exportgraphics(gca, 'fig4.jpg', 'Resolution', 600)
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/20251103175514028.jpg" alt="fig4" style="width:50%;" />

<br>

# Combine using `swarmchart` and `boxchart`

I think sometimes maybe we can try to combine using `swarmchart` and `boxchart`[^5] to create a composite image, like:

```matlab
clc, clear, close all

x1 = ones(1,500);
x2 = 2 * ones(1,500);
x = [x1 x2];
y1 = 2 * randn(1,500);
y2 = [randn(1,250) randn(1,250) + 4];
y = [y1 y2];


figure('Color', 'w')
hold(gca, 'on')
s = swarmchart(x,y,'filled','MarkerFaceAlpha',0.3,'MarkerEdgeAlpha',0.5,'SizeData',20);

s.XJitterWidth = 0.5;

boxchart(x, y, 'BoxFaceColor', 'b', 'BoxFaceAlpha', 0.2, 'JitterOutliers', 'off')

exportgraphics(gca, 'fig5.jpg', 'Resolution', 600)
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/20251103180543269.jpg" alt="fig5" style="width:50%;" />

or

```matlab
% ...
s.XJitter = 'rand';
s.XJitterWidth = 0.5;
% ...
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/20251103180749056.jpg" alt="fig5" style="width:50%;" />

Emmm, at least not bad 😂

<br>

# MATLAB `swarmchart3` function

By the way, there is another function `swarmchart3`[^2] to create a 3-D swarm scatter chart. Here is a simple example:

```matlab
clc, clear, close all

x = [zeros(1,500) ones(1,500)];
y = randi(2,1,1000);
z = randn(1,1000).^2;
c = sqrt(z);
swarmchart3(x,y,z,50,c,'filled');

exportgraphics(gca, 'fig6.jpg', 'Resolution', 600)
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/20251103181157950.jpg" alt="fig6" style="width:50%;" />

<br>

**References**

[^1]: [MATLAB `swarmchart`: Swarm scatter chart](https://www.mathworks.com/help/matlab/ref/swarmchart.html).
[^2]: [MATLAB `swarmchart3`: 3-D swarm scatter chart](https://www.mathworks.com/help/matlab/ref/swarmchart3.html).
[^3]: [A Warning of Using `boxplot` on `tiledlayout` in MATLAB; Comparison between `boxchart` and `boxplot`](/2025-10-31/23-54-10.html).
[^4]: [Palmer Penguins exploration with violinplots in Matplotlib](https://python-graph-gallery.com/web-ggbetweenstats-with-matplotlib/).
[^5]: [MATLAB `boxchart`: Box chart (box plot)](https://www.mathworks.com/help/matlab/ref/boxchart.html).