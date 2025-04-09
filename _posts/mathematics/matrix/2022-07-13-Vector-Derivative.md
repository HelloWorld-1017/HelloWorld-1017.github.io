---
title: Vector Derivative
categories: 
 - Mathematics
tags: 
 - Matrix
 - Mathematical Analysis
date: 2022-07-14 17:45:25 +0800
last_modified_at: 2025-04-08 21:54:51 +0800
---

# 标量对向量求导

## 标量对向量求导

设 $f(x_1, \cdots, x_n)$ 是包含 $n$ 个变量 $(x_1,\cdots,x_n)$ 的**标量函数**，则函数 $f$ 的梯度是**向量函数**：

$$
\nabla f(x_1,\cdots, x_n)=\begin{bmatrix}f_{x_1},\cdots,f_{x_n}\end{bmatrix}
$$

其中，$f_{x_i}$ 表示标量函数 $f$ 对变量 $x_i$ 的偏导数。



## 向量点积法则

设有 $u(x_1,\cdots, x_n)$，$v(x_1,\cdots,x_n)$ 均为包含 $n$ 个变量 $(x_1,\cdots,x_n)$ 的**标量函数**，并且都具有 $m$ 个分量，分别为$u_1,\cdots,u_n$ 和 $v_1,\cdots,v_n$ 。则有向量点积法则 

$$
\nabla(u^Tv)=v^TDu+u^TDv\label{eq1}
$$

其中，$ D(\cdot)$ 表示向量函数 $(\cdot)$ 的雅可比矩阵，见公式 $\eqref{jacobianmatrix}$。 



**证明**

假设向量函数 $u$ 和 $v$ 都是具有3个分量的向量函数，均包含2个自变量

$$
\begin{align*}
\nabla(u^Tv)&=\nabla(u_1v_1+u_2v_2+u_3v_3)\\
&=\begin{bmatrix}\dfrac{\partial(u_1v_1+u_2v_2+u_3v_3)}{\partial x_1}&\dfrac{\partial(u_1v_1+u_2v_2+u_3v_3)}{\partial x_2}\end{bmatrix}\\
&=\begin{bmatrix}
(\dfrac{\partial u_1}{\partial x_1}v_1+\dfrac{\partial v_1}{\partial x_1}u_1)+
(\dfrac{\partial u_2}{\partial x_1}v_2+\dfrac{\partial v_2}{\partial x_1}u_2)+
(\dfrac{\partial u_3}{\partial x_1}v_3+\dfrac{\partial v_1}{\partial x_1}u_3)&
(\dfrac{\partial u_1}{\partial x_2}v_1+\dfrac{\partial v_1}{\partial x_2}u_1)+
(\dfrac{\partial u_2}{\partial x_2}v_2+\dfrac{\partial v_2}{\partial x_2}u_2)+
(\dfrac{\partial u_3}{\partial x_2}v_3+\dfrac{\partial v_1}{\partial x_2}u_3)
\end{bmatrix}\\
&=\begin{bmatrix}
\begin{bmatrix}
v_1&v_2&v_3
\end{bmatrix}
\begin{bmatrix}
\dfrac{\partial u_1}{\partial x_1}\\
\dfrac{\partial u_2}{\partial x_1}\\
\dfrac{\partial u_3}{\partial x_1}
\end{bmatrix}+\begin{bmatrix}
u_1&u_2&u_3
\end{bmatrix}
\begin{bmatrix}
\dfrac{\partial v_1}{\partial x_1}\\
\dfrac{\partial v_2}{\partial x_1}\\
\dfrac{\partial v_3}{\partial x_1}
\end{bmatrix}&
\begin{bmatrix}
v_1&v_2&v_3
\end{bmatrix}
\begin{bmatrix}
\dfrac{\partial u_1}{\partial x_2}\\
\dfrac{\partial u_2}{\partial x_2}\\
\dfrac{\partial u_3}{\partial x_2}
\end{bmatrix}+\begin{bmatrix}
u_1&u_2&u_3
\end{bmatrix}
\begin{bmatrix}
\dfrac{\partial v_1}{\partial x_2}\\
\dfrac{\partial v_2}{\partial x_2}\\
\dfrac{\partial v_3}{\partial x_2}
\end{bmatrix}
\end{bmatrix}\\
&=\begin{bmatrix}
\begin{bmatrix}
v_1&v_2&v_3
\end{bmatrix}
\begin{bmatrix}
\dfrac{\partial u_1}{\partial x_1}\\
\dfrac{\partial u_2}{\partial x_1}\\
\dfrac{\partial u_3}{\partial x_1}
\end{bmatrix}&
\begin{bmatrix}
v_1&v_2&v_3
\end{bmatrix}
\begin{bmatrix}
\dfrac{\partial u_1}{\partial x_2}\\
\dfrac{\partial u_2}{\partial x_2}\\
\dfrac{\partial u_3}{\partial x_2}
\end{bmatrix}
\end{bmatrix}+
\begin{bmatrix}
\begin{bmatrix}
u_1&u_2&u_3
\end{bmatrix}
\begin{bmatrix}
\dfrac{\partial v_1}{\partial x_1}\\
\dfrac{\partial v_2}{\partial x_1}\\
\dfrac{\partial v_3}{\partial x_1}
\end{bmatrix}&
\begin{bmatrix}
u_1&u_2&u_3
\end{bmatrix}
\begin{bmatrix}
\dfrac{\partial v_1}{\partial x_2}\\
\dfrac{\partial v_2}{\partial x_2}\\
\dfrac{\partial v_3}{\partial x_2}
\end{bmatrix}
\end{bmatrix}\\
&=
\begin{bmatrix}v_1&v_2&v_3\end{bmatrix}
\begin{bmatrix}
\dfrac{\partial u_1}{\partial x_1}&\dfrac{\partial u_1}{\partial x_2}\\
\dfrac{\partial u_2}{\partial x_1}&\dfrac{\partial u_2}{\partial x_2}\\
\dfrac{\partial u_3}{\partial x_1}&\dfrac{\partial u_3}{\partial x_2}\\
\end{bmatrix}+
\begin{bmatrix}u_1&u_2&u_3\end{bmatrix}
\begin{bmatrix}
\dfrac{\partial v_1}{\partial x_1}&\dfrac{\partial v_1}{\partial x_2}\\
\dfrac{\partial v_2}{\partial x_1}&\dfrac{\partial v_2}{\partial x_2}\\
\dfrac{\partial v_3}{\partial x_1}&\dfrac{\partial v_3}{\partial x_2}\\
\end{bmatrix}\\
&=v^T(Du)+u^T(Dv)
\end{align*}
$$

