---
title: Mass-Spring-Damper Simulation in MATLAB
categories: 
 - MATLAB
tags: 
 - MATLAB Simulink
date: 2023-06-19 14:51:29 +0800
last_modified_at: 2024-10-23 19:00:36 +0800
---

# Introduction

MATLAB的示例 [1] 介绍了如何使用Simulink以及Simulink Simscape库构建一个简单的质量-弹簧-阻尼（Mass-Spring-Damper）系统：

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230619134436617.png?raw=true" alt="image-20230619134436617" style="zoom: 80%;" />

这是一个很经典的系统，在很多的场景中都有应用，例如博客 [2] 中构建的电磁铁。

质量-弹簧-阻尼系统的所对应的方程为：

$$
F=m\dfrac{\mathrm{d}x^2}{\mathrm{d}t^2}+b\dfrac{\mathrm{d}x}{\mathrm{d}t}+kx\label{eq1}
$$

在这个模型中，弹簧的初始值为$x_0=1\ \mathrm{m}$，质量块速度的仿真结果如下图所示：

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230619135544844.png?raw=true" alt="image-20230619135544844" style="zoom: 80%;" />

该示例没有输出质量块的位置波形，我们可以观察一下位置波形信号：

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230619140420704.png?raw=true" alt="image-20230619140420704" style="zoom: 80%;" />

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230619140504175.png?raw=true" alt="image-20230619140504175" style="zoom: 80%;" />

可以看到，最终质量块会稳定在$x=0$处。

<br>

# Discussions

在很早以前学习这个模型时，觉得很简单，并且最终质量块的速度稳定为零，就没有深究，没有输出模型的位置信号，以为实际模型是和Simscape模型是类似的，是垂直摆放的：

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230619141309059.png?raw=true" alt="image-20230619141309059" style="zoom:50%;" />

但是在实际应用时遇到了一些问题，再回过头看到模型的位置波形时就很疑惑：为什么一个有重力的小球会停在弹簧形变量为$0$的位置呢？

于是又想了一下，觉得这个示例的模型应该对应方程$\eqref{eq1}$左端项为零的情况，即：

$$
0=m\dfrac{\mathrm{d}x^2}{\mathrm{d}t^2}+b\dfrac{\mathrm{d}x}{\mathrm{d}t}+kx
$$

其对应的实际模型应该为：

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230619142239308.png?raw=true" alt="image-20230619142239308" style="zoom:50%;" />

是水平摆放在地面上，并且地面是绝对光滑的，没有摩擦力。

如果想要对上述垂直摆放的情形进行建模，则对应的系统方程为：

$$
m\mathrm{g}=m\dfrac{\mathrm{d}x^2}{\mathrm{d}t^2}+b\dfrac{\mathrm{d}x}{\mathrm{d}t}+kx
$$

对应的Simulink模型以及质量块的位置波形为：

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230619142942531.png?raw=true" alt="image-20230619142942531" style="zoom: 80%;" />

最终质量块大致稳定在$-0.08828$处。考虑到该模型的参数：

- 质量`m`，值为`3.6`；
- 弹簧弹性系数`k`，值为`400`；

$$
\begin{split}
&3.6\times(-9.81)=-35.316\\
&400\times(-0.08828)=-35.312\\
\end{split}\notag
$$

可以验证此时模型的正确性。

<br>

**References**

[1] [Mass-Spring-Damper in Simulink and Simscape - MathWorks](https://ww2.mathworks.cn/help/simscape/ug/mass-spring-damper-in-simulink-and-simscape.html).

[2] [Simulate Solenoid in MATLAB Simulink - What a starry night~](https://ma1017.github.io/matlab/signals and systems/electromagnetism/circuit breaker/MATLAB-Simscape-solenoid/).