---
title: Train Variational Autoencoder (VAE) to Generate Images in MATLAB
categories: 
 - MATLAB
 - Machine Learning
tags:
 - Computer Vision
 - MATLAB Deep Learning Toolbox
date: 2022-10-03 14:18:19 +0800
last_modified_at: 2024-10-23 19:38:11 +0800
---

# Introduction

MATLAB提供了一个变分自编码器(Variational Autoencoder, VAE)的示例，“Train Variational Autoencoder (VAE) to Generate Images”[^1]. 该示例展示了一个使用VAE生成图片的过程。

VAE能够生成和原始数据集相同分布的数据。自编码器(autoencoder)是一种通过将输入转换为低维空间（编码步骤）并从低维表示重建输入（解码步骤）来复制其输入的模型。下图展示了autoencoder用于重构数字图像的基本结构：

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20221003135744682.png?raw=true" alt="image-20221003135744682" style="zoom:67%;" />

将随机向量输入到decoder中，就可以使用VAE生成新的图像：

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20221003135826242.png?raw=true" alt="image-20221003135826242" style="zoom: 67%;" />

VAE和常规的autoencoder的不同之处在于，它在潜在空间(latent space)中施加概率分布，并学习该分布，以使decoder的输出的分布与原始数据的分布相匹配。尤其是，latent outputs是从encoder学习的分布中随机采样的。

<br>

# Workflow

## Load Data

本示例还是使用的是手写图像数据集MNIST，需要从http://yann.lecun.com/exdb/mnist/ 上下载相应文件，并使用自定义函数`processImagesMNIST`分别提取训练图像和测试图像：

```matlab
trainImagesFile = "train-images-idx3-ubyte.gz";
testImagesFile = "t10k-images-idx3-ubyte.gz";

XTrain = processImagesMNIST(trainImagesFile);
XTest = processImagesMNIST(testImagesFile);
```

自定义函数`processImagesMNIST`：

```matlab
function X = processImagesMNIST(filename)
% The MNIST processing functions extract the data from the downloaded IDX
% files into MATLAB arrays. The processImagesMNIST function performs these
% operations: Check if the file can be opened correctly. Obtain the magic
% number by reading the first four bytes. The magic number is 2051 for
% image data, and 2049 for label data. Read the next 3 sets of 4 bytes,
% which return the number of images, the number of rows, and the number of
% columns. Read the image data. Reshape the array and swaps the first two
% dimensions due to the fact that the data was being read in column major
% format. Ensure the pixel values are in the range  [0,1] by dividing them
% all by 255, and converts the 3-D array to a 4-D dlarray object. Close the
% file.

dataFolder = fullfile(pwd, 'mnist');
gunzip(filename, dataFolder)

[~, name, ~] = fileparts(filename);

[fileID, errmsg] = fopen(fullfile(dataFolder, name), 'r', 'b');
if fileID < 0
    error(errmsg);
end

magicNum = fread(fileID, 1, 'int32', 0, 'b');
if magicNum == 2051
    fprintf('\nRead MNIST image data...\n')
end

numImages = fread(fileID, 1, 'int32', 0, 'b');
fprintf('Number of images in the dataset: %6d ...\n', numImages);
numRows = fread(fileID, 1, 'int32', 0, 'b');
numCols = fread(fileID, 1, 'int32', 0, 'b');

X = fread(fileID, inf, 'unsigned char');

X = reshape(X, numCols, numRows, numImages);
X = permute(X, [2 1 3]);
X = X./255;
X = reshape(X, [28, 28, 1, size(X, 3)]);

fclose(fileID);
end
```

下面介绍`processImagesMNIST`函数所依次实现的功能。

### Unzip the file

使用`gunzip`函数解压下载下来的GNU zip file，解压的文件保存在当前文件夹下的`mnist`文件夹中：

注：GNU是一种操作系统，其名称来自“GNU’s Not Unix!”。
{: .notice--primary}

```matlab
dataFolder = fullfile(pwd, 'mnist');
gunzip(filename, dataFolder)
```

![image-20221002203029860](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20221002203029860.png?raw=true)

### Open the file

使用`fopen`函数打开解压后的文件：

```matlab
[~, name, ~] = fileparts(filename);

[fileID, errmsg] = fopen(fullfile(dataFolder, name), 'r', 'b');
if fileID < 0
    error(errmsg);
end
```

`fopen`函数官方文档[^2].
{: .notice--primary}

