---
layout: single
title: Multi-input and Multi-output Neural Network Structures in MATLAB
date: 2022-10-12 13:09:07 +0800
categories: 
 - MATLAB
 - Machine Learning
tags:
 - MATLAB Deep Learning Toolbox
toc: false
---

今天在根据之前学习的内容编写一个解决自己科研课题的一个CGAN，但是在更新Generator状态的时候遇到了一个错误。更新Generator的State的主要代码为：

```matlab
[dlXGenerated, stateG] = forward(netG, dlZ, dlT);
netG.State = stateG;
```

此时遇到错误：

```
Error using dlnetwork>iAssertValidState
State must be a table with columns 'Layer', 'Parameter', and
'Value'. Each entry of 'Value' must be a 1-by-1 cell array
containing a real-valued finite numeric array or dlarray
object.
```

之后，我查看了`forward`函数的官方文档：[forward - MathWorks](https://ww2.mathworks.cn/help/deeplearning/ref/dlnetwork.forward.html)，发现自己可能是自己定义的网络结构有问题。

```matlab
numLatentInputs = 3;
numClasses = 7;

LayersG = [
    featureInputLayer(numLatentInputs)
    concatenationLayer(1, 2, 'Name','cat')
    fullyConnectedLayer(5)
    batchNormalizationLayer
    reluLayer
    fullyConnectedLayer(6)
    batchNormalizationLayer
    reluLayer
    fullyConnectedLayer(7)
    batchNormalizationLayer
    reluLayer
    ];
Layersf1 = [
    featureInputLayer(1, 'Name', 'LabelsG')
    fullyConnectedLayer(5)
    batchNormalizationLayer
    reluLayer
    fullyConnectedLayer(1)
    ];
lgraphG = layerGraph(LayersG);
lgraphG = addLayers(lgraphG, Layersf1);
lgraphG = connectLayers(lgraphG, 'LabelsG', 'cat/in2');
```

绘制该神经网络的结构图：

```matlab
plot(lgraphG)
```

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20221013131327393.png?raw=true" alt="image-20221013131327393" style="zoom:67%;" />

可以看到，实际上我在无意中定义了一个双输出的神经网络结构，因此代码：

```matlab
[dlXGenerated, stateG] = forward(netG, dlZ, dlT);
```

的`stateG`是第二个输出值，而不是表示网络State的table，因此出现了报错。

<br>

上述代码片段之所以是定义了一个双输出的的结构，是因为代码：

```matlab
Layersf1 = [
    featureInputLayer(1, 'Name', 'LabelsG')
    fullyConnectedLayer(5)
    batchNormalizationLayer
    reluLayer
    fullyConnectedLayer(1)
    ];
```

错把第一个输入层的`'Name'`设置为`'LabelsG'`，使得之后连接网络时：

```matlab
lgraphG = connectLayers(lgraphG, 'LabelsG', 'cat/in2');
```

将`Layersf1`的第一层的输出连接到`lgraphG`中，并且第一层的输出还会继续向前连接，就导致了双输出。更改这个代码也很简单，只需要将`Layersf1`的层结构改为：

```matlab
Layersf1 = [
    featureInputLayer(1)
    fullyConnectedLayer(5)
    batchNormalizationLayer
    reluLayer
    fullyConnectedLayer(1, 'Name', 'LabelsG')
    ];
```

就是一个简单的CGAN的Generator的结构了：

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20221013130725445.png?raw=true" alt="image-20221013130725445" style="zoom: 67%;" />

实际上，多输入多输出的神经网络结构在深度学习模型中是比较常见的，比如著名的ResNet，GoogleNet等等（见[resnet50 - MathWorks](https://ww2.mathworks.cn/help/deeplearning/ref/resnet50.html)）。