---
title: Train Conditional Generative Adversarial Network (CGAN) in MATLAB
categories: 
 - MATLAB
 - Machine Learning
tags:
 - MATLAB Deep Learning Toolbox
 - Computer Vision
date: 2022-10-09 08:15:17 +0800
last_modified_at: 2024-04-23 08:48:42 +0800
---

# Introduction

博客[^1]分析了MATLAB中一个关于GAN的示例，但实际上，GAN有很多很多变种，MATLAB还提供了一个CGAN(Conditional Generative Adversarial Network，条件生成对抗网络)的示例，"Train Conditional Generative Adversarial Network(CGAN)"[^2]. 前者可以视为一个无监督学习模型，而后者是一个使用带标签数据集训练的有监督学习模型。两个示例使用的是同一个训练集，其代码也非常类似，本文主要分析两者实现之间的差异，相同的部分从略。

<br>

# Differences Between GAN and CGAN


## Difference 1: Load Data

对于CGAN，在使用`imgaeDatastore`装载图片数据时，需要新增`LabelSource`的参数设置：

```matlab
mageFolder = fullfile(pwd,"flower_photos");
datasetFolder = fullfile(imageFolder);
imds = imageDatastore(datasetFolder,IncludeSubfolders=true,LabelSource="foldernames");
```

表示将`flower_photos`文件夹下的子文件夹名作为图片的标签。此时，`imds`变量新增了一个`Labels`属性：

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/img/image-20221008134917873.png?raw=true" alt="image-20221008134917873" style="zoom:80%;" />

我们可以查看一下分类：

```matlab
classes = categories(imds.Labels);
numClasses = numel(classes);
```

```
classes =
  5×1 cell array
    {'daisy'     }
    {'dandelion' }
    {'roses'     }
    {'sunflowers'}
    {'tulips'    }

numClasses =
     5
```

## Difference 2: Define the structures of Generator and Discriminator


<figure>
    <img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/img/image-20221008133932054.png?raw=true" alt="image-20221008133932054" style="zoom: 80%;" />
    <img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/img/image-20221008134014138.png?raw=true" alt="image-20221008134014138" style="zoom:80%;" />
    <figcation>(a)The structure of GAN; (b)The structure of CGAN.</figcation>
</figure>

上面一组图展示了GAN和CGAN结构之间的差异，可以看到，在CGAN中，图片的Labels需要输入到Generator和Discriminator中。因此，CGAN的Generator和Discriminator的结构也需要更改为下面的样子：

<figure>
    <img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/img/image-20221008135334707.png?raw=true" alt="image-20221008135334707" style="zoom:80%;" />
    <img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/img/image-20221008135422776.png?raw=true" alt="image-20221008135422776" style="zoom:80%;" />
    <figcaption>(a)The structure of Generator of CGAN;(b)The stucture of Discriminator of CGAN.</figcaption>
</figure>

下面分别进行介绍。

### The structure of Generator

CGAN的Generator网络结构如下图所示：

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/img/image-20221008135334707.png?raw=true" alt="image-20221008135334707" style="zoom:80%;" />

和GAN的差异就在前面一部分：

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/img/image-20221008140148586.png?raw=true" alt="image-20221008140148586" style="zoom:80%;" />

它的结构定义为：

```matlab
numLatentInputs = 100;
embeddingDimension = 50;
numFilters = 64;

filterSize = 5;
projectionSize = [4 4 1024];

layersGenerator = [
    featureInputLayer(numLatentInputs)               % Output size, [100, 1]
    fullyConnectedLayer(prod(projectionSize))        % Output size, [16384, 1]
    functionLayer(@(X) feature2image(X,projectionSize),Formattable=true) % Output size, [4, 4, 1024, 1]
    concatenationLayer(3,2,Name="cat");              % Output size, [4, 4, 1025, 1]

    transposedConv2dLayer(filterSize,4*numFilters)   % Output size, [8, 8, 256, 1]
    batchNormalizationLayer                          % Output size, [8, 8, 256, 1]
    reluLayer                                        % Output size, [8, 8, 256, 1]
    transposedConv2dLayer(filterSize,2*numFilters,Stride=2,Cropping="same") % Output size, [16, 16, 128, 1]
    batchNormalizationLayer                          % Output size, [16, 16, 128, 1]
    reluLayer                                        % Output size, [16, 16, 128, 1]
    transposedConv2dLayer(filterSize,numFilters,Stride=2,Cropping="same") % Output size, [32, 32, 64, 1]
    batchNormalizationLayer                          % Output size, [32, 32, 64, 1]
    reluLayer                                        % Output size, [32, 32, 64, 1]
    transposedConv2dLayer(filterSize,3,Stride=2,Cropping="same")% Output size, [64, 64, 3, 1]
    tanhLayer                                        % Output size, [64, 64, 3, 1]
    ];

lgraphGenerator = layerGraph(layersGenerator);

layers = [
    featureInputLayer(1)                           % Output size, [1, 1]
    embeddingLayer(embeddingDimension,numClasses)  % Output size, [50, 1]
    fullyConnectedLayer(prod(projectionSize(1:2))) % Output size, [16, 1]
    functionLayer(@(X) feature2image(X,[projectionSize(1:2) 1]), ...
    Formattable=true,Name="emb_reshape")           % Output size, [4, 4, 1, 1]
    ];

lgraphGenerator = addLayers(lgraphGenerator,layers);
lgraphGenerator = connectLayers(lgraphGenerator,"emb_reshape","cat/in2");

% convert the layer graph to a dlnetwork object
netG = dlnetwork(lgraphGenerator)
```

