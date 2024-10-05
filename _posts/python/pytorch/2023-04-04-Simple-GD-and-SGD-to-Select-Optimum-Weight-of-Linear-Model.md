---
title: A Simple Gradient Descend (GD) and A Stochastic Gradient Descend (SGD) to Select Optimum Weight of Linear Model
categories: 
 - Machine Learning
 - Python
tags:
 - Python PyTorch
 - Optimization
date: 2023-04-04 10:04:03 +0800
last_modified_at: 2024-10-05 20:34:49 +0800
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

![image-20230403211245718](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230403211245718.png?raw=true)

那么，为什么只能保证找到局部最优的梯度下降法还用得这么普遍呢？ 因为后来人们研究发现，**损失函数并没有很多的局部最优点，其实比较少**。但是，会存在另外一种比较特殊的点，鞍点（saddle point），即梯度值为0（零向量）的点。

如果进行梯度优化时进入到了鞍点，那么就没有办法继续向前迭代：

![image-20230403211805739](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230403211805739.png?raw=true)

在深度学习里面，我们所要解决的最大的问题是不是局部最优问题，而是鞍点问题。

## A simple code implementation

对于在博客[^1]中所提到的一个简单的线性拟合问题：

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

![image-20230403214959725](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230403214959725.png?raw=true)

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

![image-20230404102044749](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230404102044749.png?raw=true)

虽然使用SGD算法比使用GD算法得到的神经网络准确率较高，但是相比GD算法，SGD算法具有更高的时间复杂度，运算效率更低。

例如现在一共有四个样本，在神经网络前馈的过程中，对于GD算法而言，对样本$x_1$，$x_2$，$x_3$和$x_4$计算$f(x_1)$，$f(x_2)$，$f(x_3)$和$f(x_4)$的步骤是可以并行进行的；但是如果使用SGD算法，将样本$x_1$，$x_2$，$x_3$和样本$x_4$分为两个batch（第一个batch的样本为$x_1$和$x_3$，第二个batch的样本为$x_2$和$x_4$），则每一个batch中的样本计算是可以并行的，但不同batch的样本是无法并行计算的，因为根据SGD的设计，计算完每一个batch之后需要梯度下降更新权重$\omega$，不同batch的样本在计算时$\omega$是不同的，因此无法并行计算。

<br>

# Calculate Gradients and Thereby Backward by PyTorch

上文所实现的计算损失值的过程（forward）和更新权重的过程（backward），可以使用PyTorch所提供的Tensor类以及相应的函数进行实现，具体代码如下：

```python
import numpy as np
import matplotlib.pyplot as plt 
import torch

x_s = [1.0, 2.0, 3.0]
y_s = [2.0, 4.0, 6.0]

w = torch.Tensor([1.0])
w.requires_grad = True   

def forward(x):
    return x * w  

def loss(x, y):
    y_pred = forward(x)
    return (y_pred - y) ** 2

print("predict (before training)", 4, forward(4).item())

for epoch in range(100):      
    for x, y in zip(x_s, y_s):
        l = loss(x, y)
        l.backward() # Calculate gradients (where needed) in the calculation graph
        print('\t grad', x, y, w.grad.item())
        w.data = w.data - 0.01 * w.grad.data
        
        w.grad.data.zero_()
        
    print("progress", epoch, l.item())
print("predict (after training)", 4, forward(4).item())
```

需要说明的有以下几点：

**（1）Tensor类**

```python
w = torch.Tensor([1.0])
w.requires_grad = True 
```

在PyTorch中，最基本的一个数据类就是Tensor。它可以保存标量，向量，矩阵，甚至是更高维度的张量。Tensor中有两个比较重要的成员，一个是`data`，一个是`grad`，分别用来保存它本身的值，以及损失函数对权重的导数：

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230404174511345.png?raw=true" alt="image-20230404174511345" style="zoom:67%;" />

默认的创建的`torch.Tensor`是不需要进行计算梯度的，只有设置了`w.reauires_grad = True`，即表示我们希望计算关于该变量的梯度时，才会进行计算梯度。

**（2）动态计算图**

```python
def forward(x):
    return x * w  
```

`w`是一个Tensor，因此在forward过程中当`w`遇到乘法运算符`*`时，`*`就已经被重载了，它要进行的是Tensor和Tensor的数乘运算，同时变量`x`也被自动地转换成了Tensor，并且它们相乘的结果`x*w`同样是Tensor，并且和`w`一样，也需要计算梯度；

注：如果我们定义了Tensor，就可以去建立计算图。实际上，用PyTorch在构建神经网络时，看到关于Tensor的计算就要意识到是在构建计算图。
{: .notice--primary}

**（3）`l.backward()`**

```python
l = loss(x, y)
l.backward()
```

由于自定义函数`loss`的计算过程使用到了我们上面所提到的`forward`函数，因此计算出来的损失值`l`同样是一个Tensor，可以调用这个Tensor的成员函数`backward`。它就可以自动地把这个计算图链路上的梯度都求出来，然后把这个梯度保存在Tensor中（对于这个例子，就是将梯度保存在变量`w`中）。梯度保存在`w`之后，计算图就被释放了。

**只要一使用`backward`，计算图就被释放了。下一次进行loss计算，就会建立一个新的计算图。**这么做的原因，是有的时候我们构建的神经网络，我们每一次构建的计算图可能是不一样的（例如存在随机的Dropout）。这是一种非常灵活的方式，也是PyTorch的核心竞争力。

**（4）更新梯度时要使用`w.grad.data`**

```python
w.data = w.data - 0.01 * w.grad.data
```

在更新梯度时，不要拿`w.grad`直接进行操作。因为`w.grad`也是一个Tensor，如果直接使用`w.grad`进行梯度更新，那么这实际上就是在构建计算图，而我们想要做的仅仅是一个纯数值的更新，因此要使用`w.grad.data`，防止产生计算图。

**（5）`.item()`**

```python
print('\t grad', x, y, w.grad.item())
```

`w.grad.item()`是用来把梯度里面的数值直接拿出来，变成python中的标量。这么做是为了防止产生计算图，造成困扰。同理，想要计算每一个训练Epoch的损失值之和，要使用`l.item()`，否则就会一直构建计算图。在样本非常多、BatchSize比较小的情况下，就会导致内存占用非常严重。

**（6）`w.grad.data.zero_()`**

在根据梯度值更新完权重后，需要将权重`w`里面梯度的数据全部清零：

```python
w.grad.data.zero_()
```

如果不清零，则下一次对损失函数对权重求导的值会加在上一次的结果之上（The grad computed by `.backward()` will be accumulated）。那么，为什么PyTorch不直接把它清零呢？这是因为对于权重`w`，我们有时候会使用很多模型的设计技巧，就是需要`w`做一个累加，这是我们需要的。所以如果清零，则一定要使用显式代码。

注：这里只是清零计算的权重梯度的data（`w.grad.data`），而没有清权重`w`的data(`w.data`)。
{: .notice--primary}

<br>

**References**

- [03.梯度下降算法](https://www.bilibili.com/video/BV1Y7411d7Ys?p=3&vd_source=8aeddead7f39b0189fff9b14fa090a75).
- [04.反向传播](https://www.bilibili.com/video/BV1Y7411d7Ys?p=4&vd_source=8aeddead7f39b0189fff9b14fa090a75).

[^1]: [A Simple Exhaustive Method for Selecting Optimum Weight of Linear Model](http://127.0.0.1:4000/2023-04-03/16-44-31.html).

