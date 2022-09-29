---
layout: single
title: 【MATLAB Graphics】Colourful Black
date: 2022-09-02 19:19:19 +0800
categories: 
 - Programming
tags:
 - MATLAB
 - MATLAB Graphics
toc: false
---

MATLAB的`colormap`函数可以将默认的色卡作为输入值：

<img src="https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20220902181921057.png" alt="image-20220902181921057" style="zoom: 50%;" />

除此之外，还可以调用用户设置的色彩矩阵，这种方式可以使我们用“离散”的颜色来表表达数据范围。比如：

```matlab
clc, clear, close all
mymap = [ ...
    0 0.5 0.7;
    1 0 0;
    0 0 1;
    1 1 0.5
    ];
surf(peaks(50))
colormap(mymap)
colorbar
```

<img src="https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20220902182405760.png" alt="image-20220902182405760" style="zoom: 80%;" />

`mymap`与色卡的对应关系为：

<img src="https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20220902182739675.png" alt="image-20220902182739675" style="zoom:80%;" />

<br>

在尝试的过程中，我将`peaks()`函数的参数调整为1000，即：

```matlab
...
surf(peaks(1000))
...
```



<img src="https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20220902182900966.png" alt="image-20220902182900966" style="zoom:80%;" />

在图中看到了色卡中并没有定义的黑色。起初对于`peaks`函数的值域不是了解，以为是函数值超过了色卡定义的范围，即[-6, 8]，于是找到了`caxis`函数来试图解决：

```matlab
...
surf(peaks(1000))
colormap(mymap)
caxis([-1000, 1000])
...
```

但还是没有效果，

<img src="https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20220902183450033.png" alt="image-20220902183450033" style="zoom:80%;" />

后来发现，问题并不出在这里，**这个黑色其实是网格线**。如果把图片放大可以看到：

![image-20220902183640569](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20220902183640569.png)

这个黑是五彩斑斓的黑~

<br>

同样的状况还出现在另一个情景当中。我想要遍历正方形区域$[0,0]\rightarrow[2,0]\rightarrow[2,2]\rightarrow[0,2]\rightarrow[0,0]$内的有限网格，将离$[0,0]$最近的点所构成的网格涂成一种颜色，离$[2,0]$距离最近的点所构成的网格涂成另外一种颜色，使用代码：

注：这种需求很常见，比如绘制漂亮的分形图像。
{: .notice}

```matlab
clc, clear, close all

points_x = [0, 2];
points_y = [0, 0];
interval = linspace(0, 2, 100);
[xGrid, yGrid] = meshgrid(interval, interval);
x = xGrid(:);
y = yGrid(:);
d1 = (x-points_x(1)).^2+(y-points_y(1)).^2;
d2 = (x-points_x(2)).^2+(y-points_y(2)).^2;
D = [d1, d2];
[~, idx] = min(D, [], 2);
contourf(xGrid, yGrid, ...
    reshape(idx, size(xGrid, 1), size(yGrid, 2)));
colorbar
```

得到图像：

<img src="https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20220902184807938.png" alt="image-20220902184807938" style="zoom:80%;" />



中间有一条黑钱。其实这不是黑线，放大看的话可以看到也是彩色的：

<img src="https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20220902184851836.png" alt="image-20220902184851836" style="zoom:80%;" />



但其实，用于绘图的数据是定类类型，只有1和2两个值，中间的颜色是不应该出现的。

起初我以为出现这种状况是因为没有使用“离散”的色卡，如果我们使用上述自定义色卡的形式定义一个离散的色卡：

```matlab
...
mymap = [0, 1, 0; 1, 0, 0];
colormap(mymap)
colorbar
```
可以看到，图中虽然只出现了定义的两种颜色，但还是不太理想，仍然有黑色线条出现：

![image-20220902185521330](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20220902185521330.png)

![image-20220902185532533](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20220902185532533.png)

这里的黑线就很不合理，也并不可能是数值计算的误差导致的。

<br>

这个问题可能是`contourf`这个函数的代码实现所导致的，这些线就是代码所绘制的一些“等高线”，只是出现在这里不太合理。

使用`imagesc`函数，就不会出现这个问题：

```matlab
clc, clear, close all

points_x = [0, 2];
points_y = [0, 0];
interval = linspace(0, 2, 100);
[xGrid, yGrid] = meshgrid(interval, interval);
x = xGrid(:);
y = yGrid(:);
d1 = (x-points_x(1)).^2+(y-points_y(1)).^2;
d2 = (x-points_x(2)).^2+(y-points_y(2)).^2;
D = [d1, d2];
[~, idx] = min(D, [], 2);
imagesc('xData', [0, 2], 'yData', [2, 0], ...
    'CData', reshape(idx, size(xGrid, 1), size(yGrid, 2)));
mymap = [0, 1, 0; 1, 0, 0];
colormap(mymap)
colorbar
```

<img src="https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20220902191455141.png" alt="image-20220902191455141" style="zoom: 80%;" />

<br>

很有意思，记录一下。