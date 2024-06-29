---
layout: single
title: Stop Training Neural Network while Using MATLAB `trainNetwork` Function
date: 2023-03-21 13:46:41 +0800
categories: 
 - MATLAB
 - Machine Learning
tags:
 - MATLAB Deep Learning Toolbox
---

# Introduction

MATLAB Deep Learning Toolbox提供了一个用于训练分类和回归神经网络的函数`trainNetwork`（[trainNetwork - MathWorks](https://ww2.mathworks.cn/help/deeplearning/ref/trainnetwork.html)）。在用户不自定义training loop的情况下，使用`trainNetwork`训练神经网络是很方便的。并且，用户可以通过`trainingOptions`函数（[trainingOptions - MathWorks](https://ww2.mathworks.cn/help/deeplearning/ref/trainingoptions.html)）设置神经网络的训练选项，并将其作为输入参数`options`传入到`trainNetwork`函数中。例如，MATLAB官网所提供的一个示例（[Monitor Deep Learning Training Progress](https://ww2.mathworks.cn/help/deeplearning/ref/trainingoptions.html#bvniuj4)）：

```matlab
...
layers = [
    imageInputLayer([28 28 1])
    convolution2dLayer(3,8,Padding="same")
    batchNormalizationLayer
    reluLayer   
    maxPooling2dLayer(2,Stride=2)
    convolution2dLayer(3,16,Padding="same")
    batchNormalizationLayer
    reluLayer
    maxPooling2dLayer(2,Stride=2)
    convolution2dLayer(3,32,Padding="same")
    batchNormalizationLayer
    reluLayer
    fullyConnectedLayer(10)
    softmaxLayer
    classificationLayer];
    
options = trainingOptions("sgdm", ...
    MaxEpochs=8, ...
    ValidationData={XValidation,YValidation}, ...
    ValidationFrequency=30, ...
    Verbose=false, ...
    Plots="training-progress");
    
net = trainNetwork(XTrain,YTrain,layers,options);
```

在训练神经网络时，一个很重要的问题是：在什么情况下停止训练？因此，本博客就梳理一下基于`trainNetwork`函数训练网络时如何使用`trainingOptions`函数设置神经网络的停止条件。

<br>

# (1) Stop training if the maximum training epochs is reached (`MaxEpochs` property)

`trainingOptions`函数提供了设置神经网络的最大训练轮数的属性`MaxEpochs`：

![image-20230321110115211](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230321110115211.png?raw=true)

其默认值是30。

在训练神经网络时，我们通常会使用`MiniBatchSize`属性（同样使用`trainingOptions`函数设置，默认大小为128）指定Mini-batch的大小，将一个Mini-batch的数据传入到神经网络后，会进行前馈和反馈的过程，这是一个**Iteration**；当所有的数据都以Mini-batch的方式参与训练后，就完成了一个**Epoch**. 而到达了`MaxEpochs`属性所指定的最大训练轮数后，神经网络停止训练，这是最简单的一种停止神经网络训练的方式。

<br>

# (2) Automatic validation stopping (`ValidatationPatience` and `OutputNetwork` properties)

使用`trainNetwork`训练神经网络很方便的一点是我们可以在图形界面监视神经网络的训练过程，监视的指标有：Training accuracy，Smoothed training accuracy，Validation accuracy；Training loss，Smoothed training loss，Validation loss：

![image-20230321111611264](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230321111611264.png?raw=true)

训练集的准确率和误差是始终可以监视的，但是如果我们想要使用验证集同时验证网络的性能，则需要在`trainingOptions`函数中指定验证集（`ValidationData`属性）以及验证频率的设置（`ValidationFrequency`属性）。例如：

```matlab
options = trainingOptions("sgdm", ...
    MaxEpochs=8, ...
    ValidationData={XValidation,YValidation}, ...
    ValidationFrequency=30, ...
    Verbose=false, ...
    Plots="training-progress");
```

**但是，这样的设置仅仅使得我们可以观察到验证集的验证效果（准确率和误差），并没有利用验证集的信息进行早停的设置。**

如果想要automatic validation stopping，则需要指定`trianingOptions`的`ValidatationPatience`属性：

![image-20230321112353362](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230321112353362.png?raw=true)

该属性指定为一个正整数或者是默认的`Inf`. 

随着神经网络的不断训练，测试集损失值会出现不降反升的现象，这意味着可能发生了过拟合现象；但另一方面，这也可能是神经网络训练过程的正常波动现象。因此，需要使用一种方式（在某种程度上）确保是出现了过拟合现象。`trainNetwork`函数会将截止到当前训练的最小验证集损失值记录下来，并将后面每一次验证时的验证集损失值与当前最小验证集损失相比较，如果验证集损失值大于最小验证集损失的次数大于`ValidatationPatience`属性的值，就会停止训练。

> 这里需要强调的是另一个属性`ValidationFrequency`，这个属性指定了验证集验证的频率：
>
> ![image-20230321125922866](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230321125922866.png?raw=true)
>
> `ValidationFrequency`指定为一个正整数，默认值是50。需要注意的是，这一属性的单位是iteration（并非epochs），即每训练50 iterations就使用验证集验证一次。

当神经网络停止训练后，输出的神经网络也有两个选择。一是输出具有最小验证集误差的那个神经网络，二是输出停止时最后一次训练的神经网络。我们可以通过`OutputNetwork`属性进行设置：

![image-20230321130544695](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230321130544695.png?raw=true)

<br>

# (3) Custom early stopping based on validation accuracy (`OutputFcn` property)

`trainingOptions`函数还有另外一个输入参数`OutputFcn`，该输入参数接受一个函数句柄（function handle）或者函数句柄的元组数组（cell array of function handles）：

![image-20230321131608733](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230321131608733.png?raw=true)

MATLAB提供了基于`OutputFcn`属性早停的示例：[Customize Output During Deep Learning Network Training - MathWorks](https://ww2.mathworks.cn/help/deeplearning/ug/customize-output-during-deep-learning-training.html)，相关的代码为：

```matlab
miniBatchSize = 128;
validationFrequency = floor(numel(YTrain)/miniBatchSize);
options = trainingOptions('sgdm', ...
    'InitialLearnRate',0.01, ...
    'MaxEpochs',100, ...
    'MiniBatchSize',miniBatchSize, ...
    'VerboseFrequency',validationFrequency, ...
    'ValidationData',{XValidation,YValidation}, ...
    'ValidationFrequency',validationFrequency, ...
    'Plots','training-progress', ...
    'OutputFcn',@(info)stopIfAccuracyNotImproving(info,3));
```

```matlab
function stop = stopIfAccuracyNotImproving(info,N)

stop = false;

% Keep track of the best validation accuracy and the number of validations for which
% there has not been an improvement of the accuracy.
persistent bestValAccuracy
persistent valLag

% Clear the variables when training starts.
if info.State == "start"
    bestValAccuracy = 0;
    valLag = 0;
    
elseif ~isempty(info.ValidationLoss)
    
    % Compare the current validation accuracy to the best accuracy so far,
    % and either set the best accuracy to the current accuracy, or increase
    % the number of validations for which there has not been an improvement.
    if info.ValidationAccuracy > bestValAccuracy
        valLag = 0;
        bestValAccuracy = info.ValidationAccuracy;
    else
        valLag = valLag + 1;
    end
    
    % If the validation lag is at least N, that is, the validation accuracy
    % has not improved for at least N validations, then return true and
    % stop training.
    if valLag >= N
        stop = true;
    end
    
end
end
```

这种早停策略是：

> Define the output function `stopIfAccuracyNotImproving(info,N)`, which stops network training if the best classification accuracy on the validation data does not improve for `N` network validations in a row. 

这种早停策略与上一种使用`ValidatationPatience`属性早停的策略是类似的，唯一不同的是这里使用的是准确率而不是损失值：

> This criterion is similar to the built-in stopping criterion using the validation loss, except that it applies to the classification accuracy instead of the loss.

但是，这种方式明显更加得灵活，我们可以设置各种各样的早停策略。但是在此之前，需要首先了解`stopIfAccuracyNotImproving`函数的形参`info`结构体包含了什么信息。

在这个示例文件的`stopIfAccuracyNotImproving`的函数中增加一个断点，观察一下前三次神经网络输出的结构体：

```matlab
info = 
  struct with fields:
                 Epoch: 0
             Iteration: 0
        TimeSinceStart: []
          TrainingLoss: []
        ValidationLoss: []
         BaseLearnRate: []
      TrainingAccuracy: []
          TrainingRMSE: []
    ValidationAccuracy: []
        ValidationRMSE: []
                 State: "start"
```

```matlab
info = 
  struct with fields:
                 Epoch: 1
             Iteration: 1
        TimeSinceStart: 23.7756
          TrainingLoss: 2.7155
        ValidationLoss: 2.5169
         BaseLearnRate: 0.0100
      TrainingAccuracy: 7.8125
          TrainingRMSE: 3.3138
    ValidationAccuracy: 12.7000
        ValidationRMSE: []
                 State: "iteration"
```

```matlab
info = 
  struct with fields:
                 Epoch: 1
             Iteration: 2
        TimeSinceStart: 79.4602
          TrainingLoss: 2.5766
        ValidationLoss: []
         BaseLearnRate: 0.0100
      TrainingAccuracy: 12.5000
          TrainingRMSE: 2.8631
    ValidationAccuracy: []
        ValidationRMSE: []
                 State: "iteration"
```

可以得出以下三个结论：

（1）每次Mini-batch所对应的Iteration结束后都会输出`info`结构体，并不是以Epoch为单位；

（2）输出的结构体的内容是与`OutputFcn`属性中所列出的内容是一致的；

（3）只有间隔`ValidationFrequency`的次数，才会输出验证集的相关信息（如这里的fields `ValidationLoss`和`ValidationAccuracy`)；

<br>

# (4) Custom early stopping based on training loss (`OutputFcn` property)

Added on Sep. 15 2023.
{: .notice--primary}

At times, available data are limited, and it is likely impractical to specify partial data as validation dataset. In these scenarios, stopping training network according to training loss or accuracy is an alternative choice. This could be realised by aforementioned `'OutputFcn'` property of `trainingOptions` as well. 

The following example shows how to stop network training when training loss is lower than a specified value (i.e. `1e-2`) 3 times in a row. 

```matlab
...
validationFrequency = floor(numel(YTrain)/miniBatchSize);
options = trainingOptions('sgdm', ...
    'InitialLearnRate',0.01, ...
    'MaxEpochs',100, ...
    'MiniBatchSize',miniBatchSize, ...
    'VerboseFrequency',validationFrequency, ...
    'ValidationData',{XValidation,YValidation}, ...
    'ValidationFrequency',validationFrequency, ...
    'Plots','training-progress', ...
    'OutputFcn',@(info)stopIfTrainingLossNotImproving(info,3));
[net,info] = trainNetwork(XTrain,YTrain,layers,options);

function stop = stopIfTrainingLossNotImproving(info,N)
stop = false;

persistent lossLag
lossThreshold = 1e-2;

if info.State == "start"
    lossLag = 0;
elseif ~isempty(info.TrainingLoss)
    if info.TrainingLoss > lossThreshold
        lossLag = 0;
    else
        lossLag = lossLag + 1;
    end
    if lossLag >= N
        stop = true;
    end
end
end
```

![image-20230915160625882](https://raw.githubusercontent.com/Ma1017/blog-images/main/imgs/image-20230915160625882.png)

We could observe recorded training information `info.TrainingLoss` to verify it:

```
>> info.TrainingLoss(end-4:end)
ans =
    0.0173    0.0141    0.0087    0.0068    0.0099
```

<br>

**References**

[1] [trainNetwork - MathWorks](https://ww2.mathworks.cn/help/deeplearning/ref/trainnetwork.html).

[2] [trainingOptions - MathWorks](https://ww2.mathworks.cn/help/deeplearning/ref/trainingoptions.html).

[3] [Customize Output During Deep Learning Network Training - MathWorks](https://ww2.mathworks.cn/help/deeplearning/ug/customize-output-during-deep-learning-training.html).











