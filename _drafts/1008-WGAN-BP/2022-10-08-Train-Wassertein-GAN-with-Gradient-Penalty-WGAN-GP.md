# Introduction

[Train Wasserstein GAN with Gradient Penalty (WGAN-GP) - MathWorks](https://ww2.mathworks.cn/help/deeplearning/ug/trainwasserstein-gan-with-gradient-penalty-wgan-gp.html).

文章XX和XX介绍了MATLAB官方提供的关于GANs的两个示例，前者介绍了无监督学习的GAN，后者介绍了有监督学习的CGAN。两个示例采用的都是来自http://download.tensorflow.org/example_images/flower_photos.tgz的鲜花数据集。本文所介绍的WGAN-BP同样采用的也是该数据集，并且采用的是无监督的GAN模型。但是，本文的WGAN-BP对XX中的GAN做了两方面的改进：

- XX
- XX

WGAN-BP的出发点源于：在理想情况下，GAN的Generator和Discriminator能够达到纳什均衡。但是，文献XX认为，GANs中最小化的散度(ie negative log likelihood function)关于Generator's learnable parameters偏导数可能是不连续的，这会导致训练困难，于是引入了Wasserstein GAN(WGAN)模型，后者使用Wassertein loss来帮助稳定训练过程。但是，WGAN模型仍然会产生不良的样本或者不收敛，因为weight constraint和cost function之间的interactions会梯度停止(vanishing)和梯度爆炸(exploding)。为了解决这个问题，文献XX引入了gradient penalty，通过惩罚具有较大norm values的梯度来改善稳定性，代价就是延长了计算时间，这个模型就是WGAN-BP模型。

本文将重点介绍XX中的GAN与WGAN-BP之间的差异，相同的部分从略。

<br>

在本示例中，Generator和Discriminator的损失函数值计算和

