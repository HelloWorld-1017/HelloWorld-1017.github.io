---
layout: single
title: Partition Data (MATLAB `cvpartition` Function)
date: 2022-09-24 13:47:45 +0800
categories: 
 - MATLAB
 - Machine Learning
tags:
 - MATLAB Statistics and Machine Learning Toolbox
---

# Introduction

在人工智能领域，验证模型泛化能力有四种常用的方法：留出法（Hold-out Method）、交叉验证法（Cross Validation，CV）、留一法（Leave-One-Out Cross Validataion，LOOCV）和自助取样法（Bootstrap）。四种方法的本质都是对数据集合进行不同的切割，进而得到不同的数据集，在不同的数据集上验证模型，以求在新数据上有更好的表现。在模型效果相当的情况下，只有经过反复验证下都稳定的模型才是一个稳健的模型。

**（1）留出法**

留出法是最常见的数据集切割方法。常见的形式是把数据集切割成训练集(Train set)、测试集(Test set)和验证集(Validation set)。模型在训练阶段使用训练集，在测试集上评估模型效果，最后在验证集上评估。先后在测试集和验证集上验证效果的原因是：业内的通常做法是把一整份数据切成训练集和测试集，两者的分布非常接近，所以仅仅使用测试集作为效果评估指标肯定不够，因此需要用一个未知数据集(验证集)考察模型的泛化误差。

**（2）交叉验证**

使用留出法进行数据集的分割并进行建模，每次得到的结果可能都不一致，并且这种划分方法总有一定比例的测试数据无法参与到训练中。为了解决这两个问题，可以通过多次更细粒度的样本划分，多次训练和评估，得到更准确的无偏估计以减少随机性，这就是交叉验证的思想。交叉验证就是平均过程，包含了公平评估的思想。它除了可应用在模型的训练和调参中，也能用于不同算法的评估选择中，这正是交叉验证的评估本质，即评估分类器性能的一种统计分析方法。

K折交叉验证(K-Fold Cross Validation)是指把数据集切成K个相同大小的数据集，使用其中K-1个数据集训练模型，剩下一个数据集进行验证。这种组合会产生K组训练集和测试集，将不同组合下的泛化误差作为整体泛化误差的估计。最常见的交叉验证有10折交叉验证和5折交叉验证。在实践中，单次K折交叉验证仍然无法全面考察模型的稳定性，因此常常采用p次K折交叉验证法。

**（3）留一法**

留一法是K折交叉验证的一个特例，或者理解为在样本粒度上进行更为细致的切分。在总量为N的数据集上，每次采用N-1个训练模型，用剩下1个样本作为测试集，以此来评价模型。用此种方式建模，每次建模都使用了全量的数据集，所以模型无限接近数据全貌，所建模型更加准确。此外，在数据集的选择过程中没有随机因素包含其中。

留一法的确定是在数据集很大时计算量巨大。如果在100万个数据集上训练模型，则需要训练100万个模型，非常耗时。如果样本量更大，留一法切分数据集的操作在工程上实现难度很大，必要时需要采取并行方式。而在小数据集上，用留一法是可取的。

<br>

# MATLAB `cvpartition` function

## Partition data method

MATLAB提供了数据切割函数`cvpartition`，并且支持留出法、交叉验证和留一法的使用。

以`fisheriris`数据集为例，展示三种数据切割方法的使用。

```matlab
load fisheriris
```

### Hold-out

```matlab
c1 = cvpartition(species,'Holdout',0.2)
```

```matlab
c1 = 
Hold-out cross validation partition
   NumObservations: 150
       NumTestSets: 1
         TrainSize: 120
          TestSize: 30
```
### Cross validation

```matlab
c2 = cvpartition(species, 'KFold', 5);
```

```matlab
c2 = 
K-fold cross validation partition
   NumObservations: 150
       NumTestSets: 5
         TrainSize: 120  120  120  120  120
          TestSize: 30  30  30  30  30
```

### Leave-One-Out cross validation

```matlab
c3 = cvpartition(species, 'leaveout');
```

```matlab
c3 = 
Leave-one-out cross validation partition
   NumObservations: 150
       NumTestSets: 150
     TrainSize: 149  149  149  149  149  149  149  149  149  149 ...
      TestSize: 1  1  1  1  1  1  1  1  1  1 ...
```

