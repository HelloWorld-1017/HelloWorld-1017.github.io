串行结构；

讨论如何实现更复杂的结构；

<img src="https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20230412234527217.png"/>

GoogLeNet

减少代码的冗余（重复）；



把相似的结构用类封装起来

这一个块（蓝蓝红四个蓝）称为一个Inception（盗梦空间）

在定义神经网络的时候，有些参数是比较难选的。比如说卷积核的大小。GoogLeNet的出发点是：既然不知道多大的卷积核好用，那我就在Inception块中都用一下。如果$3\times3$的效果好，那么$3\times3$这个路径上的权重就会变得比较大，变得比较重要，其他路线上的权重就会变小。它是通过**提供几种候选的CNN的配置，通过训练自动地在这几条路里面找到最优的卷积的组合**。



根据通道Concatenate



要想最后再拼接到一块，那么必须保证图像的Height和Width是一致的，唯一不同的就是Channel。通过设置Average Pooling的padding和stride保证这一点；



$1\times1$ convolution（09：34）



