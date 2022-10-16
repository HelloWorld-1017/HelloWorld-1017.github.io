https://www.bilibili.com/video/BV1dE411u7TK/?p=4&spm_id_from=pageDriver&vd_source=8aeddead7f39b0189fff9b14fa090a75

生成模型就是用来生成数据的，生成样本的

但是也不能说能生成数据的模型就是生成模型，也就是说生成模型还有其他的任务，比如说，GMM可以用来聚类。



GAN，GMM：非监督学习

朴素贝叶斯，监督学习，用于进行分类问题。

生成模型关注的是样本分布本身，所以也叫（概率）生成模型，因为生成模型必然是和概率相关的。

生成模型和它所要解决的任务没有必然联系，它所解决的任务可以是监督学习的任务，也可以是非监督学习的任务，我们关注的就是样本本身

监督学习任务：分类、回归、标记

非监督学习任务：降维、聚类、特征学习、密度估计、生成数据

## 

# 从四个方面：任务、表示、推断、学习

## 任务

和概率相关就认为是概率模型，如果在建模的过程中没有考虑概率的分布，就（暂且）认为是非概率模型。

LR逻辑回归，

MEMM，最大熵，

CRF，条件随机场

PLA（感知机算法），在讲述PLA的时候，肯定是没有考虑到概率分布的

SVM，KNN，NN（最简单的），（前馈神经网络）神经网络一定不是生成模型



在非监督的类别内，概率模型一定是生成模型，因为不存在标签，

PCA（数学实质就是进行SVD分解），LSA（浅语意分解），LDA，PLSA，k-means，

![image-20221012140458126](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20221012140458126.png)

监督 or 非监督

![image-20221012160408643](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20221012160408643.png)

对于生成模型，监督还是非监督没有那么重要

概率图模型中的大部分模型都属于生成模型，

最简单的神经网络模型虽然本身是判别模型，但是NN里面的分布式表示的思想与概率图模型混合到一起，最后产生生成模型，

生成模型本身是横跨概率图模型和深度学习（eg 神经网络），把神经网络的东西揉到一起，尤其是那些深度生成模型，往往指的就是以深度学习为基础，把概率混到一起而形成的模型。

最简单的一个生成模型就是朴素贝叶斯。简单是因为两个方面，一是假设简单

<img src="https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20221012160535613.png" alt="image-20221012160535613" style="zoom:50%;" />

（朴素贝叶斯不是混合模型）

混合模型(Mixture Model)：GMM（但是我们是可以选择分布的，比如迪利克雷分布等等）

Time-series Model：HMM、KF(Kalman Filter)、PF(Particle Filter)；

高斯过程不是参数模型，实际上属于非参数模型(Non-parametric Model)：GP（高斯过程），DP（迪利克雷过程）（参数空间是无限的）

Mixed Membership Model: LDA

因子模型(Factorial Model)：因子分析(FA)、P-PCA、ICA，稀疏编码

<img src="https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20221012161303636.png" alt="image-20221012161303636" style="zoom:50%;" />

上面都是传统的生成模型

这些都是概率图模型中的

深度学习模型：

Energy-based Model：Boltzman Machine系列（深度信念网络等等）（这些是实际上都是无向图模型）

有向图模型：VAE（将Autoencoder和概率结合，用变分的手段去处理）、GAN、自回归网络(Autoregressive model)，Flow-based Model

<img src="https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20221012161748058.png" alt="image-20221012161748058" style="zoom:50%;" />

PCA看起来和概率没有关系，但是它属于特殊的P-PCA，而后者则属于FA。

<img src="https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20221012162021588.png" alt="image-20221012162021588" style="zoom:67%;" />

<br>



从模型的表示、推断和学习三个层面来考察生成模型

## 模型的表示

形神兼备

- 点，
- 边（有向or无向）
- 是否含有隐变量
- 结构（深浅），那些比较浅的模型它的结构都已经固化了，用于处理特定问题，不像深度模型，可以改变结构，添加层。
- 稀疏or稠密，连接是否有缺失

<img src="https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20221012163039015.png" alt="image-20221012163039015" style="zoom:50%;" />

神：概率分布本身

<img src="https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20221012163233097.png" alt="image-20221012163233097" style="zoom:50%;" />

参数是有限的集合，还是无限的(Non-parameteric)

第二点并不是针对是否存在隐变量的，它注重的是我们是否是对P(X)进行参数估计，implicit表示我们最终的目的并不是为了参数估计，我们不需要把密度函数的形式求出来，如果我们的目的只是为了生成样本的话，我们完全可以采用其他方式生成一些样本，只要确保这些样本是从P(X)出来的即可，是否把P(X)求出来其实是没有必要的。除了GAN是属于Implicit，其他的都属于Explicit Density。

## 模型的推断

只有一个维度，就是是否是tractable or intractable

<img src="https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20221012163927628.png" alt="image-20221012163927628" style="zoom:50%;" />

## 模型的学习

极大似然估计

likelihood-based(log似然函数) model vs. likelihood-free Model

学习的时候不使用log似然函数

比如，GAN中所使用的判别器和它自己的判别函数

<img src="https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20221012164233228.png" alt="image-20221012164233228" style="zoom:50%;" />



# 模型分类

