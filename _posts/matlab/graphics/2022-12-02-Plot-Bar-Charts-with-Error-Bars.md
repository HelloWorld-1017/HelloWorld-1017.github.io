---
layout: single
title: Plot Bar Charts with Error Bars in MATLAB
date: 2022-12-02 00:03:01 +0800
categories: 
 - MATLAB
tags:
 - MATLAB Graphics
---

# Plot Bar Charts with Error Bars in MATLAB

在科研绘图中，带误差线的柱状图是常见的，如果想要使用MATLAB实现，需要一起使用`bar`函数和`errorbar`函数，官方给出了一个示例：[Bar Chart with Error Bars - MathWorks](https://ww2.mathworks.cn/help/matlab/creating_plots/bar-chart-with-error-bars.html)：

```matlab
x = 1:13;
data = [37.6 24.5 14.6 18.1 19.5 8.1 28.5 7.9 3.3 4.1 7.9 1.9 4.3]';
errhigh = [2.1 4.4 0.4 3.3 2.5 0.4 1.6 0.8 0.6 0.8 2.2 0.9 1.5];
errlow  = [4.4 2.4 2.3 0.5 1.6 1.5 4.5 1.5 0.4 1.2 1.3 0.8 1.9];

bar(x,data)                

hold on

er = errorbar(x,data,errlow,errhigh);    
er.Color = [0 0 0];                            
er.LineStyle = 'none';  

hold off
```

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20221201232609322.png?raw=true" alt="image-20221201232609322"  />

可以看到，这种方法的关键就是`bar`函数和`errorbar`函数的横坐标对齐。但是，当`bar`函数是多分类的情况怎么对齐呢？比如说，实现下面这样的图：

![image-20221201232814238](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20221201232814238.png?raw=true)

(图片来自文献 [2])

MATLAB官方并没有给出类似的示例。但是，知乎用户CoderMan提供了一种实现方式 [3]，其最核心的部分就是读取`bar`类变量的`XEndPoints`属性。基于这一点，本博客实现一下这种针对多分类的带有误差线的柱状图绘制。

```matlab
clc, clear, close all

x = categorical({'Class1', 'Class2'});
y = [10, 9; 7, 11];

errhigh_D1 = [2, 3];
errlow_D1 = [0.5, 0.5];
errhigh_D2 = [0.5, 0.5];
errlow_D2 = [3, 2];


figure
hold(gca, "on")
box(gca, "on")

% Plot bar for class1 and class2
b = bar(x, y);

% Plot errorbar for class1
err1 = errorbar(b(1).XEndPoints, y(:, 1), errlow_D1, errhigh_D1);
err1.Color = [0 0 0];                            
err1.LineStyle = 'none';  
err1.LineWidth = 1.5;

% Plot errorbar for class2
err2 = errorbar(b(2).XEndPoints, y(:, 2), errlow_D2, errhigh_D2);
err2.Color = [0 0 0];                            
err2.LineStyle = 'none';  
err2.LineWidth = 1.5;
legend("D1", "D2")
```

![image-20221202001308659](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20221202001308659.png?raw=true)

Bingo~ 

当然可以把上面的代码写成循环，但是这样的代码更具有可读性。

<br>

# Different types of values used for error bars

error bars值的选择并不是唯一的，用户可以有多种选择，但是需要首先说明它的含义。

R Graph Gallery提供了三种选择 [4]，分别是使用：Standard Deviation(SD)，Standard Error(SE)，和Confidence Interval(CI)。

![image-20221202113915392](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20221202113915392.png?raw=true)

都是一些比较常见的measure，详细的描述可以参见R Graph Gallery的官方文档：[Barplot with error bars - The R Graph Gallery](https://r-graph-gallery.com/4-barplot-with-error-bar.html). 

之所以想要查一下error bars值的含义，是因为在上面MATLAB提供的例子中，error bars的上下限是不一致的，不知道这个示例使用的是什么measure。可能像box plot一样使用了类似分位点的概念，也有可能这只是展示一下效果，因为我所见到的论文中上下限都是一致的。

<br>

**Reference**

[1] [Bar Chart with Error Bars - MathWorks](https://ww2.mathworks.cn/help/matlab/creating_plots/bar-chart-with-error-bars.html).

[2] Zhao M, Zhong S, Fu X, et al. Deep residual shrinkage networks for fault diagnosis[J]. IEEE Transactions on Industrial Informatics, 2019, 16(7): 4681-4690.

[3] CoderMan.[【2.2.2 带有误差线的柱状图】Matlab科研论文作图](https://zhuanlan.zhihu.com/p/349573334).

[4] [Barplot with error bars - The R Graph Gallery](https://r-graph-gallery.com/4-barplot-with-error-bar.html).

