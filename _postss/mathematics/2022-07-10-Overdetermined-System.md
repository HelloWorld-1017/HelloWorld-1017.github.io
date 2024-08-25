---
layout: single
title: Solve Over-determined Equations
date: 2022-07-10 15:29:33 +0800
categories: 
 - Mathematics
tags: 
  - Matrix 
---

# 超定方程组的定义

根据维基百科对于超定方程组的定义：

> **Overdetermined system** [[2]](#ref)
>
> In mathematics, a **system of equations is considered overdetermined** if there are more equations than unknowns. An overdetermined system is almost always inconsistent (it has no solution) when constructed with random coefficients. However, an overdetermined system will have solutions in some cases, for example if some equation occurs several times in the system, or if some equations are linear combinations of the others.
> The terminology can be described in terms of the concept of **constraint counting**. Each unknown can be seen as an available degree of freedom. Each equation introduced into the system can be viewed as a constraint that restricts one degree of freedom. Therefore, the critical case occurs when the number of equations and the number of free variables are equal. For every variable giving a degree of freedom, there exists a corresponding constraint. The overdetermined case occurs when the system has been overconstrained — that is, when the equations outnumber the unknowns. In contrast, the underdetermined case occurs when the system has been underconstrained — that is, when the number of equations is fewer than the number of unknowns. Such systems usually have an infinite number of solutions.

可知：

（1）超定方程组的概念并没有限定是线性方程组，涉及范围更广的非线性方程组同样也有超定方程组的概念；

（2）超定方程组的定义只是定义了：方程个数大于未知数的个数就是超定方程组。因此，超定方程组和方程组有解并没有必然的联系；

（3）超定方程组通常是不存在解的，但是有一些例外的情况。例如，超定方程组的一些方程存在线性关系，或者其中一些方程是另一些方程的线性组合；

（4）超定的概念重点在于强调约束的数量，以及和自由度之间比较，并不强调超过自由度数量的约束是否“有效”。

<br>

# 线性超定方程的求解

## 求解公式

根据超定方程的定义，超定方程可以存在精确解，也可以不存在精确解，只存在近似解。而我们可以使用一种通用的计算方法，使我们面对存在精确解的超定方程可以求出**精确解**，面对不存在精确解的超定方程**求出一个在向量范数意义下的一个"最好的"近似解**。

> 超定方程的求解 [[1]](#ref)
>
> 假设 $A$ 是一个形状为 $n\times m$ 的矩阵，并且 $n>m$ （超定）, $\mathrm{rank}(A)=m$，则对于超定方程组$A\boldsymbol{x}=\boldsymbol{b}$ 
>
> （1）如果存在精确解，那么可以用下面的计算式得到精确解：
> 
> $$
A\boldsymbol{x}=\boldsymbol{b}\quad\Rightarrow\quad \boldsymbol{x}=(A^TA)^{-1}A^T\boldsymbol{b}=A^{+} \boldsymbol{b}\label{equa1}
> $$
> 
> 其中，$A^+=(A^TA)^{-1}A^T$ 称为矩阵 $A$ 的伪逆；
>
> （2）如果不能存在精确解，则可以得到一个近似解：
> 
> $$
> A\boldsymbol{x}=\boldsymbol{b}\quad\Rightarrow\quad \boldsymbol{x}_{min}=A^{+} \boldsymbol{b}\label{equa2}
> $$
> 
> $\boldsymbol{x}_{min}$ 由最小化 $\vert\vert A\boldsymbol{x}-\boldsymbol{b}\vert\vert^2$ （向量范数的平方，通常取二范数）得到的近似解。

（1）对于第一种情况

设有超定方程组 $A\boldsymbol{x}=\boldsymbol{b}$ ，假设

$$
A=\begin{bmatrix}1&1\\1&2\\1&1\end{bmatrix},\quad \boldsymbol{b}=\begin{bmatrix}5\\8\\5\end{bmatrix}\notag
$$

则容易得到 $\mathrm{rank}(A)=2=m$，方程组存在精确解 $\boldsymbol{x}=[2,3]^T$。

另一方面，可以计算得到

$$
A^T=\begin{bmatrix}1&1&1\\1&2&1\end{bmatrix},\quad A^TA=\begin{bmatrix}3&4\\4&6\end{bmatrix},\quad
(A^TA)^{-1}=\begin{bmatrix}3&-2\\-2&1.5\end{bmatrix}\notag
$$

于是根据公式$\eqref{equa1}$可以得到

$$
\boldsymbol{x}=(A^TA)^{-1}A^T\boldsymbol{b}=\begin{bmatrix}3&-2\\-2&1.5\end{bmatrix}\begin{bmatrix}1&1&1\\1&2&1\end{bmatrix}\begin{bmatrix}5\\8\\5\end{bmatrix}=\begin{bmatrix}2\\3\end{bmatrix}\notag
$$

与我们的预期一致，依据公式$\eqref{equa1}$得到了方程的精确解。

（2）对于第二种情况

实际上，公式 $\eqref{equa2}$ 可以从超定方程组求解的几何意义上推导出，并且与最小二乘法存在着紧密的联系，相关内容可参考博客 [[3]](#ref)。



## 注意超定方程系数矩阵的秩

值得注意的是，上述超定方程的求解方法中的另一个条件 $\mathrm{rank}(A)=m$ ，即系数矩阵的秩和向量的个数相同。这意味着，当超定方程组系数矩阵的秩 $\mathrm{rank}(A)<m$ 时，即当超定方程组所对应的齐次线性方程组 $A\boldsymbol{x}=\boldsymbol{0}$时有无穷多解时，该通用公式不能使用。

例如，假设有超定方程组 $A\boldsymbol{x}=\boldsymbol{b}$ ，且

$$
A=\begin{bmatrix}1&1\\1&1\\1&1\end{bmatrix},\quad \boldsymbol{b}=\begin{bmatrix}2\\3\\4\end{bmatrix}\notag
$$

$\mathrm{rank}(A)=1<m$，则有

$$
A^T=\begin{bmatrix}1&1&1\\1&1&1\end{bmatrix},\quad A^TA=\begin{bmatrix}3&3\\3&3\end{bmatrix}\notag
$$

可以看到，矩阵 $A^TA$ 的逆不存在，因此不能使用求解公式。这时候，我们只能使用最小二乘法来得到近似解。

$$
\begin{align}
&\arg\min\limits_{\boldsymbol{x}}\vert\vert A\boldsymbol{x}-\boldsymbol{b}\vert\vert^2_2\notag \\
=&\arg\min\limits_{\boldsymbol{x}}\vert\vert\begin{bmatrix}x_1+x_2\\x_1+x_2\\x_1+x_2\end{bmatrix}-\begin{bmatrix}2\\3\\4\end{bmatrix}\vert\vert_2^2\notag \\
=&\arg\min\limits_{\boldsymbol{x}}\Big[(x_1+x_2-2)^2+(x_1+x_2-3)^2+(x_1+x_2-4)^2\Big]\notag \\
=&\arg\min\limits_{\boldsymbol{x}}\Big[(A\boldsymbol{x}-\boldsymbol{b})^T(A\boldsymbol{x}-\boldsymbol{b})\Big]\notag \\
=&\arg\min\limits_{\boldsymbol{x}}(\boldsymbol{x}^TA^TA\boldsymbol{x}-2\boldsymbol{x}^TA^T\boldsymbol{b}+\boldsymbol{b}^T\boldsymbol{b})\label{minLoss}
\end{align}
$$

$$
\begin{align}
&\dfrac{\partial L(\boldsymbol{x})}{\partial \boldsymbol{x}}=2A^TA\boldsymbol{x}-2A^T\boldsymbol{b}=0\notag \\
\Rightarrow&A^TA\boldsymbol{x}=A^T\boldsymbol{b}\label{equa3}
\end{align}
$$

事实上，如果矩阵 $A^TA$ 可逆，就可以推出公式 $\eqref{equa2}$ 。

公式 $\eqref{equa3}$ 对应的线性方程为：

$$
\begin{bmatrix}3&3\\3&3\end{bmatrix}\begin{bmatrix}x_1\\x_2\end{bmatrix}=\begin{bmatrix}9\\9\end{bmatrix}\label{equa4}
$$

线性方程组 $\eqref{equa4}$ 实际上有无穷多解，即最小二乘法损失函数 $L(\boldsymbol{x})$ 有无穷多个极小值，并且都落在直线 $x_1+x_2=3$ 上。如下图所示：

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220711183217117.png?raw=true" alt="image-20220711183217117" style="zoom:50%;" />

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220711183229158.png?raw=true" alt="image-20220711183229158" style="zoom:50%;" />

```matlab
clc, clear, close all
% Plot loss function
range = -10:.1:10;
[x_1, x_2] = meshgrid(range, range);
L = (x_1+x_2-2).^2 + (x_1+x_2-3).^2 + (x_1+x_2-4).^2;
mesh(x_1, x_2, L)
xlabel("x_1"), ylabel("x_2"), zlabel("L")
xlim([-10, 10]), ylim([-10, 10]), zlim([-1, 1e3]) % necessary, if use view function after

% Plot solutions
x_1 = range;
x_2 = 3-x_1;
hold on
plot(x_1, x_2, LineWidth=4.0, Color='r')
view(64,30.34)
saveas(gca, 'pic1.svg')
view(47,1)
saveas(gca, 'pic2.svg')
```

综上，对于线性超定方程组，如果矩阵 $A^TA$ 可逆，则我们可以通过求解公式来求得方程组的精确解或者近似解；如果矩阵 $A^TA$ 不可逆，那么我们可以直接求解式 $\eqref{equa3}$ 所对应的线性方程组。

## 非线性超定方程组的求解

最后，仍需要强调的是，以上的解析求解过程只对**线性**方程组成立。当超定方程组为非线性方程时，不存在类似的解法。但是最小二乘法是仍然可以使用，即转换为优化问题

$$
\arg\min\limits_{\boldsymbol{x}}\vert\vert\boldsymbol{b}-f(\boldsymbol{x})\vert\vert^2\label{NLP}
$$

来求解 $\boldsymbol{x}$ 仍然是成立的，但是很难通过令偏导等于零或者简单求解类似于式 $\eqref{equa3}$ 的方程组（同样很难求解）来直接求得方程组的解，更多是使用梯度下降法等数值算法，或者使用遗传算法等启发式算法求解优化问题 $\eqref{NLP}$，当然，全局最优解是很难求得的。

<br>

<div id="ref"></div>

**References**

[1] [Matrix Cookbook](https://www.math.uwaterloo.ca/~hwolkowi/matrixcookbook.pdf). 

[2] [Overdetermined system - Wikipedia](https://en.wikipedia.org/wiki/Overdetermined_system).

[3] [Inspect the Least Square Method from Perspective of Curve Fitting, Parameter Estimation, and Geometry View of Solving Over-determined Equations - What a starry night~](https://helloworld-1017.github.io/2022-07-07/15-36-27.html).
