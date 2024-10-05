---
title: A Simple Fully-Connected DNN for Solving MNIST Image Classification with PyTorch
categories: 
 - Machine Learning
 - Python
tags:
 - Python PyTorch
 - Computer Vision
date: 2023-04-11 16:34:31 +0800
last_modified_at: 2024-05-25 09:58:38 +0800
---

# Introduction

在博客 [2] 中，我们构建了一个全连接神经网络（A.K.A MLP）解决糖尿病数据集多对应的二分类问题。本博客将继续这个工作，根据参考 [1] 使用全连接神经网络解决MNIST手写图像数据的多分类问题。

<br>

# Load MNIST Dataset and Preprocess

在博客 [2] 的最后，我们简单介绍了如何使用`dasets`和`DataLoader`加载`torchvision.datasets`中的Benchmark数据集。但在实际中，在加载数据集的同时也需要对图像数据做一些预处理：

```python
import torch
from torchvision import transforms
from torchvision import datasets
from torch.utils.data import DataLoader
import torch.nn.functional as F
import torch.optim as optim
import numpy as np

batch_size = 64
transform = transforms.Compose([
    transforms.ToTensor(),
    transforms.Normalize((0.1370, ),(0.3081, ))
])

train_dataset = datasets.MNIST(root = 'mnist',
                               train = True,
                               download = True,
                               transform = transform)

train_loader = DataLoader(train_dataset,
                          shuffle = True,
                          batch_size = batch_size)

test_dataset = datasets.MNIST(root = 'mnist',
                               train = False,
                               download = True,
                               transform = transform)

test_loader = DataLoader(test_dataset,
                          shuffle = False,
                          batch_size = batch_size)
```

可以看到，在一开始构造了一个`transforms.Compose`对象，它可以把中括号中包含的一系列的对象构成一个类似于pipeline的处理流程。例如在这个例子中，预处理主要包含以下两个预处理步骤：

**（1）`transforms.ToTensor()`**

使用PIL Image读进来的图像一般是$\mathrm{W\times H\times C}$的张量，而在PyTorch中，需要将图像转换成$\mathrm{C\times W\times H}$的形式，即把通道这个维度放在最前面（注：这一点似乎与MATLAB的处理方式不同，MATLAB一般是转换成SSCB的张量）。例如，对于MNIST数据集：

$$
\mathbb{Z}^{28\times28},pixel\in\{0,\cdots,255\}\rightarrow\mathbb{R}^{1\times28\times28},\ pixel\in\{0,\cdots,1\}\notag
$$

PyTorch所提供的的`transforms.ToTensor()`就是用于实现这个功能的。

**（2）标准化（归一化）`transforms.Normalize`**

在训练神经网络的时候，神经网络希望读进来的数值比较小，最好是在-1~1之间，并且最最好是能服从正态分布，这样的输入对神经网络是最有帮助的（这一点是经过验证的，著名的BatchNormalize (BN) layer就是对这种思想的推广 [3] ）。`transforms.Normalize`的作用就是对图像数据进行标准化，其中，0.1370是均值，0.3081是标准差（这两个数是对MNIST整个图像集计算后得到的结果）。

我们可以简单地查看一下数据集的特点：

```
# The image data of the first training sample
In [22]: train_dataset[0][0],train_dataset[0][0].shape
Out[22]: 
(tensor([[[-4.4466e-01, -4.4466e-01, -4.4466e-01, -4.4466e-01, -4.4466e-01,
           -4.4466e-01, -4.4466e-01, -4.4466e-01, -4.4466e-01, -4.4466e-01,
           -4.4466e-01, -4.4466e-01, -4.4466e-01, -4.4466e-01, -4.4466e-01,
           -4.4466e-01, -4.4466e-01, -4.4466e-01, -4.4466e-01, -4.4466e-01,
           -4.4466e-01, -4.4466e-01, -4.4466e-01, -4.4466e-01, -4.4466e-01,
           -4.4466e-01, -4.4466e-01, -4.4466e-01],
         ...
          [-4.4466e-01, -4.4466e-01, -4.4466e-01, -4.4466e-01, -4.4466e-01,
           -4.4466e-01, -4.4466e-01, -4.4466e-01, -4.4466e-01, -4.4466e-01,
           -4.4466e-01, -4.4466e-01, -4.4466e-01, -4.4466e-01, -4.4466e-01,
           -4.4466e-01, -4.4466e-01, -4.4466e-01, -4.4466e-01, -4.4466e-01,
           -4.4466e-01, -4.4466e-01, -4.4466e-01, -4.4466e-01, -4.4466e-01,
           -4.4466e-01, -4.4466e-01, -4.4466e-01]]]),
 torch.Size([1, 28, 28]))
```

```
In [23]: train_dataset[0][1]
Out[23]: 5
```

> 或者可以使用代码：
>
> ```python
> img, label = train_dataset[0]
> ```
>
> 获取一个样本的数据和标签。

