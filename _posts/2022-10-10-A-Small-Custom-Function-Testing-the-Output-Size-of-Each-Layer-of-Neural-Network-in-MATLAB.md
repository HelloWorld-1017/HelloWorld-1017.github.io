---
layout: single
title: A Small Custom Function, Testing the Output Size of Each Layer of Neural Network in MATLAB
date: 2022-10-10 13:51:38 +0800
categories: 
 - Programming
 - Machine Learning
tags:
 - MATLAB
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

其功能是通过循环选取网络图`Layers`的前`idx`个层，转换为`dlnetwork`对象，之后使用随机生成的输入进行前馈过程，最后将输出的大小展示在命令行中。下面以[Train Variational Autoencoder(VAE) to Generate Images in MATLAB](http://whatastarrynight.com/programming/machine%20learning/Train-Variational-Autoencoder(VAE)-to-Generate-Images-in-MATLAB/)中VAE所使用的Encoder网络和Decoder网络进行测试。

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
    samplingLayer                                       % Output siez, [16, 1]
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
