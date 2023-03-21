# Introduction

MATLAB提供了一个使用ResNet分类CIFAR-10图像数据示例：[Train Residual Network for Image Classification - MathWorks](https://ww2.mathworks.cn/help/deeplearning/ug/train-residual-network-for-image-classification.html)。CIFAR数据集是图像分类领域的Benchmark，收集自Alex Krizhevsky（AlexNet的作者），分为CIFAR-10和CIFAR-100数据集。该MATLAB示例所使用的CIFAR-10就是下载自Alex Krizhevsky的网站（[CIFAR-10 and CIFAR-100 datasets (toronto.edu)](https://www.cs.toronto.edu/~kriz/cifar.html)）。Alex Krizhevsky的网站对这两个数据集进行了简要的介绍，并且这个MATLAB示例展示了如何导入和使用下载的数据集，因此本博客就结合这两方面的资料，整理一下CIFAR-10和CIFAR-100的基本信息。

<br>

# CIFAR-10 Dataset 

> MATLAB版本的CIFAR-10图像数据集下载地址：[CIFAR-10 Matlab version](https://www.cs.toronto.edu/~kriz/cifar-10-matlab.tar.gz)

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
- 所有的训练数据加载一起，每一类样本的数量是一致的吗？

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
        1005         974        1032        1016         999         937        1030        1001        1025  
```

`data_batch_2.mat`：

```matlab
training batch 2 of 5
Sample size
       10000
Sample size of each class in per batch
         984        1007        1010         995        1010         988        1008        1026         987
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

















<br>

**References**

[1] [CIFAR-10 and CIFAR-100 datasets](https://www.cs.toronto.edu/~kriz/cifar.html).

[2] [Train Residual Network for Image Classification - MathWorks](https://ww2.mathworks.cn/help/deeplearning/ug/train-residual-network-for-image-classification.html).