```matlab
plot(lgraphGenerator)
```

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/img/image-20221008142317431.png?raw=true" alt="image-20221008142317431" style="zoom: 80%;" />

其中，比较陌生的层是`feature2image`层、`concatenationLayer`层和`embeddingLayer`层。

#### `feature2image` Custom Layer

`feature2image`层是一个用户自定义层：

```matlab
function Y = feature2image(X,outputSize)
% Y = feature2image(X,outputSize) reshapes input with format "CB" to have
% format "SSCB" to have size given by outputSize.
Y = reshape(X, outputSize(1), outputSize(2), outputSize(3), []);
Y = dlarray(Y,'SSCB');
end
```

这个层的作用是将一个CB类型的数据reshape成一个SSCB的数据，对应于RGB图像。

#### `concatenationLayer`Built-in Layer

`concatenationLayer`层是MATLAB提供的一个层[^3]，该层的作用就是连接两个网络结构：

```matlab
layersGenerator = [
	...
	concatenationLayer(3,2,Name="cat");
	...];
```

其中：

- `3`是`dim`属性，表示连接的维度是3；
- `2`是`numInputs`属性，表示该层提供的连接端口个数；

它需要配合`addLayers`和`connectLayers`函数进行使用：

```matlab
lgraphGenerator = addLayers(lgraphGenerator,layers);
lgraphGenerator = connectLayers(lgraphGenerator,"emb_reshape","cat/in2");
```

#### `embeddingLayer`Custom Layer

`embeddingLayer`层同样是一个用户自定义层：

```matlab
classdef embeddingLayer < nnet.layer.Layer & ...
        nnet.layer.Formattable

    properties (Learnable)
        % Layer learnable parameters.
        Weights
    end
    
    methods
        function layer = embeddingLayer(embeddingDimension, inputDimension, NameValueArgs)
            % layer = embeddingLayer(embeddingDimension,inputDimension)
            % creates a embedAndReshapeLayer object that embeds and
            % reshapes the input to the specified output size using an
            % embedding of the specified size and input dimension.
            %
            % layer = embeddingLayer(embeddingDimension,inputDimension,Name=name)
            % also specifies the layer name.
            
            % Parse input arguments.
            arguments
                embeddingDimension
                inputDimension
                NameValueArgs.Name = "";
            end
            
            name = NameValueArgs.Name;
            
            % Set layer name.
            layer.Name = name;

            % Set layer description.
            layer.Description = "Embedding layer with dimension " + embeddingDimension;
            
            % Initialize embedding weights.
            layer.Weights = randn(embeddingDimension,inputDimension);
            sz = [embeddingDimension inputDimension];
            mu = 0;
            sigma = 0.01;
            layer.Weights = initializeGaussian(sz,mu,sigma);
        end
        
        function Z = predict(layer, X)
            % Forward input data through the layer at prediction time and
            % output the result.
            %
            % Inputs:
            %         layer - Layer to forward propagate through
            %         X     - Numeric indices, specified as a formatted
            %                 dlarray with a "C" and optionally a "B"
            %                 dimension.
            % Outputs:
            %         Z     - Output of layer forward function returned as 
            %                 an dlarray with format "CB".

            % Embedding.
            weights = layer.Weights;
            Z = embed(X,weights);
        end
    end
end
```

它的作用主要还是Reshape，相当于定义了两个层和它们之间的连接线。

### The structure of Discriminator

同样地，CGAN和GAN的Discriminator之间的差异仍体现在前面一部分：

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/img/image-20221008144604573.png?raw=true" alt="image-20221008144604573" style="zoom:80%;" />

