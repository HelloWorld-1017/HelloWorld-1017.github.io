---
title: A Simple Linear Model with PyTorch
categories: 
 - Machine Learning
 - Python
tags:
 - Python PyTorch
date: 2023-04-04 19:16:36 +0800
last_modified_at: 2024-05-22 20:58:59 +0800
---

# Introduction

本博客使用PyTorch框架实现博客[^1]中所示的线性模型的求解：

> 对于一组数据：
>
> $$
> \begin{split}
> x:1,2,3\\
> y:2,4,6
> \end{split}\notag
> $$
>
> 使用模型$y=\omega\cdot x+b$拟合。

注：所有的博客内容均来自对于参考[^3]的学习和梳理。

<br>


# Prepare Dataset

```python
x_data = torch.Tensor([[1.0], [2.0], [3.0]])
y_data = torch.Tensor([[2.0], [4.0], [6.0]])
```

这里需要注意的是，`x_data`和`y_data`一定要是矩阵：

```python
x_data.size()
Out[2]: torch.Size([3, 1])

y_data.size()
Out[3]: torch.Size([3, 1])
```

外层的中括号不可以缺少。

<br>

# Design Model

```python
class LinearModel(torch.nn.Module):
    def __init__(self):
        super(LinearModel, self).__init__()
        self.linear = torch.nn.Linear(1, 1)
        
    def forward(self, x):
        y_pred = self.linear(x)
        return y_pred

model = LinearModel() # 实例化一个对象
```

模型需要定义成一个类，继承自torch中的`torch.nn.Module`类，`Module`类中有很多方法，在训练模型时需要用到。在这个类中，至少需要实现两个函数：`__init__()`和`forward()`。

## `__init__()` function

```python
super(LinearModel, self).__init__()
```

`__init__()`是构造函数（Constructor），是在初始化类时默认调用的函数，表示调用父类的initial（构造函数），必须要有，照抄即可。但是需要注意的是，`super()`的第一个参数必须是定义的模型类的名称，这里是`LinearModel`。

```python
self.linear = torch.nn.Linear(1, 1)
```

使用`torch.nn.Linear`类以实例化一个对象`linear`，其Input size为`1`，Output size也为`1`，默认设置下包含了weight和bias[^2]：

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230404183520947.png?raw=true" alt="image-20230404183520947" style="zoom:67%;" />

## `forward()` function

`forward()`函数定义了在前馈的过程中所要执行的计算，并且必须叫`forward`这个名称，因为这实际上是一个函数重写（Override），覆盖一个父类函数，或者说是进行“实例化”。语句`y_pred = self.linear(x)`的作用是将之前实例化的对象`linear`变成一个“可调用（callable）的对象”。

## Backward function?

注意这里没有写反馈过程的运算，是因为这个类是继承自`torch.nn.Module`类，由`torch.nn.Module`类构造出的对象会自动地根据计算图实现反馈的过程，除非我们需要自己设计求梯度和更新的算法。

<br>

# Construct Loss and Optimizer

下一步是构造损失函数和优化器：

```python
criterion = torch.nn.MSELoss(size_average = False)
optimizer = torch.optim.SGD(model.parameters(), lr = 0.01)
```

（1）`torch.nn.MSELoss`同样继承自`torch.nn.Module`，同样会构建计算图，成为整个计算图的一部分；而优化器是不会构建计算图的。

（2）我们刚才实例化的对象是`model()`继承自`torch.nn.Module`类，这个父类有一个成员函数`parameters()`，`parameters()`会检查模型中的所有成员（例如这里只有`self.linear(x)`），如果这些成员中有相应的权重（例如这里`self.linear(x)`的一个weight和一个bias），`parameters()`会把这些权重都视为trainable parameters。因此，`torch.optim.SGD`中的参数`model.parameters()`是告诉优化器模型中的所有训练参数都是需要优化更新的。

除了这里使用的`torch.optim.SGD`优化器，PyTorch还提供了这些优化器：

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230404191431788.png?raw=true" alt="image-20230404191431788" style="zoom:67%;" />

<br>

# Training Loop

训练的循环主要包含四个步骤，都是必要的步骤

- 计算预测值：`loss = criterion(y_pred, y_data)`；
- 计算损失，`loss = criterion(y_pred, y_data)`；
- 梯度清零，`optimizer.zero_grad()`；
- 自动梯度计算，`loss.backward()`；
- 更新权重，`optimizer.step()`；

注：这里梯度清零的操作可以放在“自动梯度计算”和“更新权重”操作之前，也可以放在这两个操作之后，都可以运行并且得到正确的结果。只要保证每一次训练步骤中都对梯度清零即可。当然，不能放在这两个操作之间~
{: .notice--primary}

```python
for epoch in range(300):
    # Forward
    y_pred = model(x_data)
    loss = criterion(y_pred, y_data)
    print(epoch,'\t', model.linear.weight.item(),
          '\t', model.linear.bias.item(),
          '\t',  loss.item())
    
    # Reset gradients
    optimizer.zero_grad()
    
    # Backward: autograd
    loss.backward()
    
    # Update
    optimizer.step() 
```

<br>

# Complete code

```python
import torch

x_data = torch.Tensor([[1.0], [2.0], [3.0]])
y_data = torch.Tensor([[2.0], [4.0], [6.0]])

class LinearModel(torch.nn.Module):
    def __init__(self):
        super(LinearModel, self).__init__()
        self.linear = torch.nn.Linear(1, 1)
        
    def forward(self, x):
        y_pred = self.linear(x) 
        return y_pred
    
# instantiate LinearModel Class
model = LinearModel() 

criterion = torch.nn.MSELoss(size_average = False) 
optimizer = torch.optim.SGD(model.parameters(), lr = 0.01)

for epoch in range(300):
    # Forward
    y_pred = model(x_data)
    loss = criterion(y_pred, y_data)
    print(epoch,'\t', model.linear.weight.item(),
          '\t', model.linear.bias.item(),
          '\t',  loss.item())
    
    # Reset gradients
    optimizer.zero_grad()
    
    # Backward: autograd
    loss.backward()
    
    # Update
    optimizer.step() 
    
print('w = ', model.linear.weight.item())
print('b = ', model.linear.bias.item())

x_test = torch.Tensor([[4.0]])
y_test = model(x_test)
print('y_pred = ', y_test.data)
```

<br>

**References**

[^1]: [Simple Gradient Descend (GD) and Stochastic Gradient Descend (SGD) Methods Selecting Optimum Weight of Linear Model](https://helloworld-1017.github.io/2023-04-04/10-04-03.html).
[^2]: [Linear](https://pytorch.org/docs/stable/generated/torch.nn.Linear.html?highlight=torch+nn+linear#torch.nn.Linear).
[^3]: [05.用PyTorch实现线性回归](https://www.bilibili.com/video/BV1Y7411d7Ys?p=5&vd_source=8aeddead7f39b0189fff9b14fa090a75).