---
layout: single
title: A Small Custom Function, Testing the Output Size of Each Layer of Neural Network in MATLAB
date: 2022-10-10 13:51:38 +0800
categories: 
 - MATLAB
 - Machine Learning
tags:
 - MATLAB Deep Learning Toolbox
toc: false
---

在使用MATLAB Deep Learning Toolbox提供的神经网络结构的时候，发现在大多数情况下，神经网络的Layers并没有显式的关于输入输出size的属性。很多层对于输入是没有要求的，不需要将上一层的输出和下一层的输入设置一致，各种Layer更像是定义了各种Operation，比如`convolution2dLayer`层和`transposedConv2dLayer`层，经过层的输出的size需要根据公式和参数设置进行计算，比较麻烦。

最开始我想要了解经过一个层的output size，采用的方式是注释掉后面的层，然后随机生成一个预期的Data format的dlarray，然后查看输出的大小。这么做有些繁琐，因此我就写了一个小的函数`helperTestLayerOutput`：

```matlab
function helperTestLayerOutput(Layers, Input)
% Select the former 'idx' layers
for idx = 1:numel(Layers)
    RestLayers = Layers(1:idx);
    % Convert to dlnetwork object
    RestNet = dlnetwork(RestLayers);
    % Forward process
    Output = predict(RestNet, Input);
    % Show output size in command line
    fprintf(sprintf('The output size of the %s layer is: ', num2str(idx)))
    disp(size(Output))
end
end
```

其功能是通过循环选取网络图`Layers`的前`idx`个层，转换为`dlnetwork`对象，之后使用随机生成的输入进行前馈过程，最后将输出的大小展示在命令行中。

