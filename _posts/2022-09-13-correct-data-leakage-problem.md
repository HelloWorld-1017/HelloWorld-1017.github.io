---
layout: single
title: Correct Data Leakage Problem
date: 2022-09-13 18:14:17 +0800
categories: 
 - Mathematics
 - MATLAB
 - Machine Learning
tags:
 - Probability Theory and Mathematical Statistics
 - MATLAB Statistics and Machine Learning Toolbox
---

# Introduction

在[Train an SVM Using Generated Data by MVN-RNG, and Test with Real Data](http://whatastarrynight.com/mathematics/programming/machine%20learning/Train-An-SVM-Using-Generated-Data-by-MVN-RNG-and-Test-Using-Real-Data/)中，我基于已有数据集的均值和方差使用MVN-RNG生成了一些数据，并使用这些生成数据训练了一个分类模型（SVM），之后用这些数据集测试模型准确率，效果很好。但是后来在实践中发现，这样的过程实际上存在严重的数据泄露问题。本文的代码纠正了这一问题，代码在一开始就将数据集分割为训练集和测试集，使用训练集的均值和协方差矩阵生成数据，之后使用生成数据训练SVM，最后使用测试集进行测试模型效果。另外，为了从统计上分析存在数据泄露和不存在数据泄露的差异，代码进行了100次的训练测试循环，最终输出准确率平均值和准确率的标准差。

<br>

# Contrast

## fisheriris Dataset

存在数据泄露：

```matlab
% 'Average of accuracies is 0.9783,
%   Standard diviation of accuracies is 0.0045'
```

不存在数据泄露：

```matlab
% 'Average of accuracies is 0.9767,
%   Standard diviation of accuracies is 0.0266'
```

## ionosphere Dataset

存在数据泄露：

```matlab
% 'Average of accuracies is 0.9052,
%   Standard diviation of accuracies is 0.0052'
```

不存在数据泄露：

```matlab
% 'Average of accuracies is 0.8660,
%   Standard diviation of accuracies is 0.0359'
```

## ovariancancer Dataset

存在数据泄露：

```matlab
% 'Average of accuracies is 1.0000,
%   Standard diviation of accuracies is 0.0000'
```

不存在数据泄露：

```matlab
% 'Average of accuracies is 0.9777,
%   Standard diviation of accuracies is 0.0175'
```

## simulatedDataset

存在数据泄露：

```matlab
% 'Average of accuracies is 0.9833,
%  Standard diviation of accuracies is 0.0053'
```

不存在数据泄露：

```matlab
% 'Average of accuracies is 0.9801,
% Standard diviation of accuracies is 0.0108'
```

## digitTrainCellArrayData

存在数据泄露：

```matlab
% 'Average of accuracies is 0.9590,
%   Standard diviation of accuracies is 0.0020'
```

不存在数据泄露：

```matlab
% 'Average of accuracies is 0.8002,
%   Standard diviation of accuracies is 0.0118'
```

<br>

# Conclusion

可以看到，对于这里列出的**所有**数据集，当存在数据泄露现象时，模型的平均准确率就较高，准确率标准差就越低，而这种“较优”从技术上讲是错误的。并且，特征处理得越好，数据量越大，数据穿越造成的影响就越小；问题越复杂，数据泄露造成的影响就越大。

<br>

# Code

这里列出纠正了数据泄露问题的代码实现。

## fisheriris Dataset

```matlab
clc, clear, close all
% Load real dataset
load fisheriris

numTimes = 100;
accus = zeros(numTimes, 1);
for i = 1:numel(accus)
    accus(i) = TrainAndTest(meas, species);
end
accu_ave = mean(accus);
accu_std = std(accus);


sprintf('Average of accuracies is %.4f,\n Standard diviation of accuracies is %.4f', ...
    accu_ave, accu_std)
% 'Average of accuracies is 0.9767,
%   Standard diviation of accuracies is 0.0266'

function accu = TrainAndTest(meas, species)
% Split the features of 3 kinds of species
idx = strcmp(species, "setosa");
Features_seto = meas(idx, :);
idx = strcmp(species, "versicolor");
Features_vers = meas(idx, :);
idx = strcmp(species, "virginica");
Features_virg = meas(idx, :);

% Split train and test set
% For setosa
idx = randperm(50);
idx_train = idx(11:end);
Features_seto_train = Features_seto(idx_train, :);
idx_test = idx(1:10);
Features_seto_test = Features_seto(idx_test, :);
% For versicolor
idx = randperm(50);
idx_train = idx(11:end);
Features_vers_train = Features_vers(idx_train, :);
idx_test = idx(1:10);
Features_vers_test = Features_vers(idx_test, :);
% For virginica
idx = randperm(50);
idx_train = idx(11:end);
Features_virg_train = Features_virg(idx_train, :);
idx_test = idx(1:10);
Features_virg_test = Features_virg(idx_test, :);

% Calculate the mu and Sigma of features of each sepices from train set
mu_seto = mean(Features_seto_train);
Sigma_seto = cov(Features_seto_train);
mu_vers = mean(Features_vers_train);
Sigma_vers = cov(Features_vers_train);
mu_virg = mean(Features_virg_train);
Sigma_virg = cov(Features_virg_train);

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
mdl = fitcecoc(X_generate, Y_generate, 'Learners', t, ...
    'ClassNames', {'setosa','versicolor','virginica'});

% Construct test set, including features and labels
Features_test = [Features_seto_test; Features_vers_test; Features_virg_test];
Y_test = [repmat("setosa", 10, 1); repmat("versicolor", 10, 1); repmat("virginica", 10, 1)];

% Predict the labels using the true fetures
pred = mdl.predict(Features_test);

% Calculate the accuracy
accu = sum(strcmp(pred, Y_test))/numel(Y_test);
end
```

## ionosphere Dataset

```matlab
clc, clear, close all
load ionosphere.mat

numTimes = 100;
accus = zeros(numTimes, 1);
for i = 1:numel(accus)
    accus(i) = TrainAndTest(X, Y);
end
accu_ave = mean(accus);
accu_std = std(accus);

sprintf('Average of accuracies is %.4f,\n Standard diviation of accuracies is %.4f', ...
    accu_ave, accu_std)
% 'Average of accuracies is 0.8660,
%   Standard diviation of accuracies is 0.0359'

function accu = TrainAndTest(X, Y)
% Split features of different class 
idx = strcmp(Y, 'g');
Features_g = X(idx, :);
idx = strcmp(Y, 'b');
Features_b = X(idx, :);

% Split train and test set
% For class g
[numRows, ~] = size(Features_g);
idx = randperm(numRows);
idx_train = idx(round(numRows*0.2)+1:end);
Features_g_train = Features_g(idx_train, :);
idx_test = idx(1:round(numRows*0.2));
Features_g_test = Features_g(idx_test, :);
% For class b
[numRows, ~] = size(Features_b);
idx = randperm(numRows);
idx_train = idx(round(numRows*0.2)+1:end);
Features_b_train = Features_b(idx_train, :);
idx_test = idx(1:round(numRows*0.2));
Features_b_test = Features_b(idx_test, :);

% Caculate mu and Sigma from train set
mu_g = mean(Features_g_train);
Sigma_g = cov(Features_g_train);
mu_b = mean(Features_b_train);
Sigma_b = cov(Features_b_train);

% Generate the features and the corresponding labels
numPerClass = 2000;
X_generate  = [mvnrnd(mu_g, Sigma_g, numPerClass);
    mvnrnd(mu_b, Sigma_b, numPerClass)];
Y_generate  = [repmat("g", numPerClass, 1);
    repmat("b", numPerClass, 1)];

% Set and train the ECOC classifier using generated dataset
t = templateSVM('Standardize', true);
mdl = fitcecoc(X_generate, Y_generate, 'Learners', t, 'ClassNames', {'g','b'});

% Construct test set, including features and labels
Features_test = [Features_g_test; Features_b_test];
[rowsg, ~] = size(Features_g_test);
[rowsb, ~] = size(Features_b_test);
Y_test = [repmat("g", rowsg, 1); repmat("b", rowsb, 1)];

% Make prediction
pred = mdl.predict(Features_test);
% Calculate accuracie
accu = sum(strcmp(pred, Y_test))/numel(Y_test);
end
```

## ovariancancer Dataset

```matlab
clc, clear, close all

load ovariancancer.mat

numTimes = 100;
accus = zeros(numTimes, 1);
for i = 1:numel(accus)
    accus(i) = TrainAndTest(obs, grp);
end
accu_ave = mean(accus);
accu_std = std(accus);

sprintf('Average of accuracies is %.4f,\n Standard diviation of accuracies is %.4f', ...
    accu_ave, accu_std)
% 'Average of accuracies is 0.9777,
%   Standard diviation of accuracies is 0.0175'

function accu = TrainAndTest(obs, grp)
% Split features of different class 
idx = strcmp(grp, "Cancer");
Features_cancer = obs(idx, :);
idx = strcmp(grp, "Normal");
Features_normal = obs(idx, :);

% Split train and test set
% For class 'Cancer'
[numRows, ~] = size(Features_cancer);
idx = randperm(numRows);
idx_train = idx(round(numRows*0.2)+1:end);
Features_cancer_train = Features_cancer(idx_train, :);
idx_test = idx(1:round(numRows*0.2));
Features_cancer_test = Features_cancer(idx_test, :);
% For class 'Normal'
[numRows, ~] = size(Features_normal);
idx = randperm(numRows);
idx_train = idx(round(numRows*0.2)+1:end);
Features_normal_train = Features_normal(idx_train, :);
idx_test = idx(1:round(numRows*0.2));
Features_normal_test = Features_normal(idx_test, :);

% Caculate mu and Sigma from train set
mu_cancer = mean(Features_cancer_train);
Sigma_cancer = cov(Features_cancer_train);
mu_normal = mean(Features_normal_train);
SIgma_normal = cov(Features_normal_train);

% Generate the features and the corresponding labels
numPerClass = 1000;
X_generate = [mvnrnd(mu_cancer, Sigma_cancer, numPerClass);
    mvnrnd(mu_normal, SIgma_normal, numPerClass)];
Y_generate = [repmat("Cancer", numPerClass, 1);
    repmat("Normal", numPerClass, 1)];

% Set and train the ECOC classifier using generated dataset
t = templateSVM('Standardize', true);
mdl = fitcecoc(X_generate, Y_generate, 'Learners', t, 'ClassNames', {'Cancer', 'Normal'});

% Construct test set, including features and labels
Features_test = [Features_cancer_test; Features_normal_test];
[rows_cancer, ~] = size(Features_cancer_test);
[rows_normal, ~] = size(Features_normal_test);
Y_test = [repmat("Cancer", rows_cancer, 1);
    repmat("Normal", rows_normal, 1)];

% Make prediction
pred = mdl.predict(Features_test);
% Calculate accuracies
accu = sum(strcmp(pred, Y_test))/numel(Y_test);
end
```

## simulatedDataset

```matlab
clc, clear, close all
load simulatedDataset.mat
flow = flow';
labels = labels';

numTimes = 100;
accus = zeros(numTimes, 1);
for i = 1:numel(accus)
    accus(i) = TrainAndTest(flow, labels);
end
accu_ave = mean(accus);
accu_std = std(accus);

sprintf('Average of accuracies is %.4f,\n Standard diviation of accuracies is %.4f', ...
    accu_ave, accu_std)
% 'Average of accuracies is 0.9801,
% Standard diviation of accuracies is 0.0108'

function accu = TrainAndTest(flow, labels)
% Split features of different class 
idx = labels==1;
signals_1 = flow(idx, :);
idx = labels==2;
signals_2 = flow(idx, :);

% Split train and test set
% For class 1
[numRows, ~] = size(signals_1);
idx = randperm(numRows);
idx_train = idx(round(numRows*0.2)+1:end);
signals_1_train = signals_1(idx_train, :);
idx_test = idx(1:round(numRows*0.2));
signals_1_test = signals_1(idx_test, :);
% For class 1
[numRows, ~] = size(signals_2);
idx = randperm(numRows);
idx_train = idx(round(numRows*0.2)+1:end);
signals_2_train = signals_2(idx_train, :);
idx_test = idx(1:round(numRows*0.2));
signals_2_test = signals_2(idx_test, :);

% Caculate mu and Sigma from train set
mu_1 = mean(signals_1_train);
Sigma_1 = cov(signals_1_train);
mu_2 = mean(signals_2_train);
Sigma_2 = cov(signals_2_train);

% Generate the features and the corresponding labels
numPerClass = 1000;
X_generate = [mvnrnd(mu_1, Sigma_1, numPerClass);
    mvnrnd(mu_2, Sigma_2, numPerClass)];
Y_generate = [ones(numPerClass, 1);
    2*ones(numPerClass, 1)];

% Set and train the ECOC classifier using generated dataset
t = templateSVM('Standardize', true);
mdl = fitcecoc(X_generate, Y_generate, 'Learners', t);

% Construct test set, including features and labels
signals_test = [signals_1_test; signals_2_test];
[rows_1, ~] = size(signals_1_test);
[rows_2, ~] = size(signals_2_test);
Y_test = [ones(rows_1, 1); 2*ones(rows_2, 1)];

% Make prediction
pred = mdl.predict(signals_test);
accu = sum(pred==Y_test)/numel(Y_test);
end
```

## digitTrainCellArrayData

```matlab
clc, clear, close all

% Load the training data into memory
[xTrainImages, tTrain] = digitTrainCellArrayData;

numTimes = 100;
accus = zeros(numTimes, 1);
for i = 1:numel(accus)
    accus(i) = TrainAndTest(xTrainImages, tTrain);
    disp(i)
end
accu_ave = mean(accus);
accu_std = std(accus);

sprintf('Average of accuracies is %.4f,\n Standard diviation of accuracies is %.4f', ...
    accu_ave, accu_std)
% 'Average of accuracies is 0.8002,
%   Standard diviation of accuracies is 0.0118'

function accu = TrainAndTest(xTrainImages, tTrain)
X = zeros(5000, 28*28);
for i = 1:numel(xTrainImages)
    X(i, :) = xTrainImages{i}(:);
end
[Y, ~] = find(tTrain == 1);

X_generate = [];
Y_generate = [];
X_test = [];
Y_test = [];
numPerClass = 2000;
for i = 1:10
    si = num2str(i);
    % Split the features of different classes
    idx = Y==i;
    eval(sprintf('Image_%s = X(idx, :);', si));

    % Split train and test set
    eval(sprintf('[numRows, ~] = size(Image_%s);', si))
    idx = randperm(numRows);
    idx_train = idx(round(numRows*0.2)+1:end);
    idx_test = idx(1:round(numRows*0.2));
    eval(sprintf('Image_%s_train = Image_%s(idx_train, :);', si, si))
    eval(sprintf('Image_%s_test = Image_%s(idx_test, :);', si, si))

    % Calculate the mu and Sigma of features of each sepices from train set
    eval(sprintf('mu_%s = mean(Image_%s_train);', si, si));
    eval(sprintf('Sigma_%s = cov(Image_%s_train);', si, si));

    % Generate the features and the corresponding labels
    eval(sprintf('X_generate = [X_generate; mvnrnd(mu_%s, Sigma_%s, numPerClass)];', si, si));
    eval(sprintf('Y_generate= [Y_generate; %s*ones(numPerClass, 1)];', si));

    % Construct test set, including features and labels
    eval(sprintf('X_test = [X_test; Image_%s_test];', si))
    eval(sprintf('[rows_%s, ~] = size(Image_%s_test);', si, si))
    eval(sprintf('Y_test = [Y_test; %s*ones(rows_%s, 1)];', si, si))
end

t = templateSVM('Standardize', true);
mdl = fitcecoc(X_generate, Y_generate, 'Learners', t);

pred = mdl.predict(X_test);
accu = sum(pred==Y_test)/numel(Y_test);
end
```











