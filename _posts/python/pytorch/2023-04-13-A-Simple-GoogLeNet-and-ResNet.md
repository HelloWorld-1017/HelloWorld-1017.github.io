---
title: A Simple GoogLeNet and ResNet for Solving MNIST Image Classification with PyTorch
categories: 
 - Machine Learning
 - Python
tags:
 - Python PyTorch
 - Computer Vision
date: 2023-04-13 21:32:29 +0800
last_modified_at: 2024-10-05 20:21:14 +0800
---

# Introduction

在博客[^1]中，我们讨论了了如何构建一个CNN来实现MNIST手写数据集的分类问题。本博客将继续学习两个更复杂的神经网络结构，GoogLeNet和ResNet，主要讨论一下如何使用PyTorch构建复杂的神经网络。

<br>

# GoogLeNet

## Methodology

GoogLeNet于2015年提出[^3]：

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230412234527217.png?raw=true"/>

在定义神经网络的时候，有些参数是比较难选的，例如卷积核的大小。GoogLeNet的出发点是：既然不知道多大的卷积核好用，那么就在一个 **Inception** 中都构造一下（btw，电影《盗梦空间》的英文名称就是Inception ），最后将不同branch的输出拼接（concatenate）：

![image-20230413122449428](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230413122449428.png?raw=true)

如果$3\times3$的效果好，那么在训练的过程中$3\times3$这个路径上的权重就会变得比较大，变得比较重要，其他路线上的权重就会变小。它是通过**提供几种候选的CNN的配置，通过训练自动地在这几条路里面找到最优的卷积的组合**。

要想使得多个branch的输出可以拼接到一起，**就必须保证每个branch输出的Height和Width是一致的，唯一的不同是Channel的大小**，最后沿着Channel这个维度将输出拼接起来：

![image-20230413122924591](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230413122924591.png?raw=true)

为了能够保证每个branch输出的Height和Width是一致的，我们就需要对每一个branch中的卷积层的`padding`属性和`stride`属性进行设计。

## $1\times1$ Convolution (NIN)

在上面的Inception module中，我们可以看到一个比较特殊的卷积层，即$1\times1$的卷积。实际上，它的原理和其他的卷积层并没有区别，它的功能是融合input中相同位置的所有信息：

![image-20230413195039110](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230413195039110.png?raw=true)

而它最重要的作用是**以一种低计算资源的方式改变通道的数量**。

例如，假如我们想要使得通道的数量由192降低到32，如果我们使用$5\times5$（padding=2）的卷积层，则降低通道数量这一操作大概需要120 million次运算：

![image-20230413122219174](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230413122219174.png?raw=true)

而使用$5\times5$的卷积层，则只需要大概12 million次运算，计算量大概只有之前的1/10，极大地节省了计算资源：

![image-20230413122241092](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230413122241092.png?raw=true)

这对于深度神经网络的训练是非常有益的。有的时候，也把这种$1\times1$的卷积核叫做Network in Network（NiN）[^4][^5]。

## Implementation of Inception Module and model definition (for MNIST classification problem)

在面向对象编程的过程中，为了减少代码的冗余（重复），通常会把相似的结构用类封装起来，因此我们可以首先为上面的Inception module封装成一个类`InceptionA`（继承自`torch.nn.Module`）：

