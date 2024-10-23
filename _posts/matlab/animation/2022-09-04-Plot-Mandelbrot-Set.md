---
layout: single
title: Plot Mandelbrot Set in MATLAB
date: 2022-09-04 15:45:23 +0800
categories: 
 - Mathematics
 - Uncertainty
 - Signals and Systems
 - MATLAB
tags:
 - Complex Analysis
 - Fractal
 - MATLAB Graphics
 - MATLAB Animation
last_modified_at: 2023-11-14 14:12:04 +0800
---

# Mandelbrot Set 

根据Wikipedia对于Mandelbrot set的定义：Mandelbrot set是一个复数$c$的集合，当从$z=0$开始迭代时，函数

$$
f_c(z)=z^2+c\label{eq1}
$$

不会发散至无穷大，即序列$f_c(0), f_c(f_c(0)),\cdots$的绝对值保持有界$^{[1]}$。

<br>

# Plot Mandelbrot Set using method provided by MATLAB Official example



MATLAB官方提供了一种基于`gpuArray`计算的Mandelbrot set的实现方法：

```matlab
maxIterations = 500;
gridSize = 1000;
xlim = [-0.748766713922161, -0.748766707771757];
ylim = [ 0.123640844894862,  0.123640851045266];

x = gpuArray.linspace(xlim(1), xlim(2), gridSize);
y = gpuArray.linspace(ylim(1), ylim(2), gridSize);
whos x y

[xGrid, yGrid] = meshgrid(x, y);
z0 = complex(xGrid, yGrid); % 1000-by-1000, Complex matrix

count = ones(size(z0), 'gpuArray');

z = z0;

for n = 0:maxIterations
    z = z.^2 + z0;
    inside = abs(z) <= 2;
    count = count + inside;
end
% count = log(count);

imagesc(x, y, count)
colormap([jet(); flipud(jet()); 0 0 0]);
colorbar
axis off
```

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220904120024087.png?raw=true" alt="image-20220904120024087" style="zoom: 80%;" />

但是，代码片段：

```matlab
...
[xGrid, yGrid] = meshgrid(x, y);
z0 = complex(xGrid, yGrid); % 1000-by-1000, Complex matrix

z = z0;
...
```

表明：迭代过程并不是从`z=0`开始的（尽管很接近。因为`xlim`和`ylim`的范围都很小，可以近似为0）。

上述代码更像是对于迭代方程：

$$
f_c(c)=c^2+c
$$

的实现，没有严格区分开变量$z$和$c$。而根据定义，Mandelbrot Set实际上是复数$c$的集合，$z$始终是从0开始迭代的。基于该原因，使用下面的代码实现可能更为合理：

```matlab
maxIterations = 500;
gridSize = 1000;
xlim = [-0.748766713922161, -0.748766707771757];
ylim = [ 0.123640844894862,  0.123640851045266];

x = gpuArray.linspace(xlim(1), xlim(2), gridSize);
y = gpuArray.linspace(ylim(1), ylim(2), gridSize);
whos x y

[xGrid, yGrid] = meshgrid(x, y);
z0 = complex(xGrid, yGrid); % 1000-by-1000, Complex matrix

count = ones(size(z0), 'gpuArray');

% z = z0;
z = zeros(size(z0));

for n = 0:maxIterations
    z = z.^2 + z0;
    inside = abs(z) <= 2;
    count = count + inside;
end
% count = log(count);

imagesc(x, y, count)
colormap([jet(); flipud(jet()); 0 0 0]);
colorbar
axis off
```

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220904120951554.png?raw=true" alt="image-20220904120951554" style="zoom: 80%;" />

尽管两个图像之间并没有什么明显的差异，但是区分变量$z$和$c$是有必要的。

若$z$从不同的初始值开始迭代，而保持$c$不变（这里取做0.5），实现代码为：

```matlab
maxIterations = 500;
gridSize = 5000;
xlim = [-2, 2];
ylim = [-2, 2];

x = gpuArray.linspace(xlim(1), xlim(2), gridSize);
y = gpuArray.linspace(ylim(1), ylim(2), gridSize);
whos x y

[xGrid, yGrid] = meshgrid(x, y);
z0 = complex(xGrid, yGrid); % 1000-by-1000, Complex matrix
count = ones(size(z0), 'gpuArray');

z = z0;

for n = 0:maxIterations
    z = z.^2 + 0.5;
    inside = abs(z) <= 2;
    count = count + inside;
end

imagesc(x, y, count)
colormap([jet(); flipud(jet()); 0 0 0]);
colorbar
axis off
```

