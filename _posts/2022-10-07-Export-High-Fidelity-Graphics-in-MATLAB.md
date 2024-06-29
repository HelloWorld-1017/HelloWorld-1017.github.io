---
layout: single
title: Export High Fidelity Graphics in MATLAB
date: 2022-10-07 22:35:31 +0800
categories: 
 - MATLAB
tags:
 - MATLAB Graphics
toc: false
---

之前在使用MATLAB绘制的图像的时候，一般会采用直接复制的方式：

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20221007222601167.png" alt="image-20221007222601167" style="zoom:50%;" />

或者使用`saveas`函数。

但是在R2020a以后的版本，MATLAB提供了一个更全面的函数`exportgraphics`用于输出图片，可以指定图片的尺寸，像素，背景色，文件格式等设置：[Save Figure with Specific Size, Resolution, or Background Color - MathWorks](https://ww2.mathworks.cn/help/matlab/creating_plots/save-figure-at-specific-size-and-resolution.html)。

运行下面的代码：

```matlab
clc, clear, close all

x = 1:0.1:4;
y = x.^2;

fileFormats = [".jpg?raw=true", ".tif"];
resolutions = [300, 600, 900, 1000, 2400];
for i = 1:numel(fileFormats)
    for j = 1:numel(resolutions)
        figure
        plot(x, y, 'Marker', 'o', LineWidth=1.5)
        title(strcat("Resolution: ", num2str(resolutions(j)), ", File Format: ", fileFormats(i)))
        box on
        exportgraphics(gcf, strcat("pic", num2str(resolutions(j)), fileFormats(i)), 'Resolution', resolutions(j))
    end
end
```

可以导出不同像素的`.jpg`和`.tif`格式的图像：

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20221007223239242.png?raw=true" alt="image-20221007223239242" style="zoom:50%;" />

将它们导入到word中，之后另存为PDF文件，可以看到它们之间细微的差别。2400 dpi的图像在细节方面的确表现得更优秀。

<br>

另外，MATLAB还提供了另外一个`copygraphics`函数，用于将图片复制到粘贴板中，其参数设置和`exportgraphics`函数是一致的：[copygraphics - MathWorks](https://ww2.mathworks.cn/help/matlab/ref/copygraphics.html).

<br>

**Reference**

[1] [Save Figure with Specific Size, Resolution, or Background Color - MathWorks](https://ww2.mathworks.cn/help/matlab/creating_plots/save-figure-at-specific-size-and-resolution.html).

[2] [exportgraphics - MathWorks](https://ww2.mathworks.cn/help/matlab/ref/exportgraphics.html).

[3] [copygraphics - MathWorks](https://ww2.mathworks.cn/help/matlab/ref/copygraphics.html).

