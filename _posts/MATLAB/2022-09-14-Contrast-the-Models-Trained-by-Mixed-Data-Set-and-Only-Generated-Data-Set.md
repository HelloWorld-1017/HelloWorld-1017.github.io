---
layout: single
title: Contrast the Models Trained by Mixed Data Set and Only Generated Data Set
categories: 
 - Mathematics
 - MATLAB
 - Machine Learning
tags:
 - Probability Theory and Mathematical Statistics
 - MATLAB Statistics and Machine Learning Toolbox
date: 2022-09-14 12:47:45 +0800
last_modified_at0: 2022-09-14 12:47:45 +0800
last_modified_at1: 2024-04-19 15:47:20 +0800
last_modified_at: 2024-04-19 15:47:20 +0800
---

# Introduction

之前的两篇博客，"Train an SVM Using Generated Data by MVN-RNG, and Test with Real Data"[^1], "Correct Data Leakage Problem"[^2]，都考虑使用MVG-RNG来做数据增强。前一篇博客没有考虑数据穿越（数据泄露）问题，后一篇做出了纠正。这两篇博客的共同点是都使用生成数据作为所有的训练集数据，考虑的是最坏的情况。但在实践中，数据增强是对数据集的**补充**使得模型泛化能力更强，而不是**替代**。因此，如果使用数据增强技术，需要将生成数据和真实数据一起作为训练集训练模型。这篇博客就对比了（1）使用由生成数据和真实数据混合构成的训练集；（2）使用由生成数据构成的完整的训练集训练出的模型的性能。

<br>

# Code

为了使代码更具有通用性，对整个过程进行了整理，将过程封装成函数，以适应不同问题，并且使用MATLAB提供的函数，很大程度上简化了代码的结构。

首先构造了自定义函数`helperConstructTrainAndTestSet.m`：

```matlab
function [X_train, Y_train, X_test, Y_test] = helperConstructTrainAndTestSet(Features, Labels, numPerClass, Tag)
% Convert labels to categorical variable
Labels = categorical(Labels);
% % Class names
% ClassNames = categories(Labels);

% Partition train and test set
cv = cvpartition(Labels, 'HoldOut', 0.2, 'Stratify', true);
X_train = Features(cv.training, :);
Y_train = Labels(cv.training, :);
X_test = Features(cv.test, :);
Y_test = Labels(cv.test, :);

% Calculate the mean and covariance matrix
[CategoricalVariable, Classes] = findgroups(Y_train);
means = splitapply(@mean, X_train, CategoricalVariable);
covs = splitapply(@(x){cov(x)}, X_train, CategoricalVariable);

if strcmp(Tag, "generate")
    X_train = [];
    Y_train = [];
end

% Generate data and mix with real train data
for i = 1:numel(Classes)
    X_train = [X_train; mvnrnd(means(i, :), covs{i}, numPerClass)];
    Y_train = [Y_train; repmat(Classes(i), numPerClass, 1)];
end
end
```

该函数使用了三个MATLAB提供的比较简洁的函数：

- `cvpartition`，用于partition data；
- `findgroups`和`splitapply`，用于方便地计算每一种分类的均值和协方差矩阵；

之后，定义了单轮的模型训练和测试函数`TrainAndTest.m`：

```matlab
function accu = TrainAndTest(X_train, Y_train, X_test, Y_test)
% Create and train an SVM
t = templateSVM('Standardize', true);
mdl = fitcecoc(X_train, Y_train, 'Learners', t);

% Predict the labels using the true fetures
pred = mdl.predict(X_test);

% Calculate the accuracy
accu = sum(pred == Y_test)/numel(Y_test);
end
```

之后，通过调用`TrainAndTest`函数，将训练测试的循环过程封装成函数`Loop.m`：

```matlab
function Loop(Features, Labels, numTimes, numPerClass, DatasetName)
% Trained with real and generated data
accus = zeros(numTimes, 1);
for i = 1:numel(accus)
    % Construct train and test data set
    [X_train, Y_train, X_test, Y_test] = helperConstructTrainAndTestSet(Features, Labels, numPerClass, "mix");
    % Train and test
    accu = TrainAndTest(X_train, Y_train, X_test, Y_test);
    accus(i) = accu;
end
accu_ave = mean(accus);
accu_std = std(accus);
sprintf('[%s]\nModel trained with real and generated data\n(%d Loops, %d Train sample numbers): \nAverage of accuracies is %.4f,\n Standard diviation of accuracies is %.4f', ...
    DatasetName, numTimes, height(X_train), accu_ave, accu_std)

% Trained with ONLY generated data
for i = 1:numel(accus)
    % Construct train and test data set
    [X_train, Y_train, X_test, Y_test] = helperConstructTrainAndTestSet(Features, Labels, numPerClass, "generate");
    % Train and test
    accu = TrainAndTest(X_train, Y_train, X_test, Y_test);
    accus(i) = accu;
end
accu_ave = mean(accus);
accu_std = std(accus);
sprintf('[%s]\nModel trained with ONLY generated data\n(%d Loops, %d Train sample numbers): \nAverage of accuracies is %.4f,\n Standard diviation of accuracies is %.4f', ...
    DatasetName, numTimes, height(X_train), accu_ave, accu_std)
end
```