## Usage of  index

上述过程中得到的`c1`、`c2`和`c3`都是索引，之后使用索引来切分数据集。

比如，对于留出法：

```matlab
x1_train = meas(c1.training, :);
y1_train = species(c1.training);
x1_test = meas(c1.test, :);
y1_test = species(c1.test);
```

```matlab
Name            Size            Bytes  Class     Attributes
  x1_test        30x4               960  double              
  x1_train      120x4              3840  double              
  y1_test        30x1              3620  cell                
  y1_train      120x1             14480  cell
```

对于交叉验证法：

```matlab
x2_train = meas(c2.training(3), :);
y2_train = species(c2.training(3));
x2_test = meas(c2.test(3), :);
y2_test = species(c2.test(3));
```

```matlab
Name            Size            Bytes  Class     Attributes
  x2_test        30x4               960  double              
  x2_train      120x4              3840  double              
  y2_test        30x1              3620  cell                
  y2_train      120x1             14480  cell
```

## `Stratify` option

`cvpartition`函数可以设置`Stratify`选项。**默认**`Stratify=true`，会根据数据集标签的比例进行切分数据集，当`Stratify=false`，则会随机分割：

```matlab
clc, clear, close all
load fisheriris

rng('default')
species = categorical(species);
% Class names
C = categories(species); 
% Class numbers
numClasses = size(C,1);

figure('Units', 'pixels', 'Position', [1000, 552, 856, 785])
% Cross validation method with 'Stratify'=false
cv1 = cvpartition(species, 'KFold', 5, 'Stratify', false);
plotBar(cv1, species, numClasses, C, 'Nonstratified Partition')
% Cross validation method with 'Stratify'=true
cv2 = cvpartition(species, 'KFold', 5, 'Stratify', true);
plotBar(cv2, species, numClasses, C, 'Stratified Partition')

function plotBar(cv, species, numClasses, ClassName, titleName)
numFolds = cv.NumTestSets;
nTestData = zeros(numFolds, numClasses);
for i = 1:numFolds
    % Record number of test set observations in each class
    testClasses = species(cv.test(i));
    nCounts = countcats(testClasses); 
    nTestData(i, :) = nCounts';
end
nexttile
bar(nTestData)
xlabel('Test Set (Fold)')
ylabel('Number of Observations')
title(titleName)
legend(ClassName)
grid on
box on
end
```

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220924132133219.png?raw=true" alt="image-20220924132133219" style="zoom:67%;" />

fisheriris数据集中三个物种都有50条数据，比例是1:1:1，所以当`Stratify=true`，切分后的数据集的数量比例是1:1:1。

如果原始数据集的数据不相等，比如删除一些数据，使得原始数据集中三个物种的比例是为3:2:1：

```matlab
clc, clear, close all
load fisheriris
rng('default')

% Delete some data, make proportion 3:2:1
idx = randperm(50, 20);
meas(idx, :) = [];
species(idx, :) = [];
idx = randperm(50, 30)+30;
meas(idx, :) = [];
species(idx, :) = [];
idx = randperm(50, 40)+50;
meas(idx, :) = [];
species(idx, :) = [];
```

此时，查看三个物种的比例：

```matlab
species = categorical(species);
countcats(species)
```

```matlab
ans =
    30
    20
    10
```

之后，像上面一样，使用交叉验证法将数据集进行切割，并可视化：

```matlab
% Class names
C = categories(species); 
% Class numbers
numClasses = size(C,1);

figure('Units', 'pixels', 'Position', [1000, 552, 856, 785])
% Cross validation method with 'Stratify'=false
cv1 = cvpartition(species, 'KFold', 5, 'Stratify', false);
plotBar(cv1, species, numClasses, C, 'Nonstratified Partition')
% Cross validation method with 'Stratify'=true
cv2 = cvpartition(species, 'KFold', 5, 'Stratify', true);
plotBar(cv2, species, numClasses, C, 'Stratified Partition')

function plotBar(cv, species, numClasses, ClassName, titleName)
numFolds = cv.NumTestSets;
nTestData = zeros(numFolds, numClasses);
for i = 1:numFolds
    % Record number of test set observations in each class
    testClasses = species(cv.test(i));
    nCounts = countcats(testClasses); 
    nTestData(i, :) = nCounts';
end
nexttile
bar(nTestData)
xlabel('Test Set (Fold)')
ylabel('Number of Observations')
title(titleName)
legend(ClassName)
grid on
box on
end
```

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220924133719786.png?raw=true" alt="image-20220924133719786" style="zoom:67%;" />