下面以[Train Variational Autoencoder(VAE) to Generate Images in MATLAB](http://whatastarrynight.com/programming/machine%20learning/Train-Variational-Autoencoder(VAE)-to-Generate-Images-in-MATLAB/)中VAE所使用的Encoder网络和Decoder网络进行测试。

对于Encoder网络：

```matlab
clc, clear, close all

numLatentChannels = 16;
imageSize = [28 28 1];

layersE = [
    imageInputLayer(imageSize, Normalization="none")    % Output size, [28, 28, 1, 1]
    convolution2dLayer(3, 32, Padding="same", Stride=2) % Output size, [14, 14, 32, 1]
    reluLayer                                           % Output size, [14, 14, 32, 1]                   
    convolution2dLayer(3, 64, Padding="same", Stride=2) % Output size, [7, 7, 64, 1]
    reluLayer                                           % Output size, [7, 7, 64, 1]
    fullyConnectedLayer(2*numLatentChannels)            % Output size, [32, 1]
    samplingLayer                                       % Output size, [16, 1]
    ];

Input = randn(imageSize);
Input = dlarray(Input, "SSCB");

helperTestLayerOutput(layersE, Input)

function helperTestLayerOutput(Layers, Input)
% Select the former 'idx' layers
for idx = 1:numel(Layers)
    RestLayers = Layers(1:idx);
    % Convert to dlnetwork object
    RestNet = dlnetwork(RestLayers);
    % Forward process
    Output = predict(RestNet, Input);
    % Show output size in command line
    fprintf(sprintf('The output size of the %s layer is: ', num2str(idx)))
    disp(size(Output))
end
end
```

命令行中展示的内容：

```matlab
The output size of the 1 layer is:     28    28     1     1
The output size of the 2 layer is:     14    14    32     1
The output size of the 3 layer is:     14    14    32     1
The output size of the 4 layer is:      7     7    64     1
The output size of the 5 layer is:      7     7    64     1
The output size of the 6 layer is:     32     1
The output size of the 7 layer is:     16     1
```

对于Decoder网络：

```matlab
clc, clear, close all

imageSize = [28 28 1];
numLatentChannels = 16;
projectionSize = [7 7 64];
numInputChannels = size(imageSize,1);

% Construct computational graph
layersD = [
    featureInputLayer(numLatentChannels)                       % Output size, [16, 1]
    projectAndReshapeLayer(projectionSize, numLatentChannels)  % Output size, [7, 7, 64, 1]
    transposedConv2dLayer(3, 64, Cropping="same",Stride=2)     % Output size, [14, 14, 64, 1]
    reluLayer                                                  % Output size, [14, 14, 64, 1]
    transposedConv2dLayer(3, 32, Cropping="same",Stride=2)     % Output size, [28, 28, 32, 1]
    reluLayer                                                  % Output size, [28, 28, 32, 1]
    transposedConv2dLayer(3, numInputChannels, Cropping="same")% Output size, [28, 28, 1, 1]
    sigmoidLayer                                               % Output size, [28, 28, 1, 1]
    ];

% New a Input and convert it to dlarray 
Input = randn([16, 1]);
Input = dlarray(Input, "CB");

helperTestLayerOutput(layersD, Input)

function helperTestLayerOutput(Layers, Input)
% Select the former 'idx' layers
for idx = 1:numel(Layers)
    RestLayers = Layers(1:idx);
    % Convert to dlnetwork object
    RestNet = dlnetwork(RestLayers);
    % Forward process
    Output = predict(RestNet, Input);
    % Show output size in command line
    fprintf(sprintf('The output size of the %s layer is: ', num2str(idx)))
    disp(size(Output))
end
end
```
命令行中展示的内容：

```matlab
The output size of the 1 layer is:     16     1
The output size of the 2 layer is:      7     7    64     1
The output size of the 3 layer is:     14    14    64     1
The output size of the 4 layer is:     14    14    64     1
The output size of the 5 layer is:     28    28    32     1
The output size of the 6 layer is:     28    28    32     1
The output size of the 7 layer is:     28    28     1     1
The output size of the 8 layer is:     28    28     1     1
```

Bingo~

<br>

**2023年1月4日**

今天在学习示例[Compare Deep Learning Model Using ROC Curves - MathWorks](https://ww2.mathworks.cn/help/deeplearning/ug/compare-deep-learning-models-using-ROC-curves.html)时发现Deep Learning Toolbox其实提供了类似的且更为强大的`analyzeNetwork`函数（[analyzeNetwork - MathWorks](https://ww2.mathworks.cn/help/deeplearning/ref/analyzenetwork.html)）来实现上面的功能。

```matlab
clc, clear, close all

imageSize = [28 28 1];

% For Encoder
numLatentChannels = 16;
layersE = [
    imageInputLayer(imageSize, Normalization="none")   
    convolution2dLayer(3, 32, Padding="same", Stride=2) 
    reluLayer                                                              
    convolution2dLayer(3, 64, Padding="same", Stride=2) 
    reluLayer                                          
    fullyConnectedLayer(2*numLatentChannels)            
    samplingLayer                                       
    ];

% For Decoder
projectionSize = [7 7 64];
numInputChannels = size(imageSize,1);
layersD = [
    featureInputLayer(numLatentChannels)                       
    projectAndReshapeLayer(projectionSize, numLatentChannels)  
    transposedConv2dLayer(3, 64, Cropping="same",Stride=2)    
    reluLayer                                                  
    transposedConv2dLayer(3, 32, Cropping="same",Stride=2)    
    reluLayer                                                  
    transposedConv2dLayer(3, numInputChannels, Cropping="same")
    sigmoidLayer                                              
    ];

NetE = layerGraph(layersE);
NetD = layerGraph(layersD);

analyzeNetwork(NetE)
analyzeNetwork(NetD)
```

![image-20230104121358730](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230104121358730.png?raw=true)

![image-20230104121412683](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230104121412683.png?raw=true)

可以看到，每一层输出的size和之前写的小函数得到的结果是一致的。但与此同时，软件还检测出神经网络的一些errors。但是，这两个神经网络结构同样来自官方示例[Train Variational Autoencoder(VAE) to Generate Images in MATLAB](http://whatastarrynight.com/programming/machine%20learning/Train-Variational-Autoencoder(VAE)-to-Generate-Images-in-MATLAB/)，完全可以运行并且没有报错，这是怎么回事呢？

进一步查看[analyzeNetwork](https://ww2.mathworks.cn/help/deeplearning/ref/analyzenetwork.html)的官方文档，可以看到实际上该函数对于`target`做出了区分：

![image-20230104122219070](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230104122219070.png?raw=true)

简单地讲，使用`trainNetwork`训练的神经网络（比如示例[Compare Deep Learning Model Using ROC Curves - MathWorks](https://ww2.mathworks.cn/help/deeplearning/ug/compare-deep-learning-models-using-ROC-curves.html)中定义的神经网络）都是比较经典的结构或者采用通用的训练策略和设置；而如果用户想要自定义cusom trianing loop（比如示例[Train Variational Autoencoder(VAE) to Generate Images in MATLAB](http://whatastarrynight.com/programming/machine%20learning/Train-Variational-Autoencoder(VAE)-to-Generate-Images-in-MATLAB/)中的VAE），需要在定义好layers后，使用`dlnetwork`函数将其转换为`dlnetwork`对象，再创建自定义循环。对于后者，分析神经网络时需要使用语法`analyzeNetwork(layers,TargetUsage="dlnetwork")`。

因此，对于上面所构建的Encoder和Decoder，需要使用下面的代码进行分析：

```matlab
...
analyzeNetwork(NetE, TargetUsage="dlnetwork")
analyzeNetwork(NetD, TargetUsage="dlnetwork")
```

![image-20230104124812740](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230104124812740.png?raw=true)

![image-20230104124822084](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230104124822084.png?raw=true)

此时就没有errors了。