与公式 $\eqref{eq1}$ 一致。将该结果推广至具有 $m$ 个分量，$n$ 个自变量的情形，就可以推导出公式 $\eqref{eq1}$ 。

> 可以看到，**标量对自变量向量求导，求导结果的维度与自变量向量的维度一致**。

<br>

# 向量对向量求导

## 向量对向量求导

设 

$$
F(x_1,\cdots,x_n)=\begin{bmatrix}f_1(x_1,\cdots,x_n)\\\vdots\\f_n(x_1,\cdots,x_n)\end{bmatrix}\notag
$$

为包含 $n$ 个变量 $(x_1,\cdots,x_n)$ 的向量函数，则 $F(x_1,\cdots,x_m)$ 对自变量求导的结果可以由雅可比矩阵表示：

$$
\begin{equation}
DF(\boldsymbol{x}) = 
\begin{bmatrix}
\dfrac{\partial f_1}{\partial x_1} & \dfrac{\partial f_1}{\partial x_2}  & \cdots & \dfrac{\partial f_1}{\partial x_n} \\ 
\dfrac{\partial f_2}{\partial x_1} & \dfrac{\partial f_2}{\partial x_2}  & \cdots & \dfrac{\partial f_2}{\partial x_n} \\
\vdots & \vdots & \vdots & \vdots \\
\dfrac{\partial f_m}{\partial x_1} & \dfrac{\partial f_m}{\partial x_2}  & \cdots & \dfrac{\partial f_m}{\partial x_n}
\end{bmatrix}
=\begin{bmatrix}
\nabla f_1\\
\vdots\\
\nabla f_m
\end{bmatrix}\label{jacobianmatrix}
\end{equation}
$$


## 矩阵向量乘积法则



设 $A(x_1,\cdots,x_n)$ 为一个 $l\times m$ 的矩阵函数， $v(x_1,\cdots,x_n)$ 是一个 $m\times 1$ 的向量函数，则

$$
D(Av)=A\cdot Dv + \sum_{i=1}^n v_i D(a_{\cdot i})\label{eq2}
$$

**证明**

设 $A(x_1,x_2)$ 为一个 $4\times 3$ 的矩阵函数， $v(x_1,x_2)$ 是一个 $3\times 1$ 的向量函数，自变量有2个 $(x_1, x_2)$

$$
A=\begin{bmatrix}
a_{11}&a_{12}&a_{13}\\
a_{21}&a_{22}&a_{23}\\
a_{31}&a_{32}&a_{33}\\
a_{41}&a_{42}&a_{43}\\
\end{bmatrix}_{4\times 3},\
v=\begin{bmatrix}
v_1\\
v_2\\
v_3
\end{bmatrix}_{3\times 1}\notag
$$

则

$$
\begin{equation*}
Av=\begin{bmatrix}
\sum^3(a_{1i}v_i)\\
\sum^3(a_{2i}v_i)\\
\sum^3(a_{3i}v_i)\\
\sum^3(a_{4i}v_i)\\
\end{bmatrix}_{4\times 1},\ 
Dv=\begin{bmatrix}
\dfrac{\partial v_1}{\partial x_1}&\dfrac{\partial v_1}{\partial x_2}\\
\dfrac{\partial v_2}{\partial x_1}&\dfrac{\partial v_2}{\partial x_2}\\
\dfrac{\partial v_3}{\partial x_1}&\dfrac{\partial v_3}{\partial x_2}\\
\end{bmatrix}_{3\times2},\
D(a_{\cdot i})=
\begin{bmatrix}
\dfrac{\partial a_{1i}}{\partial x_1}&\dfrac{\partial a_{1i}}{\partial x_2}\\
\dfrac{\partial a_{2i}}{\partial x_1}&\dfrac{\partial a_{2i}}{\partial x_2}\\
\dfrac{\partial a_{3i}}{\partial x_1}&\dfrac{\partial a_{3i}}{\partial x_2}\\
\dfrac{\partial a_{4i}}{\partial x_1}&\dfrac{\partial a_{4i}}{\partial x_2}\\
\end{bmatrix}
\end{equation*}
$$

