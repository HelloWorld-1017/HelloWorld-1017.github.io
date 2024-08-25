---
layout: single
title: MATLAB `imagesc` Function
date: 2022-07-18 19:09:19 +0800
categories: 
 - MATLAB 
tags:
 - MATLAB Graphics
---

# 基本语法

> **`imagesc`**: Display image with scaled color

MATLAB 官方提供的示例：

```matlab
x = [5 8];
y = [3 6];
C = [0 2 4 6; 8 10 12 14; 16 18 20 22];
imagesc(x,y,C)
colorbar
```

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220718182728255.png?raw=true" alt="image-20220718182728255" style="zoom:50%;" />

上述代码中

- 第1行和第2行中 $x$ 和 $y$ 中的元素分别对应图像左上角和右下角位置的 $xy$ 坐标，即第3行中 $C(1,1)$ 和 $C(m,n)$ 的位置。$x$ 和 $y$ 均为 two-element vector，如果设定了多个元素（甚至 $x$ 和 $y$ 的形状不一致也可以），那么MATLAB会自动取 $x$ 和 $y$ 的第一个元素和最后一个元素，即 $x=[x(1),x(end)]$，$y=[y(1),y(end)]$
- 第3行指定的 $C$ ：MATLAB 会按照一定算法自动地将 $C$ 中的最小值对应色卡的的最低端，$C$ 中的最大值对应色卡的的最顶端，$C$ 中的其他元素对应色卡中间的相应颜色；并且 $C$ 的行列数，会自动对应图像中色块的行列数。

测试代码

```matlab
clc, clear, close all

x = [5 5 5 8]; 
y = [3 4 7]; 
C = [0 2 4 6 8 9;
    8 10 12 14 16 17;
    16 18 20 22 24 25;
    0 18 20 22 24 25];
imagesc(x, y, C), hold on
scatter([x(1), x(end)], [y(1), y(end)], 50, "filled"), hold on
text(x(1), y(1), ['(', num2str(x(1)), ',', num2str(y(1)), ')'], fontsize=13, Color='w')
text(x(end), y(end), ['(', num2str(x(end)), ',', num2str(y(end)), ')'], fontsize=13, Color='k')
colorbar
```

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220718185509146.png?raw=true" alt="image-20220718185509146" style="zoom:50%;" />

<br>

# 改变纵坐标

上面的图像中，横坐标都是递增，而纵坐标是递减的。如果想改变这种设置，可以用两种方式，更推荐其中第2种方式，因为可以保留下坐标Ticks的竖线：

```matlab
clc, clear, close all

x = [5 8];
y = [3 6];
C = [0 2 4 6; 8 10 12 14; 16 18 20 22];
imagesc(x, y, C)
% imagesc('xData', x, 'yData', y,'CData', C) % Method 1
set(gca, 'yDir', 'normal') % Method 2
colorbar
```

![image-20220904154245136](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220904154245136.png?raw=true)

<br>

# clims

**imagesc** 函数可以设置色卡最低端（最顶端）所所对应的最小（最大）值，矩阵 $C$ 中小于最小值（大于最大值）的数值都会被设置为色卡最低端（最顶端）所对应的颜色。

```matlab
C = [0 2 4 6; 8 10 12 14; 16 18 20 22];
clims = [4 18];% [limit_min, limit_max]
imagesc(C, clims)
colorbar
```

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220718190512349.png?raw=true" alt="image-20220718190512349" style="zoom:50%;" />

<br>

# 色卡

MATLAB 所采用的默认色卡是 `Parula`，用户可以自己设置，如：

```matlab
C = [0 2 4 6; 8 10 12 14; 16 18 20 22];
clims = [4 18];% [limit_min, limit_max]
imagesc(C, clims)
colormap('Jet')
colorbar
```

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220718190433965.png?raw=true" alt="image-20220718190433965" style="zoom:50%;" />

MATLAB 内建的色卡有以下几种：

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220718190340288.png?raw=true" alt="image-20220718190340288" style="zoom:50%;" />

<br>

**References**

[1] [imagesc - MATLAB Documentation](https://ww2.mathworks.cn/help/matlab/ref/imagesc.html).