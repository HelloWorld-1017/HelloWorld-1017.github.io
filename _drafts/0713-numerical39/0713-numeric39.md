

>  当使用有限精度的计算机内存来表示真实、无穷精度数字的时候，舍入误差不可避免。尽管我们希望在长的计算中生成的较小的误差对于结果仅有较小的影响，但是事实表明在很多情况下仅仅是一厢情愿。简单算法，诸如高斯消去或者微分方程的求解方法，能够把极微小的误差放大到极大的规模。事实上，本书的一个主要议题就是使读者*<u>意识到</u>*：**由于计算机所造成的小误差使得计算面临不可靠的危险，并且要知道如何避免或最小化这样的危险**。[1]

数值分析的一个目标是在给定的精度级别中估计结果。使用双精度意味着我们使用52位精度（大约16位十进制数字）来保存和操作数字。

但是，用计算机计算得到的答案总能有16位 *正确的* 有效数字吗？答案是否定的：利用双精度的计算机不能得到16位正确的有效数字，即便使用最好的算法。



# 前言

这篇文章中的示例和思想均来自XXX的《数值分析》，我尝试基于 MATLAB 来实现和验证这些思想和见解。但是，在使用计算机进行实现的过程中，我并没有得到作者所述的现象。我尝试解释一下其中的原因，先写在前面。





根据二分法的误差上限和迭代次数之间的关系：

XX

精确到小数点后几位的定义：

XX



作者试图通过一个使用二分法寻找非线性方程的根的实例，说明……。











# 前向与后向误差

## 算例

使用二分法计算函数 
$$
f(x)=x^3-2x^2+\dfrac43x-\dfrac8{27} \label{eq1}
$$

的根，精确到小数点后6位。

## 分析

容易验证，式 $\eqref{eq1}$ 的函数 $f(x)$ 可以化简为 $f(x) = (x-\dfrac23)^2$，$x=\dfrac23$ 是函数的三重根。函数图像如下图所示：

<img src="https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/img/image-20220714132122813.png" style="zoom:67%;" />

```matlab
% MATLAB script
clc, clear, close all

% Plot function curve
a = 0.4; b = 1;
x = a:0.01:b;
y = (x-2/3).^3;

LineWidth = 1.7;
Interpreter = 'latex';
plot(x, y, LineWidth=LineWidth), hold on
hline = plot([a, b],[0, 0], ...
    'LineStyle','--', ...
    LineWidth=LineWidth,...
    Color="#7F7F7F"...
    ); hold on
scatter(2/3, 0, 57, 'filled', MarkerFaceColor=[200, 92, 92]/255)
xlabel('$x$', Interpreter=Interpreter)
ylabel('$f(x)$', Interpreter=Interpreter)
title('Function curve')
```





在区间 $[0,1]$ 内使用二分法寻找方程的根，可以得到算法的收敛过程图：




> 理应