```python
class InceptionA(nn.Module): 
    def __init__(self, in_channels):
        super(InceptionA, self).__init__()
        
        # The first branch (Pooling branch)：output 24 channels
        self.branch_pool = nn.Conv2d(in_channels,24,kernel_size=1)
        # Output size ：28 + 2*1 - (3-1) - 1 + 1 = 28
        
        # The second branch: output 16 channels
        self.branch1x1 = nn.Conv2d(in_channels,16,kernel_size=1)
        # Output size：28
        
        # The third branch: output 24 channels
        self.branch5x5_1 = nn.Conv2d(in_channels,16,kernel_size=1) # 1x1 convolution
        self.branch5x5_2 = nn.Conv2d(16,24,kernel_size=5,padding=2)# 5x5 convolution
        # Output size：28+2*2-1*(5-1)-1 +1 = 28
        
        # The fourth branch: output 24 channels
        self.branch3x3_1 = nn.Conv2d(in_channels,16,kernel_size=1) # 1x1 convolution
        self.branch3x3_2 = nn.Conv2d(16,24,kernel_size=3,padding=1)# 3x3 convolution
        self.branch3x3_3 = nn.Conv2d(24,24,kernel_size=3,padding=1)# 3x3 convolution
        # Output size：28 + [2*1-(3-1)-1 + 1] + [2*1-(3-1)-1 +1] = 28

    def forward(self, x):
        # The first branch (Pooling branch)
        branch_pool = F.avg_pool2d(x,kernel_size=3,stride=1,padding=1) # 池化层默认stride = kernel_size
        branch_pool = self.branch_pool(branch_pool)
        
        # The second branch
        branch1x1 = self.branch1x1(x)
        
        # The third branch
        branch5x5 = self.branch5x5_1(x)
        branch5x5 = self.branch5x5_2(branch5x5)
        
        # The fourth branch
        branch3x3 = self.branch3x3_1(x)
        branch3x3 = self.branch3x3_2(branch3x3)
        branch3x3 = self.branch3x3_3(branch3x3)

        outputs = [branch1x1,branch5x5,branch3x3,branch_pool]
        return torch.cat(outputs,dim=1) # Concatenate outputs
```

这个类的主要作用是定义各个branch，最后按照Channel拼接在一起，最终输出的形状为（$Batch\times88\times W\times H$），即这个模块不改变输入的大小，仅改变通道数。

在定义完`InceptionA`类后，就可以在构建模型中进行实例化：

```python
class Net(torch.nn.Module):
    def __init__(self):
        super(Net, self).__init__()
        # Define convolution layer
        self.conv1 = torch.nn.Conv2d(1,10,kernel_size=5)
        self.conv2 = torch.nn.Conv2d(88,20,kernel_size=5)
        
        # Instantiate InceptionA module
        self.incep1 = InceptionA(in_channels=10)
        self.incep2 = InceptionA(in_channels=20)
        
        # Max-pooling layer
        self.mp = torch.nn.MaxPool2d(kernel_size=2)
        
        # Fully-connected layer
        self.fc = torch.nn.Linear(1408, 10)
        
    def forward(self, x):
        batch_size = x.size(0)
        x = F.relu(self.mp(self.conv1(x))) # Output 10 channels
        x = self.incep1(x)                 # Output 88 channels
        
        x = F.relu(self.mp(self.conv2(x))) # Output 20 channels
        x = self.incep2(x)                 # Output 88 channels 
        x = x.view(batch_size, -1)
        x = self.fc(x)
        
        return x

model = Net()
```

可以查看一下整个GoogLeNet的结构和参数：

```python
from torchsummary import summary
summary(model, input_size=(1,28,28), batch_size=-1)
```

```
----------------------------------------------------------------
        Layer (type)               Output Shape         Param #
================================================================
            Conv2d-1           [-1, 10, 24, 24]             260
         MaxPool2d-2           [-1, 10, 12, 12]               0
            Conv2d-3           [-1, 24, 12, 12]             264
            Conv2d-4           [-1, 16, 12, 12]             176
            Conv2d-5           [-1, 16, 12, 12]             176
            Conv2d-6           [-1, 24, 12, 12]           9,624
            Conv2d-7           [-1, 16, 12, 12]             176
            Conv2d-8           [-1, 24, 12, 12]           3,480
            Conv2d-9           [-1, 24, 12, 12]           5,208
       InceptionA-10           [-1, 88, 12, 12]               0
           Conv2d-11             [-1, 20, 8, 8]          44,020
        MaxPool2d-12             [-1, 20, 4, 4]               0
           Conv2d-13             [-1, 24, 4, 4]             504
           Conv2d-14             [-1, 16, 4, 4]             336
           Conv2d-15             [-1, 16, 4, 4]             336
           Conv2d-16             [-1, 24, 4, 4]           9,624
           Conv2d-17             [-1, 16, 4, 4]             336
           Conv2d-18             [-1, 24, 4, 4]           3,480
           Conv2d-19             [-1, 24, 4, 4]           5,208
       InceptionA-20             [-1, 88, 4, 4]               0
           Linear-21                   [-1, 10]          14,090
================================================================
Total params: 97,298
Trainable params: 97,298
Non-trainable params: 0
----------------------------------------------------------------
Input size (MB): 0.00
Forward/backward pass size (MB): 0.35
Params size (MB): 0.37
Estimated Total Size (MB): 0.72
----------------------------------------------------------------
```

