---
layout: single
title: Learning Rate Settings while Using MATLAB `trainNetwork` Function
date: 2023-03-23 12:41:23 +0800
categories: 
 - MATLAB
 - Machine Learning
tags:
 - MATLAB Deep Learning Toolbox
toc: false
---

在使用MATLAB Deep Learning Toolbox所提供的`trainNetwork`函数（[trainNetwork - MathWorks](https://ww2.mathworks.cn/help/deeplearning/ref/trainnetwork.html)）训练神经网络时，可以使用`trainingOptions`函数（[trainingOptions - MathWorks](https://ww2.mathworks.cn/help/deeplearning/ref/trainingoptions.html)）设置神经网络的学习率，涉及到的`trainingOptions`属性一共有四个，分别是`InitialLearnRate`，`LearnRateSchedule`，`LearnRateDropPeriod`和`LearnRateDropFactor`.

（1）`InitialLearnRate`：设置初始学习率，`sgdm`求解器的默认值为0.01，`rmsprop`和`adam`求解器的默认值为0.001.

![image-20230323102117839](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230323102117839.png?raw=true)

（2）`LearnRateSchedule`：设置学习率的dropping策略，一共由两个选项，`none`代表整个训练过程中的学习率是个常数（即`InitialLearnRate`设置的值），`piecewise`代表在经过一定的训练Epochs（而不是Iterations）后，通过乘系数的方式更新学习率。

![image-20230323102623048](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230323102623048.png?raw=true)

（3）`LearnRateDropPeriod`：当`'LearnRateSchedule'='piecewise'`时，设置降低学习率的Epochs.

![image-20230323102852606](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230323102852606.png?raw=true)

（4）`LearnRateDropFactor`：当`'LearnRateSchedule'='piecewise'`时，设置学习率的衰减因子，从0到1取值。

![image-20230323103044281](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230323103044281.png?raw=true)

由此可见，在整个训练的过程中，学习率要么保持不变，要么衰减，不能设置学习率增加的训练过程（增加学习率不太符合常理，但并非是不能这么做）。

<br>

之后找了一个简单的官方示例，修改了`trainingOptions`的这四个属性，做了简单的验证：

```matlab
% MATLAB official example: Train Network for Sequence Classification
clc,clear,close all

[XTrain,YTrain] = japaneseVowelsTrainData;
[XTest,YTest] = japaneseVowelsTestData;

inputSize = 12;
numHiddenUnits = 100;
numClasses = 9;

layers = [ ...
    sequenceInputLayer(inputSize)
    lstmLayer(numHiddenUnits,'OutputMode','last')
    fullyConnectedLayer(numClasses)
    softmaxLayer
    classificationLayer];

maxEpochs = 70;
miniBatchSize = 27;

options = trainingOptions('sgdm', ...
    'ExecutionEnvironment','cpu', ...
    'MaxEpochs',maxEpochs, ...
    'MiniBatchSize',miniBatchSize, ...
    'ValidationData', {XTest,YTest},...
    'ValidationFrequency', 10,...
    'GradientThreshold',1, ...
    'Verbose',false, ...
    'Plots','training-progress',...
    'LearnRateSchedule','piecewise',...
    'LearnRateDropPeriod',30,...
    'LearnRateDropFactor',0.3);

[net,info] = trainNetwork(XTrain,YTrain,layers,options);
```

在这样的`miniBatchSize`和`maxEpochs`设置下，一共会训练70个Epochs，每个Epoch会训练10个Iterations：

![image-20230323104327523](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230323104327523.png?raw=true)

因此，`'LearnRateDropPeriod',30`和`'LearnRateDropFactor',0.3`就意味着每300个Iterations（30 Epochs）学习率衰减0.3.

最后，将训练过程的学习率绘制出来：

```matlab
plot(info.BaseLearnRate)
```

![image-20230323110050545](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230323110050545.png?raw=true)

符合我们的预期。

<br>

最后，找了篇论文 [1] 看了一下作者所采用的学习率设置：

![image-20230323110228657](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230323110228657.png?raw=true)

是和MATLAB的学习率设置逻辑是一致的。

<br>

**References**

[1] Zhao, Minghang, et al. "Deep residual shrinkage networks for fault diagnosis." *IEEE Transactions on Industrial Informatics* 16.7 (2019): 4681-4690.