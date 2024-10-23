---
layout: single
title: Sequence Classification Using LSTM and 1-D Convolutions in MATLAB
date: 2022-12-10 15:22:11 +0800
categories: 
 - MATLAB
 - Machine Learning
tags:
 - MATLAB Deep Learning Toolbox
last_modified_at: 2023-11-06 15:24:48 +0800
---

# Introduction

MATLAB官方提供了分别使用LSTM神经网络和1-D Convolutions对sequence data进行分类的示例："Sequecen Classification Using Deep Learning" [^1]，Sequence Classification Using 1-D Convolutions [^2]。这两个示例使用的是同一个训练集，即Japanese Vowels训练集，一共有270条训练数据，和370条测试数据，共9个分类。

<br>

# Workflow for  Using LSTM

## Load Sequence data

首先加载训练集数据：

```matlab
[XTrain, YTrain] = japaneseVowelsTrainData;
```

其中：

- `XTrain`是训练集特征，一共有270条数据，每条数据包含12个表示特征的sequence data，对于每条数据的12个特征是等长的，但是不同数据的特征长度是不一样的。

  ```matlab
  >> numel(XTrain)
  ans =
     270
  ```

  ```matlab
  >> XTrain(1:5)
  ans =
    5×1 cell array
      {12×20 double}
      {12×26 double}
      {12×22 double}
      {12×20 double}
      {12×21 double}
  ```

- `YTrain`是训练集标签，一共有9种分类：

  ```matlab
  >> unique(YTrain)
  ans = 
    9×1 categorical array
       1 
       2 
       3 
       4 
       5 
       6 
       7 
       8 
       9 
  ```

可视化第1个训练样本的12个特征数据：

```matlab
figure
plot(XTrain{1}')
xlabel("Time Step")
title("Training Observation 1")
numFeatures = size(XTrain{1},1);
legend("Feature " + string(1:numFeatures), Location="northeastoutside")
```

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20221210143537493.png?raw=true" alt="image-20221210143537493" style="zoom: 50%;" />

## Prepare Data for padding

默认情况下，在训练过程中，软件会将训练数据划分为mini-batch，并且对序列进行padding，以使序列有着相同的长度。但是，过多的padding会对神经网络的性能产生负面影响。为了避免在训练过程中过多的padding，我们可以将训练数据按照序列的长度进行排序，之后选择合适的mini-batch size，以使每个mini-batch中的sequences有着相同的长度。

下图就展示了在sorting data之前和之后padding的效果：

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20221210144122027.png?raw=true" alt="image-20221210144122027" style="zoom:50%;" />

首先，获得每一个observation的序列长度，保存在`sequenceLengths`中：

```matlab
sequenceLengths = nan(1, numel(XTrain));
numObservations = numel(XTrain);
for i=1:numObservations
    sequence = XTrain{i};
    sequenceLengths(i) = size(sequence,2);
end
```

之后，根据sequence length对数据进行排序：

```matlab
[sequenceLengths,idx] = sort(sequenceLengths);
XTrain = XTrain(idx);
YTrain = YTrain(idx);
```

之后，我们在bar chart中看一下排序好的数据：

```matlab
figure
bar(sequenceLengths)
ylim([0 30])
xlabel("Sequence")
ylabel("Length")
title("Sorted Data")
```

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20221210144454577.png?raw=true" alt="image-20221210144454577" style="zoom:50%;" />

我们设定mini-batch的size为27，以均匀分割数据，并且降低在每一个mini-batch中padding的数量：

```matlab
miniBatchSize = 27;
```

最终padding的效果是：

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20221210144721064.png?raw=true" alt="image-20221210144721064" style="zoom: 50%;" />

## Define LSTM network architecture

这一步定义LSTM神经网络的结构。

- 设置input size为12，即数据特征的数量；
- 设置bidirectional LSTM layer有100个隐藏单元，最后输出the last element of the sequence；
- 设置一个输出为9维(类别的数量)的fully connected layer，以及后面的softmax layer和classification layer。

> 注：这里采用的是bidirectional LSTM layer，即双向LSTM，而不是LSTM layer。官方的解释是：If you have access to full sequences at prediction time, then you can use a bidirectional LSTM layer in your network. A bidirectional LSTM layer learns from the full sequence at each time step. If you do not have access to the full sequence at prediction time, for example, if you are forecasting values or predicting one time step at a time, then use an LSTM layer instead.

```matlab
inputSize = 12;
numHiddenUnits = 100;
numClasses = 9;

layers = [ ...
    sequenceInputLayer(inputSize)
    bilstmLayer(numHiddenUnits,OutputMode="last")
    fullyConnectedLayer(numClasses)
    softmaxLayer
    classificationLayer];
```

```matlab
>> layers
layers = 
  5×1 Layer array with layers:
     1   ''   Sequence Input          Sequence input with 12 dimensions
     2   ''   BiLSTM                  BiLSTM with 100 hidden units
     3   ''   Fully Connected         9 fully connected layer
     4   ''   Softmax                 softmax
     5   ''   Classification Output   crossentropyex
```

之后，设置training options。

- 设置求解器为“Adam”，gradient threshold为1，最大训练轮数为50；

- 为了对序列进行padding，设置sequence length为"longest"；

- 为了保证我们之前按照序列长度排序好的训练集保持不表，指定never shuffle the data；

