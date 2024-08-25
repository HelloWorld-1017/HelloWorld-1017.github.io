---
layout: single
title: Position Settings of Figure and Axes in MATLAB
categories: 
 - MATLAB
tags: 
 - MATLAB Graphics
 - MATLAB App Building
date: 2022-06-23 09:06:32 +0800
last_modified_at0: 2022-06-23 09:06:32 +0800
last_modified_at1: 2024-03-14 11:55:56 +0800
last_modified_at: 2024-03-14 11:55:56 +0800
---

## Figure的位置和大小设定

```matlab
clc, clear, close all

left = 29;
bottom = 7;
width = 15;
height = 15;

fig = figure( ...
    'unit','centimeters', ... % sepcify units
    'position',[left, bottom, width, height], ... % specify UI figure position
    'Color', 'White', ... % speycify background color
    'Resize', false ...    % can not resize the UI figure
);
```

![pic_gcf](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/img/pic_gcf.png?raw=true)

<br>

## Axes的位置和大小设定

### `Position`属性

```matlab
clc, clear, close all

left = 29;
bottom = 7;
width = 15;
height = 15;

fig = figure( ...
    'unit','centimeters', ... % sepcify units
    'position',[left, bottom, width, height], ... % specify UI figure position
    'Color', 'White', ... % speycify background color
    'Resize', false ...    % can not resize the UI figure
); 

left = 3;
bottom = 3.5;
width = 10;
height = 10;

ax = axes('unit', 'centimeters', ... % sepcify units
    'Position',[left, bottom, width, height], ...% specify axes position
    'Color', [0.9,0.9,0.9] ... % sepcify background color
    );
```
<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/img/pic_gca.png?raw=true" alt="pic_gca" style="zoom:50%;" />

### `Position`属性和Axis limits属性、`DataAspectRatio`属性、`PlotBoxAspectRatio`属性的冲突


但是，设置好Axes对象的`Position`属性中的width和height，<font color='red'>在区域内绘制给定数据后</font>，区域大小会发生变化，区域的width和height并不是我们设置的值。这是因为Axes对象的`Position`属性和Axis limits属性(`XLim`, `YLim`, `ZLim`属性)、`DataAspectRatio`属性、`PlotBoxAspectRatio`属性三个属性之间发生了冲突。

**`Xlim`, `YLim`, `ZLim`属性**：分别指定坐标轴的x,y,z轴的坐标轴范围，例如：

```
set(gca, 'XLim', [0 10]) % 指定x轴的显示范围的最小值是0，最大值是10
set(gca, 'YLim', [0 5])  % 指定y轴的显示范围的最小值是0，最大值是5
```
![image-20220710123446605](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/img/image-20220710123446605.png?raw=true)

**`DataAspectRatio`属性**：沿每个轴的数据单位的相对长度，指定为[dx dy dz]形式的三元素向量，默认值是`[1,1,1]`。
 例如：

```matlab
 set(gca, 'DataAspectRatio', [1 2 1])  % 指定x轴上1个数据单位的长度与y轴上2个数据单元和z轴上1个数据单元的长度相同
```

![image-20220710123348436](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/img/image-20220710123348436.png?raw=true)

`PlotBoxAspectRatio属性`：指定每个轴的相对长度，指定为定义相对x轴、y轴和z轴比例因子的三元素向量[px py pz]，默认值是`[1,1,1]`。
 例如：

```matlab
 set(gca, 'PlotBoxAspectRatio', [1 3 1]) % 指定x轴、y轴、z轴的相对长度之比为1:3:1
```
![image-20220710123316228](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/img/image-20220710123316228.png?raw=true)

我们在指定`Position`属性和上述三个属性时（或者使用默认值时），如果不经过精确的计算，很多时候会发生冲突，这就导致了绘制数据后区域大小并不一定是`Position`属性中设置的值。但是MATLAB并不会报错，而是会自适应地调整设置。例如，如果用户指定了Axis limits，`DataAspectRatio`，`PlotBoxAspectRatio`，MATLAB就会忽略掉`PlotBoxAspectRatio`的设置，只使用用户所指定的Axis limits和`DataAspectRatio`。

<br>

**References**

[1] [Control UI figure appearance and behavior for uifigure-based apps - MathWorks](https://ww2.mathworks.cn/help/matlab/ref/matlab.ui.figureappd-properties.html).

[2] [Axes appearance and behavior - MathWorks](https://ww2.mathworks.cn/help/matlab/ref/matlab.graphics.axis.axes-properties.html).