可以看到，`Stratify=true`将数据集按种类3:2:1的比例进行切分。

# Extract a specified number of samples from each class

Added on 31, Aug. 2023.
{:.notice}

In certain scenarios, we probably want to extract a specified number of samples from each class, regardless of whether or not the origin dataset is balanced, like respectively extracting 5, 3, and 2 samples of each class from deleted `fisheriris` dataset aforementioned in the last section for instance: 

```matlab
clc,clear,close all
load fisheriris.mat

% Delete some data, make proportion 3:2:1
idx_training = randperm(50, 20);
meas(idx_training, :) = [];
species(idx_training, :) = [];
idx_training = randperm(50, 30)+30;
meas(idx_training, :) = [];
species(idx_training, :) = [];
idx_training = randperm(50, 40)+50;
meas(idx_training, :) = [];
species(idx_training, :) = [];

% % % For verifying 
% meas(:,5) = (1:height(meas))'; % add a tag for each sample

% Select a specified number of samples from each class
[meas_training,species_training,meas_test,species_test] = helperExtractSample(meas,species,[5;3;2]);

% % % For verifying 
% % For feature 'meas'
% combinenation_meas = [meas_training;meas_test];
% combinenation_species = [species_training;species_test];
% disp(numel(unique(combinenation_meas(:,5))))
% % For label 'species'
% variables = findgroups(combinenation_species);
% totalNumPerClass = splitapply(@numel,combinenation_species,variables);
% disp(totalNumPerClass)

function [feautues_training,labels_training,features_test,labels_test] = ...
    helperExtractSample(features,labels,trainingNumPerClass) % Function for Select a specified number of samples from each class
% Initial pre-process
classesName = unique(labels);
numClasses = numel(classesName);
variables = findgroups(labels);
totalNumPerClass = splitapply(@numel,labels,variables);
testNumPerClass = totalNumPerClass-trainingNumPerClass;

trainingNum = sum(trainingNumPerClass);
testNum = sum(totalNumPerClass)-trainingNum;

feautues_training = nan(trainingNum,width(features));
features_test = nan(testNum,width(features));

labels_training = cell(trainingNum,1);
labels_test = cell(testNum,1);

beginningIdx_training = 1;
beginningIdx_test = 1;
for i = 1:numClasses
    % Extract all samples of the same label
    speciesIdx = strcmp(labels,classesName(i));
    selectedFeatures = features(speciesIdx,:);
    selectedLabels = labels(speciesIdx);
    idx_training = randperm(totalNumPerClass(i),trainingNumPerClass(i));

    % Extract a specified number of training samples
    idxRange_training = beginningIdx_training:(beginningIdx_training+trainingNumPerClass(i)-1);
    feautues_training(idxRange_training,:) = selectedFeatures(idx_training,:);
    labels_training(idxRange_training,1) = selectedLabels(idx_training,:);
    beginningIdx_training = beginningIdx_training+trainingNumPerClass(i);

    % Extract a specified number of test samples
    idxRange_test = beginningIdx_test:(beginningIdx_test+testNumPerClass(i)-1);
    idx_test = 1:totalNumPerClass(i);
    idx_test(idx_training) = [];
    features_test(idxRange_test,:) = selectedFeatures(idx_test,:);
    labels_test(idxRange_test,1) = selectedLabels(idx_test,:);
    beginningIdx_test = beginningIdx_test+testNumPerClass(i);
end
% Display label results
disp(labels_training)
end
```

```
    {'setosa'    }
    {'setosa'    }
    {'setosa'    }
    {'versicolor'}
    {'versicolor'}
    {'versicolor'}
    {'virginica' }
    {'virginica' }
    {'virginica' }
```

<br>

**References**

[1] [cvpartition - MathWorks](https://ww2.mathworks.cn/help/stats/cvpartition.html).