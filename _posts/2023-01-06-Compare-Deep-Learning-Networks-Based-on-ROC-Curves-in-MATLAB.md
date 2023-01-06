---
layout: single
title:  Compare Deep Learning Networks Based on ROC Curves in MATLAB
date: 2023-01-06 20:59:50 +0800
categories: 
 - MATLAB
 - Machine Learning
tags:
 - MATLAB Statistics and Machine Learning Toolbox
 - Deep Learning Toolbox
 - Transfer Learning
---

# Introduction

博客[Receiver Operating Characteristic (ROC) Curve in MATLAB](http://whatastarrynight.com/matlab/machine%20learning/Receiver-Operating-Characteristic-(ROC)-Curve-in-MATLAB/)介绍了ROC曲线以及如何在MATLAB中绘制和计算ROC曲线。本博客介绍MATLAB提供的另一个使用ROC曲线对比模型的示例：[Compare Deep Learning Model Using ROC Curves - MathWorks](https://ww2.mathworks.cn/help/deeplearning/ug/compare-deep-learning-models-using-ROC-curves.html)。该示例对比的两个模型均为深度学习模型，虽然更加复杂，但是基本思想并没有区别；另一方面，该示例提供了一些基于模型ROC曲线对比的角度，值得学习借鉴。

<br>

# Load Data

本示例所采用的数据集是[Flowers dataset](http://download.tensorflow.org/example_images/flower_photos.tgz)，该数据集有3670张图片，一共有五种分类，分别是：daisy，dandelion，roses，sunflowers和tulips。创建image datastore，并使用`splitEachLabel`函数按照6:2:2的比例将数据集划分为训练集、验证集和测试集：

```matlab
imds = imageDatastore("flower_photos", IncludeSubfolders=true, LabelSource="foldernames");

[imdsTrain, imdsValidation, imdsTest] = splitEachLabel(imds, 0.6, 0.2, 0.2, "randomize");
```

数据的类别共有5种：

```matlab
numClasses = 5;
```

<br>

# Prepare Network

创建两个图像分类模型。对于第一个模型，我们从头开始构建和训练一个深度神经网络；第二个模型则采用transfer learning的技术基于pretrained GoogLeNet Network针对新数据进行再训练。两个神经网络输入层的大小均为：

```matlab
inputSize = [224 224 3];
```

## Network 1

```matlab
numFilters = 16;
filterSize = 3;
poolSize = 2;

layers = [
    imageInputLayer(inputSize)
    
    convolution2dLayer(filterSize,numFilters,Padding="same")
    batchNormalizationLayer
    reluLayer
    maxPooling2dLayer(filterSize,Stride=2)

    convolution2dLayer(filterSize,2*numFilters,Padding="same")
    batchNormalizationLayer
    reluLayer
    maxPooling2dLayer(poolSize,Stride=2)

    convolution2dLayer(filterSize,4*numFilters,Padding="same")
    batchNormalizationLayer
    reluLayer
    maxPooling2dLayer(poolSize,Stride=2)
   
    dropoutLayer(0.8)

    fullyConnectedLayer(numClasses)
    softmaxLayer
    classificationLayer];

lgraphSmallNet = layerGraph(layers);
```

## Network 2

首先加载GoogLeNet：

```matlab
lgraphGoogLeNet = layerGraph(googlenet);
```

查看一下这个神经网络的结构：

```matlab
plot(lgraphGoogLeNet)
```

![image-20230104112343706](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/DeLLLaptop/image-20230104112343706.png)

为了能够将pretrained network用于transfer learning，我们首先需要将network匹配new dataset：

- Replace the last learnable layer with a new layer that is adapted to the new data. For GoogLeNet, this layer is the final fully connected layer, `loss3-classifier`. Set the output size in the new layer to match the number of classes in the new data. 
- **Increase the learning in the new layer by increasing the weight and bias learn rate factors.** This increase ensures that learning is faster in the new layer than in the transferred layers.
- Replace the output layer, `output`, with a new output layer that is adapted to the new data.

<img src="https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/DeLLLaptop/image-20230104112833124.png" alt="image-20230104112833124" style="zoom: 80%;" />

```matlab
newLearnableLayer = fullyConnectedLayer(numClasses, ...
    WeightLearnRateFactor=10, ...
    BiasLearnRateFactor=10);
lgraphGoogLeNet = replaceLayer(lgraphGoogLeNet,"loss3-classifier",newLearnableLayer);

newOutputLayer = classificationLayer("Name","ClassificationLayer_predictions");
lgraphGoogLeNet = replaceLayer(lgraphGoogLeNet,"output",newOutputLayer);
```

我们可以对比一下replace前后神经网络的变化：

```matlab
lgraphGoogLeNet = layerGraph(googlenet);
% plot(lgraphGoogLeNet)
NetBefore = lgraphGoogLeNet;
...
replaceLayer(lgraphGoogLeNet,"output",newOutputLayer);
NetAfter = lgraphGoogLeNet;
...
analyzeNetwork(NetBefore)
analyzeNetwork(NetAfter)
```

![image-20230104114014040](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/DeLLLaptop/image-20230104114014040.png)

![image-20230104114033174](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/DeLLLaptop/image-20230104114033174.png)



## Compare Networks

```matlab
analyzeNetwork(lgraphGoogLeNet)
analyzeNetwork(lgraphSmallNet)
```

Network 1：

![image-20230104114517225](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/DeLLLaptop/image-20230104114517225.png)

Network 2:

![image-20230104114543380](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/DeLLLaptop/image-20230104114543380.png)

第一个小的神经网络一共有17个layers和近300,000个参数，大的GoogLeNet Network有144个layers和大约6,000,000个参数。但是由于我们采用了transfer learning的技术，后者的GoogLeNet Network训练时长并不会很长，因为该pretrained network已经学习到了一定的特征提取能力，我们可以将其作为一个starting point for new data。

<br>

# Prepare Data

我们对原始图像数据集使用一些图像增强技术，得到一个augmented image datastore：

注：Data augmentation helps prevent the network from overfitting and memorizing the exact details of the training images.
{: .notice--primary}

```matlab
% For train
augmenter = imageDataAugmenter(RandXReflection=true, RandScale=[0.5 1.5]);
augimdsTrain = augmentedImageDatastore(inputSize, imdsTrain, DataAugmentation=augmenter);
```

而对于validation images，则仅仅resize而不进行任何的data augmentation，不指定任何的preprocessing operations：

```matlab
% For validation
augimdsValidation = augmentedImageDatastore(inputSize,imdsValidation);
```

验证集的作用是监测神经网络模型的训练过程。

# Set training options

对于神经网络1：

```matlab
% Set training options for Network 1
optsSmallNet = trainingOptions("sgdm", ...
    MaxEpochs=150, ...
    InitialLearnRate=0.002, ...
    ValidationData=augimdsValidation, ...
    ValidationFrequency=150, ...
    Verbose=false, ...
    Plots="training-progress");
```

对于神经网络2：

```matlab
% Set training options for Network 2
optsGoogLeNet = optsSmallNet;
optsGoogLeNet.MaxEpochs = 15;
optsGoogLeNet.InitialLearnRate = 0.0001;
```

对于pretrained network，我们不需要训练太多轮，因此我们将最大轮数设置为15。在之前，我们增加了new learnable layer的learning rate。为了放慢pretrained network的earlier layers的训练过程，我们选择一个小的initial learning rate，设置为0.0001。

<br>

# Train Networks

```matlab
% For Network 1 
netSmallNet = trainNetwork(augimdsTrain, lgraphSmallNet, optsSmallNet);
```

![image-20230106200837717](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/DeLLLaptop/image-20230106200837717.png)

```matlab
% For Network 2
netGoogLeNet = trainNetwork(augimdsTrain, lgraphGoogLeNet, optsGoogLeNet);
```

![image-20230106200825645](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/DeLLLaptop/image-20230106200825645.png)

从模型训练的训练过程中我们可以看到，采用了pretrained的模型虽然具有更多参数，但是反而能在较短的时间内训练出更好的效果。

<br>

# Test Networks

本部分基于测试集数据从不同角度测试两个训练好的神经网络模型。

## Compare Network Accuracy

首先，测试预测准确率。

同样地，我们需要首先对test data进行resize：

```matlab
% Prepare the test data
augimdsTest = augmentedImageDatastore(inputSize, imdsTest);
```

测试两个networks的预测准确率：

```matlab
% Classify the test data
[YTestSmallNet, scoresSmallNet] = classify(netSmallNet, augimdsTest);
[YTestGoogLeNet, scoresGoogLeNet] = classify(netGoogLeNet, augimdsTest);

% Compare the accuracy
TTest = imdsTest.Labels;
accSmallNet = sum(TTest == YTestSmallNet)/numel(TTest);
accGoogLeNet = sum(TTest == YTestGoogLeNet)/numel(TTest);
```

```matlab
>> accSmallNet, accGoogLeNet
accSmallNet =
    0.7401
accGoogLeNet =
    0.8898
```

这一部分代码另一个主要作用就是为后面`rocmetrics`函数提供`Scores`输入：`scoresSmallNet`，`scoresGoogLeNet`。

## Confusion Matrix

绘制混淆矩阵：

```matlab
% Plot confunsion matrix
figure 
tiledlayout(1,2)
nexttile
confusionchart(TTest, YTestSmallNet)
title("SmallNet")
nexttile
confusionchart(TTest, YTestGoogLeNet)
title("GoogLeNet")
```

![image-20230106202354561](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/DeLLLaptop/image-20230106202354561.png)

## ROC Curves

### Compare ROC Curves

使用`rocmetrics`函数计算并绘制ROC曲线：

```matlab
% Compare ROC Curves
% Create rocmetrics objects
classNames = netSmallNet.Layers(end).Classes;
rocSmallNet = rocmetrics(TTest, scoresSmallNet, classNames);
rocGoogLeNet = rocmetrics(TTest, scoresGoogLeNet, classNames);

% Plot ROC Curves
figure
tiledlayout(1,2)
nexttile
plot(rocSmallNet)
title("ROC Curve: SmallNet")
nexttile
plot(rocGoogLeNet)
title("ROC Curve: GoogLeNet")
```

![image-20230106202641040](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/DeLLLaptop/image-20230106202641040.png)

### Compare AUC Values

```matlab
% Access the AUC value for each class
aucSmallNet = rocSmallNet.AUC;
aucGoogLeNet = rocGoogLeNet.AUC;
```

```matlab
>> aucSmallNet, aucGoogLeNet
aucSmallNet =
  1×5 single row vector
    0.9518    0.9278    0.8823    0.9632    0.9064

aucGoogLeNet =
  1×5 single row vector
    0.9830    0.9919    0.9771    0.9900    0.9776
```

并以bar plot的方式可视化：

```matlab
figure
bar([aucSmallNet; aucGoogLeNet]')
xticklabels(classNames)
legend(["SmallNet","GoogLeNet"],Location="southeast")
title("AUC")
```

<img src="https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/DeLLLaptop/image-20230106202814337.png" alt="image-20230106202814337" style="zoom:80%;" />

### Investigate Specific Class

本部分针对类别"sunflowers"对比两个模型的ROC曲线：

```matlab
% ROC curves of 'sunflowers' class
classToInvestigate = "sunflowers";

figure
c = cell(2,1);
g = cell(2,1);
[c{1},g{1}] = plot(rocSmallNet,ClassNames=classToInvestigate);
hold on
[c{2},g{2}] = plot(rocGoogLeNet,ClassNames=classToInvestigate);
modelNames = ["SmallNet","GoogLeNet"];
for i = 1:2
    c{i}.DisplayName = replace(c{i}.DisplayName, ...
        classToInvestigate,modelNames(i));
    g{i}(1).DisplayName = join([modelNames(i),"Model Operating Point"]);
end
title("ROC Curve","Class: " + classToInvestigate)
hold off
```



<img src="https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/DeLLLaptop/image-20230106202849289.png" alt="image-20230106202849289" style="zoom:80%;" />

### Compare Average ROC Curves

对比两个神经网络模型的平均ROC曲线：

```matlab
% Compare average ROC curves
figure
[FPR1, TPR1, Thresholds1, AUC1] = average(rocSmallNet, "macro");
[FPR2, TPR2, Thresholds2, AUC2] = average(rocGoogLeNet, "macro");
hold(gca, "on")
box(gca, "on")
plot([0; FPR1], [0; TPR1],...
    DisplayName=sprintf("SmallNet (AUC=%.4f)", AUC1))
plot([0; FPR2], [0; TPR2],...
    DisplayName=sprintf("GoogLelNet (AUC=%.4f)", AUC2))
legend("Location", "southeast")
xlabel("FPR")
ylabel("TPR")
```

<img src="https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/DeLLLaptop/image-20230106204356697.png" alt="image-20230106204356697" style="zoom: 80%;" />

## Conclusion

所有的这些测试效果都表明：采用了GoogLeNet神经网络结构和Transfer Learning的神经网络具有更优秀的性能。

<br>