其中：

```matlab
[fileID, errmsg] = fopen(fullfile(dataFolder, name), 'r', 'b');
```

- `fileID`为integer file identifier，该值大于等于3。MATLAB保留了file identifier的0，1，2，分别表示standard input，standard output(the screen)，和standard error。如果`fopen`不能打开文件，则`fileID`的值为-1。这里的`fileID`的值为3；
- `fullfile(dataFolder, name)`为文件的绝对路径；
- `'r'`表示 Open file for reading；
- `'b'`是`machinefmt`的属性，该属性用于设置Order for reading or writing bytes or bits，`'b'`表示Big-endian ordering。

### Read the file

使用`fread`函数读取文件的identifier`fileID`：

```matlab
magicNum = fread(fileID, 1, 'int32', 0, 'b');
if magicNum == 2051
    fprintf('\nRead MNIST image data...\n')
end
```

`fread`函数官方文档[^3].
{: .notice--primary}

`fread`函数从一个open binary file文件读取数据，读到向量`magicNum`中，并且position the file pointer at the end-of-file marker. The binary file is indicated by the file identifier `fileID` which was obtained by using `fopen` function. 当结束读取时，需要调用`fclose(fileID)`将文件关闭。

其中：

- `1`是`sizeA`属性，表示读取的dimension；
- `'int32'`是`precision`属性，interprets values in the file according to the form and size described by precision；
- `0`是`skip`属性，表示skips the number of bytes or bits specified by skip after reading each value in the file；
- `'b'`是`machinefmt`属性，含义和`fopen`函数中一致，表示the order for reading bytes or bits in the file；

此时有：

```
magicNum =
        2051
```

之后，再读取`numImages`值，`numRows`值和`numCols`值：

```matlab
numImages = fread(fileID, 1, 'int32', 0, 'b');
fprintf('Number of images in the dataset: %6d ...\n', numImages);
numRows = fread(fileID, 1, 'int32', 0, 'b');
numCols = fread(fileID, 1, 'int32', 0, 'b');
```

```
numImages =
       60000
numRows =
    28
numCols =
    28
```

这里所有的读取语句完全一样，`fileID`的值也始终是3，但是读取出来的数值是不一样的，这里具体的细节不是很清楚，但是应该是有一个cursor，按照规定的方向和顺序在移动。
{: .notice--primary}

之后，再读取每一个图像灰度值，放在变量`X`中：

```matlab
X = fread(fileID, inf, 'unsigned char');

X = reshape(X, numCols, numRows, numImages);
X = permute(X, [2 1 3]);
X = X./255;
X = reshape(X, [28, 28, 1, size(X, 3)]);
```

```
Name             Size                Bytes  Class     Attributes
  X         47040000x1             376320000  double

Name       Size                      Bytes  Class     Attributes
  X         28x28x60000            376320000  double

Name       Size                      Bytes  Class     Attributes
  X         28x28x60000            376320000  double

Name       Size                        Bytes  Class     Attributes
  X         28x28x1x60000            376320000  double
```

经过一系列操作，最终变量`X`是一个四维向量。

### Close the file

最后关闭打开的文件：

```matlab
fclose(fileID);
```

### Conclusion

使用综上所述的自定义函数`processImagesMNIST`分别读取训练集和测试集数据，可以得到：

```
Name                  Size                        Bytes  Class     
  XTest                28x28x1x10000             62720000  double         
  XTrain               28x28x1x60000            376320000  double
```

训练集有60000张图像，而测试集有10000张图像。

## Define Network Architecture

Autoencoders有两个部分：encoder和decoder。encoder将图像作为输入，中间经过一系列的downsampling操作，输出a latent vector representation(ie encoding)；类似地，decoder将latent vector representation作为输入，使用一系列upsampling操作，输出重构的图像。

### Define Encoder Network Architecture

本示例的encoder网络结构将28-by-28-by-1的图像下采样成一个16-by-1的latent vectors：

![image-20221003110820759](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20221003110820759.png?raw=true)

其中，各层的作用：

- For image input, specify an image input layer with input size matching the training data. **Do not normalize the data**.
- To downsample the input, specify two blocks of 2-D convolution and ReLU layers.
- To output a concatenated vector of means and log-variances, specify a fully connected layer with twice the number of output channels as the number of latent channels.
- To sample an encoding specified by the statistics, include a sampling layer using the custom layer samplingLayer. To access this layer, open this example as a live script.

