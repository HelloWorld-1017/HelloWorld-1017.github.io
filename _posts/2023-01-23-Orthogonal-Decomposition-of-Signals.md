---
layout: single
title:  Orthogonal Decomposition of Signals
date: 2023-01-23 23:22:33 +0800
categories: 
 - Signals and Systems
---



# Orthogonal Decomposition of Vectors

二维空间中的任意一个向量$\vec{V}$都可以由两个**正交的（Orthogonal）**二维向量$\vec{e}_1$和$\vec{e}_2$线性表示，即：

$$
\vec{V}=\alpha_1\vec{e}_1+\alpha_2\vec{e}_2
$$

例如，对于下面的情形：

![image-20230122124026424](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230122124026424.png?raw=true)

我们可以列出方程组：

$$
\begin{bmatrix}\vec{e}_1&\vec{e}_2\end{bmatrix}\begin{bmatrix}\alpha_1\\\alpha_2\end{bmatrix}=\vec{V}
$$

即：

$$
\begin{bmatrix}2&-1\\1&2\end{bmatrix}\begin{bmatrix}\alpha_1\\\alpha_2\end{bmatrix}=\begin{bmatrix}2\\3\end{bmatrix}
$$

求解方程组可以得到：

$$
\begin{bmatrix}\alpha_1\\\alpha_2\end{bmatrix}=\begin{bmatrix}1.4\\0.8\end{bmatrix}
$$

除此之外，还有另一种视角来看待这个问题。

假如我们想用与$\vec{e}_1$成比例的矢量$\alpha_1\vec{e}_1$近似地表示$V$，则误差矢量可以定义为：

$$
\vec{V}_{e_1}=\vec{V}-\alpha_1\vec{e}_1
$$

如果我们想要使该误差矢量最小，就需要满足：

![image-20230122125020203](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230122125020203.png?raw=true)

$$
\vert\alpha_1\vec{e}_1\vert=\vert\vec{V}\vert\cos\theta_1\label{eq1}
$$

由式$\eqref{eq1}$可以得到：

$$
\alpha_1=\dfrac{\vert\vec{V}\vert\cos\theta_1}{\vert\vec{e}_1\vert}=\dfrac{\vert\vec{V}\vert{\vert\vec{e}_1\vert}\cos\theta_1}{\vert\vec{e}_1\vert{\vert\vec{e}_1\vert}}=\dfrac{\vec{V}\cdot\vec{e}_1}{\vec{e}_1\cdot\vec{e}_1}
$$

即：

$$
\alpha_1=\dfrac{(2,3)\cdot(2,1)}{(2,1)\cdot(2,1)}=\dfrac75=1.4
$$

$$
\alpha_2=\dfrac{(2,3)\cdot(-1,2)}{(-1,2)\cdot(-1,2)}=\dfrac45=0.8
$$

可以看到两种方式计算得到的$\alpha_1$和$\alpha_2$值是一样的。

这一结论可以推广至$n$维空间：$n$维空间中的任一矢量$\vec{V}$，可以精确地表示为$n$个正交矢量的线性组合，即：

$$
\vec{V}=\alpha_1\vec{e}_1+\alpha_2\vec{e}_2+\cdots+\alpha_r\vec{e}_r+\cdots+\alpha_n\vec{e}_n
$$

式中，$\vec{e}_i\cdot\vec{e}_j=0(i\ne j)$，第$r$个分量的系数为：

$$
\alpha_r=\dfrac{\vec{V}\cdot\vec{e}_r}{\vec{e}_r\cdot\vec{e}_r}\label{eqmain}
$$

注：需要注意的是，这里的分解一定是正交分解，即基向量是相互垂直的，如果两个基向量不垂直，则不能使用这样的方法。关于这一点的简单验证见文末的附录。
{: .notice--warning}

<br>

# Signal Decomposition

我们可以将矢量空间分解的这一见解推广至信号空间：在信号空间找到若干个**相互正交的信号**作为**基本信号**，使得信号空间中的任意信号均可表示成它们的**线性组合**。

## Orthogonal Signals (Functions)

在$(t_1,t_2)$区间的两个函数$\varphi_1(t)$和$\varphi_2(t)$，若满足：

$$
\int^{t_2}_{t_1}\varphi_1(t)\cdot\varphi^*_2(t)\mathrm{d}t=0
$$

即两函数的内积为0，则称函数（信号）$\varphi_1(t)$和$\varphi_2(t)$**在区间$(t_1,t_2)$内正交**。如果两个函数均为实函数，则两函数正交意味着：

$$
\int^{t_2}_{t_1}\varphi_1(t)\cdot\varphi_2(t)\mathrm{d}t=0
$$

注：两个函数（信号）的正交是指在一个区间内正交。
{: .notice--warning}