进一步可以得到：

$$
\begin{align*}
D(Av)&=
\begin{bmatrix}
\dfrac{\partial \sum^3(a_{1i}v_i)}{\partial x_1} & \dfrac{\partial \sum^3(a_{1i}v_i)}{\partial x_2}\\
\dfrac{\partial \sum^3(a_{2i}v_i)}{\partial x_1} & \dfrac{\partial \sum^3(a_{2i}v_i)}{\partial x_2}\\
\dfrac{\partial \sum^3(a_{3i}v_i)}{\partial x_1} & \dfrac{\partial \sum^3(a_{3i}v_i)}{\partial x_2}\\
\dfrac{\partial \sum^3(a_{4i}v_i)}{\partial x_1} & \dfrac{\partial \sum^3(a_{4i}v_i)}{\partial x_2}\\
\end{bmatrix}_{4\times2}\\ 
&=\begin{bmatrix}
\sum^3\Big(\dfrac{\partial a_{1i}}{\partial x_1}v_i+\dfrac{\partial v_i}{\partial x_1}a_{1i}\Big)&\sum^3\Big(\dfrac{\partial a_{1i}}{\partial x_2}v_i+\dfrac{\partial v_i}{\partial x_2}a_{1i}\Big)\\
\sum^3\Big(\dfrac{\partial a_{2i}}{\partial x_1}v_i+\dfrac{\partial v_i}{\partial x_1}a_{2i}\Big)&\sum^3\Big(\dfrac{\partial a_{2i}}{\partial x_2}v_i+\dfrac{\partial v_i}{\partial x_2}a_{2i}\Big)\\
\sum^3\Big(\dfrac{\partial a_{3i}}{\partial x_1}v_i+\dfrac{\partial v_i}{\partial x_1}a_{3i}\Big)&\sum^3\Big(\dfrac{\partial a_{3i}}{\partial x_2}v_i+\dfrac{\partial v_i}{\partial x_2}a_{3i}\Big)\\
\sum^3\Big(\dfrac{\partial a_{4i}}{\partial x_1}v_i+\dfrac{\partial v_i}{\partial x_1}a_{4i}\Big)&\sum^3\Big(\dfrac{\partial a_{4i}}{\partial x_2}v_i+\dfrac{\partial v_i}{\partial x_2}a_{4i}\Big)\\
\end{bmatrix}_{4\times2}\\ 
&=
\begin{bmatrix}
\sum^3\Big(\dfrac{\partial v_i}{\partial x_1}a_{1i}\Big)&\sum^3\Big(\dfrac{\partial v_i}{\partial x_2}a_{1i}\Big)\\
\sum^3\Big(\dfrac{\partial v_i}{\partial x_1}a_{2i}\Big)&\sum^3\Big(\dfrac{\partial v_i}{\partial x_2}a_{2i}\Big)\\
\sum^3\Big(\dfrac{\partial v_i}{\partial x_1}a_{3i}\Big)&\sum^3\Big(\dfrac{\partial v_i}{\partial x_2}a_{3i}\Big)\\
\sum^3\Big(\dfrac{\partial v_i}{\partial x_1}a_{4i}\Big)&\sum^3\Big(\dfrac{\partial v_i}{\partial x_2}a_{4i}\Big)\\
\end{bmatrix}_{4\times2}+
\begin{bmatrix}
\sum^3\Big(\dfrac{\partial a_{1i}}{\partial x_1}v_i)&\sum^3\Big(\dfrac{\partial a_{1i}}{\partial x_2}v_i\Big)\\
\sum^3\Big(\dfrac{\partial a_{2i}}{\partial x_1}v_i\Big)&\sum^3\Big(\dfrac{\partial a_{2i}}{\partial x_2}v_i\Big)\\
\sum^3\Big(\dfrac{\partial a_{3i}}{\partial x_1}v_i\Big)&\sum^3\Big(\dfrac{\partial a_{3i}}{\partial x_2}v_i\Big)\\
\sum^3\Big(\dfrac{\partial a_{4i}}{\partial x_1}v_i\Big)&\sum^3\Big(\dfrac{\partial a_{4i}}{\partial x_2}v_i\Big)\\
\end{bmatrix}_{4\times2}\\
&=A\cdot Dv + \sum^3 v_i D(a_{\cdot i})
\end{align*}
$$

将该结果推广，就可以推导出公式 $\eqref{eq2}$ 。

<br>
