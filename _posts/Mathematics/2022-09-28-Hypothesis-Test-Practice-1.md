---
layout: single
title: "A Hypothesis Test Practice"
date: 2022-09-28 23:38:35 +0800
categories: 
 - Mathematics
 - MATLAB
tags:
 - Probability Theory and Mathematical Statistics
 - Hypothesis Test
---

# Introduction

之前的一篇博客 [1] 对了两种不同的训练集训练模型的效果：

（1）使用由生成数据和真实数据混合构成的训练集；

（2）使用由生成数据构成的训练集；

但是如果从实验科学性的角度看待那篇博客，仍存在两个问题：

（1）控制变量：在对比两种情况得到的模型效果时，并没有控制(a)用于生成数据的训练集相同；(b)生成数据相同；(c)测试集相同；

（2）模型评估：最终在进行模型评估时，使用的是“想当然”的方式，即用平均准确率表征模型的准确率（越高越好），用准确率标准差表征模型的稳定性（越低越好），结果仅仅好一点就认为所对应的训练集效果是更好的。这种方式存在较为严重的“实验者预期效应”，并不是科学的方式。

昨天学习了Hypothesis test中Fisher的Significant test方法(参考博客 [2])，突然想到可以应用在这个场景之中。Hypothesis test实际上就是对于结果评估方法的优化。为了确保“观测到的的模型测试结果”是随机的，需要首先保证控制变量，即只有解决了问题（1），才能为Significant test方法的使用提供理论前提。

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
left = arrayfun(@(x) sprintf("x_%s", num2str(x)), 1:1:numTimes);
left = char(join(left, ','));
right = repmat("[1, -1]", 1, numTimes);
right = char(join(right, ','));

eval(sprintf('[%s] = ndgrid(%s);', left, right));
expression = arrayfun(@(x) sprintf("x_%s(:)", num2str(x)), 1:1:numTimes);
expression = char(join(expression, ','));
eval(sprintf('x = [%s];', expression))
sum_prob = x*accus_mix_minus_generate;
```

```matlab
>> size(sum_prob)
ans =
     1048576           1
```

这里求出的0.7370只是$2^{20}$种的一种。当$A$与$B$的效果有较大差别时（越对假设不利），$\vert\sum(A-B)\vert$应取大值，于是按其绝对值大小将$2^{20}$个值排成一列：

```matlab
sum_prob = sort(abs(sum_prob), 'descend');
```

并计算$p_{0.7370}$：

```matlab
p = sum(sum_prob>=sum_obs)/numel(sum_prob);
```

```matlab
p =
   1.9073e-06
```

该数值远小于0.0001，这表明，即使在$\alpha=0.0001$的显著性水平下，也有理由否定H，即该结果提供了很显著的证据，不利于假设$H$。并且，$0.7370>0$，因此结论是：有很显著的证据表明方法A优于B。

<br>

将上述Significance test的部分封装成函数`helperSignificanceTest.m`：

```matlab
function p = helperSignificanceTest(accus_mix_minus_generate, numTimes)
left = arrayfun(@(x) sprintf("x_%s", num2str(x)), 1:1:numTimes);
left = char(join(left, ','));
right = repmat("[1, -1]", 1, numTimes);
right = char(join(right, ','));

eval(sprintf('[%s] = ndgrid(%s);', left, right));
expression = arrayfun(@(x) sprintf("x_%s(:)", num2str(x)), 1:1:numTimes);
expression = char(join(expression, ','));
eval(sprintf('x = [%s];', expression))

sum_prob = x*accus_mix_minus_generate;

sum_prob = sort(abs(sum_prob), 'descend');

sum_obs = sum(accus_mix_minus_generate);
p = sum(sum_prob>=abs(sum_obs))/numel(sum_prob);
end
```

注意：上面代码的倒数第二行同样需要对`sum_obs`取绝对值，否则，若`sum_obs`的值为负数，那么算出来的`p`值始终是1。一定注意！！！
{: .notice--warning}

计算A方法和B方法应用于不同数据集的$p$值（15次试验）：

```matlab
clc, clear, close all

numTimes = 15;
numPerClass = 1e3;

load fisheriris
[accus_mix1, accus_generate1, accus_mix_minus_generate1] = ...
    helperLoop(meas, species, numTimes, numPerClass);
p1 = helperSignificanceTest(accus_mix_minus_generate1, numTimes);
fprintf('p1: %.4f\n', p1)

load ionosphere.mat
[accus_mix2, accus_generate2, accus_mix_minus_generate2] = ...
    helperLoop(X, Y, numTimes, numPerClass);
p2 = helperSignificanceTest(accus_mix_minus_generate2, numTimes);
fprintf('p2: %.4f\n', p2)

load ovariancancer.mat
[accus_mix3, accus_generate3, accus_mix_minus_generate3] = ...
    helperLoop(obs, grp, numTimes, numPerClass);
p3 = helperSignificanceTest(accus_mix_minus_generate3, numTimes);
fprintf('p3: %.4f\n', p3)

load simulatedDataset.mat
flow = flow';
labels = labels';
[accus_mix4, accus_generate4, accus_mix_minus_generate4] = ...
    helperLoop(flow, labels, numTimes, numPerClass);
p4 = helperSignificanceTest(accus_mix_minus_generate4, numTimes);
fprintf('p4: %.4f\n', p4)

[xTrainImages, tTrain] = digitTrainCellArrayData;
for i = 1:numel(xTrainImages)
    X5(i, :) = xTrainImages{i}(:);
end
[Y5, ~] = find(tTrain == 1);
[accus_mix5, accus_generate5, accus_mix_minus_generate5] = ...
    helperLoop(X5, Y5, numTimes, numPerClass);
p5 = helperSignificanceTest(accus_mix_minus_generate5, numTimes);
fprintf('p5: %.4f\n', p5) 
```

结果为：

```matlab
p1: 0.5000
p2: 0.0312
p3: 0.5000
p4: 0.0001
p5: 0.0001
```

```matlab
>> mean(accus_mix_minus_generate2), mean(accus_mix_minus_generate4), mean(accus_mix_minus_generate5)
ans =
    0.0086
ans =
    0.0121
ans =
    0.0393
```

因此，我们可以说在$\alpha=0.05$的显著性水平下，对于数据集fisheriris、ovariancancer，接受假设$H$，即认为方法A与方法B的效果是一致的；对于数据集、ionosphere、simulatedDataset、digitTrainCellArrayData，拒绝假设$H$，并且均认为方法A的效果优于方法B。

<br>

# Notes

- 本文的Significant test并不是纯粹地针对方法，而是针对**应用于特定的训练集**的方法；
- 还是要说，Hypothesis test的核心在于“拒绝”或者“接受”，而不是“证明”；
- 这种Significance test的计算资源消耗是巨大的。

<br>

**References**

[1] [Contrast the Models Trained by Mixed Data Set and Only Generated Data Set - What a starry night~](https://helloworld-1017.github.io/mathematics/matlab/machine learning/Contrast-the-Models-Trained-by-Mixed-Data-Set-and-Only-Generated-Data-Set/).

[2] [【Hypothesis Test 1】Summarize the Thoughts of Pearson and Fisher - What a starry night~](https://helloworld-1017.github.io/mathematics/hypothesis-test-summarize-the-thoughts-of-Pearson-and-Fisher/).