此时的图像张量的确是$\mathrm{C\times W\times H}$（$1\times28\times28$）的形状，而标签是0~9的定类变量。

> 关于标签的定义，我们可以在`datasets.MNIST`的源码中查看到：
>
> ![image-20230411150043796](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230411150043796.png?raw=true)

<br>

# Model Design and Loss Function

这里所使用的全连接神经网络与博客 [2] 中所介绍的并没有本质的不同，唯一的差别在于**神经网络输出层的处理**和**损失函数的定义**：

```python
class Model(torch.nn.Module):
    def __init__(self):
        super(Model, self).__init__()
        self.l1 = torch.nn.Linear(784, 512)
        self.l2 = torch.nn.Linear(512, 256)
        self.l3 = torch.nn.Linear(256, 128)
        self.l4 = torch.nn.Linear(128, 64)
        self.l5 = torch.nn.Linear(64, 10)
        
    def forward(self, x):
        x = x.view(-1, 784) # Convert image matrix to vector
        x = F.relu(self.l1(x))
        x = F.relu(self.l2(x))
        x = F.relu(self.l3(x))
        x = F.relu(self.l4(x))
        return self.l5(x)
    
model = Model()

criterion = torch.nn.CrossEntropyLoss()
optimizer = optim.SGD(model.parameters(), lr = 0.01, momentum = 0.5)
```

在博客 [2] 中，我们就提到过：在多分类问题中，神经网络的输出层是不会连接激活函数的，而是在连接了一个Softmax层后传入多分类交叉熵损失函数中计算损失值；并且在博客 [4] 中提到，无论是对于二分类任务还是多分类任务，“*更方便的处理方式是直接将模型对于每一类的预测概率都计算出来，之后直接做矩阵运算。*”例如，对于一个三个样本的Mini-batch，计算损失函数有：

$$
\begin{split}
loss=&-\dfrac13\times\sum_{i=0}^2p(v_i)\log\hat{p}(v_i)\\
=&-\dfrac13\times\mathrm{sum}\Big(
\begin{bmatrix}
0&1&0&0&0&0&0&0&0&0\\
0&0&0&0&0&0&0&1&0&0\\
1&0&0&0&0&0&0&0&0&0\\
\end{bmatrix}\cdot\\
&\log
\begin{bmatrix}
\mathrm{XX}&0.9&\mathrm{XX}&\mathrm{XX}&\mathrm{XX}&\mathrm{XX}&\mathrm{XX}&\mathrm{XX}&\mathrm{XX}&\mathrm{XX}\\
\mathrm{XX}&\mathrm{XX}&\mathrm{XX}&\mathrm{XX}&0.7&\mathrm{XX}&\mathrm{XX}&\mathrm{0.1}&\mathrm{XX}&\mathrm{XX}\\
0.8&\mathrm{XX}&\mathrm{XX}&\mathrm{XX}&\mathrm{XX}&\mathrm{XX}&\mathrm{XX}&\mathrm{XX}&\mathrm{XX}&\mathrm{XX}\\
\end{bmatrix}
\Big)\\
=&-\dfrac13\times\log\Big(
\begin{bmatrix}
0.9\\
0.1\\
0.8
\end{bmatrix}
\Big)\\
=&0.8770
\end{split}\notag
$$

其中，$\hat{p}(v_i)$是模型预测样本属于类别$v_i$的概率；而$p(v_i)$表示样本的标签（例如，对于这三个样本，其标签分别是“数字1”，“数字8”和“数字0”），这种标签的编码方式称为**One-hot coding（独热编码）**，这是很常见的一种编码方式。

在上面的代码中，我们并没有看到（1）Softmax层，以及（2）0-9的定类标签向独热编码方式的转换。这是因为这两个步骤都集成在了多分类交叉熵损失函数`torch.nn.CrossEntropyLoss`的定义中 [5] ：

![image-20230411160800983](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230411160800983.png?raw=true)

![image-20230411131637395](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230411131637395.png?raw=true)

<br>

# Train and Test

最后，为了简化代码，将一个训练Epoch封装成`train`函数，将测试过程封装成了`test`函数：

```python
def train(epoch):
    for batch_idx, data in enumerate(train_loader, 0):
        inputs, target = data
        optimizer.zero_grad()
        outputs = model(inputs)
        loss = criterion(outputs, target)
        loss.backward()
        optimizer.step()

        if batch_idx % 300 == 299: # Display error per 300 iterations, avoid consuming computing power
            print('[%d, %5d] loss: %.4f' % (epoch + 1, batch_idx + 1, loss.item()))

def test():
    correct = 0
    total = 0
    with torch.no_grad(): # Do NOT calculate gradients in the following process
        for data in test_loader:
            images, labels = data
            outputs = model(images)
            _, predicted = torch.max(outputs.data, dim = 1)
            total += labels.size(0)
            correct += (predicted == labels).sum().item()
    print('Accuracy on test set: %d %%' % (100 * correct / total))

if __name__ == '__main__':
    for epoch in range(5):
        train(epoch)
        test()
```