- Since the mini-batches are small with short sequences, training is better suited for the CPU. Set the `ExecutionEnvironment` option to `"cpu"`。如果计算机的GPU可用，并且想要使用GPU训练，则将`ExecutionEnvironment`设置为`"auto"`(这也是默认值)；

  注：如果采用CPU进行计算，则整个训练过程耗时约8.520864秒；如果使用GPU运算，则耗时3.924722秒；但是第一次使用GPU时会慢一些，大约耗费了20秒左右。可能软件也需要进行初始化。
  {: .notice--warning}

```matlab
options = trainingOptions("adam", ...
    ExecutionEnvironment="cpu", ...
    GradientThreshold=1, ...
    MaxEpochs=50, ...
    MiniBatchSize=miniBatchSize, ...
    SequenceLength="longest", ...
    Shuffle="never", ...
    Verbose=0, ...
    Plots="training-progress");
```

##  Train LSTM network

之后，使用`trainNetwork`函数训练设置好的神经网络：

```matlab
net = trainNetwork(XTrain,YTrain,layers,options);
```

![training_process](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/training_process.png?raw=true)

如果不想展示这样的图像，需要更改`options`变量中的`Plots`设置 [^3]：

```matlab
options = trainingOptions(...
    Plots="none");
```

<br>

## Test LSTM network

加载测试数据：

```matlab
[XTest,YTest] = japaneseVowelsTestData;
```

```matlab
XTest(1:3)
ans =
  3×1 cell array
    {12×19 double}
    {12×17 double}
    {12×19 double}
```

并且测试数据也需要按照序列长度进行排序：

```matlab
sequenceLengthsTest = nan(1, numel(XTest));
numObservationsTest = numel(XTest);
for i=1:numObservationsTest
    sequence = XTest{i};
    sequenceLengthsTest(i) = size(sequence,2);
end

[sequenceLengthsTest,idx] = sort(sequenceLengthsTest);
XTest = XTest(idx);
YTest = YTest(idx);
```

使用`classify`函数进行分类(预测)时，也需要注意这一点：

```matlab
YPred = classify(net,XTest, ...
    MiniBatchSize=miniBatchSize, ...
    SequenceLength="longest");
```

计算测试准确率：

```matlab
acc = sum(YPred == YTest)./numel(YTest)
```

```matlab
>> acc
acc =
    0.9541
```

<br>

# Workflow for Using 1-D Convolutions

## Load sequence data

```matlab
[XTrain,TTrain] = japaneseVowelsTrainData;
[XValidation,TValidation] = japaneseVowelsTestData;

numFeatures = size(XTrain{1},1);
classes = categories(TTrain);
numClasses = numel(classes);
```

```matlab
>> numFeatures, numClasses
numFeatures =
    12
numClasses =
     9
```

## Define 1-D convolutional network architecture

- 将输入数据特征的数量作为input size；
- Specify two blocks of 1-D convolution, ReLU, and layer normalization layers, where the convolutional layer has a filter size of 3. Specify 32 and 64 filters for the first and second convolutional layers, respectively. For both convolutional layers, left-pad the inputs such that the outputs have the same length (causal padding).
- To reduce the output of the convolutional layers to a single vector, use a 1-D global average pooling layer.
- To map the output to a vector of probabilities, specify a fully connected layer with an output size matching the number of classes, followed by a softmax layer and a classification layer.

```matlab
filterSize = 3;
numFilters = 32;

layers = [ ...
    sequenceInputLayer(numFeatures)

    convolution1dLayer(filterSize,numFilters,Padding="causal")
    reluLayer
    layerNormalizationLayer

    convolution1dLayer(filterSize,2*numFilters,Padding="causal")
    reluLayer
    layerNormalizationLayer

    globalAveragePooling1dLayer
    
    fullyConnectedLayer(numClasses)
    softmaxLayer
    classificationLayer];
```

## Train network

设置Training options：

```matlab
miniBatchSize = 27;

options = trainingOptions("adam", ...
    MiniBatchSize=miniBatchSize, ...
    MaxEpochs=15, ...
    SequencePaddingDirection="left", ...
    ValidationData={XValidation,TValidation}, ...
    Plots="training-progress", ...
    Verbose=0);
```

之后训练网络：

```matlab
net = trainNetwork(XTrain,TTrain,layers,options);
```

![training_process_1d](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/training_process_1d.png?raw=true)

## Test network

使用测试集测试网络：

```matlab
YPred = classify(net,XValidation, ...
    MiniBatchSize=miniBatchSize, ...
    SequencePaddingDirection="left");
acc = mean(YPred == TValidation);
confusionchart(TValidation,YPred)
```

```matlab
>> acc
acc =
    0.9568
```

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20221211151109487.png?raw=true" alt="image-20221211151109487" style="zoom:50%;" />

这里用于测试的测试集，和上面训练过程中使用的验证集是一个数据集，稍微有一些不合理。

<br>

**Reference**

[^1]: [Sequence Classification Using Deep Learning - MathWorks](https://ww2.mathworks.cn/help/deeplearning/ug/classify-sequence-data-using-lstm-networks.html).
[^2]: [Sequence Classification Using 1-D Convolutions - MathWorks](https://ww2.mathworks.cn/help/deeplearning/ug/sequence-classification-using-1-d-convolutions.html).
[^3]: [`trainingOptions`: Options for training deep learning neural network. - MathWorks](https://ww2.mathworks.cn/help/deeplearning/ref/trainingoptions.html).
