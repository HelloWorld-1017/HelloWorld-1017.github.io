---
layout: single
title: A Brief Introduction to Deep Learning
categories: 
 - Machine Learning
date: 2023-04-01 17:08:09 +0800
last_modified_at0: 2023-04-01 17:08:09 +0800
last_modified_at1: 2023-11-28 21:22:37 +0800
last_modified_at2: 2024-03-09 14:22:03 +0800
last_modified_at: 2024-03-09 14:22:03 +0800
---

# Introduction

在Goodfellow撰写的经典书籍*Deep learning* [^1] 的Introduction章节，有两张图来介绍Deep learning技术在整个AI技术发展过程中所处的位置；B站刘二大人的《PyTorch深度学习实践》课程 [^2] 对这两个图做了进一步的解释，本博客记录下对这两张图的学习，除此之外，根据课程 [^2] 的内容整理一下深度学习发展的过程。

<br>

# Deep Learning is the Branch of Presentation Learning

![image-20230401144104050](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230401144104050.png?raw=true)

（1）深度学习（Deep learning）是机器学习（Machine learning）的一个分支；

（2）机器学习中有一种方法是表示学习（Representation learning），用于特征的提取。因为原始的数据非常得大，每个样本数据特征非常多，人们想要使用一种更好的方法**表示**样本的**信息**。比较经典的就是浅层的自编码器（Shallow autoencoder）；如果是比较深层的，那么通常会被认为是深度学习的技术。因此，如果从模型的角度看，深度学习使用到的是神经网络；但是从要解决的目标上看，深度学习实际上仍然是表示学习的分支。

（3）深度学习仅仅是人工智能（AI）领域非常小的一个部分，但是这一非常小的部分在最近十来年变得非常得热门；

![image-20230401144225303](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230401144225303.png?raw=true)

（1）Rule-based systems（基于规则的系统）：最早的人工智能算法就是基于规则的，需要构造知识库（knowledge base），手工设计程序（图搜索、树搜索）。一个经典的例子是使用学习系统程序求取某个函数的原函数。实际上，**只要是实现一些类似于人类智能活动的程序，就可以称之为人工智能（AI）程序**。**基于规则的系统也属于人工智能的范畴，是早期开发人工智能系统的一种方式**。其中，最主要的部分是如何设计程序，即如何制定规则，而这需要非常专业的特定领域的知识。对于非常复杂的问题，很难去设计一套完备的规则，肯定会漏掉一些规则，导致算法出现缺陷；另一方面，随着规则越来越庞大，最终会变成人类难以维护的程序。

（2）Classic machine learning（经典机器学习算法）：其特点是手工设计的特征提取（Hand-designed features or hand-crafted feature），并寻找特征与输出之间的映射关系。在一些情况下， 手工的特征提取是非常简单的；但是在更多的情况下，这是非常复杂的（例如使用特别复杂的统计处理技术将一张图像的某个区域转换成一个固定长度的向量）。手工设计特征提取的最终目标是将输入数据（无论是什么样的形式，语言，文字或者图片等等）最终转换成一个特征向量（或者张量）。之后，建立这个特征向量$x$与输出$y$之间的映射函数$y=f(x)$。

（3）Representation learning（表示学习）：表示学习技术最主要的改进是将“学习”这一思想拓展到feature的提取过程。在早期（上图Representation learning的左边的分支），feature的提取是一个**单独的**步骤，主要是使用特定的算法（例如PCA），从非常复杂的输入数据中提取出一个representive向量，以避免维度的诅咒（特征越多，对训练样本数据的需求量就越多）。

在表示学习中，有一个分支是研究流形（Manifold），比如有时候会听到这样的说法：“某些数据是在高维空间中的低维流形”；以三维空间举例，这大致是在说，虽然这些数据点都位于三维空间中，用三维坐标表示，但是它们基本上都是位于一个比较光滑的（可微分的）曲面上，因此，我们就可以在这个低维的曲面上来描述这个数据，数据的维度就从三维降到了二维 [^2]。
{: .notice--primary}

在这个阶段，人们需要单独地训练特征提取器；而当表示学习发展到深度学习（上图Representation learning的右边的分支），人们只需要将原始数据简单地预处理为一个简单的特征（Simple feature）（例如将不同像素大小的图像剪切成相同像素大小的图像，诸如此类的预处理步骤），之后在神经网络中设计一个独立的层（Additional layers）用于特征提取，然后直接输入到学习器。相比于传统的表示学习（特征提取与学习器分开训练，比如无监督学习中的很多工作都是用于feature提取的训练，而学习器是做有标签的、有监督的训练），深度学习中特征提取的训练和学习器的训练是统一的，因此Deep learning中的训练也被称为是**End-to-end（端到端）训练**。

<br>

# A Brief History of Machine Learning

我们可以通过ILSVRC（ImageNet Large Scale Visual Recognition Challenge）竞赛的错误率下降的趋势看出传统机器学习遇到的挑战和深度学习发展的进程：

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230401161548318.png?raw=true" alt="image-20230401161548318" style="zoom: 33%;" />

一些经典的神经网络结构的出现，能够极大程度上推动深度学习的发展：

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230401162948166.png?raw=true" style="zoom:33%;" />

(1) **LeNet**：Y. Lecun, L. Bottou, Y. Bengio and P. Haffner, "Gradient-based learning applied to document recognition," in *Proceedings of the IEEE*, vol. 86, no. 11, pp. 2278-2324, Nov. 1998, doi: 10.1109/5.726791, available: [https://ieeexplore.ieee.org/abstract/document/726791](https://ieeexplore.ieee.org/abstract/document/726791).

(2) **AlexNet**: Krizhevsky, Alex, Ilya Sutskever, and Geoffrey E. Hinton, "Imagenet classification with deep convolutional neural networks." *Communications of the ACM* 60.6 (2017): 84-90, available: [https://dl.acm.org/doi/abs/10.1145/3065386](https://dl.acm.org/doi/abs/10.1145/3065386).

(3) **GoogLeNet**: Szegedy, Christian, *et al.*, "Going deeper with convolutions," *Proceedings of the IEEE conference on computer vision and pattern recognition*. 2015, available: [https://www.cv-foundation.org/openaccess/content_cvpr_2015/html/Szegedy_Going_Deeper_With_2015_CVPR_paper.html](https://www.cv-foundation.org/openaccess/content_cvpr_2015/html/Szegedy_Going_Deeper_With_2015_CVPR_paper.html).

(4) **VGG**: Simonyan, Karen, and Andrew Zisserman, "Very deep convolutional networks for large-scale image recognition," *arXiv preprint arXiv:1409.1556* (2014), available: [https://arxiv.org/abs/1409.1556](https://arxiv.org/abs/1409.1556).

(5) **ResNet**: He, Kaiming, *et al.*, "Deep residual learning for image recognition," *Proceedings of the IEEE conference on computer vision and pattern recognition*. 2016, available: [https://openaccess.thecvf.com/content_cvpr_2016/html/He_Deep_Residual_Learning_CVPR_2016_paper.html](https://openaccess.thecvf.com/content_cvpr_2016/html/He_Deep_Residual_Learning_CVPR_2016_paper.html).

<br>

**References**

[^1]: Ian Goodfellow *et al.*, Deep Learning. MIT Press, available: [https://www.deeplearningbook.org/](https://www.deeplearningbook.org/).
[^2]: [《PyTorch深度学习实践》完结合集 - 刘二大人](https://www.bilibili.com/list/21241234?sid=245319&desc=1&oid=97078147&bvid=BV1Y7411d7Ys).