可以看到图像为：

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220904121751235.png?raw=true" alt="image-20220904121751235" style="zoom: 80%;" />

在分形领域或者全纯动力学领域可能对上述两个都很漂亮的图形有更为严格的区分。

<br>

# Plot Mandelbrot Set using methods provided by Vendoyov

在MATLAB File Exchange中，Vendoyov提供了绘制Mandelbrot set的代码$^{[4]}$：

注：本人对代码重新进行了整理和改写，作者的原意没有改变。作者源代码见参考[4]。
{: .notice--primary}

```matlab
clc, clear, close all

gridSize = 2e3;
x = gpuArray.linspace(-2, 2, gridSize);
y = gpuArray.linspace(-2, 2, gridSize);

[xGrid, yGrid] = meshgrid(x,y); % for vectorized calculation
c = complex(xGrid, yGrid);

R = 10; % if abs(z)>R then z is considered as infinity
maxIterations = 100; % maximal number of iterations, 100 is close to infinity
z = zeros(size(c), 'gpuArray'); % starts from zeros

for i = 1:maxIterations
    z = z.^2+c; 
end

logicalImage = abs(z)<R; % Logical image
imagesc(x, y, logicalImage);
xlabel('Re(c)');
ylabel('Im(c)');
set(gca, 'yDir', 'normal')
colormap("jet")
cbar = colorbar;
cbar.Limits = [0, 1];
```

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220904152649720.png?raw=true" alt="image-20220904152649720" style="zoom: 80%;" />

从上述代码中可以看到，Vendoyov对于方程$\eqref{eq1}$的迭代，就是从$z=0$开始，符合Mandelbrot set的定义。Vendoyov将参数c的网格矩阵根据方程$\eqref{eq1}$进行迭代，在迭代`maxIterations`次后，若函数值的模仍小于设定的`R`，就认为该点是收敛的，则将`logicalImage`中的对应位置设为逻辑`1`；若函数值的模大于`R`，则认为是发散的，将`logicalImage`中的对应位置设为逻辑`0`，之后进行绘图。

由于`logicalImage`只有两类值，因此上图中只有两种颜色。Vendoyov还提供了另一种方式来丰富图中的细节：

```matlab
clc, clear, close all

gridSize = 2e3;
x = gpuArray.linspace(-2, 2, gridSize);
y = gpuArray.linspace(-2, 2, gridSize);
[xGrid, yGrid] = meshgrid(x,y);
c = complex(xGrid, yGrid);

R = 5; % if abs(z)>R then z is considered as infinity
maxIterations = 100;% maximal number of iterations, 100 is close to infinity

z = zeros(size(c), 'gpuArray'); % starts from zeros
count = zeros(size(c), 'gpuArray');

for i = 1:maxIterations
    z = z.^2+c; 
    bw = abs(z)<R;
    count(bw) = i;
end

imagesc(x, y, count);
xlabel('Re(c)');
ylabel('Im(c)');
set(gca, 'yDir', 'normal')
colormap("jet")
cbar = colorbar;
cbar.Limits = [0, maxIterations];
```

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220904153048551.png?raw=true" alt="image-20220904153048551" style="zoom:80%;" />

这种方式通过`count`矩阵来记录参数`c`经过**多少次**迭代后仍可以认为是收敛的（函数值的模小于`R`）：`count`矩阵中的数字越大，就表示经过多轮迭代后仍收敛。

除此之外，Vendoyov还提供了相应的生成.avi文件和.gif文件的代码，用于动态展示Mandelbrot set放大的细节。

生成.gif文件的代码：

