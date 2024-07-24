---
title: Construct A Simple CNN for Solving MNIST Image Classification with PyTorch
categories: 
 - Machine Learning
 - Python
tags:
 - Python PyTorch
 - Computer Vision
 - PyTorch Warnings and Errors
date: 2023-04-13 17:28:01 +0800
last_modified_at: 2024-05-25 09:58:11 +0800
---

# Introduction

如果我们的神经网络都是由线性层串行地连接起来，层与层各节点之间都有权重连接，任意一个节点都要参与到下一层的计算中，这种线性层也被称为是全连接层（fully-connected layer），而由多层全连接层构成的网络也被称为全连接神经网络（Fully-Connected Neural Network，也有叫Dnese/Deep Connected，即**DNN**）。在博客 [2] 中，我们就把MNIST图像展开成一个向量，传入到了一个DNN中，实现了图像分类的问题。但是，在使用全连接层处理图像时，第一步就要把图像数据拉成一个长向量，这样的做法会丧失图像的**空间结构的信息**。卷积神经网络（Convolutional Neural Network, CNN）就可以在一定程度上解决这样的问题，卷积层的使用可以很好得保留图像的空间结构。一个基本的CNN结构如下图所示：

![image-20230411222929745](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230411222929745.png?raw=true)

相比于全连接神经网络，CNN有一些特殊之处：

- 卷积运算（Convolution）：由卷积层提供；
- 下采样运算（Subsampling）：由池化层提供。下采样的运算有很多种，对应着各种各样运算的池化层。在本博客的例子中，我们只采用了一种池化层，即最大池化层。
- 在整个CNN中，前面的卷积层和池化层实际上就是完成了（自动）特征提取的工作（Feature extraction），后面的全连接层的部分用于分类（Classification）。因此，CNN是一个End-to-End的神经网络结构。

下面就详细地学习一下CNN的各个部分。

<br>

# Convolution Layer

## Basic `in_channels`, `out_channels`, `kernel_size` properties

在生活中，当我们使用相机拍摄一个物体时，就会形成一个栅格图像（raster image）[3]。栅格图像是由一个一个像素点构成，每个像素点都由一个RGB元组来描述，从而形成对整个图像信息的精确描述。我们通常称这种彩色图像的RGB元组为RGB通道（channel）。

例如，对于一个$5\times5$的三通道的栅格图像做$3\times3$的卷积运算，最终可以得到一个通道：

![image-20230412092550862](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230412092550862.png?raw=true)

**并且需要强调的是，最后只有一个通道！！！**

![image-20230412092607313](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230412092607313.png?raw=true)

并且，对于输入通道为$n$的输入做卷积，输出的结果同样只有一个通道！！！

![image-20230411201311121](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230411201311121.png?raw=true)

如果我们想增加输出的通道数量，则需要增加卷积核的个数（即下图中的filter的个数）：

![image-20230412092654809](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230412092654809.png?raw=true)

最终，总结起来就是：

- 每一个卷积核的通道数量（`torch.nn.Conv2d`的`in_channels`参数）要求和输入的通道数量是一样的，即$n$个；

- 卷积核的总数（`torch.nn.Conv2d`的`out_channels`参数）是和输出的通道数量是一样的，即$m$个；

- 因此，卷积核实际上是一个4维的张量（`in_channels`，`out_channels`，`kernel_size`(int or tuple)）：

  ![image-20230412092713434](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230412092713434.png?raw=true)

下面就简单验证一下$1\times10\times3\times3$的卷积核对$1\times5\times100\times100$的图像的改变：

```python
import torch

in_channels, out_channels = 5,10
width, height = 100,100
kernel_size = 3
batch_size = 1

input = torch.randn(batch_size, # Batch
                    in_channels,# Channels
                    width,      # Width
                    height)     # Height

conv_layer = torch.nn.Conv2d(in_channels,
                            out_channels,
                            kernel_size=kernel_size)

output = conv_layer(input)

print(input.shape)
print(conv_layer.weight.shape)
print(output.shape)
```

```
torch.Size([1, 5, 100, 100])
torch.Size([10, 5, 3, 3])
torch.Size([1, 10, 98, 98])
```

