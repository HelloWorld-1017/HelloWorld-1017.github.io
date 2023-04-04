---
layout: single
title: Simple Gradient Descend (GD) and Stochastic Gradient Descend (SGD) Methods Selecting Optimum Weight of Linear Model
date: 2023-04-04 10:04:03 +0800
categories: 
 - Machine Learning
 - Operation Research
 - Python
---

# Gradient Descend

## Gradient Descend

根据梯度的定义有：

$$
\dfrac{\partial f}{\partial x}=\lim_{\Delta x\rightarrow0}\dfrac{f(x+\Delta x)-f(x)}{\Delta x}
$$

其中，$\Delta x$始终是大于0的。因此：

- 当$f(x+\Delta x)-f(x)>0$时，表示随着$\Delta x$的增加，函数$f(x)$是递增的，此时梯度$\partial f/\partial x$是正数，与$\Delta x$的方向保持一致，指向函数的递增方向；
- 当$f(x+\Delta x)-f(x)<0$时，表示随着$\Delta x$的增加，函数$f(x)$是递减的，此时梯度$\partial f/\partial x$是负数，与$\Delta x$的方向相反，仍然指向函数的递增方向。

因此，**梯度始终指向函数上升的方向**。于是，梯度下降算法（Gradient Descend）的更新公式为：

$$
\omega=\omega-\alpha\dfrac{\partial f}{\partial\omega}
$$

其中，$\alpha$为学习率（learning rate）。

## Local minimum and saddle point

实际上，梯度下降算法是属于贪心算法的，也因此，梯度下降算法不一定能够得到最优解，但是可以得到一个局部最优的结果。例如对于非凸函数：

注：简单地讲，任意连接下面这条曲线上的两个点形成一条直线，我们不能够保证曲线上的所有点都在直线的上方，这就是一个非凸函数。
{: .notice--primary}

![image-20230403211245718](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20230403211245718.png)

那么，为什么只能保证找到局部最优的梯度下降法还用得这么普遍呢？ 因为后来人们研究发现，**损失函数并没有很多的局部最优点，其实比较少**。但是，会存在另外一种比较特殊的点，鞍点（saddle point），即梯度值为0（零向量）的点。

如果进行梯度优化时进入到了鞍点，那么就没有办法继续向前迭代：

![image-20230403211805739](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20230403211805739.png)

在深度学习里面，我们所要解决的最大的问题是不是局部最优问题，而是鞍点问题。

## A simple code implementation

