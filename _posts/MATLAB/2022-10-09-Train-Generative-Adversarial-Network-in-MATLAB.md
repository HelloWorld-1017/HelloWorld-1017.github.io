---
layout: single
title: Train Generative Adversarial Network(GAN) in MATLAB
categories: 
 - MATLAB
 - Machine Learning
tags:
 - MATLAB Deep Learning Toolbox
 - Computer Vision
date: 2022-10-09 08:10:11 +0800
last_modified_at0: 2022-10-09 08:10:11 +0800
last_modified_at1: 2024-04-23 08:55:29 +0800
last_modified_at: 2024-04-23 08:55:29 +0800
---

# Introduction

本示例来自MATLAB官方：[Train Generative Adversarial Network(GAN) - MathWorks](https://ww2.mathworks.cn/help/deeplearning/ug/train-generative-adversarial-network.html).
{: .notice}

生成对抗网络(Generative adversarial network, GAN)是一类能够生成和input real data相同特征数据的深度学习网络。MATLAB自带的`trainNetwork`不支持训练GANs，因此需要自己定义`dlarray`和`dlnetwork`对象使用自动微分功能，编写custom training loop。

GAN包含两个部分结构：

- 生成器(Generator)，给定一个随机向量(隐层输入，latent input)作为输入，该网络可以生成和训练数据相同结构数据；

  ![image-20221008082639079](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/img/image-20221008082639079.png?raw=true)

- 判别器(Discriminator)，给定批量的训练数据(真实数据)和生成数据，该网络判断它们是"real"还是"generated"。

下图展示了GAN的总体结构：

![image-20221008082729985](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/img/image-20221008082729985.png?raw=true)

训练GAN，就是同时提升Generator和Discriminator的表现：

- 训练Generator，使得其生成数据能够骗过Discriminator。因此，为了优化Generator的性能，需要在向Discriminator输入生成数据时，最小化Discriminator的损失函数值；
- 训练Discriminator，使得其能有效分辨真实数据和生成数据。因此，为了优化Discriminator的性能，需要在向Discriminator输入真实数据和生成数据时，最小化Discriminator的损失值函数。

在理想情况下，使用这样的训练策略能够使Generator生成足够真实的数据，使Discriminator学习到训练数据的强特征表示(strong feature representations)。

<br>

# Workflow

## Load Data

本示例的数据集是一个鲜花图片数据集，来自：http://download.tensorflow.org/example_images/flower_photos.tgz，当下载解压后，所有的图片都保存在`flower_photos`文件夹中。`flower_photos`文件夹中有5个以花名命名的子文件夹，分别是`daisy`，`dandelion`，`roses`，`sunflowers`，`tulips`：

```matlab
>> dir("flower_photos")
.            ..           LICENSE.txt  daisy        dandelion    roses        sunflowers   tulips
```

其中存放着对应所属类别的鲜花的图片。

之后，给这些图片创建image datastore：

```matlab
imageFolder = fullfile(pwd, "flower_photos");
datasetFolder = fullfile(imageFolder);
imds = imageDatastore(datasetFolder, IncludeSubfolders=true);
```

此时，变量`imds`是一个`ImageDatastore`类的实例：

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/img/image-20221008085146901.png?raw=true" alt="image-20221008085146901" style="zoom: 80%;" />

之后，对图片数据进行数据增强，数据增强的方式为random horizontal flipping，并且将图片的大小调整为64-by-64：

```matlab
augmenter = imageDataAugmenter(RandXReflection=true);
augimds = augmentedImageDatastore([64 64], imds, DataAugmentation=augmenter);
```

此时，变量`augimds`是一个`augmentedImageDatastore`类的实例：

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/img/image-20221008085606565.png?raw=true" alt="image-20221008085606565" style="zoom: 80%;" />

## Define Generative Adversarial Network

如前文所述，GAN包含两部分的神经网络，分别是Generator和Discriminator，需要分别定义。

### Define Generator Network

本示例GAN的Generator网络结构如下：

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/img/image-20221008085923114.png?raw=true" alt="image-20221008085923114"  />

该网络：

- 使用一个用户自定义层`projectAndReshapeLayer`，将size为100的random vector转换为<u>4-by-4-by-512的array</u>；
- 使用一系列的Transposed convolution layers(转置卷积层)、Batch Normalization Layers和ReLU Layers将<u>4-by-4-by-512的array</u>上采样为<u>64-by-64-by-3的array</u>。

转置卷积(transposed convolution)也称为微步卷积(fractionally strided convolution)或反卷积(deconvolution)，在图像生成网络、图像自动编码器等模型中广泛应用。卷积可以用于图像数据尺寸的缩小，而转置卷积可以用于图像数据尺寸的放大，又分别称为下采样和上采样。
{: .notice--primary}

具体而言：

- 对于Transposed convolution layers，设置5-by-5的filter，filter的数量递减，并且cropping of the output on each edge；

  在MATLAB中，不使用kernel这个说法，filter指的就是kernel。还有另外一种说法：kernel是卷积核，filter对应的是多通道的kernel。
  {: .notice--warning}

- 对于最后一个Transposed convolution layer，定义3个5-by-5的filter，对应生成图像的RGB通道；

- 在网络的最后，包含一个tanh layer。

首先自定义层`projectAndReshapeLayer`，用于project和reshape随机向量：

```matlab
classdef projectAndReshapeLayer < nnet.layer.Layer ...
        & nnet.layer.Formattable ...
        & nnet.layer.Acceleratable

    properties
        % Layer properties.
        OutputSize
    end

    properties (Learnable)
        % Layer learnable parameters.
        
        Weights
        Bias
    end
    
    methods
        function layer = projectAndReshapeLayer(outputSize,numChannels,NameValueArgs)
            % layer = projectAndReshapeLayer(outputSize,numChannels)
            % creates a projectAndReshapeLayer object that projects and
            % reshapes the input to the specified output size using and
            % specifies the number of input channels.
            %
            % layer = projectAndReshapeLayer(outputSize,numChannels,Name=name)
            % also specifies the layer name.
            
            % Parse input arguments.
            arguments
                outputSize
                numChannels
                NameValueArgs.Name = "";
            end
                        
            % Set layer name.
            name = NameValueArgs.Name;
            layer.Name = name;

            % Set layer description.
            layer.Description = "Project and reshape to size " + ...
                join(string(outputSize));
            
            % Set layer type.
            layer.Type = "Project and Reshape";
            
            % Set output size.
            layer.OutputSize = outputSize;
            
            % Initialize fully connect weights and bias.
            sz = [prod(outputSize) numChannels];
            numOut = prod(outputSize);
            numIn = numChannels;
            layer.Weights = initializeGlorot(sz, numOut, numIn);
            layer.Bias = initializeZeros([prod(outputSize) 1]);
        end
        
        function Z = predict(layer, X)
            % Forward input data through the layer at prediction time and
            % output the result.
            %
            % Inputs:
            %         layer - Layer to forward propagate through
            %         X     - Input data, specified as a formatted dlarray
            %                 with a "C" and optionally a "B" dimension.
            % Outputs:
            %         Z     - Output of layer forward function returned as 
            %                 a formatted dlarray with format "SSCB".

            % Fully connect.
            weights = layer.Weights;
            bias = layer.Bias;
            X = fullyconnect(X, weights, bias);
            
            % Reshape.
            outputSize = layer.OutputSize;
            Z = reshape(X,outputSize(1), outputSize(2), outputSize(3), []);
            Z = dlarray(Z, "SSCB");
        end
    end
end
```

之后，定义Generator网络结构：

```matlab
filterSize = 5;
numFilters = 64;
numLatentInputs = 100;

projectionSize = [4 4 512];

layersGenerator = [
    featureInputLayer(numLatentInputs)
    projectAndReshapeLayer(projectionSize,numLatentInputs)
    transposedConv2dLayer(filterSize,4*numFilters)
    batchNormalizationLayer
    reluLayer
    transposedConv2dLayer(filterSize,2*numFilters,Stride=2,Cropping="same")
    batchNormalizationLayer
    reluLayer
    transposedConv2dLayer(filterSize,numFilters,Stride=2,Cropping="same")
    batchNormalizationLayer
    reluLayer
    transposedConv2dLayer(filterSize,3,Stride=2,Cropping="same")
    tanhLayer];
```

之后，将其转换为`dlnetwork`对象，以使用自动微分功能和custom training loop：

```matlab
netG = dlnetwork(layersGenerator);
```

### Define Discriminator Network

本示例GAN的Discriminator的网络结构如下图所示：

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/img/image-20221008100427867.png?raw=true" alt="image-20221008100427867"  />

该网络：

- 将64-by-64-by-3的图像作为输出，并且返回一个scalar prediction score；
- 由一系列Convolution layers，Batch Normalization layers和Leaky ReLU layers构成；
- 使用Dropout层向输入图像中添加噪声；

具体而言：

- 对于Dropout layer，指定dropout probability为0.5；
- 对于Convolution layer，设置5-by-5的filter，filter的数量递增，stride为2，并且padding output；
- 对于Leaky ReLU layers，设置scale为0.2；
- 为了输出范围为[0,1]的概率值，在最后的Convolution layer后面添加一个Sigmoid layer。

```matlab
dropoutProb = 0.5;
numFilters = 64;
scale = 0.2;

inputSize = [64 64 3];
filterSize = 5;

layersDiscriminator = [
    imageInputLayer(inputSize,Normalization="none")
    dropoutLayer(dropoutProb)
    convolution2dLayer(filterSize,numFilters,Stride=2,Padding="same")
    leakyReluLayer(scale)
    convolution2dLayer(filterSize,2*numFilters,Stride=2,Padding="same")
    batchNormalizationLayer
    leakyReluLayer(scale)
    convolution2dLayer(filterSize,4*numFilters,Stride=2,Padding="same")
    batchNormalizationLayer
    leakyReluLayer(scale)
    convolution2dLayer(filterSize,8*numFilters,Stride=2,Padding="same")
    batchNormalizationLayer
    leakyReluLayer(scale)
    convolution2dLayer(4,1)
    sigmoidLayer];
```

并将其转换为`dlnetwork`对象：

```matlab
netD = dlnetwork(layersDiscriminator);
```

## Define Model Functions

定义损失函数`modelLoss`：

```matlab
function [lossG,lossD,gradientsG,gradientsD,stateG,scoreG,scoreD] = ...
    modelLoss(netG,netD,X,Z,flipProb)

% Calculate the predictions for real data with the discriminator network.
YReal = forward(netD,X);

% Calculate the predictions for generated data with the discriminator
% network.
[XGenerated,stateG] = forward(netG,Z);
YGenerated = forward(netD,XGenerated);

% Calculate the score of the discriminator.
scoreD = (mean(YReal) + mean(1-YGenerated)) / 2;

% Calculate the score of the generator.
scoreG = mean(YGenerated);

% Randomly flip the labels of the real images.
numObservations = size(YReal,4);
idx = rand(1,numObservations) < flipProb;
YReal(:,:,:,idx) = 1 - YReal(:,:,:,idx);

% Calculate the GAN loss.
[lossG, lossD] = ganLoss(YReal,YGenerated);

% For each network, calculate the gradients with respect to the loss.
gradientsG = dlgradient(lossG,netG.Learnables,RetainData=true);
gradientsD = dlgradient(lossD,netD.Learnables);
end
```

该函数的输入：

- `netG`和`netD`，分别代表Generator网络和Discriminator网络；
- `X`，代表a mini-batch of input data；
- `Z`，代表random vectors；
- `flipProb`，代表the probability to flip the real labels；

输出：

- `lossG`和`lossD`，分别表示Generator网络和Discriminator网络的损失值；
- `gradientsG`和`gradientsD`，分别表示Generator网络和Discriminator网络的损失值关于其learnable parameters的梯度；
- `stateG`为generator state；
- `scoreG`和`scoreD`，分别为两个网络的scores；

其中，最重要的是**(1)两个网络的损失值的计算**和**(2)两个网络的scores**。



### Losses of G and D

Generator和Discriminator网络的losses计算路径示意图如下图所示：

![image-20221008153243800](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/img/image-20221008153243800.png?raw=true)

在计算losses的时候，调用了一个自定义函数`ganLoss`：

```matlab
function [lossG,lossD] = ganLoss(YReal,YGenerated)

% Calculate the loss for the discriminator network.
lossD = -mean(log(YReal)) - mean(log(1-YGenerated));

% Calculate the loss for the generator network.
lossG = -mean(log(YGenerated));
end
```

其中，函数的输入：

- `YReal`表示Discriminator认为<u>**真实图片**</u>为真实的概率；
- `YGenerated`表示Discriminator认为<u>**生成图片**</u>为真实的概率，`1-YGenerated`表示Discriminator认为<u>**生成图片**</u>为生成的概率；

正如前文所述，Generator的训练目标是使其生成的数据骗过Discriminator，使后者认为生成的数据是真实的，因此Generator需要最大化`YGenerated`，即最小化损失函数negative log likelihood function：

$$
\mathrm{lossGenerator = -mean(log(Y_{Generated}))}\notag
$$

```matlab
% Calculate the loss for the generator network.
lossG = -mean(log(YGenerated));
```

Discriminator的训练目标是使其能有效分辨真实数据和生成数据，因此Discriminator需要最大化`Yreal`和`1-YGenerated`，即最小化损失函数negative log likelihood function：

$$
\mathrm{lossDiscriminator=-mean(log(Y_{Real}))-mean(log(1-Y_{Generated}))}\notag
$$

```matlab
% Calculate the loss for the discriminator network.
lossD = -mean(log(YReal)) - mean(log(1-YGenerated));
```
### Scores of G and D

Generator和Discriminator网络的Scores计算路径示意图如下图所示：

![image-20221008153217280](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/img/image-20221008153217280.png?raw=true)

在计算scores时，`YReal`和`YGenerated`的含义和计算losses是一致的，计算方法和意义也是类似的，只是多了一个负号但是能够更有效地反映相同的信息(The score is inversely proportional to the loss but effectively contains the same information)。

Generator的score：

$$
\mathrm{scoreGenerator=mean(Y_{Generated})}\notag
$$

```matlab
% Calculate the score of the generator.
scoreG = mean(YGenerated);
```

Discriminator的score：

$$
\mathrm{scoreDiscriminator=\dfrac12\Big[mean(Y_{Real})+mean(1-Y_{Generated})\Big]}\notag
$$

## Specify Training Options

设置mini-batch size和training Epochs：

```matlab
numEpochs = 500;
miniBatchSize = 128;
```

设置Adam优化器：包含learning rate，gradient decay factor和squared gradient decay factor：

```matlab
learnRate = 0.0002;
gradientDecayFactor = 0.5;
squaredGradientDecayFactor = 0.999;
```

如果Discriminator很快地分辨出真实的和生成的图像，那么就会导致Generator训练失败。更好地平衡G和D的训练，需要向真实数据中心添加噪声，这里采用的方式是flipping the labels assigned to the real images，这里指定概率为0.35，但是注意这一操作does not impair the generator as all the generated images are still labeled correctly.

这里`flipProb`函数的作用以及提到的label的含义可以见前面`modelLoss`函数的定义。
{: .notice--warning}

```matlab
flipProb = 0.35;
```

每训练100次展示generated validation images：

注意：这里的100次不是指epoch，而是指100个mini-batch训练。
{: .notice--warning}

```matlab
validationFrequency = 100;
```

## Train Model

首先，将训练图片分割成Mini-batch：

```matlab
augimds.MiniBatchSize = miniBatchSize;

mbq = minibatchqueue(augimds, ...
    MiniBatchSize=miniBatchSize, ...
    PartialMiniBatch="discard", ...
    MiniBatchFcn=@preprocessMiniBatch, ...
    MiniBatchFormat="SSCB");
```

其中，函数`preprocessMiniBatch`为自定义函数：

```matlab
function X = preprocessMiniBatch(data)
% Concatenate mini-batch
X = cat(4,data{:});
% Rescale the images in the range [-1 1].
X = rescale(X,-1,1,InputMin=0,InputMax=255);
end
```

之后，设置Adam优化器的初始参数：

```matlab
trailingAvgG = [];
trailingAvgSqG = [];
trailingAvg = [];
trailingAvgSqD = [];
```

为了监测训练过程，我们需要固定一些随机向量，观察它们输入到Generator生成的图片：

```matlab
numValidationImages = 25;
ZValidation = randn(numLatentInputs,numValidationImages,"single");
ZValidation = dlarray(ZValidation,"CB");
if canUseGPU
    ZValidation = gpuArray(ZValidation);
end
```

之后，初始化training progress plots，用于展示Generator和Discriminator的scores：

```matlab
f = figure;
f.Position(3) = 2*f.Position(3);

imageAxes = subplot(1,2,1);
scoreAxes = subplot(1,2,2);

C = colororder;
lineScoreG = animatedline(scoreAxes,Color=C(1,:));
lineScoreD = animatedline(scoreAxes,Color=C(2,:));
legend("Generator","Discriminator");
ylim([0 1])
xlabel("Iteration")
ylabel("Score")
grid on
```

最后进行训练：

```matlab
iteration = 0;
start = tic;

% Loop over epochs.
for epoch = 1:numEpochs

    % Reset and shuffle datastore.
    shuffle(mbq);

    % Loop over mini-batches.
    while hasdata(mbq)
        iteration = iteration + 1;

        % Read mini-batch of data.
        X = next(mbq);

        % Generate latent inputs for the generator network. Convert to
        % dlarray and specify the format "CB" (channel, batch). If a GPU is
        % available, then convert latent inputs to gpuArray.
        Z = randn(numLatentInputs,miniBatchSize,"single");
        Z = dlarray(Z,"CB");

        if canUseGPU
            Z = gpuArray(Z);
        end

        % Evaluate the gradients of the loss with respect to the learnable
        % parameters, the generator state, and the network scores using
        % dlfeval and the modelLoss function.
        [~,~,gradientsG,gradientsD,stateG,scoreG,scoreD] = ...
            dlfeval(@modelLoss,netG,netD,X,Z,flipProb);
        netG.State = stateG;

        % Update the discriminator network parameters.
        [netD,trailingAvg,trailingAvgSqD] = adamupdate(netD, gradientsD, ...
            trailingAvg, trailingAvgSqD, iteration, ...
            learnRate, gradientDecayFactor, squaredGradientDecayFactor);

        % Update the generator network parameters.
        [netG,trailingAvgG,trailingAvgSqG] = adamupdate(netG, gradientsG, ...
            trailingAvgG, trailingAvgSqG, iteration, ...
            learnRate, gradientDecayFactor, squaredGradientDecayFactor);

        % Every validationFrequency iterations, display batch of generated
        % images using the held-out generator input.
        if mod(iteration,validationFrequency) == 0 || iteration == 1
            % Generate images using the held-out generator input.
            XGeneratedValidation = predict(netG,ZValidation);

            % Tile and rescale the images in the range [0 1].
            I = imtile(extractdata(XGeneratedValidation));
            I = rescale(I);

            % Display the images.
            subplot(1,2,1);
            image(imageAxes,I)
            xticklabels([]);
            yticklabels([]);
            title("Generated Images");
        end

        % Update the scores plot.
        subplot(1,2,2)
        scoreG = double(extractdata(scoreG));
        addpoints(lineScoreG,iteration,scoreG);

        scoreD = double(extractdata(scoreD));
        addpoints(lineScoreD,iteration,scoreD);

        % Update the title with training progress information.
        D = duration(0,0,toc(start),Format="hh:mm:ss");
        title(...
            "Epoch: " + epoch + ", " + ...
            "Iteration: " + iteration + ", " + ...
            "Elapsed: " + string(D))
        drawnow
    end
end
```

整个的训练过程都是比较常见的操作，但是还需要注意一些地方。

首先，在整个过程中是不使用loss值的，在更新参数的时候只需要使用`modelLoss`函数输出的梯度信息即可。之后，使用`gradientG`更新Generator，使用`gradientD`更新Discriminator：

```matlab
[~,~,gradientsG,gradientsD,stateG,scoreG,scoreD] = ...
    dlfeval(@modelLoss,netG,netD,X,Z,flipProb);
netG.State = stateG;

[netD,trailingAvg,trailingAvgSqD] = adamupdate(netD, gradientsD, ...
    trailingAvg, trailingAvgSqD, iteration, ...
    learnRate, gradientDecayFactor, squaredGradientDecayFactor);

[netG,trailingAvgG,trailingAvgSqG] = adamupdate(netG, gradientsG, ...
    trailingAvgG, trailingAvgSqG, iteration, ...
    learnRate, gradientDecayFactor, squaredGradientDecayFactor);
```

在绘图的时候绘制的是scores，也不是损失函数值：

```matlab
subplot(1,2,2)
scoreG = double(extractdata(scoreG));
addpoints(lineScoreG,iteration,scoreG);
scoreD = double(extractdata(scoreD));
addpoints(lineScoreD,iteration,scoreD);
```

另一方面，本示例在训练GAN时采用的也是同时训练的方式，即每一次迭代都更新Generator和Discriminator。这种训练方式并不是唯一的，还存在其他的训练策略。

使用NVIDA GeForce RTX 3060 Ti GPU 花费1h33min训练了500轮，得到最终的结果：

![image-20221008205333021](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20221008205333021.png?raw=true)

## Generate New Images

查看训练好的生成器的效果：

```matlab
numObservations = 25;
ZNew = randn(numLatentInputs,numObservations,"single");
ZNew = dlarray(ZNew,"CB");

if canUseGPU
    ZNew = gpuArray(ZNew);
end

XGeneratedNew = predict(netG,ZNew);

I = imtile(extractdata(XGeneratedNew));
I = rescale(I);
figure
image(I)
axis off
title("Generated Images")
```

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20221008205523033.png?raw=true" alt="image-20221008205523033" style="zoom:67%;" />

## Save models

最后，保存模型：

```matlab
% Save models
save('Generator.mat', 'netG');
save('Discriminator.mat', 'netD')
```

测试一下保存的模型：

```matlab
clc, clear, close all

load("Discriminator.mat")
load("Generator.mat")

numLatentInputs = 100;
numObservations = 25;

ZNew = randn(numLatentInputs,numObservations,"single");
ZNew = dlarray(ZNew,"CB");

% If a GPU is available, then convert the latent vectors to gpuArray
if canUseGPU
    ZNew = gpuArray(ZNew);
end

% Generate new images using the predict function with the generator and the input data
XGeneratedNew = predict(netG,ZNew);

% Display the images
I = imtile(extractdata(XGeneratedNew));
I = rescale(I);
figure
image(I)
axis off
title("Generated Images")
```

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20221008210046431.png?raw=true" alt="image-20221008210046431" style="zoom:80%;" />

<br>

# Reference

[1] [Train Generative Adversarial Network(GAN) - MathWorks](https://ww2.mathworks.cn/help/deeplearning/ug/train-generative-adversarial-network.html).

