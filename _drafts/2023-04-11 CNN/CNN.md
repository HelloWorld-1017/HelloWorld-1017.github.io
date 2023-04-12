

# Introduction

如果我们的神经网络都是由线性层串行地连接起来，层与层各节点之间都有权重连接，任意一个节点都要参与到下一层的计算中，这种线性层也被称为是全连接层（fully-connected layer），而由多层全连接层构成的网络也被称为全连接神经网络（Fully-Connected Neural Network，也有叫Dnese/Deep Connected，即**DNN**）。在博客 [2] 中，我们就把MNIST图像展开成一个向量，传入到了一个DNN中，实现了图像分类的问题。但是，在使用全连接层处理图像时，第一步就要把图像数据拉成一个长向量，这样的做法会丧失图像的**空间结构的信息**。卷积神经网络（Convolutional Neural Network, CNN）就可以在一定程度上解决这样的问题，卷积层的使用可以很好得保留图像的空间结构。一个基本的CNN结构如下图所示：

![image-20230411222929745](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20230411222929745.png)

相比于全连接神经网络，CNN有一些特殊之处：

- 卷积运算（Convolution）：由卷积层提供；
- 下采样运算（Subsampling）：由池化层提供。下采样的运算有很多种，对应着各种各样运算的池化层。在本博客的例子中，我们只采用了一种池化层，即最大池化层。
- 在整个CNN中，前面的卷积层和池化层实际上就是完成了（自动）特征提取的工作（Feature extraction），后面的全连接层的部分用于分类（Classification）。因此，CNN是一个End-to-End的神经网络结构。

下面就详细地学习一下CNN的各个部分。

<br>

# Convolution Layer

## `in_channels`, `out_channels`, `kernel_size` properties

在生活中，当我们使用相机拍摄一个物体时，就会形成一个栅格图像（raster image）[3]。栅格图像是由一个一个像素点构成，每个像素点都由一个RGB元组来描述，从而形成对整个图像信息的精确描述。我们通常称这种彩色图像的RGB元组为RGB通道（channel）。

例如，对于一个$5\times5$的三通道的栅格图像做$3\times3$的卷积运算，最终可以得到一个通道：

![image-20230412092550862](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/DeLLLaptop/image-20230412092550862.png)

**并且需要强调的是，最后只有一个通道！！！**

![image-20230412092607313](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/DeLLLaptop/image-20230412092607313.png)

并且，对于输入通道为$n$的输入做卷积，输出的结果同样只有一个通道！！！

![image-20230411201311121](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20230411201311121.png)

如果我们想增加输出的通道数量，则需要增加卷积核的个数（即下图中的filter的个数）：

![image-20230412092654809](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/DeLLLaptop/image-20230412092654809.png)

最终，总结起来就是：

- 每一个卷积核的通道数量（`torch.nn.Conv2d`的`in_channels`参数）要求和输入的通道数量是一样的，即$n$个；

- 卷积核的总数（`torch.nn.Conv2d`的`out_channels`参数）是和输出的通道数量是一样的，即$m$个；

- 因此，卷积核实际上是一个4维的张量（`in_channels`，`out_channels`，`kernel_size`(tuple)）：

  ![image-20230412092713434](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/DeLLLaptop/image-20230412092713434.png)

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

```python
torch.Size([1, 5, 100, 100])
torch.Size([10, 5, 3, 3])
torch.Size([1, 10, 98, 98])
```

## `padding` property

`padding`是卷积层`torch.nn.Conv2d`的一个重要的属性。如果设置`padding=1`，则会在输入通道的四周补上一圈0元素：

![image-20230411212155975](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20230411212155975.png)

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

```python
tensor([[[[ 91., 168., 224., 215., 127.],
          [114., 211., 295., 262., 149.],
          [192., 259., 282., 214., 122.],
          [194., 251., 253., 169.,  86.],
          [ 96., 112., 110.,  68.,  31.]]]], grad_fn=<ConvolutionBackward0>)
```

可以看到是与预期的结果是一致的。



padding， same参数   





## `stride` property

`torch.nn.Conv2d`还有一个属性是`stride`，表示卷积核每次移动的步长：![image-20230411213139008](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20230411213139008.png)

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

同样与预期结果一致。

<br>

# Max-Pooling Layer

**在使用下采样时（Subsampling），通道数是不改变的。**

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



下采样层的作用只是改变了损失函数的值，本身是无参的；

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

[2] [Constructing A Simple Fully-Connected DNN for Solving MNIST Image Classification with PyTorch - What a starry night~](http://whatastarrynight.com/machine learning/python/Constructing-A-Simple-Fully-Connected-DNN-for-Solving-MNIST-Image-Classification-with-PyTorch/).

[3] [Raster vs. Vector Images - All About Images - Research Guides at University of Michigan Library](https://guides.lib.umich.edu/c.php?g=282942&p=1885352#:~:text=Raster (or bitmap) images are,together to create the image.).



