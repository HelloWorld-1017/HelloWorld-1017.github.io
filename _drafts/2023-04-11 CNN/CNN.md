

# Introduction

在博客XX中：







如果我们的神经网络都是由线性层串行地连接起来，我们就把它叫做全连接神经网络(Fully Connected Neural Network，也有叫Dnese/Deep Connected，所以就有人叫这种网络为**DNN**)，层与层各节点之间都有权重连接，任意一个节点都要参与到下一层的计算中。所以把这种线性层也叫做全连接层。



在全连接层处理图像的时候，第一步要把图像数据拉成一个长向量，这样就丧失了已有的**空间结构的信息**。CNN是直接按照图像的空间结构进行保存，从而保存原始的空间信息。



在使用下采样时（Subsampling），通道数是不改变的。

前面的卷积运算实际上就是（自动）特征提取的工作（Feature extraction），后面全连接层的部分用于分类（Classification），实现了一个End-to-End的特征提取：

![image-20230411222929745](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20230411222929745.png)

在整个流程中的特征提取阶段，我们主要使用了卷积层（Convolution layer）和最大池化层（Max



栅格图像；

![image-20230411200810833](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20230411200810833.png)

也就是说，对于一个3通道的图像，做一个$3\times3$的卷积运算，最后只有一个通道！！！

![image-20230411201046798](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20230411201046798.png)

同样地，对于输入通道为$n$的输入做卷积，输出的结果同样只有一个通道！！！

![image-20230411201311121](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20230411201311121.png)





![image-20230411201747790](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20230411201747790.png)

- 每一个卷积核的通道数量要求和输入的通道数量是一样的，即$n$个；
- 卷积核的总数是和输出的通道数量是一样的，即$m$个；
- 因此，卷积卷积核实际上是一个4维的张量。

![image-20230411201912189](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20230411201912189.png)





一个简单的算例：

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
print(conv_layer.weight.shape)
```

```python
torch.Size([1, 5, 100, 100])
torch.Size([10, 5, 3, 3])
torch.Size([10, 5, 3, 3])
```





常见的参数：

1. padding， same参数   

# Convolution Layer

## `padding` property

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

```python
tensor([[[[ 91., 168., 224., 215., 127.],
          [114., 211., 295., 262., 149.],
          [192., 259., 282., 214., 122.],
          [194., 251., 253., 169.,  86.],
          [ 96., 112., 110.,  68.,  31.]]]], grad_fn=<ConvolutionBackward0>)
```

与预期的结果是一致的：

![image-20230411212155975](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20230411212155975.png)

## `stride` property

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

```python
tensor([[[[211., 262.],
          [251., 169.]]]], grad_fn=<ConvolutionBackward0>)
```

与预期结果一致：

![image-20230411213139008](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20230411213139008.png)

# Max-Pooling Layer

最大池化层（Max-Pooling），没有权重（无参数的层，因此不需要优化），默认参数stride=2；

找最大值；

```python
import torch

input = [3,4,6,5,
         2,4,6,8,
         1,6,7,8,
         9,7,4,6]

input = torch.Tensor(input).view(1,1,4,4)

maxpooling_layer = torch.nn.MaxPool2d(kernel_size=2)

output = maxpooling_layer(input)
print(output)
```

```python
tensor([[[[4., 8.],
          [9., 8.]]]])
```

![image-20230411213844287](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20230411213844287.png)

一个很明显的特点是：打印输出的时候是不显示`grad_fn=<ConvolutionBackward0>`的；

先讨论形状是奇数的情况下的最大池化层；





池化层似乎都是无参的;

## `AcgPool2d` layer

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

```python
tensor([[[[3.2500, 6.2500],
          [5.7500, 6.2500]]]])
```

实际中根据需要使用，在本博客的示例中，我们仅仅使用最大池化层。

<br>

# Model Architecture

（整体的结构图，PPT）



卷积层和池化层是不太在乎输入的大小，但是最后的分类器是必须要知道大小的。

但是有一个偷懒的方法，就是构建模型的时候先不定义全连接层，只定义到Feature extraction的阶段，然后给一个随机的输入，输出一下结果看一下



![image-20230411203257722](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20230411203257722.png)

==手算一下，然后找函数验证一下==

<br>

使用GPU加速

（1）把模型迁移到GPU上；

```python
device = torch.deivce("cuda:0" if torch.cuda._available() else "cpu")
model.to(device)
```

（2）把数据和标签都迁移到GPU上；但是要注意，模型和数据需要放在同一块显卡上；





<br>

**References**

[1] [10.卷积神经网络（基础篇）- 刘二大人](https://www.bilibili.com/video/BV1Y7411d7Ys?p=10&vd_source=8aeddead7f39b0189fff9b14fa090a75).