## Set of Orthogonal Function

若$n$个函数$\varphi_1(t)$，$\varphi_2(t)$，$\cdots$，$\varphi_n(t)$构成一个函数集，当这些函数在区间$(t_1,t_2)$内满足：

$$
\int^{t_2}_{t_1}\varphi_i(t)\cdot\varphi^*_j(t)\mathrm{d}t=\left\{
\begin{split}
&0,&i\ne j\\
&K_i\ne0,\ &i=j\\
\end{split}
\right.
$$

则称此函数集在区间$(t_1,t_2)$上的正交函数集。如果$K_i=1$，则称为是标准正交函数集。

## Complete Orthognoal System

如果在正交函数集$\{\varphi_1(t),\varphi_2(t),\cdots,\varphi_n(t)\}$之外，不存在任何函数$\varphi(t)$（$\varphi(t)$不恒等于0）满足：

$$
\int_{t_1}^{t_2}\varphi(t)\varphi_i^*(t)\mathrm{d}t=0\quad(i=1,2,\cdots,n)
$$

则称该函数集为完备正交函数集。

两组典型的在区间$(t_0,t_0+T)(T=2\pi/\Omega)$上的完备正交函数集：

- 三角函数集（实数集）：$\{1,\cos(n\Omega t), \sin(n\Omega t), \cdots\}(n=1,2,\cdots)$
- 虚指数函数集（复数集）：$\{\mathrm{e}^{\mathrm{j}n\Omega t}\}(n=0,\pm1,\pm2,\cdots)$

除此之外，还有一些其他的正交函数集：沃尔什(Walsh)函数集、勒让德多项式、切比雪夫多项式等等。

## Orthogonal Decomposition of Signals

（以实函数为例）类比于前文矢量正交分解，假设有$n$个函数$\varphi_1(t)$，$\varphi_2(t)$，$\cdots$，$\varphi_n(t)$在区间$(t_1,t_2)$构成一个正交函数空间。将任一函数$f(t)$用这$n$个正交函数的线性组合来近似，可表示为：

$$
f(t)\approx C_1\varphi_1(t)+\cdots+C_i\varphi_i(t)+\cdots+C_n\varphi_n(t)=\sum_{j=1}^nC_j\varphi_j(t)
$$

注：这里说“近似”是因为没有说这个正交函数集是一个“完备的”正交函数集。
{: .notice--warning}

则**均方误差（误差的方均根）**定义为：

$$
\bar{\varepsilon^2}=\dfrac1{t_2-t_1}\int_{t_1}^{t_2}[f(t)-\sum_{j=1}^nC_j\varphi_j(t)]^2\mathrm{d}t\label{eq4}
$$

为了使均方误差最小，则需要对于各系数的偏导数均为0：

$$
\begin{split}
&\dfrac{\partial\bar{\varepsilon^2}}{\partial C_j}=\dfrac{\partial}{\partial C_j}\dfrac1{t_2-t_1}[\int_{t_1}^{t_2}[f(t)^2+C_j^2\varphi_j^2(t)-2f(t)C_j\varphi_j(t)]\mathrm{d}t=0\\
\Rightarrow&\dfrac{\partial}{\partial C_j}\int_{t_1}^{t_2}[C_j^2\varphi_j^2(t)-2f(t)C_j\varphi_j(t)]\mathrm{d}t=0
\end{split}
$$

互换积分与微分次序，有：

$$
2C_j\int_{t_1}^{t_2}\varphi_j^2(t)\mathrm{d}t=2\int_{t_1}^{t_2}f(t)\varphi_j(t)\mathrm{d}t
$$

进而可以得到：

$$
C_j=\dfrac{\int_{t_1}^{t_2}f(t)\varphi_j(t)\mathrm{d}t}{\int_{t_1}^{t_2}\varphi_j^2(t)\mathrm{d}t}=\dfrac{1}{K_j}\int_{t_1}^{t_2}f(t)\varphi_j(t)\mathrm{d}t\label{eq5}
$$


将系数$\eqref{eq5}$带入到均方误差$\eqref{eq4}$中，有：

$$
\begin{split}
\bar{\varepsilon^2}&=\dfrac1{t_2-t_1}\int_{t_1}^{t_2}[f(t)-\sum_{j=1}^nC_j\varphi_j(t)]^2\mathrm{d}t\\
&=\dfrac1{t_2-t_1}\int_{t_1}^{t_2}[f^2+\sum C_j^2\varphi_j^2-2f\sum C_j\varphi_j]\mathrm{d}t\\
&=\dfrac{1}{t_2-t_1}[\int_{t_1}^{t_2}f^2\mathrm{d}t+\sum C_j^2\int_{t_1}^{t_2}\varphi_j^2\mathrm{d}t-2\sum C_j \int_{t_1}^{t_2} f\varphi_j\mathrm{d}t]\\
&=\dfrac{1}{t_2-t_1}[\int_{t_1}^{t_2}f^2\mathrm{d}t+\sum C_j^2K_j-2\sum C_j K_jC_j]\\
&=\dfrac{1}{t_2-t_1}[\int_{t_1}^{t_2}f^2\mathrm{d}t-\sum C_j^2K_j]
\end{split}\label{eq3}
$$

式$\eqref{eq3}$中，$C_j^2>0$且$K_j>0$。因此，随着$n$的增大，均方误差$\bar{\varepsilon^2}$逐渐减小，当$n\rightarrow\infty$时，即用完备正交函数集近似时，均方误差为0.

总结上文的推导，我们可以得到：

任意信号$f(t)$可以表示为无穷多个正交函数之和：

$$
f(t)=C_1\varphi_1(t)+\cdots+C_i\varphi_i(t)+\cdots=\sum_{i=1}^\infty C_i\varphi_i(t)
$$

上式称为信号的正交展开式，也称为广义傅里叶级数（Generalized Fourier series）。

$C_i$称为广义傅里叶系数：

- 在实变函数下，有：

  $$
  C_i=\dfrac{\int_{t_1}^{t_2}f(t)\varphi_i(t)\mathrm{d}t}{\int_{t_1}^{t_2}\varphi_i^2(t)\mathrm{d}t}=\dfrac{1}{K_i}\int_{t_1}^{t_2}f(t)\varphi_i(t)\mathrm{d}t
  $$
  
- 在复变函数下，有：
- 
  $$
  C_i=\dfrac{\int_{t_1}^{t_2}f(t)\varphi_i^*(t)\mathrm{d}t}{\int_{t_1}^{t_2}\varphi_i(t)\varphi_i^*(t)\mathrm{d}t}=\dfrac{1}{K_i}\int_{t_1}^{t_2}f(t)\varphi_i^*(t)\mathrm{d}t
  $$



## Parseval's theorem

之前根据式$\eqref{eq3}$推出，当正交函数集完备时，均方误差为0，进而可以得到：

$$
\int_{t_1}^{t_2}f^2(t)\mathrm{d}t=\sum_{j=1}^\infty C_j^2K_j
$$

即：

$$
\int^{t_2}_{t_1}f^2(t)\mathrm{d}t=\sum^{\infty}_{j=1}\int^{t_2}_{t_1}[C_j\varphi_j(t)]^2\mathrm{d}t
$$

上式左侧表示信号的能量，右侧表示各正交分量能量之和。因此，该式表明，在区间$(t_1,t_2)$内，信号$f(t)$所含有的能量恒等于此信号在**完备正交函数集**中各正交分量能量之和（也表明信号在时域和频域内的能量相等），即能量守恒定理，也称为帕斯瓦尔定理**（Parseval's theorem）**。

<br>

# Appendix

二维空间中的任意一个向量$\vec{V}$都可以由两个线性无关的二维向量$\vec{e}_1$和$\vec{e}_2$线性表示，即：

$$
\vec{V}=\alpha_1\vec{e}_1+\alpha_2\vec{e}_2
$$

$\vec{e}_1$和$\vec{e}_2$并不是必要条件，例如，对于下面的分解：

![image-20230123230359066](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230123230359066.png?raw=true)

我们可以列出方程组：

$$
\begin{bmatrix}\vec{e}_1&\vec{e}_2\end{bmatrix}\begin{bmatrix}\alpha_1\\\alpha_2\end{bmatrix}=\vec{V}
$$

即：

$$
\begin{bmatrix}1&2\\2&1\end{bmatrix}\begin{bmatrix}\alpha_1\\\alpha_2\end{bmatrix}=\begin{bmatrix}2\\3\end{bmatrix}
$$

易得：

$$
\begin{bmatrix}\alpha_1\\\alpha_2\end{bmatrix}=\begin{bmatrix}1.33\\0.33\end{bmatrix}
$$

假如我们想要使用上文的方法，即从误差最小的角度求解出系数，则根据式$\eqref{eqmain}$有：

$$
\alpha_1=\dfrac{(2,3)\cdot(1,2)}{(1,2)\cdot(1,2)}=\dfrac85=1.6
$$

$$
\alpha_2=\dfrac{(2,3)\cdot(2,1)}{(2,1)\cdot(2,1)}=\dfrac75=1.4
$$

很明显，这种方法算出的结果是错误的。

<br>

**References**

[1] [信号与线性系统分析 吴大正 郭宝龙 - bilibili](https://www.bilibili.com/video/BV16E411E7PA/?spm_id_from=333.337.search-card.all.click)