## Complete code implementation

```python
import torch
from torchvision import transforms
from torchvision import datasets
from torch.utils.data import DataLoader
import torch.nn.functional as F
import torch.optim as optim
import matplotlib.pyplot as plt
import torch.nn as nn
import datetime

# Prepare MNIST dataset: 28x28 pixels
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

class InceptionA(nn.Module): 
    def __init__(self, in_channels):
        super(InceptionA, self).__init__()
        
        # The first branch (Pooling branch)：output 24 channels
        self.branch_pool = nn.Conv2d(in_channels,24,kernel_size=1)
        # Output size ：28 + 2*1 - (3-1) - 1 + 1 = 28
        
        # The second branch: output 16 channels
        self.branch1x1 = nn.Conv2d(in_channels,16,kernel_size=1)
        # Output size：28
        
        # The third branch: output 24 channels
        self.branch5x5_1 = nn.Conv2d(in_channels,16,kernel_size=1) # 1x1 convolution
        self.branch5x5_2 = nn.Conv2d(16,24,kernel_size=5,padding=2)# 5x5 convolution
        # Output size：28+2*2-1*(5-1)-1 +1 = 28
        
        # The fourth branch: output 24 channels
        self.branch3x3_1 = nn.Conv2d(in_channels,16,kernel_size=1) # 1x1 convolution
        self.branch3x3_2 = nn.Conv2d(16,24,kernel_size=3,padding=1)# 3x3 convolution
        self.branch3x3_3 = nn.Conv2d(24,24,kernel_size=3,padding=1)# 3x3 convolution
        # Output size：28 + [2*1-(3-1)-1 + 1] + [2*1-(3-1)-1 +1] = 28

    def forward(self, x):
        # The first branch (Pooling branch)
        branch_pool = F.avg_pool2d(x,kernel_size=3,stride=1,padding=1) # 池化层默认stride = kernel_size
        branch_pool = self.branch_pool(branch_pool)
        
        # The second branch
        branch1x1 = self.branch1x1(x)
        
        # The third branch
        branch5x5 = self.branch5x5_1(x)
        branch5x5 = self.branch5x5_2(branch5x5)
        
        # The fourth branch
        branch3x3 = self.branch3x3_1(x)
        branch3x3 = self.branch3x3_2(branch3x3)
        branch3x3 = self.branch3x3_3(branch3x3)

        outputs = [branch1x1,branch5x5,branch3x3,branch_pool]
        return torch.cat(outputs,dim=1) # Concatenate outputs
    
class Net(torch.nn.Module):
    def __init__(self):
        super(Net, self).__init__()
        # Define convolution layer
        self.conv1 = torch.nn.Conv2d(1,10,kernel_size=5)
        self.conv2 = torch.nn.Conv2d(88,20,kernel_size=5)
        
        # Instantiate InceptionA module
        self.incep1 = InceptionA(in_channels=10)
        self.incep2 = InceptionA(in_channels=20)
        
        # Max-pooling layer
        self.mp = torch.nn.MaxPool2d(kernel_size=2)
        
        # Fully-connected layer
        self.fc = torch.nn.Linear(1408, 10)
        
    def forward(self, x):
        batch_size = x.size(0)
        x = F.relu(self.mp(self.conv1(x))) # Output 10 channels
        x = self.incep1(x)                 # Output 88 channels
        
        x = F.relu(self.mp(self.conv2(x))) # Output 20 channels
        x = self.incep2(x)                 # Output 88 channels 
        x = x.view(batch_size, -1)
        x = self.fc(x)
        
        return x

model = Net()

criterion = torch.nn.CrossEntropyLoss()
optimizer = optim.SGD(model.parameters(), lr = 0.01, momentum = 0.5)

device = torch.device("cuda:0" if torch.cuda.is_available() else "cpu")
model.to(device)

def train(epoch):
    for batch_idx, data in enumerate(train_loader, 0):
        inputs, target = data
        inputs, target = inputs.to(device), target.to(device) 
        optimizer.zero_grad()
        
        outputs = model(inputs)
        loss = criterion(outputs, target)
        loss.backward()
        optimizer.step()
        
        if batch_idx % 300 == 299:
            print('[%d, %5d] loss:%.4f' % (epoch+1,batch_idx+1,loss.item()))

def test():
    correct = 0
    total = 0
    with torch.no_grad():
        for data in test_loader:
            images, labels = data 
            images, labels = images.to(device), labels.to(device) 
            outputs = model(images)
            
            _, predicted = torch.max(outputs.data, dim = 1)
            total += labels.size(0)
            correct += (predicted == labels).sum().item()
    print('Accuracy on test set: %.4f %%' % (100 * correct / total))
    return 100 * correct / total
    
if __name__ == '__main__':
    starttime = datetime.datetime.now()

    accuracies = []
    epoches = []
    for epoch in range(5):
        train(epoch)
        accuracy = test()
        accuracies.append(accuracy)
        epoches.append(epoch)

    plt.cla()
    plt.plot(epoches,accuracies,
             color='#0072BD', marker = 'o',label = 'Test accuracy',
             linewidth = 1,
             markersize = 3)
    plt.ylabel('Test accuracy (%)', fontsize = 20)
    plt.xlabel('Epoch', fontsize = 20)
    plt.plot([0, 10],[accuracies[-1], accuracies[-1]], 
             linestyle='--',
             color='#D95319')
    plt.axis([0,50,0,110])
    plt.xticks(fontsize = 20)
    plt.yticks(fontsize = 20)
    plt.text(1,accuracies[-1]+5,
             'Accuracy converge to: %.0f'%accuracies[-1]+'%',fontsize=10)
    plt.legend()
    plt.show()
    
    # # Save figure
    # fig = plt.gcf()
    # fig.set_size_inches(5, 5)
    # fig.savefig('fig11.svg')
 
    plt.rcParams['font.sans-serif'] = ['Times New Roman']
    plt.rcParams['axes.unicode_minus'] = False
    
    endtime = datetime.datetime.now()
    time_span = endtime - starttime
    print((endtime - starttime).seconds)
```