```matlab
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
```

其中的自定义层`samplingLayer`：

```matlab
classdef samplingLayer < nnet.layer.Layer

    methods
        function layer = samplingLayer(args)
            % layer = samplingLayer creates a sampling layer for VAEs.
            %
            % layer = samplingLayer(Name=name) also specifies the layer 
            % name.
            % Parse input arguments.
            arguments
                args.Name = "";
            end
            
            % Layer properties.
            layer.Name = args.Name;
            layer.Type = "Sampling";
            layer.Description = "Mean and log-variance sampling";
            layer.OutputNames = ["out" "mean" "log-variance"];
        end

        function [Z,mu,logSigmaSq] = predict(~,X)
            % [Z,mu,logSigmaSq] = predict(~,Z) Forwards input data through
            % the layer at prediction and training time and output the
            % result.
            % Inputs:
            %         X - Concatenated input data where X(1:K,:) and 
            %             X(K+1:end,:) correspond to the mean and 
            %             log-variances, respectively, and K is the number 
            %             of latent channels.
            % Outputs:
            %         Z          - Sampled output
            %         mu         - Mean vector.
            %         logSigmaSq - Log-variance vector

            % Data dimensions.
            numLatentChannels = size(X,1)/2;
            miniBatchSize = size(X,2);

            % Split statistics.
            mu = X(1:numLatentChannels,:);
            logSigmaSq = X(numLatentChannels+1:end,:);

            % Sample output.
            epsilon = randn(numLatentChannels,miniBatchSize,"like",X);
            sigma = exp(.5 * logSigmaSq);
            Z = epsilon .* sigma + mu;
        end
    end
end
```

该layer实现的功能如下图所示：

![image-20221010104647823](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/img/image-20221010104647823.png?raw=true)

- 输出latent vector，即变量`Z`，作为decoder网络的输入；
- 输出mean vector $\mu$和log-variance vector $\log(\sigma^2)$，即变量`mu`和`logSigmaSq`，用于计算网络损失函数中的KL散度。

### Define Decoder Network Architecture

本示例的decoder网络结构将16-by-1的latent vectors重构为28-by-28-by-1的图像，即最终输出的是生成图像：

![image-20221003111905924](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20221003111905924.png?raw=true)

各层的作用：

- For feature vector input, specify a feature input layer with input size matching the number of latent channels.
- Project and reshape the latent input to 7-by-7-by-64 arrays using the custom layer `projectAndReshapeLayer`.Specify a projection size of [7 7 64].
  To upsample the input, specify two blocks of transposed convolution and ReLU layers.
- To output an image of size 28-by-28-by-1, include a transposed convolution layer with one 3-by-3 filter.
  To map the output to values in the range [0,1], include a sigmoid activation layer.

```matlab
projectionSize = [7 7 64];
numInputChannels = size(imageSize,1);
    
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
```

其中，自定义层`projectAndReshapeLayer`：

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
            layer.Weights = initializeGlorot(sz,numOut,numIn);
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
            X = fullyconnect(X,weights,bias);
            
            % Reshape.
            outputSize = layer.OutputSize;
            Z = reshape(X,outputSize(1),outputSize(2),outputSize(3),[]);
            Z = dlarray(Z,"SSCB");
        end
    end
end
```

### Convert  the layer arrays to `dlnetwork` objects

在MATLAB中为了使用自定义的训练过程，并且使用MATLAB提供的自动微分技术，需要将网络结构转换为`dlnetwork`对象：

```matlab
netE = dlnetwork(layersE);
netD = dlnetwork(layersD);
```

## Define Model Loss Function

自定义损失函数`modelLoss`，该损失函数返回模型损失值和损失值关于网络参数的梯度：

```matlab
function [loss, gradientsE, gradientsD] = modelLoss(netE, netD, X)

% Forward through encoder.
[Z, mu, logSigmaSq] = forward(netE, X);

% Forward through decoder.
Y = forward(netD, Z);

% Calculate loss and gradients.
loss = elboLoss(Y, X, mu, logSigmaSq);
[gradientsE, gradientsD] = dlgradient(loss, netE.Learnables, netD.Learnables);
end
```

`modelLoss`函数的输入输出：

- `netE`和`netD`分别表示encoder和decoder网络；
- `X`为输入数据的mini-batch；
- `loss`为模型损失；
- `gradientsE`和`gradentsD`分别为损失函数关于encoder和decoder网络参数的梯度。

该函数将训练图像传入到encoder中，并且将图像所对应的encoding输入到decoder中，以计算损失值。

损失值函数采用的是自定义损失函数`elboLoss`：

```matlab
function loss = elboLoss(Y, T, mu, logSigmaSq)