对于在[A Simple Exhaustive Method for Selecting Optimum Weight of Linear Mode](http://whatastarrynight.com/machine learning/python/A-Simple-Exhaustive-Method-for-Selecting-Optimum-Weight-of-Linear-Model/)中所提到的一个简单的线性拟合问题：

> 对于一组数据：
>
> $$
> \begin{split}
> x:1,2,3\\
> y:2,4,6
> \end{split}\notag
> $$
> 
> 使用模型$y=\omega\cdot x$拟合。

可以得到损失函数MSE为：

$$
\begin{split}
Loss&=\dfrac1N\sum_{i=1}^N(\hat{y}_n-y_n)^2\\
&=\dfrac1N\sum_{n=1}^N(\omega\cdot x_n-y_n)^2\\
\end{split}
$$

则$Loss$关于$w$的梯度可以表示为：

$$
\begin{split}
\dfrac{\partial Loss}{\partial \omega}&=\dfrac1N\sum_{n=1}^N2\cdot x_n\cdot(\omega\cdot x_n-y_n)
\end{split}
$$

实现的代码为：

```python
import numpy as np
import matplotlib.pyplot as plt

# Training data
x_data = [1.0, 2.0, 3.0]
y_data = [2.0, 4.0, 6.0]

# Initial weight
w = 1.0 

w_list = []
cost_list = []
epoch_list = []


def forward(x):
    return x * w

def cost(xs, ys):
    cost = 0
    for x, y in zip(xs, ys):
        y_pred = forward(x)
        cost += (y_pred - y) ** 2
    return cost / len(xs) # Mean

def gradient(xs, ys):
    grad = 0
    # Summation of deriviatives 
    for x, y in zip(xs, ys):
        grad += 2 * x * (x * w - y)
    return grad/len(xs)  # Mean

print('Predict (befor training):', 4, forward(4))
for epoch in range(100): # 100-times epochs training
    cost_val = cost(x_data, y_data) # Calculate loss (just for display)
    grad_val = gradient(x_data, y_data) # Caculate gradient
    w -= 0.01 * grad_val  # Update weights
    
    w_list.append(w)
    cost_list.append(cost_val)
    epoch_list.append(epoch)
    
    print('Epoch:', epoch, 'w=', w, 'loss = ', cost_val)
    
# Make a prediction
print('Predict (after training)', 4, forward(4))

ax1 = plt.subplot(121)
plt.plot(w_list, cost_list)
plt.grid ()
ax1.set_title('Title 1')
ax1.set_xlabel('Weight')
ax1.set_ylabel('Loss value')

ax2 = plt.subplot(122)
plt.plot(epoch_list, cost_list)
plt.grid ()
ax2.set_title('Title 2')
ax2.set_xlabel('Epoch')
ax2.set_ylabel('Loss value')
plt.show()
```

![image-20230403214959725](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20230403214959725.png)

<br>

# Stochastic Gradient Descend

在深度学习里，梯度下降其实用得挺少的，多用梯度下降的一个延申版本：随机梯度下降（Stochastic Gradient Descend，SGD）。正如前文所述，梯度下降用的是所有的样本的损失值来计算梯度，这种方法得到的损失函数就可能会遇到鞍点问题；而SGD是从所有的样本中随机选取一批样本进行损失值的计算，并进行梯度下降，由于样本都是有噪声的，引入随机噪声以后，可能会将优化过程从鞍点中向前推动，从而跨越过鞍点，向最优值前进。在神经网络训练中，SGD被证明是非常有效的方法。

```python
import numpy as np
import matplotlib.pyplot as plt

# Training data
x_data = [1.0, 2.0, 3.0]
y_data = [2.0, 4.0, 6.0]

# Initial weight
w = 1.0 

w_list = []
cost_list = []
epoch_list = []

def forward(x):
    return x * w

def cost(x, y):
    cost = (forward(x) - y) ** 2
    return cost

def gradient(x, y):
    grad = 2 * x * (x * w - y)
    return grad

print('Predict (befor training):', 4, forward(4))
for epoch in range(100): # 100-times epochs training
    for x, y in zip(x_data,y_data):
        cost_val = cost(x, y) # Calculate loss (just for display)
        grad_val = gradient(x, y) # Caculate gradient
        w -= 0.01 * grad_val  # Update weights
    w_list.append(w)
    cost_list.append(cost_val)
    epoch_list.append(epoch)
    print('Epoch:', epoch, 'w=', w, 'loss = ', cost_val)
    
# Make a prediction
print('Predict (after training)', 4, forward(4))

ax1 = plt.subplot(121)
plt.plot(w_list, cost_list)
plt.grid ()
ax1.set_xlabel('Weight')
ax1.set_ylabel('Loss value')

ax2 = plt.subplot(122)
plt.plot(epoch_list, cost_list)
plt.grid ()
ax2.set_xlabel('Epoch')
ax2.set_ylabel('Loss value')
plt.show()
```

![image-20230404102044749](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/DeLLLaptop/image-20230404102044749.png)

虽然使用SGD算法比使用GD算法得到的神经网络准确率较高，但是相比GD算法，SGD算法具有更高的时间复杂度，运算效率更低。

例如现在一共有四个样本，在神经网络前馈的过程中，对于GD算法而言，对样本$x_1$，$x_2$，$x_3$和$x_4$计算$f(x_1)$，$f(x_2)$，$f(x_3)$和$f(x_4)$的步骤是可以并行进行的；但是如果使用SGD算法，将样本$x_1$，$x_2$，$x_3$和样本$x_4$分为两个batch（第一个batch的样本为$x_1$和$x_3$，第二个batch的样本为$x_2$和$x_4$），则每一个batch中的样本计算是可以并行的，但不同batch的样本是无法并行计算的，因为根据SGD的设计，计算完每一个batch之后需要梯度下降更新权重$\omega$，不同batch的样本在计算时$\omega$是不同的，因此无法并行计算。

<br>

**References**

[1] [03.梯度下降算法 - 刘二大人](https://www.bilibili.com/video/BV1Y7411d7Ys?p=3&vd_source=8aeddead7f39b0189fff9b14fa090a75).