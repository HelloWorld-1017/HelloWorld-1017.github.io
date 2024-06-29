---
layout: single
title: Construct A Simple Logistic Regression Model for Binary Classification Problem with PyTorch
categories: 
 - Machine Learning
 - Python
tags:
 - Python PyTorch
 - Operations Research
toc: false
date: 2023-04-09 16:38:03 +0800
last_modified_at0: 2023-04-09 16:38:03 +0800
last_modified_at1: 2024-05-22 20:56:14 +0800
last_modified_at: 2024-05-22 20:56:14 +0800
---

在博客[^1]中，我们使用了PyTorch框架训练了一个很简单的线性模型，用于解决下面的数据拟合问题：

> 对于一组数据：
> 
> $$
> \begin{split}
> &x:1,2,3\\
> &y:2,4,6
> \end{split}
> $$
> 
> 使用模型$y=\omega\cdot x+b$拟合。

实际上，这是一个**回归问题**。如果将数据集中数据的标签更改为：

$$
\begin{split}
&x:1,2,3\\
&y:0,0,1
\end{split}
$$

0和1分别表示两种不同的类别，那么我们所要解决的就是一个**分类问题**。

对于一个分类问题而言，我们通常是使模型输出预测样本为每一类的“概率”，之后选取预测概率最大的类为模型的预测类。

那么，如何使得模型输出预测“概率”呢？对于这样一个简单的二分类而言，实际上只需要获得模型关于其中一类的预测概率即可（下文只预测样本属于类别1的概率），可以采取下面这种简单的方法，即Logistic回归模型：

注：虽然是叫做Logistic回归，实际上它解决的是一个二分类问题。
{: .notice--primary}

![image-20230409160417104](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230409160417104.png?raw=true)

其中，$\sigma$是Logistic函数，是S型（Sigmoid）函数的一种，用于将神经网络的输出值压缩到$[0,1]$之间有，由于非常常用，有时候也被直接称为Sigmoid函数。它的公式为：

$$
\sigma(x)=\dfrac{1}{1+\mathrm{e}^{-x}}
$$

最终，整个Logistic回归模型可以写作

$$
\hat{y}=\sigma(\omega\cdot x+b)
$$

> 相比之前所使用的线性模型：
> 
> $$
> \hat{y}=x\cdot\omega+b
> $$
> 
> Logistic回归模型输出的在$[0,1]$之间的预测概率。

Logistic回归模型与线性回归模型的另一点差异在于损失函数的不同。对于线性模型，其输出的是预测一个值，预测值与真实值之间的差异（即损失函数）可以使用两者之间的**距离**来度量：

$$
loss=(\hat{y}-y)^2=(x\cdot\omega+b-y)^2
$$

而对于分类问题，模型的输出是一个概率值，此时的损失函数应当是衡量模型预测的**分布**与真实分布之间的差异，需要使用KL散度，而在实际中更常使用的是交叉熵（参考博客[^2]）。对于二分类问题，其损失函数（Binary Cross Entropy loss，BCE losss）为：

$$
loss= -(y\log(\hat{y})+(1-y)\log(1-\hat{y}))
$$

<br>

因此，在使用PyTorch实现时，代码与线性模型相比仅有两点不同：

（1）将模型的输出连接一个Sigmoid函数：

```python
# ...
import torch.nn.functional as F
# ...

class LogisticRegressionModel(torch.nn.Module):
    def __init__(self):
        super(LogisticRegressionModel, self).__init__()
        self.linear = torch.nn.Linear(1, 1)
        
    def forward(self, x):
        y_pred = F.sigmoid(self.linear(x))
        return y_pred
```

（2）将模型的损失函数更改为二分类交叉熵损失：

```python
criterion = torch.nn.BCELoss(size_average = False)
```

其余的代码都是一样的。

<br>

最终，整体的代码为：

```python
import numpy as np
import torch
import matplotlib.pyplot as plt
import torch.nn.functional as F

x_data = torch.Tensor([[1.0], [2.0], [3.0]])
y_data = torch.Tensor([[0], [0], [1]])

class LogisticRegressionModel(torch.nn.Module):
    def __init__(self):
        super(LogisticRegressionModel, self).__init__()
        self.linear = torch.nn.Linear(1, 1)
        
    def forward(self, x):
        y_pred = F.sigmoid(self.linear(x))
        return y_pred

model = LogisticRegressionModel()

criterion = torch.nn.BCELoss(size_average = False)
optimizer = torch.optim.SGD(model.parameters(), lr = 0.01)

for epoch in range(3000):
    y_pred = model(x_data)
    loss = criterion(y_pred, y_data)
    print(epoch, loss.item())
    
    optimizer.zero_grad()
    loss.backward()
    optimizer.step()
    
    
x = np.linspace(0, 10, 200)
x_t = torch.Tensor(x).view((200, 1))
y_t = model(x_t) # Forward
y = y_t.data.numpy()


plt.cla()
plt.plot(x, y)
plt.plot([0, 10], [0.5, 0.5], c = 'r')
plt.xlabel('Hours')
plt.ylabel('Probability of Pass')
plt.grid()
plt.show()
```

![image-20230409162054843](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230409162054843.png?raw=true)

需要注意的是，上面这段代码并没有根据预测的概率（预测为类别1的概率）而对样本进行分类，如果想要进一步分类，只需要依据输出概率做很简单的判定即可，这里就不再赘述。

<br>

# References

- [06.逻辑斯蒂回归 - 刘二大人](https://www.bilibili.com/video/BV1Y7411d7Ys?p=6&vd_source=8aeddead7f39b0189fff9b14fa090a75).

[^1]: [Construct A Simple MLP for Diabetes Dataset Binary Classification Problem with PyTorch (Load Datasets using PyTorch DataSet and DataLoader) - WHAT A STARRY NIGHT~](https://helloworld-1017.github.io/2023-04-10/13-44-03.html).
[^2]: [Entropy, Cross entropy, KL Divergence and Their Relation - WHAT A STARRY NIGHT~](https://helloworld-1017.github.io/2023-04-09/14-25-33.html).