% Reconstruction loss.
reconstructionLoss = mse(Y, T);

% KL divergence.
KL = -0.5 * sum(1 + logSigmaSq - mu.^2 - exp(logSigmaSq),1);
KL = mean(KL);

% Combined loss.
loss = reconstructionLoss + KL;

end
```

`elboLoss`函数的输入：

- `Y`，生成图像；
- `X`，训练图像；
- `mu`和`logSigmaSq`，分别是encoder的mean和log-variances；

该函数基于以上输入计算evidence lower bound(ELBO) loss。该损失函数的计算路径如下图所示：

![image-20221010132050967](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/img/image-20221010132050967.png?raw=true)

ELBO损失总体上可以分为两个损失项：
$$
\mathrm{ELBO\ loss}=\mathrm{reconstrcution\ loss}+\mathrm{KL\ loss}\notag
$$

其中，$\mathrm{reconstruction}$损失使用mean-squared error(MSE)计算生成图像和生成图像之间的差距：

$$
\mathrm{reconstruction\ loss}=\mathrm{MSE(reconstructed\ image,\ input\ image)}\notag
$$

$\mathrm{KL\ loss}$，或者称为Kullback–Leibler divergence(KL 散度)，衡量了两个概率分布之间的差异。在这里最小化KL散度，意味着保证学习到的means和variances尽可能接近目标分布（ie 正态分布）。

‍♂️注意‍♀️：这里展现了VAE一个重要的假设，即假设encoder所输出的coding是服从**正态分布**的。
{: .notice--warning}

对于具有K个维度的latent vector，其KL散度的计算公式为：

$$
\mathrm{KL\ loss}=-0.5\times\sum_{i=1}^K(1+\log(\sigma_i^2)-\mu_i^2-\sigma_i^2)\notag
$$

包含KL散度损失项的实际效果是将基于reconstruction loss学习到的clusters紧紧地围绕在latent space地中心，行程一个连续的采样空间。

## Define Model Predictions Function and Mini Batch Preprocessing Function

定义模型的预测函数`modelPredictions`，该函数用于输出整个mini-batch的生成图像数据：

```matlab
function Y = modelPredictions(netE,netD,mbq)

Y = [];

% Loop over mini-batches.
while hasdata(mbq)
    X = next(mbq);

    % Forward through encoder.
    Z = predict(netE, X);

    % Forward through dencoder.
    XGenerated = predict(netD, Z);

    % Extract and concatenate predictions.
    Y = cat(4, Y, extractdata(XGenerated));
end

end
```

该函数的输入输出：

- `netE`和`netD`分别表示encoder和decoder网络；
- `mbq`表示一个mini-batch；
- `Y`为生成图像数据矩阵；

定义mini-batch预处理函数`preprocessMiniBath`，该函数preprocesses a mini-batch of predictors by concatenating the input along the fourth dimension.

```matlab
function X = preprocessMiniBatch(dataX)

% Concatenate.
X = cat(4, dataX{:});

end
```

## Specify Training Options

设置训练轮数为30轮，mini-batch的大小为128，学习学习率为1e-3：

```matlab
numEpochs = 30;
miniBatchSize = 128;
learnRate = 1e-3;
```

## Train Model

使用custom training loop训练模型。

### Create a `minibatch` object

首先创建`minibatchqueue`对象：

```matlab
dsTrain = arrayDatastore(XTrain, IterationDimension=4);
numOutputs = 1;

mbq = minibatchqueue(dsTrain, numOutputs, ...
    MiniBatchSize = miniBatchSize, ...
    MiniBatchFcn = @preprocessMiniBatch, ...
    MiniBatchFormat = "SSCB", ...
    PartialMiniBatch = "discard");
