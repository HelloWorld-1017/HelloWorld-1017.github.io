---
layout: single
title: Analysis for Image Classification Benchmark CIFAR-10 and CIFAR-100 Datasets
date: 2023-03-22 12:41:23 +0800
categories: 
 - MATLAB
 - Machine Learning
tags:
 - MATLAB Deep Learning Toolbox
---

# Introduction

MATLAB提供了一个使用ResNet分类CIFAR-10图像数据示例：[Train Residual Network for Image Classification - MathWorks](https://ww2.mathworks.cn/help/deeplearning/ug/train-residual-network-for-image-classification.html)。CIFAR数据集是图像分类领域的Benchmark，收集自Alex Krizhevsky（AlexNet的作者），分为CIFAR-10和CIFAR-100数据集。该MATLAB示例所使用的CIFAR-10就是下载自Alex Krizhevsky的网站（[CIFAR-10 and CIFAR-100 datasets (toronto.edu)](https://www.cs.toronto.edu/~kriz/cifar.html)）。Alex Krizhevsky的网站对这两个数据集进行了简要的介绍，并且这个MATLAB示例展示了如何导入和使用下载的数据集，因此本博客就结合这两方面的资料，整理一下CIFAR-10和CIFAR-100的基本信息。

<br>

# CIFAR-10 Dataset 

> MATLAB版本的CIFAR-10图像数据集下载地址：https://www.cs.toronto.edu/~kriz/cifar-10-matlab.tar.gz

MATLAB版本的CIFAR-10数据集共包含7个`.mat`文件，分别是：

```matlab
>> dir
.                 
..                
batches.meta.mat 
data_batch_1.mat 
data_batch_2.mat
data_batch_3.mat
data_batch_4.mat
data_batch_5.mat
test_batch.mat
```

## Information file: `batches.meta.mat`

`batches.meta.mat`文件中仅仅包含着CIFAR-10数据集的label信息：

```matlab
>> load batches.meta.mat
>> whos
  Name              Size            Bytes  Class    Attributes
  label_names      10x1              1140  cell        
```

```matlab
>> label_names
label_names =
  10×1 cell array
    {'airplane'  }
    {'automobile'}
    {'bird'      }
    {'cat'       }
    {'deer'      }
    {'dog'       }
    {'frog'      }
    {'horse'     }
    {'ship'      }
    {'truck'     }
```

## Training dataset: `data_batch_1.mat`~`data_batch_5.mat`

训练数据分别保存在五个`.mat`文件中：`data_batch_1.mat`~`data_batch_5.mat`。每个`.mat`文件中保存的数据都是类似的。以`data_batch_1.mat`为例，该文件包含三个变量：

```matlab
>> load data_batch_1.mat
>> whos
  Name                 Size                 Bytes  Class    Attributes
  batch_label          1x21                    42  char               
  data             10000x3072            30720000  uint8             
  labels           10000x1                  10000  uint8              
```

其中：

- `batch_label`变量中保存着batch的信息：

  ```matlab
  >> batch_label
  batch_label =
      'training batch 1 of 5'
  ```

- 变量`data`中保存着图像的RGB数据（均为整数），每张图像包含32x32x3（3072）个数据点；`data`中一共保存了10,000张图像；

- 变量`labels`是这10,000张图像所对应的标签，从0到9

  ```matlab
  >> unique(labels)
  ans =
    10×1 uint8 column vector
     0
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

我比较关心的是：

- 每一个训练集的`.mat`文件中一共包含多少条训练数据？
- 每一个训练集的`.mat`文件中所包含的训练数据中每一类样本的数量是一致的吗？
- 所有的训练数据中每一类样本的数量是一致的吗？

因此，就简单地写了一个脚本文件来查看这些信息：

```matlab
clc,clear,close all

numsBatches = 5;
nums = nan(numsBatches,10);

for i = 1:numsBatches
    filename = sprintf("data_batch_%s.mat",num2str(i));
    load(filename)
    disp(batch_label)

    [ClassVariable,Class] = findgroups(labels);
    nums(i,:) = splitapply(@numel, labels, ClassVariable);

    disp("Sample size")
    disp(sum(nums(i,:)))
    disp("Sample size of each class in per batch")
    disp(nums(i,:))

    clear batch_label data labels
end
disp("Sample size of each class in whole training dataset")
disp(sum(nums))
```

`data_batch_1.mat`：

```matlab
training batch 1 of 5
Sample size
       10000
Sample size of each class in per batch
        1005         974        1032        1016         999         937        1030        1001        1025         981
```

`data_batch_2.mat`：

```matlab
training batch 2 of 5
Sample size
       10000
Sample size of each class in per batch
         984        1007        1010         995        1010         988        1008        1026         987         985
```

`data_batch_3.mat`：

```matlab
training batch 3 of 5
Sample size
       10000
Sample size of each class in per batch
         994        1042         965         997         990        1029         978        1015         961        1029
```

`data_batch_4.mat`：

```matlab
training batch 4 of 5
Sample size
       10000
Sample size of each class in per batch
        1003         963        1041         976        1004        1021        1004         981        1024         983
```

`data_batch_5.mat`：

```matlab
training batch 5 of 5
Sample size
       10000
Sample size of each class in per batch
        1014        1014         952        1016         997        1025         980         977        1003        1022
```

总体样本的数量

```matlab
Sample size of each class in whole training dataset
        5000        5000        5000        5000        5000        5000        5000        5000        5000        5000
```

最终将结果汇总在表格中：

![image-20230321180632180](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230321180632180.png?raw=true)

可以看到：

- 每一个`.mat`文件中都包含了10,000条数据，一共是50,000条训练数据；
- 每一个`.mat`文件中的各类数据的数量并不是一致的，有一些细微的差别；
- 所有的训练数据中每一类样本的数量是一致的，各5,000条；

## Test dataset: `test_batch.mat`

类似地，测试集数据也可以进行类似的分析：

```matlab
>> load test_batch.mat
>> whos
  Name                 Size                 Bytes  Class    Attributes

  batch_label          1x20                    40  char               
  data             10000x3072            30720000  uint8              
  labels           10000x1                  10000  uint8              
```

```matlab
clc,clear,close all

load test_batch.mat

[ClassVariable,Class] = findgroups(labels);
nums = splitapply(@numel, labels, ClassVariable);

disp(nums')
```

```matlab
        1000        1000        1000        1000        1000        1000        1000        1000        1000        1000
```

可以看到测试集中每类有1000个样本。

注：实际上，Alex在其网站中简单的介绍了CIFAR-10数据集的构成情况，上述分析只是简单地做了验证。“The CIFAR-10 dataset consists of 60000 32x32 colour images in 10 classes, with 6000 images per class. There are 50000 training images and 10000 test images. The dataset is divided into five training batches and one test batch, each with 10000 images. The test batch contains exactly 1000 randomly-selected images from each class. The training batches contain the remaining images in random order, but some training batches may contain more images from one class than another. Between them, the training batches contain exactly 5000 images from each class.”
{: .notice-warning}

## Preprocess by MATLAB example

博客一开头所提到的MATLAB示例展示了对于这些原始图片数据的处理。使用了自定义的函数文件`loadCIFARData.m`：

```matlab
function [XTrain,YTrain,XTest,YTest] = loadCIFARData(location)
location = fullfile(location,'cifar-10-batches-mat');
[XTrain1,YTrain1] = loadBatchAsFourDimensionalArray(location,'data_batch_1.mat');
[XTrain2,YTrain2] = loadBatchAsFourDimensionalArray(location,'data_batch_2.mat');
[XTrain3,YTrain3] = loadBatchAsFourDimensionalArray(location,'data_batch_3.mat');
[XTrain4,YTrain4] = loadBatchAsFourDimensionalArray(location,'data_batch_4.mat');
[XTrain5,YTrain5] = loadBatchAsFourDimensionalArray(location,'data_batch_5.mat');
XTrain = cat(4,XTrain1,XTrain2,XTrain3,XTrain4,XTrain5);
YTrain = [YTrain1;YTrain2;YTrain3;YTrain4;YTrain5];

[XTest,YTest] = loadBatchAsFourDimensionalArray(location,'test_batch.mat');
end

function [XBatch,YBatch] = loadBatchAsFourDimensionalArray(location,batchFileName)
s = load(fullfile(location,batchFileName));
XBatch = s.data';
XBatch = reshape(XBatch,32,32,3,[]);
XBatch = permute(XBatch,[2 1 3 4]); % Attention here
YBatch = convertLabelsToCategorical(location,s.labels);
end

function categoricalLabels = convertLabelsToCategorical(location,integerLabels)
s = load(fullfile(location,'batches.meta.mat'));
categoricalLabels = categorical(integerLabels,0:9,s.label_names);
end
```

总得来说，代码非常简单，这里就不再赘述。

调用`loadCIFARData.m`：

```matlab
[XTrain,TTrain,XValidation,TValidation] = loadCIFARData(pwd);
```

查看图像的效果：

```matlab
figure;
idx = randperm(size(XTrain,4),20);
im = imtile(XTrain(:,:,:,idx),ThumbnailSize=[96,96]);
imshow(im)
```

![image-20230321183317343](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230321183317343.png?raw=true)

<br>

# CIFAR-100 Dataset

> MATLAB版本的CIFAR-100图像数据集下载地址：https://www.cs.toronto.edu/~kriz/cifar-100-matlab.tar.gz

MATLAB版本的CIFAR-100数据集共包含3个`.mat`文件，分别是：

```matlab
>> dir
.          
..         
meta.mat   
test.mat   
train.mat  
```

## Label information file: `meta.mat`

`meta.mat`中保存着数据的分类信息，具有两个变量：

```matlab
>> load meta.mat
>> whos
  Name                      Size            Bytes  Class    Attributes
  coarse_label_names       20x1              2696  cell               
  fine_label_names        100x1             11650  cell               
```

CIFAR-100一共有20大类（Superclass）的图像，而这20个大类又可以细分为100个小类（Classes），每个大类均包含5个小类：

![image-20230321190428322](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230321190428322.png?raw=true)

而`coarse_label_names`和`fine_label_names`就保存着Superclasses和Classes的名称。

## Training dataset: `train.mat`

训练集数据保存在`train.mat`中：

```matlab
>> load train.mat
>> whos
  Name                   Size                  Bytes  Class    Attributes
  batch_label            1x21                     42  char               
  coarse_labels      50000x1                   50000  uint8              
  data               50000x3072            153600000  uint8              
  filenames          50000x1                 7400190  cell               
  fine_labels        50000x1                   50000  uint8              
```

其中，比较陌生的是`filenames`变量，里面保存着是图片的文件名称（尽管压缩包中并没有真正包含这些图像）：

```matlab
>> filenames(1:5)
ans =
  5×1 cell array
    {'bos_taurus_s_000507.png' }
    {'stegosaurus_s_000125.png'}
    {'mcintosh_s_000643.png'   }
    {'altar_boy_s_001435.png'  }
    {'cichlid_s_000031.png'    }
```

同样地，我们可以分析一下每个Superclass和Class的样本数量：

```matlab
load train.mat

% For superclass
[ClassVariable,~] = findgroups(coarse_labels);
nums_superclass = splitapply(@numel, coarse_labels, ClassVariable);
disp(nums_superclass')

% For class
[ClassVariable,~] = findgroups(fine_labels);
nums_class = splitapply(@numel, fine_labels, ClassVariable);
disp(nums_class')
```

最后的结果是，每个Class都有500张图片，因此，每个Superclass都有2,500张图片，一共具有50,000张图片的数据。

<br>

## Test dataset: `test.mat`

对于测试数据`test.mat`：

```matlab
>> load test.mat
>> whos
  Name                   Size                 Bytes  Class    Attributes
  batch_label            1x20                    40  char               
  coarse_labels      10000x1                  10000  uint8              
  data               10000x3072            30720000  uint8              
  filenames          10000x1                1480250  cell               
  fine_labels        10000x1                  10000  uint8              
```

```matlab
clc,clear,close all

load test.mat

% For superclass
[ClassVariable,~] = findgroups(coarse_labels);
nums_superclass = splitapply(@numel, coarse_labels, ClassVariable);
disp(nums_superclass')

% For class
[ClassVariable,~] = findgroups(fine_labels);
nums_class = splitapply(@numel, fine_labels, ClassVariable);
disp(nums_class')
```

对于测试集，每个Class都有100张图片，因此，每个Superclass都有500张图片，一共具有10,000张图片的数据。

<br>

# Datasets Merge

在某些情况下，将训练集和测试集的数据合并成一整个数据集是更加方便的。可以参照MATLAB示例对于CIFAR-10数据集的处理方式，将CIFAR-10和CIFAR-100数据集的训练集数据和测试集数据分别合并起来。

注：以下的脚本文件需要与数据集放在相同的工作文件夹中。
{: .notice--warning}

对于CIFAR-10数据集：

```matlab
clc,clear,close all

[XTrain,YTrain,XTest,YTest] = loadCIFARData(pwd);

data = cat(4,XTrain,XTest);
labels = [YTrain;YTest];

save("CIFAR-10.mat","data","labels")

function [XTrain,YTrain,XTest,YTest] = loadCIFARData(location)
[XTrain1,YTrain1] = loadBatchAsFourDimensionalArray(location,'data_batch_1.mat');
[XTrain2,YTrain2] = loadBatchAsFourDimensionalArray(location,'data_batch_2.mat');
[XTrain3,YTrain3] = loadBatchAsFourDimensionalArray(location,'data_batch_3.mat');
[XTrain4,YTrain4] = loadBatchAsFourDimensionalArray(location,'data_batch_4.mat');
[XTrain5,YTrain5] = loadBatchAsFourDimensionalArray(location,'data_batch_5.mat');
XTrain = cat(4,XTrain1,XTrain2,XTrain3,XTrain4,XTrain5);
YTrain = [YTrain1;YTrain2;YTrain3;YTrain4;YTrain5];

[XTest,YTest] = loadBatchAsFourDimensionalArray(location,'test_batch.mat');
end

function [XBatch,YBatch] = loadBatchAsFourDimensionalArray(location,batchFileName)
s = load(fullfile(location,batchFileName));
XBatch = s.data';
XBatch = reshape(XBatch,32,32,3,[]);
XBatch = permute(XBatch,[2 1 3 4]);
YBatch = convertLabelsToCategorical(location,s.labels);
end

function categoricalLabels = convertLabelsToCategorical(location,integerLabels)
s = load(fullfile(location,'batches.meta.mat'));
categoricalLabels = categorical(integerLabels,0:9,s.label_names);
end
```

对于CIFAR-100数据集：

```matlab
clc,clear,close all

[X_train,Y_train_coarse,Y_train_fine,filenames_train] = loadBatchAsFourDimensionalArray('train.mat');
[X_test,Y_test_coarse,Y_test_fine,filenames_test] = loadBatchAsFourDimensionalArray('test.mat');
data = cat(4,X_train,X_test);
coarse_labels = [Y_train_coarse;Y_test_coarse];
fine_labels = [Y_train_fine;Y_test_fine];
filenames = [filenames_train;filenames_test];

save("CIFAR-100.mat","data","coarse_labels","fine_labels","filenames")

function [XBatch,coarse_categoricalLabels,fine_categoricalLabels,filenames] = loadBatchAsFourDimensionalArray(filename)
s = load(filename);
XBatch = s.data';
XBatch = reshape(XBatch,32,32,3,[]);
XBatch = permute(XBatch,[2 1 3 4]);
[coarse_categoricalLabels,fine_categoricalLabels] = convertLabelsToCategorical(s.coarse_labels,s.fine_labels);
filenames = s.filenames;
end

function [coarse_categoricalLabels,fine_categoricalLabels] = ...
    convertLabelsToCategorical(coarse_integerLabels,fine_integerLabels)
s = load("meta.mat");
coarse_categoricalLabels = categorical(coarse_integerLabels,0:19,s.coarse_label_names);
fine_categoricalLabels = categorical(fine_integerLabels,0:99,s.fine_label_names);
end
```

<br>

**References**

[1] [CIFAR-10 and CIFAR-100 datasets](https://www.cs.toronto.edu/~kriz/cifar.html).

[2] [Train Residual Network for Image Classification - MathWorks](https://ww2.mathworks.cn/help/deeplearning/ug/train-residual-network-for-image-classification.html).





