---
title: Fix Text Overflowing the Axes When Plotting Figures in MATLAB
toc: false
categories:
 - MATLAB
tags:
 - MATLAB Graphics
location: United States
date: 2025-10-19 15:13:08 -0400
last_modified_at: 2025-10-19 15:13:08 -0400
---

When we plot figures in MATLAB, sometimes x-label (maybe some other text) would overflow the axes, for example:

```matlab
clc, clear, close all

X = categorical({'Small', 'Medium', 'Large', 'Extra Large'});
X = reordercats(X, {'Small', 'Medium', 'Large', 'Extra Large'});
Y = [10, 21, 33, 52];

figure("Color", "w")
tiledlayout(1, 2)

nexttile
bar(X,Y)
xlabel("Categories", "FontName", "Times New Roman", "FontSize", 30)
title("Bar plot", "FontName", "Times New Roman", "FontSize", 30)

nexttile
bar(X,Y)
xlabel("Categories", "FontName", "Times New Roman", "FontSize", 30)
title("Bar plot", "FontName", "Times New Roman", "FontSize", 30)

exportgraphics(gcf, "fig.jpg", "Resolution", 600)
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/20251019160125223.jpg" alt="fig" style="width:75%;" />

I guess it is caused by the `tiledlayout` function. To solve this problem, we can increase the height of figure and then move the whole tiled chart layout upward:

```matlab
clc, clear, close all

X = categorical({'Small', 'Medium', 'Large', 'Extra Large'});
X = reordercats(X, {'Small', 'Medium', 'Large', 'Extra Large'});
Y = [10, 21, 33, 52];

fig = figure("Color", "w");
t = tiledlayout(1, 2);

nexttile
bar(X,Y)
xlabel("Categories", "FontName", "Times New Roman", "FontSize", 30)
title("Bar plot", "FontName", "Times New Roman", "FontSize", 30)

nexttile
bar(X,Y)
xlabel("Categories", "FontName", "Times New Roman", "FontSize", 30)
title("Bar plot", "FontName", "Times New Roman", "FontSize", 30)

% IMPORTANT to adopt the same position units for fig and tiled chart layout
fig.Units  = "pixels";
t.Units = "pixels";

figPos = fig.Position;
tPos = t.Position;

fig.Position = [figPos(1), figPos(2), figPos(3), figPos(4)+100];
t.Position = [tPos(1), tPos(2)+100, tPos(3), tPos(4)];

exportgraphics(gcf, "fig1.jpg", "Resolution", 600)
```

then we can get such an figure:

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/20251019160937960.jpg" alt="fig" style="width:75%;" />

which includes the whole x-label. And as can be seen, the figure gets taller.

