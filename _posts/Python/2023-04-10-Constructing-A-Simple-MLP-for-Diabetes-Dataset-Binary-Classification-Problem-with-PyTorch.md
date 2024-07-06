---
layout: single
title: Construct A Simple MLP for Diabetes Dataset Binary Classification Problem with PyTorch (Load Datasets using PyTorch `DataSet` and `DataLoader`)
categories: 
 - Machine Learning
 - Python
tags:
 - Python PyTorch
 - Python Warnings and Errors
 - Computer Vision
date: 2023-04-10 13:44:03 +0800
last_modified_at0: 2023-04-10 13:44:03 +0800
last_modified_at1: 2024-04-22 20:45:10 +0800
last_modified_at2: 2024-05-22 20:55:31 +0800
last_modified_at3: 2024-05-25 09:59:18 +0800
last_modified_at4: 2024-06-13 22:14:27 +0800
last_modified_at: 2024-06-13 22:14:27 +0800
---

# Construct A Simple MLP for Diabetes Dataset Binary Classification Problem with PyTorch

本博客根据参考[^1]使用PyTorch框架搭建一个简单的MLP，以解决糖尿病数据集所对应的二分类问题：

```python
import torch
import numpy as np
import matplotlib.pyplot as plt

x = np.loadtxt('D:/Softwares/anaconda3/Lib/site-packages/sklearn/datasets/data/diabetes_data.csv.gz', delimiter = ' ', dtype = np.float32)
y = np.loadtxt('D:/Softwares/anaconda3/Lib/site-packages/sklearn/datasets/data/diabetes_target.csv.gz', delimiter = ' ', dtype = np.float32)
# 注意：y不是一个0~1之间的数，而是一个实数，所以直接用这个y不是分类问题，而是回归问题

y[y < 175] = 0
y[y >= 175] = 1
x_data = torch.from_numpy(x)
y_data = torch.from_numpy(y).view(y.size, 1) # y_需要是个矩阵

class Model(torch.nn.Module):
    def __init__(self):
        super(Model, self).__init__()
        self.linear1 = torch.nn.Linear(10,6)
        self.linear2 = torch.nn.Linear(6,4)
        self.linear3 = torch.nn.Linear(4,1)
        self.sigmoid = torch.nn.Sigmoid() # self.ReLU = torch.nn.ReLU()
        
    def forward(self, x):
        x = self.sigmoid(self.linear1(x))
        x = self.sigmoid(self.linear2(x))
        x = self.sigmoid(self.linear3(x))
        return x 

model = Model()

criterion = torch.nn.BCELoss(reduction = 'mean')
optimizer = torch.optim.SGD(model.parameters(), lr = 0.1)

for epoch in range(1000):
    y_pred = model(x_data) # 一个Batch直接进行训练，而没有采用mini-batch
   
    loss = criterion(y_pred, y_data)
    print(epoch, loss.item())
    
    optimizer.zero_grad()
    loss.backward()
    
    optimizer.step()
```

代码整体的构建思路与博客[^2]中所介绍的内容是一致的，不同的是这里使用的是一个benchmark数据集，并且构建了一个多层的神经网络，即MLP。因此，下面就主要对这两点做出一些解释。

（1）糖尿病数据集是一个具有多维特征的数据集，数据的标签可以是表示程度的实数，对应着一个回归问题；也可以根据这些实数标签来给样本定类，对应着一个二分类问题。上面的代码解决的就是转换后的二分类问题。

糖尿病数据集作为一个benchmark，在安装scikit-learn库时会一起下载下来，保存在`.../anaconda3/Lib/site-packages/sklearn/datasets/data/`文件夹下，代码采用绝对路径进行读取：

```python
x = np.loadtxt('D:/Softwares/anaconda3/Lib/site-packages/sklearn/datasets/data/diabetes_data.csv.gz', delimiter = ' ', dtype = np.float32)
y = np.loadtxt('D:/Softwares/anaconda3/Lib/site-packages/sklearn/datasets/data/diabetes_target.csv.gz', delimiter = ' ', dtype = np.float32)
```

其中，`.gz`文件是Linux系统中常用的压缩格式，在window环境下，python也能够读取这样的压缩格式文件；`dtype=np.float32`表示数据采用32位的浮点数保存。在神经网络计算中，通常都会使用32位的浮点数，因为一些常用的N卡的游戏卡GPU，1080，2080，它们只支持32位的浮点数计算。只有在那些比较专业的显卡，比如Tesla系列的显卡，才支持双精度（即64位）的数据计算。并且另一方面，对于训练神经网络而言，32位的浮点数计算已经足够用了。

（2）构建MLP模型的代码：

```python
class Model(torch.nn.Module):
    def __init__(self):
        super(Model, self).__init__()
        self.linear1 = torch.nn.Linear(10,6)
        self.linear2 = torch.nn.Linear(6,4)
        self.linear3 = torch.nn.Linear(4,1)
        self.sigmoid = torch.nn.Sigmoid()
        
    def forward(self, x):
        x = self.sigmoid(self.linear1(x))
        x = self.sigmoid(self.linear2(x))
        x = self.sigmoid(self.linear3(x))
        return x 
```