```matlab
clc, clear, close all

x0 = -0.21503361460851339;
y0 = 0.67999116792639069;
resolution_x = 1920; % resolution x
resolution_y = 1080; % resolution y
R = 8; % if abs(z)>R then z is considered as infinity
maxIterations = 80; % maximal number of iterations, 100 is close to infinity

figure('units', 'normalized', 'position', [0.1-0.08 0.073 0.3 0.4]);

maxZoom=150;
fc=1; % Iteration of frames
lc=1;
for zm = 1:1:maxZoom

    zmf = exp(-zm/20);
    x1 = x0-2*zmf;
    x2 = x0+2*zmf;
    y1 = y0-1.5*exp(-zm/20);
    y2 = y0+1.5*exp(-zm/20);
    x = linspace(x1, x2, resolution_x);
    y = linspace(y1, y2, resolution_y);

    [xGrid, yGrid] = meshgrid(x, y); % for vectorized calculation
    c = complex(xGrid, yGrid);

    z = zeros(size(c), 'gpuArray');     % starts from z=0
    count = zeros(size(c), 'gpuArray');

    for nc = 1:maxIterations
        z = z.^2+c;
        bw = abs(z)<R;
        count(bw) = nc;
    end

    cla % Clear current axes
    imagesc(x, y, count);
    set(gca, 'YDir', 'normal');
    colormap("jet")
    xlabel('Re(c)');
    ylabel('Im(c)');
    axis equal;
    axis off
    set(gca, 'clim', [0 maxIterations]);
    set(gca,'units','normalized','position',[0 0 1 1]);
    f = getframe(gcf);

    if lc == 1
        colorbar
        [im, map] = rgb2ind(f.cdata, 256, 'nodither'); % Convert RGB image to indexed image
        colorbar('off');
        im(1, 1, 1, 20) = 0;
    else
        im(:, :, 1, lc-1) = rgb2ind(f.cdata, map, 'nodither');
    end
    fc = fc+1;
    lc = lc+1;
end

% Write to .gif file
imwrite(im, map, 'mandelbrot_gif.gif', 'DelayTime', 0, 'LoopCount', inf) 
```

![mandelbrot_gif](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/mandelbrot_gif.gif?raw=true)

以及生成.avi视频文件的代码：

```matlab
clc, clear, close all

x0 = -0.21503361460851339;
y0 = 0.67999116792639069;
resolution_x = 1920; % resolution x
resolution_y = 1080; % resolution y
R = 8; % if abs(z)>R then z is considered as infinity
maxIterations = 100; % maximal number of iterations, 100 is close to infinity

figure('units', 'normalized', 'position', [0.1-0.08 0.073 0.8 0.8]);
maxZoom = 200; % Maximum zoom
fc = 1; % Iteration of frames

for zm = 1:0.35:maxZoom
    zmf = exp(-zm/20);
    x1 = x0-2*zmf;
    x2 = x0+2*zmf;
    y1 = y0-1.13*exp(-zm/20);
    y2 = y0+1.13*exp(-zm/20);
    x = gpuArray.linspace(x1, x2, resolution_x);
    y = gpuArray.linspace(y1, y2, resolution_y);

    [xGrid, yGrid] = meshgrid(x,y); 
    c = complex(xGrid, yGrid);

    z = zeros(size(c), 'gpuArray');        % starts from z=0
    count = zeros(size(c), 'gpuArray');

    for i=1:maxIterations
        z = z.^2+c; 
        bw = abs(z)<R;
        count(bw) = i;
    end

    cla % Clear current axes
    imagesc(x, y, count);
    colormap("jet")
    set(gca,'YDir','normal');
    axis equal
    axis off
    colorbar
    set(gca, 'clim', [0 maxIterations]); % Set the limits of the colorbar
%     set(gca, 'units', 'normalized', 'position', [0 0 1 1]); % Full the gcf with the gca, so we can not see colorbar, xlabel, ylabel etc.
    drawnow 
    frames(fc) = getframe(gcf);
    fc = fc+1;
end
frames=[frames(2:end) frames(end:-5:2)];

% Write frames to .avi file
V = VideoWriter('mandelbrot_avi.avi');
open(V)
writeVideo(V, frames)
close(V) % DO NOT forget to close, otherwise, the .avi file could not be played
```

<br>

**References**

[1] [Mandelbrot set - Wikipedia](https://en.wikipedia.org/wiki/Mandelbrot_set).

[2] [GPU Code Generation: The Mandelbrot Set](https://ww2.mathworks.cn/help/gpucoder/gs/gpu-code-generation-the-mandelbrot-set.html). 

[3] [Illustrating Three Approached to GPU Computing: The Mandelbrot Set](https://ww2.mathworks.cn/help/parallel-computing/illustrating-three-approaches-to-gpu-computing-the-mandelbrot-set.html).

[4] [Mandelbrot set, animated zoom - File Exchange](https://ww2.mathworks.cn/matlabcentral/fileexchange/37813-mandelbrot-set-animated-zoom).