## `padding` property

`padding`是卷积层`torch.nn.Conv2d`的一个重要的属性。如果设置`padding=1`，则会在输入通道的四周补上一圈零元素，从而改变output的size：

![image-20230411212155975](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230411212155975.png?raw=true)

可以使用代码简单验证一下：

```python
import torch

input = [3,4,6,5,7,
         2,4,6,8,2,
         1,6,7,8,4,
         9,7,4,6,2,
         3,7,5,4,1]
input = torch.Tensor(input).view(1,1,5,5) # BCWH

conv_layer = torch.nn.Conv2d(1, 1, 
                             kernel_size=3,
                             padding=1,
                             bias=False)

kernel = torch.Tensor([1,2,3,4,5,6,7,8,9]).view(1,1,3,3)
conv_layer.weight.data = kernel.data # Initial kernel weight

output = conv_layer(input)
print(output)
```

```
tensor([[[[ 91., 168., 224., 215., 127.],
          [114., 211., 295., 262., 149.],
          [192., 259., 282., 214., 122.],
          [194., 251., 253., 169.,  86.],
          [ 96., 112., 110.,  68.,  31.]]]], grad_fn=<ConvolutionBackward0>)
```

与预期的结果是一致的。

## `stride` property

`torch.nn.Conv2d`还有一个常用的属性是`stride`，表示卷积核每次移动的步长：

![image-20230411213139008](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230411213139008.png?raw=true)

```python
import torch

input = [3,4,6,5,7,
         2,4,6,8,2,
         1,6,7,8,4,
         9,7,4,6,2,
         3,7,5,4,1]
input = torch.Tensor(input).view(1,1,5,5)

conv_layer = torch.nn.Conv2d(1,1,
                             kernel_size=3,
                             stride=2,
                             bias=False)

kernel = torch.Tensor([1,2,3,4,5,6,7,8,9]).view(1,1,3,3)
conv_layer.weight.data = kernel.data # Initial kernel weight

output = conv_layer(input)
print(output)
```

```
tensor([[[[211., 262.],
          [251., 169.]]]], grad_fn=<ConvolutionBackward0>)
```

同样与预期结果一致。

## What if the convolution kernel size is greater than the input size? (`padding='same'`)

从上面的几个例子中可以看到，卷积核以及相关参数的设置可以改变输入数据的size（Height和Width），并且官网给出了详细的用于计算输出size的公式：

![image-20230412154658739](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230412154658739.png?raw=true)

但在一般情况下，我们在设计CNN的时候，不用特别关注卷积核的size，**我们只需要保证前后相连的两个卷积层的通道数量匹配，CNN就可以正常计算下去**。

但是，如果input的size小于卷积核的size呢？（尽管这种情况并不常见。因为在通常情况下，我们选取的都是$5\times5$或者$3\times3$的卷积核，如果想要出现这种情景，则需要很多的卷积层以及后面所要讲到的池化层）

可以简单做一个尝试，试图让一个$5\times5$的卷积核来卷$2\times2$的输入：

```python
import torch

input = [3,4,
         2,4]
input = torch.Tensor(input).view(1,1,2,2) # BCWH

conv_layer = torch.nn.Conv2d(1, 1, 
                             kernel_size=5,
                             bias=False)

kernel = torch.Tensor(range((25))).view(1,1,5,5)
conv_layer.weight.data = kernel.data # Initial kernel weight

output = conv_layer(input)
print(output)
```

结果会报错：

```
RuntimeError: Calculated padded input size per channel: (2 x 2). Kernel size: (5 x 5). Kernel size can't be greater than actual input size
```

说明PyTorch不会对这种情况进行自动地处理。此时，我们需要使用`padding`参数向输入补充零元素。

（1）设置`padding=1`仍然不符合要求：

```
RuntimeError: Calculated padded input size per channel: (4 x 4). Kernel size: (5 x 5). Kernel size can't be greater than actual input size
```

（2）设置`padding=2`，则开始可以计算：

```
tensor([[[[194., 181.],
          [129., 116.]]]], grad_fn=<ConvolutionBackward0>)
```

