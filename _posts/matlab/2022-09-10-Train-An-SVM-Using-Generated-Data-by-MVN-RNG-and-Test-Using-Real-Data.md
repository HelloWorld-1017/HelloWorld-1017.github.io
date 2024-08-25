---
layout: single
title: Train an SVM Using Generated Data by MVN-RNG, and Test with Real Data
date: 2022-09-10 11:37:41 +0800
categories: 
 - Mathematics
 - MATLAB
 - Machine Learning
tags:
 - Probability Theory and Mathematical Statistics
 - MATLAB Statistics and Machine Learning Toolbox
---

Warning⚠️⚠️⚠️ ：本文所有的示例都存在严重的**数据泄露**现象，当时没有进行考虑，之后会对针对这一问题进行修改。2023.08.31：数据泄露的问题已经进行了矫正，详见博客[Correct Data Leakage Problem - What a starry night~ ](https://ma1017.github.io/mathematics/matlab/machine learning/correct-data-leakage-problem/).
{: .notice--warning}

# Introduction

分类模型一般是通过具有特征和标签的训练数据集进行训练，之后通过测试集验证模型的效果。但是，训练模型时通常会遇到的问题是训练样本数量不足，解决该问题的一种方法是使用数学工具生成训练样本。本文尝试了一种使用多元正态分布随机数产生器(Multivariate Normal Random Number Generator)生成样本数据的方法。

首先将真实数据集按照标签分类，计算各个类别的样本均值和样本协方差矩阵。**假设针对每一种分类，各特征（即随机变量）服从多元正态分布**，因此依据各类别的样本均值和样本协方差矩阵使用RNG生成对应类别的数据集。并且本文考虑最糟糕的一种情况：即使用所有的生成数据作为训练集训练机器学习模型(eg SVM)，之后使用所有的真实数据作为测试集测试模型预测效果。

MATLAB提供了一些数据集：[Sample Data Sets - MathWorks](https://ww2.mathworks.cn/help/stats/sample-data-sets.html)。

<br>

# Numerical Features Input

## Example 1: `fisheriris` Dataset

`fisheriris`数据集有150条数据，特征维度为4，标签种类有3种，属于三分类问题。每个类别生成500条数据作为训练集。

```matlab
clc, clear, close all

% Load real dataset
load fisheriris

% Split the features of 3 kinds of species
idx = strcmp(species, "setosa");
Features_seto = meas(idx, :);
idx = strcmp(species, "versicolor");
Features_vers = meas(idx, :);
idx = strcmp(species, "virginica");
Features_virg = meas(idx, :);

% Calculate the mu and Sigma of features of each sepices
mu_seto = mean(Features_seto);
Sigma_seto = cov(Features_seto);
mu_vers = mean(Features_vers);
Sigma_vers = cov(Features_vers);
mu_virg = mean(Features_virg);
Sigma_virg = cov(Features_virg);

% Generate the features and the corresponding labels
numPerSpecies = 500;
X_generate = [mvnrnd(mu_seto, Sigma_seto, numPerSpecies);
    mvnrnd(mu_vers, Sigma_vers, numPerSpecies);
    mvnrnd(mu_virg, Sigma_virg, numPerSpecies)];
Y_generate = [repmat("setosa", numPerSpecies, 1);
    repmat("versicolor", numPerSpecies, 1); 
    repmat("virginica", numPerSpecies, 1)];

% Create an SVM template, and standardize the predictors
t = templateSVM('Standardize', true);

% Train the ECOC classifier using generated dataset
mdl = fitcecoc(X_generate, Y_generate, 'Learners', t,...
    'ClassNames', {'setosa','versicolor','virginica'});

% Predict the labels using the true fetures
pred = mdl.predict(meas);

% Calculate the accuracy
accu = sum(strcmp(pred, species))/numel(species)*100;
```

```matlab
accu =

    98
```

<br>

## Example 2: `ionosphere` Dataset

`ionosphere`数据集有351条数据，特征维度为34，标签种类有2种，是一个二分类。每个类别生成2000条数据作为训练集。

```matlab
clc, clear, close all

load ionosphere.mat

idx = strcmp(Y, 'g');
Features_g = X(idx, :);
idx = strcmp(Y, 'b');
Features_b = X(idx, :);

mu_g = mean(Features_g);
Sigma_g = cov(Features_g);
mu_b = mean(Features_b);
Sigma_b = cov(Features_b);

numPerClass = 2000;
X_generate  = [mvnrnd(mu_g, Sigma_g, numPerClass);
    mvnrnd(mu_b, Sigma_b, numPerClass)];
Y_generate  = [repmat("g", numPerClass, 1);
    repmat("b", numPerClass, 1)];

t = templateSVM('Standardize', true);
mdl = fitcecoc(X_generate, Y_generate, 'Learners', t, 'ClassNames', {'g','b'});

pred = mdl.predict(X);

accu = sum(strcmp(pred, Y))/numel(Y)*100;
```

```matlab
accu =
   90.0285
```

<br>

## Example 3: `ovariancancer` Dataset

`ovariancancer`数据集有216条数据，特征数量为4000，标签种类有2种，是一个二分类问题。每一种类别生成1000条数据作为训练集。

```matlab
clc, clear, close all

load ovariancancer.mat

idx = strcmp(grp, "Cancer");
Features_cancer = obs(idx, :);
idx = strcmp(grp, "Normal");
Features_normal = obs(idx, :);

mu_cancer = mean(Features_cancer);
Sigma_cancer = cov(Features_cancer);
mu_normal = mean(Features_normal);
SIgma_normal = cov(Features_normal);

numPerClass = 1000;

X_generate = [mvnrnd(mu_cancer, Sigma_cancer, numPerClass);
    mvnrnd(mu_normal, SIgma_normal, numPerClass)];
Y_generate = [repmat("Cancer", numPerClass, 1);
    repmat("Normal", numPerClass, 1)];

t = templateSVM('Standardize', true);
mdl = fitcecoc(X_generate, Y_generate, 'Learners', t, 'ClassNames', {'Cancer', 'Normal'});

pred = mdl.predict(obs);

accu = sum(strcmp(pred, grp))/numel(grp)*100;
```

```matlab
accu =
   100
```
<br>

# Sequential Signal Input

## Example : `simulatedDataset`

之前的例子都是假设多个数值特征属于MVN分布，而本例子是假设信号数据的各个数据点所构成的随机向量属于MVN分布。`simulatedDataset.mat`中保存着1571条信号数据，每个信号具有1201个数据点，标签种类有2种，属于二分类问题。每个类别生成1000条数据作为训练集。

```matlab
clc, clear, close all

load simulatedDataset.mat

flow = flow';
labels = labels';

idx = labels==1;
signals_1 = flow(idx, :);
idx = labels==2;
signals_2 = flow(idx, :);

mu_1 = mean(signals_1);
Sigma_1 = cov(signals_1);
mu_2 = mean(signals_2);
Sigma_2 = cov(signals_2);

numPerClass = 1000;
X_generate = [mvnrnd(mu_1, Sigma_1, numPerClass);
    mvnrnd(mu_2, Sigma_2, numPerClass)];
Y_generate = [ones(numPerClass, 1);
    2*ones(numPerClass, 1)];

t = templateSVM('Standardize', true);
mdl = fitcecoc(X_generate, Y_generate, 'Learners', t);

pred = mdl.predict(flow);
accu = sum(pred==labels)/numel(labels)*100;
```

```matlab
accu =
   98.1587
```

同样有着很高的准确率。

<br>

# 2-D Image Input

## Example: `digitTrainCellArrayData`

`digitTrainCellArrayData`函数会依次调用`digitTableToCell`函数、`digitTrainTable`函数、`digitTableToCell`函数将本地的`DigitDataset`文件夹（手写数字数据集）整理成特征`xTrainImages`和分类标签`tTrain`：

```matlab
% Load the training data into memory
[xTrainImages, tTrain] = digitTrainCellArrayData;
```

```matlab
Name               Size                 Bytes  Class     
  tTrain            10x5000              400000  double              
  xTrainImages       1x5000            31880000  cell
```

其中，标签`tTrain`是one-hot matrix，数据`xTrainImages`是一个cell类型数据，每一个cell中保存着一个`28x28 double`的矩阵，表征一个灰度图像。

图像展示：

```matlab
% Display some of the training images
for i = 1:20
    subplot(4, 5, i);
    imshow(xTrainImages{i});
end
```

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220910141053455.png?raw=true" alt="image-20220910141053455" style="zoom:50%;" />

之后，将特征(28-by-28)展开成行向量，并且将one-hot标签转换为定类变量(1~10，其中10代表数字0)：

```matlab
X = zeros(5000, 28*28);
for i = 1:numel(xTrainImages)
    X(i, :) = xTrainImages{i}(:);
end
[Y, ~] = find(tTrain == 1);
```

之后生成数据集，并使用生成数据集训练SVM，最后使用真实数据集进行验证：

```matlab
X_generate = [];
Y_generate = [];
numPerClass = 2000;
for i = 1:10
    idx = Y==i;
    expression = ['Image_', num2str(i), '=', 'X(idx, :);'];
    eval(expression);
    expression = ['mu_', num2str(i), '=', 'mean(Image_', num2str(i), ');'];
    eval(expression);
    expression = ['Sigma_', num2str(i), '=', 'cov(Image_', num2str(i), ');'];
    eval(expression);
    expression = ['X_generate=', '[X_generate; ', 'mvnrnd(mu_', num2str(i), ', ', 'Sigma_', num2str(i), ', numPerClass)];'];
    eval(expression);
    expression = ['Y_generate=', '[Y_generate;',  num2str(i), '*ones(numPerClass, 1)];'];
    eval(expression);
end

t = templateSVM('Standardize', true);
mdl = fitcecoc(X_generate, Y_generate, 'Learners', t);

pred = mdl.predict(X);
accu = sum(pred==Y)/numel(Y)*100;
```

```matlab
accu =
   95.5600
```

准确率很高。

之后，可视化一下生成的图片：

```matlab
% Show generated image in figure(2)
idx = randperm(size(X_generate, 1))';
idx = idx(1:20);
X_show = X_generate(idx, :);
Y_show = Y_generate(idx, :);

X_show_cell = {};
for i = 1:size(X_show, 1)
    X_show_cell(i) = {reshape(X_show(i, :), 28, 28)};
end

figure(2)
for i = 1:size(X_show_cell, 2)
    subplot(4, 5, i);
    imshow(X_show_cell{i});
    title(num2str(Y_show(i)))
end
```

![image-20220910135500317](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220910135500317.png?raw=true)

可以看到，虽然由生成数据所训练的模型对于真实数据集的预测效果很好（准确率为95.56%），但是所生成的图片效果并不是很好。

完整代码：

```matlab
clc, clear, close all

% Load the training data into memory
[xTrainImages, tTrain] = digitTrainCellArrayData;

% Display some of the training images
figure(1)
for i = 1:20
    subplot(4, 5, i);
    imshow(xTrainImages{i});
end

X = zeros(5000, 28*28);
for i = 1:numel(xTrainImages)
    X(i, :) = xTrainImages{i}(:);
end
[Y, ~] = find(tTrain == 1);

X_generate = [];
Y_generate = [];
numPerClass = 2000;
for i = 1:10
    idx = Y==i;
    expression = ['Image_', num2str(i), '=', 'X(idx, :);'];
    eval(expression);
    expression = ['mu_', num2str(i), '=', 'mean(Image_', num2str(i), ');'];
    eval(expression);
    expression = ['Sigma_', num2str(i), '=', 'cov(Image_', num2str(i), ');'];
    eval(expression);
    expression = ['X_generate=', '[X_generate; ', 'mvnrnd(mu_', num2str(i), ', ', 'Sigma_', num2str(i), ', numPerClass)];'];
    eval(expression);
    expression = ['Y_generate=', '[Y_generate;',  num2str(i), '*ones(numPerClass, 1)];'];
    eval(expression);
end

t = templateSVM('Standardize', true);
mdl = fitcecoc(X_generate, Y_generate, 'Learners', t);

pred = mdl.predict(X);
accu = sum(pred==Y)/numel(Y)*100;

% Show generated image in figure(2)
idx = randperm(size(X_generate, 1))';
idx = idx(1:20);
X_show = X_generate(idx, :);
Y_show = Y_generate(idx, :);

X_show_cell = {};
for i = 1:size(X_show, 1)
    X_show_cell(i) = {reshape(X_show(i, :), 28, 28)};
end

figure(2)
for i = 1:size(X_show_cell, 2)
    subplot(4, 5, i);
    imshow(X_show_cell{i});
    title(num2str(Y_show(i)))
end
```

<br>

# Conclusion

综上，使用MVN-RNG生成数据的确是一种很好的数据增强方法，另一方面，这些结果也从侧面验证了多元正态分布是一个很普遍的分布。

但是，我们这里面对的始终是一个**分类问题**。从最后一个图像的例子也可以看出，虽然对于分类问题而言，这种生成数据的方式是一个很好的数据增强方法，但是如果将MVN-RNG作为一个生成器而言，它的效果就比较差。对于类似生成图像、序列等Structure Learning问题，GAN等复杂的生成器的效果可能会更好，同时也复杂得多。