其结构定义：

```matlab
dropoutProb = 0.75;
numFilters = 64;
scale = 0.2;

inputSize = [64 64 3];
filterSize = 5;

layersDiscriminator = [
    imageInputLayer(inputSize,Normalization="none")   % Output size, [64, 64, 3, 1]
    dropoutLayer(dropoutProb)                         % Output size, [64, 64, 3, 1]
    concatenationLayer(3,2,Name="cat")                % Output size, [64, 64, 4, 1]
    convolution2dLayer(filterSize,numFilters, ...     
    Stride=2,Padding="same")                          % Output size, [32, 32, 64, 1]
    leakyReluLayer(scale)                             % Output size, [32, 32, 64, 1]
    convolution2dLayer(filterSize,2*numFilters, ...   
    Stride=2,Padding="same")                          % Output size, [16, 16, 128, 1]
    batchNormalizationLayer                           % Output size, [16, 16, 128, 1]
    leakyReluLayer(scale)                             % Output size, [16, 16, 128, 1]
    convolution2dLayer(filterSize,4*numFilters, ...
    Stride=2,Padding="same")                          % Output size, [8, 8, 256, 1]
    batchNormalizationLayer                           % Output size, [8, 8, 256, 1]
    leakyReluLayer(scale)                             % Output size, [8, 8, 256, 1]
    convolution2dLayer(filterSize,8*numFilters, ...
    Stride=2,Padding="same")                          % Output size, [4, 4, 512, 1]
    batchNormalizationLayer                           % Output size, [4, 4, 512, 1]
    leakyReluLayer(scale)                             % Output size, [4, 4, 512, 1]
    convolution2dLayer(4,1)                           % Output size, [1, 1, 1, 1]
    ];

lgraphDiscriminator = layerGraph(layersDiscriminator);

layers = [
    featureInputLayer(1)                                   % Output size, [1, 1]
    embeddingLayer(embeddingDimension,numClasses)          % Output size, [50, 1]
    fullyConnectedLayer(prod(inputSize(1:2)))              % Output size, [4096, 1]
    functionLayer(@(X) feature2image(X,[inputSize(1:2) 1]), ...
    Formattable=true,Name="emb_reshape")                   % Output size, [64, 64, 1, 1]
    ]; 

lgraphDiscriminator = addLayers(lgraphDiscriminator,layers);
lgraphDiscriminator = connectLayers(lgraphDiscriminator,"emb_reshape","cat/in2");

% Convert the layer graph to a dlnetwork object
netD = dlnetwork(lgraphDiscriminator)
```

与Generator的定义是类似的。

```matlab
plot(lgraphDiscriminator)
```

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/img/image-20221008144924079.png?raw=true" alt="image-20221008144924079" style="zoom:80%;" />

## Difference 3: Calculate losses and scores

CGAN在losses和scores的计算方面也有细微差异：

```matlab
function [lossG,lossD,gradientsG,gradientsD,stateG,scoreG,scoreD] = ...
    modelLoss(netG,netD,X,T,Z,flipFactor)

% Calculate the predictions for real data with the discriminator network.
YReal = forward(netD,X,T);

% Calculate the predictions for generated data with the discriminator network.
[XGenerated,stateG] = forward(netG,Z,T);
YGenerated = forward(netD,XGenerated,T);

% Calculate probabilities.
probGenerated = sigmoid(YGenerated);
probReal = sigmoid(YReal);

% Calculate the generator and discriminator scores.
scoreG = mean(probGenerated);
scoreD = (mean(probReal) + mean(1-probGenerated)) / 2;

% Flip labels.
numObservations = size(YReal,4);
idx = randperm(numObservations,floor(flipFactor * numObservations));
probReal(:,:,:,idx) = 1 - probReal(:,:,:,idx);

% Calculate the GAN loss.
[lossG, lossD] = ganLoss(probReal,probGenerated);

% For each network, calculate the gradients with respect to the loss.
gradientsG = dlgradient(lossG,netG.Learnables,RetainData=true);
gradientsD = dlgradient(lossD,netD.Learnables);
end
```

```matlab
function [lossG, lossD] = ganLoss(probReal,probGenerated)
% Combine the losses for the discriminator network.
lossD = -mean(log(probReal))-mean(log(1 - probGenerated));

% Calculate the loss for the generator network.
lossG = -mean(log(probGenerated));
end
```

CGAN的Generator和Discriminator网络的losses和scores计算路径示意图如下图所示：

![image-20221008154036959](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/img/image-20221008154036959.png?raw=true)