在测试过程中，`outputs.data`是一个`64x10`的Tensor，`predicted`是模型预测的标签。

```
# A example of `outputs.data`
tensor([[ -1.9499,  -1.8292,   0.9675,   1.7405,  -2.4406,   4.3613,  -2.7664,
          -5.0951,   8.0349,   0.9609],
        [  3.2935,  -7.6775,   7.2356,  -1.0674,   0.8418,   2.9343,   8.4482,
          -8.7703,   2.1215,  -3.4858],
        ...
        [ -0.1071,  -2.6978,   6.3490,   1.1409,  -0.9854,   0.1142,   3.1247,
          -1.2822,  -0.3963,  -1.3028],
        [ 17.9995, -17.4895,   2.2375,   4.7681,  -8.1000,  11.8248,  -2.4182,
          -5.1491,   1.4056,  -4.1952]])
# Corresponding `predicted`
tensor([8, 6, 
        ... 
        2, 0])
```

这里也侧面验证了`Softmax`函数是集成在`torch.nn.CrossEntropyLoss`的定义中，神经网络的输出并不是$[0,1]$之间。

<br>

# Complete Code

```python
import torch
from torchvision import transforms
from torchvision import datasets
from torch.utils.data import DataLoader
import torch.nn.functional as F
import torch.optim as optim
import numpy as np

batch_size = 64
transform = transforms.Compose([
    transforms.ToTensor(),
    transforms.Normalize((0.1370, ),(0.3081, ))
])

train_dataset = datasets.MNIST(root = 'mnist',
                               train = True,
                               download = True,
                               transform = transform)

train_loader = DataLoader(train_dataset,
                          shuffle = True,
                          batch_size = batch_size)

test_dataset = datasets.MNIST(root = 'mnist',
                               train = False,
                               download = True,
                               transform = transform)

test_loader = DataLoader(test_dataset,
                          shuffle = False,
                          batch_size = batch_size)

class Model(torch.nn.Module):
    def __init__(self):
        super(Model, self).__init__()
        self.l1 = torch.nn.Linear(784, 512)
        self.l2 = torch.nn.Linear(512, 256)
        self.l3 = torch.nn.Linear(256, 128)
        self.l4 = torch.nn.Linear(128, 64)
        self.l5 = torch.nn.Linear(64, 10)
        
    def forward(self, x):
        x = x.view(-1, 784) # Convert image matrix to vector
        x = F.relu(self.l1(x))
        x = F.relu(self.l2(x))
        x = F.relu(self.l3(x))
        x = F.relu(self.l4(x))
        return self.l5(x)
    
model = Model()

criterion = torch.nn.CrossEntropyLoss()
optimizer = optim.SGD(model.parameters(), lr = 0.01, momentum = 0.5)

def train(epoch):
    for batch_idx, data in enumerate(train_loader, 0):
        inputs, target = data
        optimizer.zero_grad()
        outputs = model(inputs)
        loss = criterion(outputs, target)
        loss.backward()
        optimizer.step()

        if batch_idx % 300 == 299: # Display error per 300 iterations, avoid consuming computing power
            print('[%d, %5d] loss: %.4f' % (epoch + 1, batch_idx + 1, loss.item()))

def test():
    correct = 0
    total = 0
    with torch.no_grad(): # Do NOT calculate gradients in the following process
        for data in test_loader:
            images, labels = data 
            outputs = model(images)
            _, predicted = torch.max(outputs.data, dim = 1)
            total += labels.size(0)
            correct += (predicted == labels).sum().item()
    print('Accuracy on test set: %d %%' % (100 * correct / total))
    
if __name__ == '__main__':
    for epoch in range(5):
        train(epoch)
        test()
```

<br>

# References

[1] [09.多分类问题 - 刘二大人](https://www.bilibili.com/video/BV1Y7411d7Ys?p=9&vd_source=8aeddead7f39b0189fff9b14fa090a75).

[2] [Constructing A Simple MLP for Diabetes Dataset Binary Classification Problem with PyTorch (Load Datasets using PyTorch DataSet and DataLoader) - What a starry night~](http://whatastarrynight.com/machine learning/python/Constructing-A-Simple-MLP-for-Diabetes-Dataset-Binary-Classification-Problem-with-PyTorch/).

[3] Ioffe, Sergey, and Christian Szegedy. "Batch normalization: Accelerating deep network training by reducing internal covariate shift." *International conference on machine learning*. pmlr, 2015. http://proceedings.mlr.press/v37/ioffe15.html.

[4] [Entropy, Cross entropy, KL Divergence and Their Relation - What a starry night~](http://whatastarrynight.com/mathematics/machine learning/signals and systems/uncertainty/matlab/Entropy-Cross-Entropy-KL-Divergence-and-their-Relation/).

[5] [CrossEntropyLoss - PyTorch 2.0 documentation](https://pytorch.org/docs/stable/generated/torch.nn.CrossEntropyLoss.html#torch.nn.CrossEntropyLoss).