<br>

# ResNet

## Methodology

在CNN中，如果一直增加卷积层的数量，看上去网络更复杂了，但是实际上结果却变差了[^6]：

![image-20230413202202814](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230413202202814.png?raw=true)

并且，这并不是过拟合所导致的，因为训练准确率和测试准确率都下降了。其根本原因是在训练过程中出现了**梯度消失**的现象。因为在反馈更新梯度时，需要将一连串的梯度乘起来（链式法则），如果这些梯度值都小于1，那么乘积就会越来越小；随着训练参数的增多，乘积就会趋于零，权重就无法进行更新，在**离输入比较近的层就得不到训练**。

解决梯度消失的一种方式是逐层训练（Greedy layer-wise training）[^7]，每次就拿其中一个层进行训练，训练完成后就将这个层固定住，然后依次进行。但是如果对于深度神经网路这么做就非常困难，因为层数实在是太多了。

在2016年，何恺明等人提出了ResNet，就很优雅地解决了训练过程中梯度消失的问题[^6]。其基本思想是在网络中引入这样的Residual block：

![image-20230413204147840](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230413204147840.png?raw=true)

在前馈的过程中，将输入与输出**加和**。这使得在反馈过程中计算梯度时，梯度值是大于1的：

$$
\dfrac{\partial[\mathcal{F}(x)+x]}{\partial x}=\dfrac{\partial\mathcal{F}(x)}{\partial x}+1\notag
$$

