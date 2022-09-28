A hypothesis test practice

tags: Experiment

# Introduction

之前的一篇博客：[Contrast the Models Trained by Mixed Data Set and Only Generated Data Set - What a starry night~](http://127.0.0.1:4000/mathematics/programming/machine learning/Contrast-the-Models-Trained-by-Mixed-Data-Set-and-Only-Generated-Data-Set/)对了两种不同的训练集训练模型的效果：

（1）使用由生成数据和真实数据混合构成的训练集；

（2）使用由生成数据构成的训练集；

但是如果从实验科学性的角度看待那篇博客，仍存在两个问题：

（1）控制变量：在对比两种情况得到的模型效果时，并没有控制(a)用于生成数据的训练集相同；(b)生成数据相同；(c)测试集相同；

（2）模型评估：最终在进行模型评估时，使用的是“想当然”的方式，即用平均准确率表征模型的准确率（越高越好），用准确率标准差表征模型的稳定性（越低越好），结果好一点就认为所对应的训练集效果是更好的。这种方式存在较为严重的“实验者预期效应”，并不是科学的方式。

昨天学习了Hypothesis test中Fisher的Significant test方法：[【Hypothesis Test 1】Summarize the Thoughts of Pearson and Fisher - What a starry night~](http://127.0.0.1:4000/mathematics/hypothesis-test-summarize-the-thoughts-of-Pearson-and-Fisher/)，突然想到可以应用在这个场景之中。Hypothesis test实际上就是对于结果评估方法的优化。为了确保“观测到的的模型测试结果”是随机的，需要首先保证控制变量，即只有解决了问题（1），才能为Significant test方法的使用提供理论前提。

<br>

# Significance Test

**针对特定的训练集**（这里以digitTrainCellArrayData数据集为例），使用以下两种方法训练模型：

- 方法A：使用由生成数据和真实数据混合构成的训练集；
- 方法B：使用由生成数据构成的训练集；

假设$H$：方法A与方法B的效果是一致的。

首先，控制变量，自定义Partition data函数`helperPartitionData.m`，使两种方法每次测试的(a)用于生成数据的训练集相同；(b)生成数据相同；(c)测试集相同：

```matlab
function [X_mix, Y_mix, X_generate, Y_generate, X_test, Y_test] = helperPartitionData(Features, Labels, numPerClass)

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

X_generate = [];
Y_generate = [];
% Generate data and mix with real train data
for i = 1:numel(Classes)
    X_generate = [X_generate; mvnrnd(means(i, :), covs{i}, numPerClass)];
    Y_generate = [Y_generate; repmat(Classes(i), numPerClass, 1)];
end

X_mix = [X_train; X_generate];
Y_mix = [Y_train; Y_generate];
end
```

之后，自定义训练测试循环函数`helperLoop.m`，该函数返回`numtimes`次训练测试的A方法的预测准确率向量`accus_mix`，B方法的预测准确率向量`accus_generate`和两个向量的差值向量`accus_mix_minus_generate`：

```matlab
function [accus_mix, accus_generate, accus_mix_minus_generate] = ...
    helperLoop(Features, Labels, numTimes, numPerClass)

accus_mix = zeros(numTimes, 1);
accus_generate = zeros(numTimes, 1);

for i = 1:numel(accus_mix)
    % Partition data
    [X_mix, Y_mix, X_generate, Y_generate, X_test, Y_test] = ...
        helperPartitionData(Features, Labels, numPerClass);

    % Create and train two SVMs
    t = templateSVM('Standardize', true);
    mdl_mix = fitcecoc(X_mix, Y_mix, 'Learners', t);
    mdl_generate = fitcecoc(X_generate, Y_generate, 'Learners', t);

    % Predict the labels using the true fetures
    pred_mix = mdl_mix.predict(X_test);
    pred_generate = mdl_generate.predict(X_test);

    % Calculate the accuracies
    accus_mix(i) = sum(pred_mix==Y_test)/numel(Y_test);
    accus_generate(i) = sum(pred_generate==Y_test)/numel(Y_test);
end

accus_mix_minus_generate = accus_mix-accus_generate;
```

最终，对于digitTrainCellArrayData数据集：

```matlab
clc, clear, close all

numTimes = 20;
numPerClass = 1e3;

[xTrainImages, tTrain] = digitTrainCellArrayData;
for i = 1:numel(xTrainImages)
    X5(i, :) = xTrainImages{i}(:);
end
[Y5, ~] = find(tTrain == 1);
[accus_mix, accus_generate, accus_mix_minus_generate] = ...
    helperLoop(X5, Y5, numTimes, numPerClass);
```

==20次是可以做到的==

结果：

```matlab
>> accus_mix', accus_generate', accus_mix_minus_generate'
ans =
    0.8270    0.8160    0.8300    0.8190    0.8350    0.8260    0.8270    0.8120    0.8340    0.8170    0.8320    0.8280    0.8100    0.8340    0.8080    0.8260    0.8220    0.8100    0.8330    0.8390

ans =
    0.7800    0.7850    0.7930    0.7790    0.7830    0.7940    0.7920    0.7820    0.8020    0.7790    0.7780    0.7760    0.7790    0.8040    0.7920    0.7860    0.7820    0.7770    0.7990    0.8060

ans =
    0.0470    0.0310    0.0370    0.0400    0.0520    0.0320    0.0350    0.0300    0.0320    0.0380    0.0540    0.0520    0.0310    0.0300    0.0160    0.0400    0.0400    0.0330    0.0340    0.0330
```

将差值向量求和$\sum(A-B)$：

```matlab
sum_obs = sum(accus_mix_minus_generate);
```

```matlab
sum_obs =
    0.7370
```

$\sum(A-B)$所有可能的取值有$2^{20}=1048576$种：

```matlab
# size
```



这里求出的==XX==只是$2^{20}$种的一种。

















并使用相同的测试集测试模型的预测准确率：







# Result





本文的Significant test并不是针对方法的，而是针对方法应用于特定的训练集的。

还是要说，Hypothesis test的核心在于“拒绝”或者“接受”，而不是“证明”。

计算资源消耗是巨大的。

