---
title: Multivariate Newton Iteration Method based on PyTorch (Vector to Vector Derivative)
toc: false
categories: 
 - Python
 - Machine Learning
tags: 
 - Python PyTorch
date: 2022-02-07 10:02:03 +0800
last_modified_at: 2024-05-22 21:08:10 +0800
---


对于非线性方程组：

$$
\left\{  
\begin{align*} &x_1^2 + x_2^2 + x_3^2-1.0 = 0 \\ &2x_1^2+x_2^2-4x_3=0\\ &3x_1^2-4x_2^2+x_3^2 = 0\\ 
\end{align*} 
\right.
$$

初始值给定：$x^{(0)}=(1.0, 1.0, 1.0)^T$。
多元牛顿法的一般迭代形式为：

$$
\begin{align*}
\boldsymbol{x}_0 &= \boldsymbol{k} \\ \boldsymbol{x}_{k+1} &=\boldsymbol{x}_{k} - DF(\boldsymbol{x}_k)^{-1}F(\boldsymbol{x}_k),\ k= 0,1,2,\cdots  
\end{align*}
$$

求解的关键是求出雅各比矩阵$DF(\boldsymbol{x}_k)$。

$$
DF(x) = 
	\begin{bmatrix}
		\dfrac{\partial f_1}{\partial x_1} & \dfrac{\partial f_1}{\partial x_2}  & \cdots & \dfrac{\partial f_1}{\partial x_n}\\ 
		\dfrac{\partial f_2}{\partial x_1} & \dfrac{\partial f_2}{\partial x_2}  & \cdots & \dfrac{\partial f_2}{\partial x_n}\\
		\vdots                             & \vdots                              & \vdots & \vdots                            \\
		\dfrac{\partial f_m}{\partial x_1} & \dfrac{\partial f_m}{\partial x_2}  & \cdots & \dfrac{\partial f_m}{\partial x_n}
	\end{bmatrix}\notag
$$

使用PyTorch自动求导机制实现如下：

```python
import torch
import numpy as np
import matplotlib.pyplot as plt

# 防止图片中汉字出现乱码
plt.rcParams["font.sans-serif"] = ["SimHei"]
plt.rcParams['axes.unicode_minus'] = False


# 定义向量函数
f = lambda x: x[0] ** 2 + x[1] ** 2 + x[2] ** 2 - 1.0
g = lambda x: 2 * x[0] ** 2 + x[1] ** 2 - 4 * x[2]
h = lambda x: 3 * x[0] ** 2 - 4 * x[1] ** 2 + x[2] ** 2

# 列表用于保存中间值
x_list = []
F_value_list = []

# 设置初值
x = torch.tensor([[1.0], [1.0], [1.0]], requires_grad = True)
x_list.append(x.data.numpy())

for i in range(5):
    # 计算函数F的值
    F_value = torch.cat((f(x), g(x), h(x)),0).reshape((3, 1))
    
    F_value_list.append(F_value.data.numpy())
    # 计算雅可比矩阵
    J = torch.cat((torch.autograd.grad(f(x), x, create_graph=True)[0],
               torch.autograd.grad(g(x), x, create_graph=True)[0],
               torch.autograd.grad(h(x), x, create_graph=True)[0]), 1).transpose(0, 1)
    # 更新向量x的值
    x = x - torch.mm(torch.linalg.inv(J), F_value)
    x_list.append(x.data.numpy())
    
x_list = np.array(x_list).reshape((-1, 3))
F_value_list = np.array(F_value_list).reshape((-1, 3))

# 绘制迭代过程图
markers = ['o', '^', 's']
labels0 = [r'$x_1$',r'$x_2$',r'$x_3$']
labels1 = [r'$f_1$',r'$f_2$',r'$f_3$']

fig, axes = plt.subplots(1,2, figsize = (17, 7))

for idx, x, f in zip(range(0,3), x_list.T, F_value_list.T):
    axes[0].plot(range(len(x)), x, marker = markers[idx], label = labels0[idx])
    axes[1].plot(range(len(f)), f, marker = markers[idx], label = labels1[idx])
    
axes[0].set_xlabel('迭代次数')
axes[0].set_ylabel(r'向量$x$各分量的值')
axes[0].set_title('变量迭代过程')
axes[0].legend()

axes[1].set_xlabel('迭代次数')
axes[1].set_ylabel(r'向量函数$F$各分量的值')
axes[1].set_title('函数值迭代过程')
axes[1].legend()
```
最后得到结果：

![image-20220708001921161](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220708001921161.png?raw=true)

Bingo！

<br>