但是为了保证输入与输出能够相加，**必须要保证Residual block的输出$\mathcal{F}(x)$与输入$x$的张量维度（四个维度）都是一样的**。

最终，会构建出这样一个神经网络：

![image-20230413205734707](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230413205734707.png?raw=true)

其中：

- 不同的颜色代表不同的size（Width和Height）；
- 虚线表示输入和输出的不同，因而不能直接连接。处理这种情况的方式是，要么直接不做连接，要么可以在连接的过程添加池化层，保证输入和输出维度一致。

## Implementation of Residual Block and model definition (for MNIST classification problem)

我们同样可以定义一个类`ResidualBlock`：

```python
# Define residual block
class ResidualBlock(torch.nn.Module):
    def __init__(self, channels):
        super(ResidualBlock, self).__init__()
        self.channels = channels
        self.conv1 = torch.nn.Conv2d(channels,channels,
                               kernel_size=3,padding=1)
        self.conv2 = torch.nn.Conv2d(channels,channels,
                               kernel_size=3,padding=1)
        
    def forward(self, x):
            y = F.relu(self.conv1(x))
            y = self.conv2(y)
            return F.relu(x + y) # Activate after plus
```

之后定义整个模型：

```python
class Net(torch.nn.Module):
    def __init__(self):
        super(Net, self).__init__()
        # Define convolution layer
        self.conv1 = torch.nn.Conv2d(1,16,kernel_size=5)
        self.conv2 = torch.nn.Conv2d(16,32,kernel_size=5)
        
        # Instantiate residual block
        self.rblock1 = ResidualBlock(16)
        self.rblock2 = ResidualBlock(32)
        
        # Define max-pooling layer
        self.mp = torch.nn.MaxPool2d(kernel_size=2)
        
        # Define fully-connected layer
        self.fc = torch.nn.Linear(512,10)
        
    def forward(self, x):
        batch_size = x.size(0)
        x = self.mp(F.relu(self.conv1(x)))
        x = self.rblock1(x)
        x = self.mp(F.relu(self.conv2(x)))
        x = self.rblock2(x)
        x = x.view(batch_size, -1)
        x = self.fc(x)
        
        return x
```

最终，查看整个模型的参数：

```python
model = Net()

from torchsummary import summary
summary(model, input_size=(1,28,28), batch_size=-1)
```

```
----------------------------------------------------------------
        Layer (type)               Output Shape         Param #
================================================================
            Conv2d-1           [-1, 16, 24, 24]             416
         MaxPool2d-2           [-1, 16, 12, 12]               0
            Conv2d-3           [-1, 16, 12, 12]           2,320
            Conv2d-4           [-1, 16, 12, 12]           2,320
     ResidualBlock-5           [-1, 16, 12, 12]               0
            Conv2d-6             [-1, 32, 8, 8]          12,832
         MaxPool2d-7             [-1, 32, 4, 4]               0
            Conv2d-8             [-1, 32, 4, 4]           9,248
            Conv2d-9             [-1, 32, 4, 4]           9,248
    ResidualBlock-10             [-1, 32, 4, 4]               0
           Linear-11                   [-1, 10]           5,130
================================================================
Total params: 41,514
Trainable params: 41,514
Non-trainable params: 0
----------------------------------------------------------------
Input size (MB): 0.00
Forward/backward pass size (MB): 0.17
Params size (MB): 0.16
Estimated Total Size (MB): 0.33
----------------------------------------------------------------
```

## Complete code implementation

