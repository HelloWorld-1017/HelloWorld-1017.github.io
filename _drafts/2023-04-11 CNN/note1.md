串行结构；

讨论如何实现更复杂的结构；

<img src="https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20230412234527217.png"/>

GoogLeNet

在面向对象编程的过程中，为了减少代码的冗余（重复），把相似的结构用类封装起来

这一个块（蓝蓝红四个蓝）称为一个Inception（盗梦空间）

在定义神经网络的时候，有些参数是比较难选的。比如说卷积核的大小。GoogLeNet的出发点是：既然不知道多大的卷积核好用，那我就在Inception块中都用一下。如果$3\times3$的效果好，那么$3\times3$这个路径上的权重就会变得比较大，变得比较重要，其他路线上的权重就会变小。它是通过**提供几种候选的CNN的配置，通过训练自动地在这几条路里面找到最优的卷积的组合**。



根据通道Concatenate



要想最后再拼接到一块，那么必须保证图像的Height和Width是一致的，唯一不同的就是Channel。通过设置Average Pooling的padding和stride保证输入输出的大小是一样的；





$1\times1$ convolution，

融合了相同位置的所有信息；最重要的作用是改变通道的数量；







如果用$5\times5$的卷积核（padding=2）的卷积：运算量大概在120 million个，

![image-20230413122219174](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/DeLLLaptop/image-20230413122219174.png)

计算量大概只有之前的1/10，节省计算量：

![image-20230413122241092](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/DeLLLaptop/image-20230413122241092.png)

有的时候，也把这种$1\times1$的卷积核叫做Network in Network。

implementation of Inception Module



![image-20230413122449428](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/DeLLLaptop/image-20230413122449428.png)

定义好各个branch之后，按照Channel拼接在一起：

![image-20230413122924591](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/DeLLLaptop/image-20230413122924591.png)

将重复部分定义为InceptionA类，最后输出（Batch$\times$88$\times$w$\times$h），即这个模块不改变图片大小，仅改变通道数

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

Inception的初始输入通道`in_channels`没有写死，而是作为一个参数，这样在初始化的时候，就可以指明初始通道数是多少，









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





==看一下googlenet的论文，参考着画一下图像==

resnet，3x3的卷积核一直堆下去，看上去网络更复杂了，但是结果却变差了；



论文中指出，这并不是过拟合现象，因为训练的准确率也下降了；其原因是梯度消失

在反馈的时候需要用链式法则把一连串的梯度乘起来，如果这些梯度值小于1，这个值就会越来越小，趋于0。

如果梯度趋近于0，那么权重就得不到更新。所以在**离输入比较近的层就得不到训练**。如何解决梯度消失？

一种方法是逐层训练，训练完这个层锁住。如果在深度学习中这么做，是非常难的，因为层数实在是太多了。（逐层训练的思想，找一下论文）

ResNet中的module：

![image-20230413155012487](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/DeLLLaptop/image-20230413155012487.png)

（这两层）Residual block的输出与输入$x$的张量维度（四个维度）都是一样的；

不同的颜色代表size发生了变化；（1/2）；

虚线表示不能直接跳连接，需要做处理，比如说直接不加跳连接，或者是加一个最大池化层；



Implementation of Residual Block

注意是先加和再激活

<br>

论文Identitiy Mappings in Deep Residual Networks，给出了非常多的Residual Block的设计；

论文：Densely Connected Convolutional Networks （DesNet）；



<br>

**References**

[1] [11.卷积神经网络（高级篇）- 刘二大人](https://www.bilibili.com/video/BV1Y7411d7Ys?p=11&vd_source=8aeddead7f39b0189fff9b14fa090a75).

[2] Szegedy, Christian, et al. “**Going deeper with convolutions**.” *Proceedings of the IEEE conference on computer vision and pattern recognition*. 2015.
 Available: [https://www.cv-foundation.org/openaccess/content_cvpr_2015/html/Szegedy_Going_Deeper_With_2015_CVPR_paper.html](https://www.cv-foundation.org/openaccess/content_cvpr_2015/html/Szegedy_Going_Deeper_With_2015_CVPR_paper.html).

[3] He, Kaiming, et al. “**Deep residual learning for image recognition**.” *Proceedings of the IEEE conference on computer vision and pattern recognition*. 2016.
Available: [https://openaccess.thecvf.com/content_cvpr_2016/html/He_Deep_Residual_Learning_CVPR_2016_paper.html](https://openaccess.thecvf.com/content_cvpr_2016/html/He_Deep_Residual_Learning_CVPR_2016_paper.html).

[4] He, Kaiming, et al. "**Identity mappings in deep residual networks**." *Computer Vision–ECCV 2016: 14th European Conference, Amsterdam, The Netherlands, October 11–14, 2016, Proceedings, Part IV 14*. Springer International Publishing, 2016.
Available: [https://link.springer.com/chapter/10.1007/978-3-319-46493-0_38](https://link.springer.com/chapter/10.1007/978-3-319-46493-0_38).

[5] Huang, Gao, et al. "**Densely connected convolutional networks**." *Proceedings of the IEEE conference on computer vision and pattern recognition*. 2017.
Available: [https://openaccess.thecvf.com/content_cvpr_2017/html/Huang_Densely_Connected_Convolutional_CVPR_2017_paper.html](https://openaccess.thecvf.com/content_cvpr_2017/html/Huang_Densely_Connected_Convolutional_CVPR_2017_paper.html).