![image-20221008154014613](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/img/image-20221008154014613.png?raw=true)

与GAN相比：

![image-20221008153243800](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/img/image-20221008153243800.png?raw=true)

![image-20221008153217280](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/img/image-20221008153217280.png?raw=true)

可以看到主要有两点差异：

1. 标签`T`需要输入到G和D中；
2. 在本示例的CGAN中，D输出值需要先经过`sigmoid`函数计算，再进行计算，这一点影响不大；

## Difference 4: Fix validation data

在设置用于观察训练进度的验证集时，除了固定随机向量，还需要固定标签：

```matlab
numValidationImagesPerClass = 5;
ZValidation = randn(numLatentInputs,numValidationImagesPerClass*numClasses,"single");

TValidation = single(repmat(1:numClasses,[1 numValidationImagesPerClass]));

% Convert the data to dlarray objects and specify the dimension labels "CB" (channel, batch).
ZValidation = dlarray(ZValidation,"CB");
TValidation = dlarray(TValidation,"CB");

% For GPU training, convert the data to gpuArray objects
if (executionEnvironment == "auto" && canUseGPU) || executionEnvironment == "gpu"
    ZValidation = gpuArray(ZValidation);
    TValidation = gpuArray(TValidation);
end
```

## Difference 5: Generate New Images

同样地，在测试Generator生成图片的效果时，除了要定义随机向量，还需要定义标签：

```matlab
% Create an array of 36 vectors of random values corresponding to the first class
numObservationsNew = 36;
idxClass = 1;
ZNew = randn(numLatentInputs,numObservationsNew,"single");
TNew = repmat(single(idxClass),[1 numObservationsNew]);

% Convert the data to dlarray objects with the dimension labels "SSCB" (spatial, spatial, channels, batch)
ZNew = dlarray(ZNew,"CB");
TNew = dlarray(TNew,"CB");

% To generate images using the GPU, also convert the data to gpuArray objects
if (executionEnvironment == "auto" && canUseGPU) || executionEnvironment == "gpu"
    ZNew = gpuArray(ZNew);
    TNew = gpuArray(TNew);
end
% Generate images using the predict function with the generator network
XGeneratedNew = predict(netG,ZNew,TNew);
```

<br>

# Result of CGAN

使用NVIDA GeForce RTX 3060 Ti GPU 花费1h45min训练了500轮，得到最终的结果：

![image-20221008231021799](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20221008231021799.png?raw=true)

查看训练好的生成器生成daisy花图像的效果：

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20221008231146582.png?raw=true" alt="image-20221008231146582" style="zoom:80%;" />

最后，保存一下模型：

```matlab
% Save models 
save('Generator.mat', 'netG')
save('Discriminator.mat', 'netD')
```

并进行测试：

```matlab
clc, clear, close all

load Generator.mat
load Discriminator.mat

% Create an array of 36 vectors of random values corresponding to the first class
numObservationsNew = 36;
numLatentInputs = 100;
idxClass = 1;
executionEnvironment = "auto";

ZNew = randn(numLatentInputs,numObservationsNew,"single");
TNew = repmat(single(idxClass),[1 numObservationsNew]);

% Convert the data to dlarray objects with the dimension labels "SSCB" (spatial, spatial, channels, batch)
ZNew = dlarray(ZNew,"CB");
TNew = dlarray(TNew,"CB");

% To generate images using the GPU, also convert the data to gpuArray objects
if (executionEnvironment == "auto" && canUseGPU) || executionEnvironment == "gpu"
    ZNew = gpuArray(ZNew);
    TNew = gpuArray(TNew);
end
% Generate images using the predict function with the generator network
XGeneratedNew = predict(netG,ZNew,TNew);

% Display the generated images in a plot
figure
I = imtile(extractdata(XGeneratedNew));
I = rescale(I);
imshow(I)
title("Class: daisy")
```

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20221008231718465.png?raw=true" alt="image-20221008231718465" style="zoom: 80%;" />

<br>

# Reference

[^1]: [Train Generative Adversarial Network (GAN) in MATLAB - What a starry night~](https://helloworld-1017.github.io/2022-10-09/08-10-11.html)
[^2]: [Train Conditional Generative Adversarial Network(CGAN) - MathWorks](https://ww2.mathworks.cn/help/deeplearning/ug/train-conditional-generative-adversarial-network.html).
[^3]: [MATLAB `concatenationLayer`: Concatenation layer - MathWorks](https://ww2.mathworks.cn/help/deeplearning/ref/nnet.cnn.layer.concatenationlayer.html).
