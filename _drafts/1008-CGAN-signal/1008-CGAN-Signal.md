[Generate Synthetic Signals Using Conditional GAN - MathWorks](https://ww2.mathworks.cn/help/deeplearning/ug/generate-synthetic-pump-signals-using-conditional-generative-adversarial-network.html).

# Introduction

在我目前看到的应用GAN生成数据的场景中，基本上都是使用GAN来生成图像或者震动信号。个人认为之所以这两种场景中应用比较多，是因为GAN生成的数据有很多噪声，比如XXX中原始图像和生成图像之间的对比：



可以看到，噪声是比较明显的。而在这两种场景之下，噪声的影响是不太重要的，或者可以通过后期处理掉的。比如图像有图像处理，而对于震动信号，我们主要关心它的频域特征和时频域特征，时域噪声中的影响是很小的，因此我们可以不太关心。

文章XX、XX和XX分别介绍了MATLAB官方提供的三个关于GAN的示例，分别







本示例所介绍的CGAN作为故障诊断其中的一个步骤，

# Work Flow

## Load Data

本示例所使用的训练集数据为仿真pump signals，由示例[Multi-Class Fault Detection Using Simulated Data - MathWorks](https://ww2.mathworks.cn/help/deeplearning/ug/generate-synthetic-pump-signals-using-conditional-generative-adversarial-network.html)中的仿真模型生成，数据压缩包可从https://ssd.mathworks.com/supportfiles/SPT/data/PumpSignalGAN.zip下载。压缩包解压后，一共有两个`.mat`文件：

- `GANModel.mat`，该文件中包含着训练好的CGAN模型，包含着G和D：

  ```matlab
  Name                    Size               Bytes  Class        Attributes
    dlnetDiscriminator      1x1             11834154  dlnetwork             
    dlnetGenerator          1x1             20873629  dlnetwork
  ```

  这两个模型并不是pre-trained模型，而是well-trained模型，在后面用户可以通过Livescript控件来选择是使用现有的模型，还是再训练一个模型(因为在这个示例中，CGAN的使用只是作为故障诊断的其中一个步骤)：

  <img src="https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/img/image-20221009092618630.png" alt="image-20221009092618630" style="zoom: 80%;" />

- `simulatedDataset.mat`，该文件包含着训练集数据：

  ```matlab
  Name           Size                 Bytes  Class     Attributes
    flow        1201x1575            15132600  double              
    labels         1x1575               12600  double
  ```

  其中，`flow`为pump signal数据，一共有1575条信号数据，每条数据有1201个样本点。`labels`为数据标签：

  ```matlab
  categories(categorical(labels))
  ans =
    2×1 cell array
      {'1'}
      {'2'}
  ```

  类别`1`代表Healthy signals，类别`2`代表Faulty signals。

  注：还需要注意的一个点是，由于这里是Simulink仿真模型所生成的仿真数据，因此每条数据样本点的个数是一样的，都是1201个样本点，但这并不是唯一的情况。在实践中，由Pico或其他数据采集系统采集到的数据，会存在异常点(例如+Inf，-Inf，NaN值)和离群值点，我们首先会对这些点的值进行处理，处理后的信号可能是不等长的(Varying length)。对于这种情况，可以在输入到神经网络前先padding，但是这样做可能会导致每条信号的数据点不对齐，所以我认为最好的做法还是在信号预处理阶段进行改善，比如不使用`rmoutliers`函数，而是采用`filloutliers`函数等等，保证进行过数据预处理后的信号还是等长的。
  {: .notice--warning}

## Define Networks Structures

本示例CGAN的示例和[Train Conditional Generative Adversarial Network(CGAN) in MATLAB](http://whatastarrynight.com/programming/machine%20learning/Train-Conditional-Generative-Adversarial-Network-in-MATLAB/)中所述的CGAN是很类似的：

<figure class="half">
    <img src="https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/img/image-20221009092653495.png" alt="image-20221009092653495" style="zoom:67%;" />
    <img src="https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/img/image-20221009092724433.png" alt="image-20221009092724433" style="zoom:67%;" />
    <figcaption>(a)Generator Structure; (b)Discriminator Structure</figcaption>
</figure>

另外，和[Train Conditional Generative Adversarial Network(CGAN) in MATLAB](http://whatastarrynight.com/programming/machine%20learning/Train-Conditional-Generative-Adversarial-Network-in-MATLAB/)中的CGAN一样，本示例虽然使用的是一维的信号数据，但是在定义G和D的时候，仍然使用的是`imageInputLayer`、`transposedConv2dLayer`和`convolution2dLayer`，差别就在于本示例采用的是它们都是一通道的layers。

## Train process and loss function

本示例的训练过程封装在了`trainGAN`函数中，本身没有什么特殊的地方；losses和scores的计算也和[Train Conditional Generative Adversarial Network(CGAN) in MATLAB](http://whatastarrynight.com/programming/machine%20learning/Train-Conditional-Generative-Adversarial-Network-in-MATLAB/)完全一致。

## 



# Application scenario

按照官方的说法：

>  The Simulink simulation takes about 14 hours to generate 2000 pump flow signals. This duration can be reduced to about 1.7 hours with eight parallel workers if you have Parallel Computing Toolbox™.
>
> The CGAN takes 1.5 hours to train and 70 seconds to generate the same amount of synthetic data with an NVIDIA Titan V GPU.










- 看一下数据集是如何分割的
- 训练SVM的时候，是只使用生成数据还是

