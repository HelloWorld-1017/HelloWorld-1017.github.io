---
layout: single
title: A Slight but Likely-Crucial Problem about MATLAB Simulink `derivative` Block
date: 2023-08-29 15:18:14 +0800
categories:
 - MATLAB
 - Signals and Systems
tags:
 - MATLAB Simulink
 - Numerical Analysis
toc: false
---

Recently, I encounter a problem while debugging a MATLAB Simulink model for my research, i.e., simulation results of the same model are convergent by solving from the perspective of "integration", but are divergent by solving from "derivative". This phenomenon ever seemed to appear in my past modeling experience, but I did not figure out why it is. So today, I model a simple model to get into it.

For sinusoidal wave $y(t) = \sin(t)$, we have:

$$
y'(t)=\cos(t),\ \int_0^t\sin(x)\mathrm{d}x=1-\cos(t)
$$

Therefore, I use a `Sine Wave` block to generate sine wave, followed by respectively performing integration (by `integrator` block) and derivation for it (by `derivative` block) , and then observe the results.

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230829135417062.png?raw=true" alt="image-20230829135417062" style="zoom:50%;" />

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230829140431401.png?raw=true" alt="image-20230829140431401" style="zoom: 50%;" />

We could find that the $y'(0)$ equals 0, but not 1 which we expect based on analytical solution. I reckon it is caused by the numerical derivative-calculated strategy in MATLAB, which make $y(0^-)=y(0)$ and thereby $y'(0)=0$. 

> This could be found more clearly from recorded integration data:
>
> ```
> >> out.dsine.Data(1:5)
> ans =
>          0
>     1.0000
>     1.0000
>     1.0000
>     1.0000
> ```
>
> And likewise, this phenomenon reproduces in another simple model:
>
> <img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230829141101738.png?raw=true" alt="image-20230829141101738" style="zoom: 80%;" />

Actually, I am not much for sure that it is only or main reason resulting in the convergence of results of complicated model with `derivative` block, but I think it is part of causes and should be noted. 

On the other hand, the integration results only relates to Initial Condition (IC), which we could easily set in `integrator` property dialog. A sample shows bellowing: 

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230829145316592.png?raw=true" alt="image-20230829145316592" style="zoom: 80%;" />

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230829145105206.png?raw=true" alt="image-20230829145105206" style="zoom: 80%;" />

So to my mind, using `integrator` block to describe system equation as much as possible, rather than `derivative` block, is a better choice as a fault value always appears in initial condition of derivative output, probably leading to divergent results, despite the fact of numerical algorithms for integration is much more complicated than that for derivative.

<br>