```python
import torch
from torchvision import transforms
from torchvision import datasets
from torch.utils.data import DataLoader
import torch.nn.functional as F
import torch.optim as optim
import matplotlib.pyplot as plt
import datetime


# Prepare MNIST dataset
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

# Define residual block
class ResidualBlock(torch.nn.Module):
    def __init__(self, channels):
        super(ResidualBlock, self).__init__()
        self.channels = channels
        self.conv1 = torch.nn.Conv2d(channels,channels,
                               kernel_size=3,padding=1)
        self.conv2 = torch.nn.Conv2d(channels,channels,
                               kernel_size=3,padding=1)
        
    def forward(self, x):
            y = F.relu(self.conv1(x))
            y = self.conv2(y)
            return F.relu(x + y) # Activate after plus

class Net(torch.nn.Module):
    def __init__(self):
        super(Net, self).__init__()
        # Define convolution layer
        self.conv1 = torch.nn.Conv2d(1,16,kernel_size=5)
        self.conv2 = torch.nn.Conv2d(16,32,kernel_size=5)
        
        # Instantiate residual block
        self.rblock1 = ResidualBlock(16)
        self.rblock2 = ResidualBlock(32)
        
        # Define max-pooling layer
        self.mp = torch.nn.MaxPool2d(kernel_size=2)
        
        # Define fully-connected layer
        self.fc = torch.nn.Linear(512,10)
        
    def forward(self, x):
        batch_size = x.size(0)
        x = self.mp(F.relu(self.conv1(x)))
        x = self.rblock1(x)
        x = self.mp(F.relu(self.conv2(x)))
        x = self.rblock2(x)
        x = x.view(batch_size, -1)
        x = self.fc(x)
        
        return x

model = Net()

criterion = torch.nn.CrossEntropyLoss()
optimizer = optim.SGD(model.parameters(), lr=0.01, momentum=0.5)

device = torch.device("cuda:0" if torch.cuda.is_available() else "cpu")
model.to(device)

def train(epoch):
    for batch_idx, data in enumerate(train_loader, 0):
        inputs, target = data
        inputs, target = inputs.to(device), target.to(device)
        optimizer.zero_grad()
            
        outputs = model(inputs)
        loss = criterion(outputs, target)
        loss.backward()
        optimizer.step()
        
        if batch_idx % 300 == 299:
            print('[%d, %5d] loss:%3.f' % (epoch+1, batch_idx+1, loss.item()))

def test():
    correct = 0
    total = 0
    with torch.no_grad():
        for data in test_loader:
            images, labels = data 
            images, labels = images.to(device), labels.to(device) 
            outputs = model(images)
            
            _, predicted = torch.max(outputs.data, dim = 1)
            total += labels.size(0)
            correct += (predicted == labels).sum().item()
    print('Accuracy on test set: %d %%' % (100 * correct / total))
    return 100 * correct / total
    
if __name__ == '__main__':
    starttime = datetime.datetime.now()
    
    accuracies = []
    epoches = []
    for epoch in range(5):
        train(epoch)
        accuracy = test()
        accuracies.append(accuracy)
        epoches.append(epoch)

    plt.cla()
    plt.plot(epoches, accuracies,
             color = '#0072BD', marker = 'o',label = 'Test accuracy',
             linewidth = 1,
             markersize = 3)
    plt.ylabel('Test accuracy (%)', fontsize = 12)
    plt.xlabel('Eopch', fontsize = 12)
    plt.plot([0, 50],[accuracies[-1], accuracies[-1]], 
             linestyle = '--',
             color = '#D95319', )
    plt.axis([0, 50, 0, 110])
    plt.xticks(fontsize = 20)
    plt.yticks(fontsize = 20)
    plt.text(0, accuracies[-1]+5, 'Accuracy converge to: %.0f'% accuracies[-1] + '%', fontsize = 12)
    plt.legend()
    plt.show()
    
    # # Save figure
    # fig = plt.gcf()
    # fig.set_size_inches(5, 5)
    # fig.savefig('fig.svg')
    
    plt.rcParams['font.sans-serif'] = ['Times New Roman']
    plt.rcParams['axes.unicode_minus'] = False
    
    endtime = datetime.datetime.now()
    time_span = endtime - starttime
    print((endtime - starttime).seconds)
    
    import os
    torch.save(model, os.getcwd() + '\\ResNet_MNIST.pt') # Save model
```