代码构建了的神经结构为：10-6($\sigma$)-4($\sigma$)-1($\sigma$)。

- 输入层神经元个数为10，对应着特征的数量；
- 输出层的神经元个数为1，对应着预测分类为1的概率；
- 具有两个隐藏层，神经元的个数分别为6和4；
- 在两个隐藏层和输出层后面，都添加了激活函数Sigmoid函数（即Logistic函数），使得MLP具有拟合复杂线性映射关系的能力；

神经网络的激活函数有很多种选择，如果选择使用ReLU激活函数，则需要注意一点：**输出层的激活函数不能使用ReLU**。因为ReLU会将输入值为负数的值都置零，这会导致在后面计算交叉熵损失时，可能会出现计算$\log(0)$的情景，这显然是不合适的。因此，输出层的激活函数仍然要使用Sigmoid函数：

```python
class Model(torch.nn.Module):
    def __init__(self):
        super(Model, self).__init__()
        self.linear1 = torch.nn.Linear(10, 6)
        self.linear2 = torch.nn.Linear(6, 4)
        self.linear3 = torch.nn.Linear(4, 1)
        self.activate = torch.nn.ReLU()
        self.sigmoid = torch.nn.Sigmoid()
        
    def forward(self, x):
        x = self.activate(self.linear1(x))
        x = self.activate(self.linear2(x))
        x = self.sigmoid(self.linear3(x))
        return x 
```

在解决多分类问题的时候，不会面临这样的问题。因为在输出层的后面通常不会选择连接Sigmoid或者ReLU的激活函数，而是直接连接一个Softmax层，其功能与Sigmoid函数是类似的，不会出现使用ReLU的场景。

<br>

# Loading Datasets and Realizing SGD using PyTorch `DataSet` and `DataLoader`

上面的代码在实现时并没有采用Mini-batch和SGD方法，在训练时更加可能会遇到鞍点问题[^3]，下面就使用PyTroch提供的工具类`Dataset`和`DataLoader`来实现SGD。

```python
import torch
from torch.utils.data import Dataset
from torch.utils.data import DataLoader

class DiabetesDataset(Dataset):
    def __init__(self):
        pass
    
    def __getitem__(self, index):
        pass
    
    def __len__(self):
        pass

dataset = DiabetesDataset()
train_loader = DataLoader(dataset=dataset,
                         batch_size=32,
                         shuffle=True,
                         num_workers=2)# Parallel threads: 2
```

（1）魔法方法`__getitem__`的定义，使得实例化`DiabetesDataset`后，能够支持下标操作，可以通过索引来挑选数据。

（2）魔法方法`__len__`能够返回数据集中数据的数量。

（3）对于`__init__`函数，我们有两种选择。一种是把所有的数据（包括特征和标签）都读取到内存中，在每次调用`__getitem__`时，就使用索引把数据拿出来。在数据集本身大小不大时，我们可以采用这种方式（例如在这里使用的Diabetes数据集），但是如果读取的是图像的数据集，可能大小有几十个G，这时候再在`__init__`中把所有数据读取到内存中显然是不合理的。在这种情况下，我们可以把图像文件都放在一个文件夹下，在`__init__`中仅把文件名列表读取到内存中。数据集标签也是一样的，如果只是做图像的分类，那么就可以直接把整个数据的标签都读取到内存中，但是假如我们想要做图像分割的任务，需要对整个图像的每个像素点进行分类，标签是一个和图像尺寸一致的矩阵，这时候需要对标签也采用“加载文件名列表”的方式处理，以保证内存的高效使用。

（4）上面的代码设置了`DataLoader`的`num_workers=2`，表示在读取Mini-batch时采用两个并行的线程。但是，在Windows平台下（PyTorch版本为0.4），如果直接使用dataLoader进行训练，会出现报错：

![image-20230410152956600](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230410152956600.png?raw=true)

![image-20230410152537722](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230410152537722.png?raw=true)

报错的原因是：在Linux和Windows平台下，实现多线程的库是不一样的。在Linux下调用多线程使用的`fork`，而Windows下采用的是`spawn`（这两个都是操作系统内核的C语言接口），它们处理多线程的方式不太一样[^4][^5]。要解决这样的问题，我们需要将使用`dataLoader`迭代的代码封装起来，封装到`if`语句中或者是封装在函数中，但是不能顶格写在程序中。

![image-20230410153115733](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230410153115733.png?raw=true)

但是在实际使用的时候，发现使用采用多线程的方式会明显降低训练速度，可能因为是CPU性能比较低。因此在下面的实现中，并没有设置`num_workers`的值。

最终实现的代码为：