这说明此时卷积核的左上角和padding后的input的左上角对齐后，卷积核的大小并不会超过padding后的input的size，因此可以计算。

（3）再进一步，如果设置`padding=3`：

```
tensor([[[[272., 259., 246., 233.],
          [207., 194., 181., 168.],
          [142., 129., 116., 103.],
          [ 77.,  64.,  51.,  38.]]]], grad_fn=<ConvolutionBackward0>)
```

则此时output的size会超过input的size。经过卷积层后，output的size反而增大了，这并不是人们期望卷积层所进行的工作（但的确有这种层的存在，即反卷积层/转置卷积层 [ConvTranspose2d - PyTorch 2.0 documentation](https://pytorch.org/docs/stable/generated/torch.nn.ConvTranspose2d.html#torch.nn.ConvTranspose2d)）。因此，实际上`torch.nn.Conv2d`的`padding`属性有一个`'same'`选项（[Conv2d  - PyTorch 2.0 documentation](https://pytorch.org/docs/stable/generated/torch.nn.Conv2d.html#torch.nn.Conv2d)），用于自动padding输入，使得卷积后的output的size与input的size是一致的：

![image-20230412161304970](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230412161304970.png?raw=true)

例如，对于上面这个例子，我们设置`padding='same'`，则输出的结果与`padding=2`的结果是一致的：

```
tensor([[[[194., 181.],
          [129., 116.]]]], grad_fn=<ConvolutionBackward1>)
```

在实际使用中，**`padding='same'`的设置非常常见且好用，它使得input经过卷积层后的size不发生改变，`torch.nn.Conv2d`仅仅改变通道的大小，而将“降维”的运算完全交给了其他的层来完成，例如后面所要提到的最大池化层**，固定size的输入经过CNN后size的改变是非常清晰的。

<br>

# Max-Pooling Layer

最大池化层（Max-Pooling Layer）是一种图像数据降维的方式（**注意：通道数不会发生改变**），它作用的方式和卷积层是类似的，直接上算例：

```python
import torch

input = [3,4,6,5,
         2,4,6,8,
         1,6,7,8,
         9,7,4,6]

input = torch.Tensor(input).view(1,1,4,4)

maxpooling_layer = torch.nn.MaxPool2d(kernel_size=2) # Default: stride=2

output = maxpooling_layer(input)
print(output)
```

```
tensor([[[[4., 8.],
          [9., 8.]]]])
```

![image-20230411213844287](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230411213844287.png?raw=true)

当输入是奇数层时：

```python
import torch

input = [3,4,6,
         2,4,6,
         1,6,7]

input = torch.Tensor(input).view(1,1,3,3)

maxpooling_layer = torch.nn.MaxPool2d(kernel_size=2)

output = maxpooling_layer(input)
print(output)
```

```
tensor([[[[4.]]]])
```

结果实际上和`stride`参数设置有关，对于`torch.nn.MaxPool2d`，它的`stride`参数默认值为2。当最大池化层步进的时候，如果发现会超过input的size，就会停止步进。如果我们设置`stride=1`，则结果为：

```
tensor([[[[4., 6.],
          [6., 7.]]]])
```

注：卷积层的`stride`参数也遵循类似的规则。
{: .notice--primary}

需要注意的一点是：**最大池化层时没有权重的（无参），因此它不需要优化**（这一点从上面输出的结果可以看出来，与卷积层的输出不同，最大池化层的输出没有`grad_fn=<ConvolutionBackward1>`的打印信息）。

## `AvgPool2d` layer

池化层有很多种类（[torch.nn - PyTorch 2.0 documentation](https://pytorch.org/docs/stable/nn.html#pooling-layers)），例如平均值池化层（[AvgPool2d - PyTorch 2.0 documentation](https://pytorch.org/docs/stable/generated/torch.nn.AvgPool2d.html#torch.nn.AvgPool2d)），其原理与最大池化层是类似的，只是选取最大值改为了取平均值：

```python
import torch

input = [3,4,6,5,
         2,4,6,8,
         1,6,7,8,
         9,7,4,6]

input = torch.Tensor(input).view(1,1,4,4)

maxpooling_layer = torch.nn.AvgPool2d(kernel_size=2)

output = maxpooling_layer(input)
print(output)
```

```
tensor([[[[3.2500, 6.2500],
          [5.7500, 6.2500]]]])
```

池化层似乎都是无参的。选用不同的池化层会改变损失函数的值，从而影响网络中其他训练参数的优化，因此在实际中可以根据需要使用，而在本博客的示例中，我们仅仅使用最大池化层。

<br>

# Model Architecture

最终，在这里为MNIST数据集的分类任务构建的CNN结构如下图所示：

![image-20230412200837414](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230412200837414.png?raw=true)

构建模型的代码为：

```python
class Net(torch.nn.Module):
    def __init__(self):  
        super(Net, self).__init__()
        # Define convolution layers
        self.conv1 = torch.nn.Conv2d(1, 10, kernel_size = 5)
        self.conv2 = torch.nn.Conv2d(10, 20, kernel_size = 5)
        # Define max-pooling layer
        self.pooling = torch.nn.MaxPool2d(kernel_size = 2)
        # Define fully-connected layer
        self.fc = torch.nn.Linear(320, 10)
        
    def forward(self, x):
        batch_size = x.size(0)
        x = F.relu(self.pooling(self.conv1(x)))
        x = F.relu(self.pooling(self.conv2(x)))
        x = x.view(batch_size, -1)
        x = self.fc(x)
        return x
```

我们在前面提到过，卷积层和池化层不太在乎输入的大小，在一般的情况下都可以进行计算，不会报错；但是当卷积部分的最后一层输出展开成一个向量时，我们需要知道展开成了一个多长的向量，以设置全连接层（分类器）神经元的个数。

一个小技巧是，在构建模型时先不定义全连接层，只定义到Feature extraction的阶段，然后给一个随机输入，看它经过前面的卷积运算后输出的size，最后再确定全连接层的神经元个数：

```python
import numpy as np
import torch
import torch.nn.functional as F

x = np.random.randint(0,1,(1,1,28,28))
x = torch.Tensor(x)

class Net(torch.nn.Module):
    def __init__(self):  
        super(Net, self).__init__()
        # Define convolution layers
        self.conv1 = torch.nn.Conv2d(1, 10, kernel_size = 5)
        self.conv2 = torch.nn.Conv2d(10, 20, kernel_size = 5)
        # Define max-pooling layer
        self.pooling = torch.nn.MaxPool2d(kernel_size = 2)
        # # Do NOT define fully-connected netwrok first
        # self.fc = torch.nn.Linear(320, 10)
        
    def forward(self, x):
        batch_size = x.size(0)
        x = F.relu(self.pooling(self.conv1(x)))
        x = F.relu(self.pooling(self.conv2(x)))
        x = x.view(batch_size, -1)
        # x = self.fc(x)
        return x
    
model = Net()
y = model(x)
print(y.size())
```

```
torch.Size([1, 320])
```

在整个CNN中，具有训练参数的层只有有三个，包括两个卷积层和一个全连接层，可训练的参数一共有：

$$
\Big[1\times10\times5\times5+10\ (bias)\Big]+\Big[10\times20\times5\times5+20\ (bias)\Big]+\Big[320\times10+10\ (bias)\Big]=8490\notag
$$

可以使用第三方工具`torchsummary`来验证一下 [4]：

```python
from torchsummary import summary
summary(model.cuda(), input_size=(1,28,28), batch_size=-1)
```

```

----------------------------------------------------------------
        Layer (type)               Output Shape         Param #
================================================================
            Conv2d-1           [-1, 10, 24, 24]             260
         MaxPool2d-2           [-1, 10, 12, 12]               0
            Conv2d-3             [-1, 20, 8, 8]           5,020
         MaxPool2d-4             [-1, 20, 4, 4]               0
            Linear-5                   [-1, 10]           3,210
================================================================
Total params: 8,490
Trainable params: 8,490
Non-trainable params: 0
----------------------------------------------------------------
Input size (MB): 0.00
Forward/backward pass size (MB): 0.07
Params size (MB): 0.03
Estimated Total Size (MB): 0.10
----------------------------------------------------------------
```

<br>

# CNN Training and Test

在定义完CNN的结构后，就可以进行模型的训练和测试了。最终，整体的代码为：

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

class Net(torch.nn.Module):
    def __init__(self):  
        super(Net, self).__init__()
        # Define convolution layers
        self.conv1 = torch.nn.Conv2d(1, 10, kernel_size = 5)
        self.conv2 = torch.nn.Conv2d(10, 20, kernel_size = 5)
        # Define max-pooling layer
        self.pooling = torch.nn.MaxPool2d(kernel_size = 2)
        # Define fully-connected layer
        self.fc = torch.nn.Linear(320, 10)
        
    def forward(self, x):
        batch_size = x.size(0)
        x = F.relu(self.pooling(self.conv1(x)))
        x = F.relu(self.pooling(self.conv2(x)))
        x = x.view(batch_size, -1)
        x = self.fc(x)
        return x

model = Net()

criterion = torch.nn.CrossEntropyLoss()
optimizer = optim.SGD(model.parameters(), lr = 0.01, momentum = 0.5)

# Use GPU if available
device = torch.device("cuda:0" if torch.cuda.is_available() else "cpu")
model.to(device)

def train(epoch):
    for batch_idx, data in enumerate(train_loader, 0):
        # Transfer the data and model to GPU or CPU
        inputs, target = data
        inputs, target = inputs.to(device), target.to(device)
        optimizer.zero_grad()
        
        outputs = model(inputs)
        loss = criterion(outputs, target)
        loss.backward()
        optimizer.step()
        
        if batch_idx % 300 == 299:
            print('[%d, %5d] loss:%.4f' % (epoch + 1, batch_idx + 1, loss.item()))

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
    for epoch in range(10):
        train(epoch)
        accuracy = test()
        accuracies.append(accuracy)
        epoches.append(epoch)

    plt.cla()
    plt.plot(epoches, accuracies,
             color = '#0072BD', marker = 'o',label = 'Test accuracy',
             linewidth = 1,
             markersize = 3)
    plt.ylabel('Test accuracy(%)', fontsize=20)
    plt.xlabel('Epoch', fontsize=20)
    plt.plot([0, 10],[accuracies[-1], accuracies[-1]], 
             linestyle = '--',
             color = '#D95319', )
    plt.axis([0, 10, 0, 110])
    plt.xticks(fontsize=20)
    plt.yticks(fontsize=20)
    plt.text(5, accuracies[-1]-8, 'Converge to: %.0f'% accuracies[-1] + '%', fontsize = 15)
    plt.legend(fontsize=20)
    plt.show()
    
    # # Save figure
    # fig = plt.gcf()
    # fig.set_size_inches(5, 5)
    # fig.savefig('fig.svg')
 
    plt.rcParams['font.sans-serif'] = ['Arial'] # SimHei
    plt.rcParams['axes.unicode_minus'] = False
    
    endtime = datetime.datetime.now()
    time_span = endtime - starttime
    print((endtime - starttime).seconds)
```

![image-20230412203438457](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230412203438457.png?raw=true)

<br>

# References

[1] [10.卷积神经网络（基础篇）- 刘二大人](https://www.bilibili.com/video/BV1Y7411d7Ys?p=10&vd_source=8aeddead7f39b0189fff9b14fa090a75).

[2] [Constructing A Simple Fully-Connected DNN for Solving MNIST Image Classification with PyTorch - What a starry night~](http://whatastarrynight.com/machine learning/python/Constructing-A-Simple-Fully-Connected-DNN-for-Solving-MNIST-Image-Classification-with-PyTorch/).

[3] [Raster vs. Vector Images - All About Images - Research Guides at University of Michigan Library](https://guides.lib.umich.edu/c.php?g=282942&p=1885352#:~:text=Raster (or bitmap) images are,together to create the image.).

[4] [torch小技巧之网络参数统计 torchstat & torchsummary - 张林克的博客](https://blog.csdn.net/weixin_45292794/article/details/108227437).



