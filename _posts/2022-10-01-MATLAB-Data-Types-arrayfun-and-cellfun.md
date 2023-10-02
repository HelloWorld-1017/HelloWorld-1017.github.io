---
layout: single
title: Structure + `arrayfun` Function, Cell + `cellfun` Function(MATLAB Data Types)
date: 2022-10-01 20:42:19 +0800
categories: 
 - MATLAB
tags:
 - MATLAB Graphics
 - MATLAB Language Fundamentals
---

# MATLAB Data Types

学习一门编程语言，在最开始的时候一般都会学习这门语言的数据结构(Data structure)，或者说是数据类型(Data types)。根据所要解决的问题选择一个比较合理的数据类型，可以使处理过程变得高效和简洁，因此数据结构的学习和使用是很重要的一个步骤，也是很容易忽视的一个部分。

MATLAB支持的基本数据类型可以在[Data Types - MathWorks](https://ww2.mathworks.cn/help/matlab/data-types.html)查到：

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20221001203128671.png?raw=true" alt="image-20221001203128671" style="zoom:67%;" />

<br>

# Structures + `arrayfun` Function

Structures和`arrayfun`函数的使用可以快速地处理相同类型的问题，非常符合MATLAB本身向量化编程的特性。

例如，[arrayfun - MathWorks](https://ww2.mathworks.cn/help/matlab/ref/arrayfun.html)官方文档中提供的一个绘图的例子：

```matlab
clc, clear, close all
rng("default")

% Create a structure array in which each structure has two fields containing numeric arrays.
S(1).X = 5:5:100; S(1).Y = rand(1, 20);
S(2).X = 10:10:100; S(2).Y = rand(1, 10);
S(3).X = 20:20:100; S(3).Y = rand(1, 5);

% Plot the numeric arrays
figure
hold(gca, "on")
grid(gca, "on")
box(gca, "on")
p = arrayfun(@(a) plot(a.X, a.Y), S);
p(1).Marker = 'o';
p(2).Marker = '+';
p(3).Marker = 's';
```

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20221001204024432.png?raw=true" alt="image-20221001204024432" style="zoom:50%;" />

<br>

# Cell + `cellfun` Function

同样地，上述问题也可以使用Cell和`cellfun`的组合进行解决：

```matlab
clc, clear, close all

X = {5:5:100, 10:10:100, 20:20:100};
Y = {rand(1,20), rand(1,10), rand(1,5)};

figure
hold(gca, "on")
grid(gca, "on")
box(gca, "on")
p = cellfun(@plot, X, Y);
p(1).Marker = 'o';
p(2).Marker = '+';
p(3).Marker = 's';
```

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20221001205111116.png?raw=true" alt="image-20221001205111116" style="zoom: 67%;" />

<br>

**参考**

[1] [Data Types - MathWorks](https://ww2.mathworks.cn/help/matlab/data-types.html)

[2] [arrayfun - MathWorks](https://ww2.mathworks.cn/help/matlab/ref/arrayfun.html)

[3] [cellfun - MathWorks](https://ww2.mathworks.cn/help/matlab/ref/cellfun.html).