```python
import numpy as np
import torch
from torch.utils.data import Dataset
from torch.utils.data import DataLoader
import matplotlib.pyplot as plt

class DiabetesDataset(Dataset):
    def __init__(self, filepath1, filepath2):
        x = np.loadtxt(filepath1, delimiter = ' ', dtype = np.float32)
        y = np.loadtxt(filepath2, delimiter = ' ', dtype = np.float32)
        y[y < 175] = 0
        y[y >= 175] = 1
        y = np.array([y]).reshape((y.size, 1))
        
        xy = np.hstack((x, y))
        
        self.len = xy.shape[0]
        self.x_data = torch.from_numpy(xy[:, :-1])
        self.y_data = torch.from_numpy(xy[:, [-1]])

    def __getitem__(self, index):
        return self.x_data[index], self.y_data[index] # Return a tuple

    def __len__(self):
        return self.len

dataset = DiabetesDataset('D:/Softwares/anaconda3/Lib/site-packages/sklearn/datasets/data/diabetes_data.csv.gz', 
                          'D:/Softwares/anaconda3/Lib/site-packages/sklearn/datasets/data/diabetes_target.csv.gz')

train_loader = DataLoader(dataset = dataset,
                          batch_size = 32, 
                          shuffle = True)
                          # num_workers=2)

class Model(torch.nn.Module):
    def __init__(self):
        super(Model, self).__init__()
        self.linear1 = torch.nn.Linear(10, 6)
        self.linear2 = torch.nn.Linear(6, 4)
        self.linear3 = torch.nn.Linear(4, 1)
        self.activate = torch.nn.ReLU()
        self.sigmoid = torch.nn.Sigmoid()
        
    def forward(self, x):
        x = self.activate(self.linear1(x))
        x = self.activate(self.linear2(x))
        x = self.sigmoid(self.linear3(x))
        return x

model = Model()

criterion = torch.nn.BCELoss(size_average = True)
optimizer = torch.optim.SGD(model.parameters(), lr = 0.1)

# if __name__ == '__main__':
loss_list = []
for epoch in range(1000):
    for i, data in enumerate(train_loader, 0):# 嵌套循环：使用mini-batch
    # 使用enumerate是为了获得当前是第几次epoch, i表示第i个Mini-Batch
    # train_loader拿出来的索引元组就放在data中；
        # 1) Prepare data
        inputs, lables = data 
        # inputs和lable是分别是X（特征值）和Y（标签）的矩阵，之后PyTorch自动地将它们转化为Tensor
        # 2) Forward
        y_pred = model(inputs)
        loss = criterion(y_pred, lables)
        print(epoch, i, loss.item())
        loss_list.append(loss.item())
        # 3) Backward
        optimizer.zero_grad()
        loss.backward()
        # 4) update
        optimizer.step()
        
ax = plt.subplot()
plt.plot(np.linspace(1,len(loss_list),len(loss_list)), loss_list)
plt.grid()
ax.set_xlabel('Iteration')
ax.set_ylabel('Loss value')
```

![image-20230410191800414](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230410191800414.png?raw=true)

可以看到这里的效果并不是很理想。

<br>

# Load Benchmark Dataset in `torchvision.datasets`

在`torchvision.datasets`中，内置了很多的benchmark数据集：

![image-20230410163320594](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230410163320594.png?raw=true)

它们都继承自`torch.utils.data.Dataset`，已经对`__getitem__`方法和`__len__`方法进行了定义。因此，在调用的时候就比较简单，不用重新继承`Dataset`类再自定义。例如，对于MNIST：

```python
import torch 
from torch.utils.data import DataLoader
from torchvision import transforms
from torchvision import datasets

train_dataset = datasets.MNIST(root='mnist',
                               train=True,
                               transform=transforms.ToTensor(), # Convert PIL Image (Python Image Library Image) to Tensor
                               download=True)

test_dataset = datasets.MNIST(root='mnist',
                              train=False,
                              transform=transforms.ToTensor(),
                              download=True)

train_loader = DataLoader(dataset=train_dataset,
                          batch_size=32,
                          shuffle=True)
test_loader = DataLoader(dataset=test_dataset,
                         batch_size=32,
                         shuffle=False)# Attention here
```

<br>

# References

[^1]: [07.处理多维特征的输入 - 刘二大人](https://www.bilibili.com/video/BV1Y7411d7Ys?p=7&vd_source=8aeddead7f39b0189fff9b14fa090a75).
[^2]: [Construct A Simple Logistic Regression Model for Binary Classification Problem with PyTorch - WHAT A STARRY NIGHT~](https://helloworld-1017.github.io/2023-04-09/16-38-03.html).
[^3]: [Simple Gradient Descend (GD) and Stochastic Gradient Descend (SGD) Methods Selecting Optimum Weight of Linear Model - WHAT A STARRY NIGHT~](https://helloworld-1017.github.io/2023-04-04/10-04-03.html).
[^4]: [`torch.utils.data`: Platform-specific behaviors — PyTorch 2.3 documentation](https://pytorch.org/docs/stable/data.html#platform-specific-behaviors).
[^5]: [TypeError: can't pickle Environment objects · Issue #526 · pytorch/examples](https://github.com/pytorch/examples/issues/526).

- [08.加载数据集 - 刘二大人](https://www.bilibili.com/video/BV1Y7411d7Ys?p=8&vd_source=8aeddead7f39b0189fff9b14fa090a75).

<br>



