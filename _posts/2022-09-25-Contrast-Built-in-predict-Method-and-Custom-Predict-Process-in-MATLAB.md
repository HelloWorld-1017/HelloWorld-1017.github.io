---
layout: single
title: Contrast Built-in `predict` Method and Custom Predict Process in MATLAB
date: 2022-09-25 14:18:45 +0800
categories: 
 - MATLAB
 - Machine Learning
tags:
 - MATLAB Statistics and Machine Learning Toolbox
---

# Introduction

构建机器学习模型这个事情有很多工具去做，比如MATLAB，Python的Keras框架和PyTorch框架。这些框架都很大，提供的工具很多，但是很大部分都是为了**训练模型**，**优化模型**。实际上，当一个模型建立好了以后，去应用（预测），去部署时，并不需要这么多工具，比如对于DNN，实际上就是一个前馈计算的过程。本文使用MATLAB搭建了一个很简单的用于分类的DNN，用于验证这样的想法。

<br>

# Workflow

还是使用fisheriris数据集：

```matlab
% Load dataset
load fisheriris
```

首先划分数据集为训练集和测试集：

```matlab
% Get paramaters of dataset
labels = categorical(labels);
ClassName = categories(labels); % Class name
numClasses = size(ClassName, 1); % Class number

% Partition data
cv = cvpartition(labels, 'Holdout', randperm(5, 1)/10);
X_train = features(cv.training, :);
Y_train = labels(cv.training);
X_test = features(cv.test, :);
Y_test = labels(cv.test);
numTrain = numel(Y_train);
numTest = numel(Y_test);
```

之后使用训练集和测试集的mu和sigma分别对训练集和测试集进行标准化：

```matlab
% Standardize the train set and test set with mu and sigma of corresponding set 
mu_train = mean(X_train);
sigma_train = std(X_train);
mu_test = mean(X_test);
sigma_test = std(X_test);
X_train = (X_train-repmat(mu_train, numTrain, 1))./repmat(sigma_train, numTrain, 1);
X_test = (X_test-repmat(mu_test, numTest, 1))./repmat(sigma_test, numTest, 1);
```

之后，拟合一个全连接神经网络分类模型

```matlab
% Fit a DNN
mdl = fitcnet(X_train, Y_train, 'LayerSizes', [7, 5], 'Activations', 'sigmoid', 'Standardize', false);
```

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220925134950130.png?raw=true" alt="image-20220925134950130" style="zoom:67%;" />

该深度神经网络包含两个隐藏层（神经元个数分别为7和5，激活函数为sigmoid），一个输入层和一个输出层，输出层后面接一个Softmax函数，将输出值压缩为一个0~1之间的概率值，并且每一个样本的所述各类别的概率加和为1。

之后，首先使用`predict`方法预测出测试集的预测标签`prediction1`，并计算准确率`accuracy1`：

```matlab
% Predict using 'predict' method
prediction1 = mdl.predict(X_test);
accuracy1 = sum(prediction1==Y_test)/numel(Y_test);
```

之后，根据`mdl`的信息，自己写一个前馈（即预测）过程，得到测试集的预测标签`prediction2`，和准确率`accuracy2`：

```matlab
% Predict using forward process
sigmoidFcn = @(x) 1/(1+exp(-x));
o1 = arrayfun(sigmoidFcn, X_test*mdl.LayerWeights{1}'+repmat(mdl.LayerBiases{1}, 1, numTest)');
o2 = arrayfun(sigmoidFcn, o1*mdl.LayerWeights{2}'+repmat(mdl.LayerBiases{2}, 1, numTest)');
o3 = o2*mdl.LayerWeights{3}'+repmat(mdl.LayerBiases{3}, 1, numTest)';
o3 = exp(o3)./repmat(sum(exp(o3), 2), 1, numClasses);
[~, I] = max(o3, [], 2);
prediction2 = categorical(I, [1, 2, 3], ClassName);
accuracy2 = sum(prediction2==Y_test)/numel(Y_test);
```

最后，将两种预测方式得到的标签进行对比，并且计算预测一致的比例：

```matlab
% Contrast two results of predictions
contrast = sum(prediction1 == prediction2)/numTest;
```