该函数将模型多次的训练测试结果打印到命令行中。

最后在代码主体部分，将不同数据集的特征和标签，以及训练测试的轮数、每一类别生成的样本的数量输入到`Loop`函数中：

```matlab
clc, clear, close all

numTimes = 1e2;
numPerClass = 1e3;

load fisheriris
Loop(meas, species, numTimes, numPerClass, "fisheriris Dataset");

load ionosphere.mat
Loop(X, Y, numTimes, numPerClass, "ionosphere Dataset");

load ovariancancer.mat
Loop(obs, grp, numTimes, numPerClass, "ovariancancer Dataset");

load simulatedDataset.mat
flow = flow';
labels = labels';
Loop(flow, labels, numTimes, numPerClass, "simulatedDataset");

[xTrainImages, tTrain] = digitTrainCellArrayData;
for i = 1:numel(xTrainImages)
    X5(i, :) = xTrainImages{i}(:);
end
[Y5, ~] = find(tTrain == 1);
Loop(X5, Y5, numTimes, numPerClass, "digitTrainCellArrayData");
```

<br>

# Results and Conclusion

执行的代码主体部分，得到结果：

（1）`fisheriris` data set

```
'[fisheriris Dataset]
Model trained with real and generated data
(100 Loops, 3120 Train sample numbers): 
Average of accuracies is 0.9723,
Standard diviation of accuracies is 0.0255'

'[fisheriris Dataset]
Model trained with ONLY generated data
(100 Loops, 3000 Train sample numbers): 
Average of accuracies is 0.9737,
Standard diviation of accuracies is 0.0289'
```

（2）`ionosphere` data set

```
'[ionosphere Dataset]
Model trained with real and generated data
(100 Loops, 2281 Train sample numbers): 
Average of accuracies is 0.8694,
Standard diviation of accuracies is 0.0385'

'[ionosphere Dataset]
Model trained with ONLY generated data
(100 Loops, 2000 Train sample numbers): 
Average of accuracies is 0.8560,
Standard diviation of accuracies is 0.0389'
```

（3）`ovariancecancer` data set

```
'[ovariancancer Dataset]
Model trained with real and generated data
(100 Loops, 2173 Train sample numbers): 
Average of accuracies is 0.9793,
Standard diviation of accuracies is 0.0195'

'[ovariancancer Dataset]
Model trained with ONLY generated data
(100 Loops, 2000 Train sample numbers): 
Average of accuracies is 0.9784,
Standard diviation of accuracies is 0.0179'
```

（4）`simulatedDataset` data set

```
'[simulatedDataset]
Model trained with real and generated data
(100 Loops, 3260 Train sample numbers): 
Average of accuracies is 0.9958,
Standard diviation of accuracies is 0.0040'

'[simulatedDataset]
Model trained with ONLY generated data
(100 Loops, 2000 Train sample numbers): 
Average of accuracies is 0.9821,
Standard diviation of accuracies is 0.0091'
```

（5）`digitTrainCellArrayData` data set

```
'[digitTrainCellArrayData]
Model trained with real and generated data
(100 Loops, 14000 Train sample numbers): 
Average of accuracies is 0.8244,
Standard diviation of accuracies is 0.0127'

'[digitTrainCellArrayData]
Model trained with ONLY generated data
(100 Loops, 10000 Train sample numbers): 
Average of accuracies is 0.7872,
Standard diviation of accuracies is 0.0128'
```

总结上述结果：

```
average mean: 
- case1: 0.9723, 0.8694, 0.9793, 0.9958
- case2: 0.9737, 0.8560, 0.9784, 0.9821
standard deviation: 
- case1: 0.0255, 0.0385, 0.0195, 0.0040
- case2: 0.0289, 0.0389, 0.0179, 0.0091
```

总体上看，使用由生成数据和真实数据混合构成的训练集训练出的模型准确率较高且稳定，但并不是绝对的。

<br>

# References

[^1]: [Train an SVM Using Generated Data by MVN-RNG, and Test with Real Data - What a starry night~](https://helloworld-1017.github.io/2022-09-10/11-37-41.html).
[^2]: [Correct Data Leakage Problem - What a starry night~](https://helloworld-1017.github.io/2022-09-13/18-14-17.html).