## Extension

除了这种最基本的ResNet，何恺明等人的论文[^8] 给出了更多的Residual Block的结构设计：

![image-20230413211808540](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230413211808540.png?raw=true)

![image-20230413211823064](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230413211823064.png?raw=true)

![image-20230413212333131](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230413212333131.png?raw=true)

![image-20230413212411870](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230413212411870.png?raw=true)

以及Huang等人提出的DenseNet [^9]：

![image-20230413212540797](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230413212540797.png?raw=true)

<br>

# References

[^1]:  [Constructing A Simple CNN for Solving MNIST Image Classification with PyTorch - What a starry night~](http://whatastarrynight.com/machine learning/python/Constructing-A-Simple-CNN-for-Solving-MNIST-Image-Classification-with-PyTorch/).

[^3]: Szegedy, Christian, et al. “Going deeper with convolutions.” *Proceedings of the IEEE conference on computer vision and pattern recognition*. 2015. Available at: [https://www.cv-foundation.org/openaccess/content_cvpr_2015/html/Szegedy_Going_Deeper_With_2015_CVPR_paper.html](https://www.cv-foundation.org/openaccess/content_cvpr_2015/html/Szegedy_Going_Deeper_With_2015_CVPR_paper.html).
[^4]: Lin M, Chen Q, Yan S. Network in network[J]. arXiv preprint arXiv:1312.4400, 2013. Available at: [https://arxiv.org/abs/1312.4400]( https://arxiv.org/abs/1312.4400).
[^5]: [Network In Network](https://kobiso.github.io/research/research-NIN/).
[^6]: He, Kaiming, et al. “Deep residual learning for image recognition.” *Proceedings of the IEEE conference on computer vision and pattern recognition*. 2016. Available at: [https://openaccess.thecvf.com/content_cvpr_2016/html/He_Deep_Residual_Learning_CVPR_2016_paper.html](https://openaccess.thecvf.com/content_cvpr_2016/html/He_Deep_Residual_Learning_CVPR_2016_paper.html).

[^7]: Bengio Y, Lamblin P, Popovici D, et al. Greedy layer-wise training of deep networks[J]. Advances in neural information processing systems, 2006, 19. Available at: [https://proceedings.neurips.cc/paper_files/paper/2006/file/5da713a690c067105aeb2fae32403405-Paper.pdf](https://proceedings.neurips.cc/paper_files/paper/2006/file/5da713a690c067105aeb2fae32403405-Paper.pdf).

[^8]: He, Kaiming, et al. "Identity mappings in deep residual networks." *Computer Vision–ECCV 2016: 14th European Conference, Amsterdam, The Netherlands, October 11–14, 2016, Proceedings, Part IV 14*. Springer International Publishing, 2016. Available at: [https://link.springer.com/chapter/10.1007/978-3-319-46493-0_38](https://link.springer.com/chapter/10.1007/978-3-319-46493-0_38).

[^9]: Huang, Gao, et al. "Densely connected convolutional networks." *Proceedings of the IEEE conference on computer vision and pattern recognition*. 2017. Available at: [https://openaccess.thecvf.com/content_cvpr_2017/html/Huang_Densely_Connected_Convolutional_CVPR_2017_paper.html](https://openaccess.thecvf.com/content_cvpr_2017/html/Huang_Densely_Connected_Convolutional_CVPR_2017_paper.html).

- [11.卷积神经网络（高级篇）- 刘二大人](https://www.bilibili.com/video/BV1Y7411d7Ys?p=11&vd_source=8aeddead7f39b0189fff9b14fa090a75).
