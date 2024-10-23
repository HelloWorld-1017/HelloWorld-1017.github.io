---
title: A Way to Generate A Colormap in MATLAB
toc: false
categories: 
 - MATLAB
 - Design
tags:
 - MATLAB Graphics
date: 2022-11-19 22:34:33 +0800
last_modified_at: 2024-09-06 07:05:14 +0800
---


前两天看到了一个很漂亮、很有启发性的关于使用MATLAB生成色卡的工作。该工作来自slandarer，实现原理和代码都记录在他的CSDN博客中[^1]。

提取图片颜色及生成色卡的代码如下：

```matlab
clc, clear, close all

% Read image
pic = imread('test.jpg');

% The number of colors in colormap
colorNum = 8;

Rchannel = pic(:, :, 1);
Gchannel = pic(:, :, 2);
Bchannel = pic(:, :, 3);
RGBarray = double([Rchannel(:), Gchannel(:), Bchannel(:)]);

% k-means cluster
[idx, Centers] = kmeans(RGBarray, colorNum, ...
    'Distance', 'sqeuclidean', 'MaxIter', 1000);
Centers = round(Centers);

figure("Units", "pixels", "Position", [492.33, 324.33, 1472, 674])
tiledlayout(1, 2)

nexttile
imshow(pic)

nexttile
view(3)
hold(gca, "on")
grid(gca, "on")
box(gca, "on")
for i = 1:colorNum
    scatter3(RGBarray(idx==i, 1), RGBarray(idx==i, 2), RGBarray(idx==i, 3), ...
        'filled', 'CData', Centers(i,:)./255);
    legends{i}=[num2str(Centers(i,1)), ' ', num2str(Centers(i,2)), ' ', num2str(Centers(i,3))];
end
legend(legends, 'Color', [0.9412    0.9412    0.9412], ...
    'FontName','Cambria', 'LineWidth', 0.8, 'FontSize', 11)
ax = gca;
ax.GridLineStyle = '--';
ax.LineWidth = 1.2;

ax.XLabel.String = 'R channel';
ax.XLabel.FontSize = 13;
ax.XLabel.FontName = 'Cambria';

ax.YLabel.String = 'G channel';
ax.YLabel.FontSize = 13;
ax.YLabel.FontName = 'Cambria';

ax.ZLabel.String = 'B channel';
ax.ZLabel.FontSize = 13;
ax.ZLabel.FontName = 'Cambria';

exportgraphics(gcf, "pic.png")
```

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/pic.png?raw=true" style="zoom:67%;" />

聚类中心对应的色卡，可以修改变量`colorNum`以改变色卡中颜色的数量。

<div class="notice--primary" markdown="1">

图像中的三维散点就是图片中对应的像素点的值：

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20221119214152915.png?raw=true" style="zoom:67%;" />

但是它们的颜色都是一样的，都是聚类中心点的颜色，从下面的代码片段可以看出这一点：

```matlab
...
for i = 1:colorNum
 scatter3(RGBarray(idx==i, 1), RGBarray(idx==i, 2), RGBarray(idx==i, 3), ...
     'filled', 'CData', Centers(i,:)./255);
...
```

另一方面，我们可以将其修改为显示像素本身的颜色：

<div id="script"></div>

```matlab
...
for i = 1:colorNum
 scatter3(RGBarray(idx==i, 1), RGBarray(idx==i, 2), RGBarray(idx==i, 3), ...
     'filled', 'CData', RGBarray(idx==i, :)./255);
...
end
```

![pic_2](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/img/pic_2.png?raw=true)

</div>

然而，这种生成色卡方式仍然具有一定的局限性，原因在于代码中使用了机器学习算法k-means寻找中心点，而机器算法是依赖于数据量的。例如，我简单画了一个图像，图像中只有纯白色、纯黑色、纯红色、纯蓝色、纯绿色：

<div id="fig"></div>

![test1](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/test1.jpg?raw=true)

按照具有5个聚类中心点提取出的结果如下：

![pic1](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/pic1.png?raw=true)

可以看到，色卡中黑色的RGB值没有误差，这是因为这张图片中黑色的像素点是最多的；而其他四种颜色的RGB值与理论值都有或多或少的误差。

但是，这样的RGB实际值与理论值之间的误差也可能是图片本身所造成的，并且很有可能是这个原因。

我们在使用绘图软件作图时会指定一些颜色，不同的绘图软件会采用不同的算法渲染图像并导出（考虑到分辨率设置 etc.）。我绘制[上述图像](#fig)时就仅仅使用了五种确定的颜色，因此理论上所有的像素点在RGB三维空间中应该只重合为5个点，但实际上我们可以看到它们并没有那么集中——使用上述展示单个像素点颜色的[代码](#script)进行可视化，可以更明显地观察到这一点：

![pic1_2](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/img/pic1_2.png?raw=true)

虽然有一些的局限性，但是瑕不掩瑜，这仍然是一个很好的色卡生成方法，上述的误差是可以接受的。只要我们看着右边的图像感觉到和谐美观，那么我们就可以将其作为一个色卡，可以不必理会人眼无法识别的差异。但是，假如我们设计一种色卡并且想要从科学或者量化的角度解释它为什么是美观的，那就是另外一回事了。

<br>

**References**

[^1]: [还在纠结配色问题？手把手教你用MATLAB一键生成高质量色卡 - slandarer](https://slandarer.blog.csdn.net/article/details/119056214).

