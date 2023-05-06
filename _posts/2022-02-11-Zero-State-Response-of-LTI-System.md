---
layout: single
title: 线性时不变(LTI)系统的零状态响应等于输入信号与单位脉冲响应的卷积
date: 2022-02-11
categories: 
 - Signals and Systems
toc: false
---



以离散系统为例。在离散的线性时不变(linear time invariant, LTI)系统中，输入为单位脉冲函数$\delta(k)$时产生单位脉冲响应$h(k)$，则有： 
<img src="https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/img/image-20220710133729178.png" alt="image-20220710133729178" style="zoom: 67%;" />



根据卷积和的定义，对于任意输入信号$f(k)$：

$$
\begin{aligned}
输入&=\sum^{\infty}_{i=-\infty}f(i)\delta(k-i)=f(k)*\delta(k)=f(k)\\响应&=\sum^{\infty}_{i=-\infty}f(i)h(k-i)=f(k)*h(k)\end{aligned}
$$

即：

<img src="https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/img/image-20220710133840501.png" alt="image-20220710133840501" style="zoom:50%;" />