为了排除随机性的影响，考察两个过程是否完全一致，将上述过程封装成函数，运行数次（500次）：

```matlab
clc, clear, close all
% Load dataset
load fisheriris
% rng('default')

numEpoches = 5e2;
accuracy1 = ones(numEpoches, 1);
accuracy2 = ones(numEpoches, 1);
contrast = ones(numEpoches, 1);

for i = 1:numEpoches
    [mdl, accuracy1(i), accuracy2(i), contrast(i)] = contrastBuiltandSelfpredict(meas, species);
end
figure('Units', 'pixels', 'Position', [769, 313, 727, 692])
tiledlayout(2, 1)
nexttile
hold on
plot(accuracy1, LineWidth=1.5, Marker='.', MarkerSize=10)
plot(accuracy2, LineWidth=1.5, Marker='x', MarkerSize=10)
legend('Buit-in predict function', 'Custom prediction process', 'Location', 'best')
title('Contrast of predictive accuracies of built-in predict function and custom prediction process')
grid on
box on

nexttile
plot(contrast, LineWidth=1.5, Marker='.', MarkerSize=10)
title(['The ratio of equally predictive results: ' num2str(sum(contrast == 1)/numel(contrast))])
grid on
box on

function [mdl, accuracy1, accuracy2, contrast] = contrastBuiltandSelfpredict(features, labels)
% Get paramaters of dataset
labels = categorical(labels);
ClassName = categories(labels); % Class name
numClasses = size(ClassName, 1); % Class number

% Partition data
cv = cvpartition(labels, 'Holdout', randperm(5, 1)/10);
X_train = features(cv.training, :);
Y_train = labels(cv.training);
X_test = features(cv.test, :);
Y_test = labels(cv.test);
numTrain = numel(Y_train);
numTest = numel(Y_test);

% Standardize the train set and test set with mu and sigma of corresponding set 
mu_train = mean(X_train);
sigma_train = std(X_train);
mu_test = mean(X_test);
sigma_test = std(X_test);
X_train = (X_train-repmat(mu_train, numTrain, 1))./repmat(sigma_train, numTrain, 1);
X_test = (X_test-repmat(mu_test, numTest, 1))./repmat(sigma_test, numTest, 1);

% Fit a DNN
mdl = fitcnet(X_train, Y_train, 'LayerSizes', [7, 5], 'Activations', 'sigmoid', 'Standardize', false);

% Predict using 'predict' method
prediction1 = mdl.predict(X_test);
accuracy1 = sum(prediction1==Y_test)/numel(Y_test);

% Predict using forward process
sigmoidFcn = @(x) 1/(1+exp(-x));
o1 = arrayfun(sigmoidFcn, X_test*mdl.LayerWeights{1}'+repmat(mdl.LayerBiases{1}, 1, numTest)');
o2 = arrayfun(sigmoidFcn, o1*mdl.LayerWeights{2}'+repmat(mdl.LayerBiases{2}, 1, numTest)');
o3 = o2*mdl.LayerWeights{3}'+repmat(mdl.LayerBiases{3}, 1, numTest)';
o3 = exp(o3)./repmat(sum(exp(o3), 2), 1, numClasses);
[~, I] = max(o3, [], 2);
prediction2 = categorical(I, [1, 2, 3], ClassName);
accuracy2 = sum(prediction2==Y_test)/numel(Y_test);

% Contrast two results of predictions
contrast = sum(prediction1 == prediction2)/numTest;
end
```

最后得到对比图像：

![image-20220925140159077](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220925140159077.png?raw=true)

<br>

# Conclusion

可以看到，虽然两种方式的预测标签在93.4%的场景下都是完全一致的，但是自己写的前馈过程的效果在某些场景是相当差的。

而出现不一致的原因，目前我还是不太清楚。我尝试了一些探索：

- 使用不同的标准化方法：比如使用训练集的mu和sigma对训练集和测试集进行标准化，这种方式更符合真实的应用场景，但是结果仍没有太大改善；
- 不使用标准化步骤：结果更差了；

<br>

**参考**

[1] [Train neural network classification model - MATLAB fitcnet - MathWorks China](https://ww2.mathworks.cn/help/stats/fitcnet.html).
