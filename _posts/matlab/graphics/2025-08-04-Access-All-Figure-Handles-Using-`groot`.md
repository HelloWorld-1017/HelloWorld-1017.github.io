---
title: Access All Figure Handles Using `groot` Function in MATLAB
toc: false
categories:
 - MATLAB
tags:
 - MATLAB Graphics
date: 2025-08-04 15:21:13 +0800
last_modified_at: 2025-08-05 21:52:25 +0800
---

In MATLAB, we can use `gcf`[^1] to get the current figure handle, which way is commonly used. To step further, we can access all figure handles with the help of `groot` function[^2]. Take the case of three figures as an example:

```matlab
clc, clear, close all
rng("default")

num = 100;
x = 1:num;
y1 = randn(1, num);
y2 = randn(1, num);
y3 = randn(1, num);

figure("Name", "fig1")
plot(x, y1)

figure("Name", "fig2")
plot(x, y2)

figure("Name", "fig3")
plot(x, y3)

r = groot
```

then we’ll have variable `r`:

```
r = 
  Graphics Root with properties:

          CurrentFigure: [1×1 Figure]
    ScreenPixelsPerInch: 96
             ScreenSize: [1 1 2560 1440]
       MonitorPositions: [2×4 double]
                  Units: 'pixels'

  Show all properties

         CallbackObject: [0×0 GraphicsPlaceholder]
               Children: [3×1 Figure]
          CurrentFigure: [1×1 Figure]
     FixedWidthFontName: 'Courier New'
       HandleVisibility: 'on'
       MonitorPositions: [2×4 double]
                 Parent: [0×0 GraphicsPlaceholder]
        PointerLocation: [544.3333 629]
            ScreenDepth: 32
    ScreenPixelsPerInch: 96
             ScreenSize: [1 1 2560 1440]
      ShowHiddenHandles: off
                    Tag: ''
                   Type: 'root'
                  Units: 'pixels'
               UserData: []
```

and among which `r.Children` is:

```
ans = 
  3×1 Figure array:

  Figure    (3: fig3)
  Figure    (2: fig2)
  Figure    (1: fig1)
```

and

```matlab
r.Children(1), r.Children(2), r.Children(3)
```

```
ans = 
  Figure (3: fig3) with properties:
      Number: 3
        Name: 'fig3'
       Color: [0.9400 0.9400 0.9400]
    Position: [1000 817.6667 560 420.0000]
       Units: 'pixels'
  Show all properties

ans = 
  Figure (2: fig2) with properties:
      Number: 2
        Name: 'fig2'
       Color: [0.9400 0.9400 0.9400]
    Position: [1000 817.6667 560 420.0000]
       Units: 'pixels'
  Show all properties

ans = 
  Figure (1: fig1) with properties:
      Number: 1
        Name: 'fig1'
       Color: [0.9400 0.9400 0.9400]
    Position: [1000 817.6667 560 420.0000]
       Units: 'pixels'
  Show all properties
```

So, we can save these three figures easily by:

```matlab
exportgraphics(r.Children(3), "fig1.png", "Resolution", 600)
exportgraphics(r.Children(2), "fig2.png", "Resolution", 600)
exportgraphics(r.Children(1), "fig3.png", "Resolution", 600)
```

By the way, note the order of figures.

<br>

**References**

[^1]: [MATLAB `gcf`: Current figure handle](https://www.mathworks.com/help/matlab/ref/gcf.html).
[^2]: [MATLAB `groot`: Graphics root object](https://www.mathworks.com/help/matlab/ref/groot.html).