```

对于每一个mini-batch：

- Convert the training data to an array datastore. Specify to iterate over the 4th dimension.
- Use the custom mini-batch preprocessing function `preprocessMiniBatch`(defined before) to concatenate multiple observations into a single mini-batch.
- Format the image data with the dimension labels "SSCB" (spatial, spatial, channel, batch). By default, the minibatchqueue object converts the data to dlarray objects with underlying type single.
- Train on a GPU if one is available. By default, the minibatchqueue object converts each output to a gpuArray if a GPU is available. Using a GPU requires Parallel Computing Toolbox™ and a supported GPU device. 
- To ensure all mini-batches are the same size, discard any partial mini-batches.

### Initialize the training progress plot

```matlab
figure
C = colororder;
lineLossTrain = animatedline(Color=C(2,:));
ylim([0 inf])
xlabel("Iteration")
ylabel("Loss")
grid on
```

### Initialize the parameters for the Adam solver

```matlab
trailingAvgE = [];
trailingAvgSqE = [];
trailingAvgD = [];
trailingAvgSqD = [];
```

### Train the network using a custom training loop

使用custom training loop训练网络。每一次训练轮，shuffle the data并且遍历mini-batch中的数据：

- Evaluate the model loss and gradients using the `dlfeval` and `modelLoss` functions.
- Update the encoder and decoder network parameters using the `adamupdate` function.
- Display the training progress.

```matlab
iteration = 0;
start = tic;

% Loop over epochs.
for epoch = 1:numEpochs

    % Shuffle data.
    shuffle(mbq);

    % Loop over mini-batches.
    while hasdata(mbq)
        iteration = iteration + 1;

        % Read mini-batch of data.
        X = next(mbq);

        % Evaluate loss and gradients.
        [loss, gradientsE, gradientsD] = dlfeval(@modelLoss, netE, netD, X);

        % Update learnable parameters.
        [netE, trailingAvgE, trailingAvgSqE] = adamupdate(netE, ...
            gradientsE, trailingAvgE, trailingAvgSqE, iteration, learnRate);

        [netD, trailingAvgD, trailingAvgSqD] = adamupdate(netD, ...
            gradientsD,trailingAvgD, trailingAvgSqD, iteration, learnRate);

        % Display the training progress.
        D = duration(0, 0, toc(start), Format="hh:mm:ss");
        loss = double(extractdata(loss));
        addpoints(lineLossTrain, iteration, loss)
        title("Epoch: " + epoch + ", Elapsed: " + string(D))
        drawnow
    end
end
```

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20221003134757506.png?raw=true" alt="image-20221003134757506" style="zoom:67%;" />

30轮训练的总时长为：28分46秒，最终的训练误差为：

```
loss =
   18.5185
```

## Test Network

使用测试集测试trained autoencoder。首先，和训练集一样，对测试集数据也分割为mini-batch：

```matlab
dsTest = arrayDatastore(XTest, IterationDimension=4);
numOutputs = 1;

mbqTest = minibatchqueue(dsTest, numOutputs, ...
    MiniBatchSize = miniBatchSize, ...
    MiniBatchFcn = @preprocessMiniBatch, ...
    MiniBatchFormat = "SSCB");
```

使用`modelPredictions`函数生成图像`YTest`：

```matlab
YTest = modelPredictions(netE, netD, mbqTest);
```

之后，可视化test images和reconstructed image的MSE形式的reconstruction errors：

```matlab
err = mean((XTest-YTest).^2,[1 2 3]);
figure
histogram(err)
xlabel("Error")
ylabel("Frequency")
title("Test Data")
```

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20221003134905709.png?raw=true" alt="image-20221003134905709" style="zoom:67%;" />

## Generate New Image

最后，创建随机的latent vectors，输入到decoder网络中，生成图像，并进行可视化：

```matlab
numImages = 64;

ZNew = randn(numLatentChannels, numImages);
ZNew = dlarray(ZNew, "CB");

YNew = predict(netD, ZNew);
YNew = extractdata(YNew);

% Display the generated images in a figure.
figure
I = imtile(YNew);
imshow(I)
title("Generated Images")
```

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20221003134942686.png?raw=true" alt="image-20221003134942686" style="zoom: 67%;" />

<br>

# Reference

[^1]: [Train Variational Autoencoder (VAE) to Generate Images - MathWorks](https://ww2.mathworks.cn/help/deeplearning/ug/train-a-variational-autoencoder-vae-to-generate-images.html).
[^2]: [MATLAB `fopen`: Open file or obtain information about open files - MathWorks](https://ww2.mathworks.cn/help/matlab/ref/fopen.html?lang=en).
[^3]: [MATLAB `fread`: Read data from binary file - MathWorks](https://ww2.mathworks.cn/help/matlab/ref/fread.html?requestedDomain=en).

