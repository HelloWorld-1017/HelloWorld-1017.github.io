---
layout: single
title: Incremental Learning in MATLAB
date: 2022-07-15 00:15:57 +0800
categories: 
 - MATLAB
 - Machine Learning
tags: 
 - MATLAB Statistics and Machine Learning Toolbox
---



# Introduction

本博客中的实例来自 MATLAB 官方案例：Implement Incremental Learning for Classification Using Flexible Workflow [[1]](#ref).

> This example shows how to use the **flexible workflow** to implement incremental learning for binary classification with prequential evaluation. A traditionally trained model initializes the incremental model. 

## Incremental Learning Workflow in MATLAB

MATLAB 的 Incremental Learning 主要分为两种工作流：Flexible workflow 和 Succinct workflow. 

### Flexible workflow

When a data chunk is available:

1. Compute cumulative and window model performance metrics by passing the data and current model to the *updateMetrics* function. **The data is treated as test** (holdout) data because the model has not been trained on it yet. *updateMetrics* overwrites the model performance stored in the model with the new values.
2. **Optionally** detect distribution drift or whether the model has degraded.
3. Train the model by passing the incoming data chunk and current model to the *fit* function. The *fit* function uses the specified solver to fit the model to the incoming data chunk, and overwrites the current coefficients and bias with the new estimates.

The flexible workflow enables you to perform custom model and data quality assessments before deciding whether to train the model. All steps are optional, but call updateMetrics before fit when you plan to call both functions.



### Succinct workflow

When a data chunk is available, supply the incoming chunk and a configured incremental model to the *updateMetricsAndFit* function. *updateMetricsAndFit* calls *updateMetrics* **immediately followed** by *fit*. The succinct workflow enables you to implement incremental learning with prequential evaluation easily when you plan to track the model performance and train the model on all incoming data chunks.



## Cold start vs. Warm start

**Cold start**
Little information might be known about the population before incremental learning starts.
Therefore, the algorithm can be run with a cold start. For example, for classification problems, the class names might not be known until after the model processes observations. 

> - 没有数据预先训练模型
> - 数据集没有标签

**Warm Start**
When enough information is known before learning begins (for example, you have good estimates of linear model coefficients), you can specify such information to provide the model with a warm start.

> - 基于预训练模型转换
> - 数据集有标签



## Data set

**Human Activity Data**
The humanactivity data set contains 24,075 observations of five different physical human activities: Sitting, Standing, Walking, Running, and  Dancing. Each observation has 60 features extracted from acceleration data measured by smartphone accelerometer sensors. The data set contains the following variables: 

1. actid (24075-by-1 double): Response vector containing the activity IDs in integers: 1, 2, 3, 4, and 5，representing Sitting, Standing, Walking, Running, and Dancing, respectively;
2. actnames (1-by-5 cell): Activity names corresponding to the integer activity IDs;
3. feat (24075-by-60 double): Feature matrix of 60 features for 24,075 observations;
4. featlabels (60-by-1): Labels of the 60 features.

The Sensor HAR (human activity recognition) App [[2]](#ref) was used to create the humanactivity data set. When measuring the raw acceleration data with this app, a person placed a smartphone in a pocket so that the smartphone was upside down and the screen faced toward the person. The software then calibrated the measured raw data accordingly and extracted the 60 features from the calibrated data. For details about the calibration and  feature extraction, see [[3]](#ref) and [[4]](#ref), respectively.                                                                      

<br>

# Flexible Workflow

## Load  and Preprocess Data

加载数据，并进行初步的整理

```matlab
clc, clear, close all
load humanactivity
rng(1) % For reproducibility
n = numel(actid); % 24075
idx = randsample(n, n); % shuffle, sampled uniformly, without replacement
X = feat(idx, :)'; % 60-by-24075
Y = actid(idx);   % 24075-by-1 logical
```

为了简化分析，只考虑二分类问题。将 Responses 分为两大类，分别是静止状态(标签为0)，包括Sitting, Standing；和运动状态（标签为1），包括 Walking, Running, 和 Dancing。

```matlab
Y = Y > 2;
```



## Pretrain Linear Model for Binary Classification

```matlab
idxtt = randsample([true false], n, true); % 1-by-24075 logical, resample with replacement, either 0 or 1
TTMdl = fitclinear(X(:,idxtt), Y(idxtt), 'ObservationsIn', 'columns') % fit model using all data, specify predictor data observation dimension
```

TTMdl is a ClassificationLinear model object representing a traditionally trained linear model for binary classification.

>  *ClassificationLinear* 模型对象相关属性
>
> 1. ***Beta***: Linear coefficient estimates, specified as a numeric vector with length equal to the number of predictors. 该例子中一共有60个predictors，所以*TTMdl.Beta* 的形状是：60-by-1 double



## Convert Trained Model

Convert the traditionally trained classification model to a binary classification linear model for incremental learning.

```matlab
IncrementalMdl = incrementalLearner(TTMdl)
```

变量 IncrementalMdl 是一个 incrementalClassificationLinear 模型对象

> incrementalClassificationLinear 模型对象相关属性
>
> 1. ***Iswarm***: Flag indicating whether model tracks performance metrics. This property is read-only. Flag indicating whether the incremental model tracks performance metrics, specified as logical 0 (false) or 1 (true).
>    The incremental model Mdl is warm (*IsWarm* becomes true) after incremental fitting functions fit (*EstimationPeriod* + *MetricsWarmupPeriod*) observations to the incremental model.
>    <u>true or 1</u>, The incremental model Mdl is warm. Consequently, *updateMetrics* and *updateMetricsAndFit* track performance metrics in the Metrics property of Mdl.
>    <u>false or 0</u>, *updateMetrics* and *updateMetricsAndFit* do not track performance metrics.
>
> 2. ***Beta***: Linear model coefficients. This property is read-only. Linear model coefficients β, specified as a NumPredictors-by-1 numeric vector. Incremental fitting functions estimate Beta during training. The default initial Beta value depends on how you create the model: (1) If you convert a traditionally trained model to create Mdl, the initial value is specified by the corresponding property of the traditionally trained model. Otherwise, (2)the initial value is zeros(NumPredictors,1).
>
> 3. ***Metrics***: Model performance metrics. This property is read-only. Model performance metrics updated during incremental learning by *updateMetrics* and *updateMetricsAndFit*, specified as a table with <u>two columns</u>(*Cumulative* and *Window*) and <u>m rows</u>, where m is the number of metrics specified by the Metrics name-value argument. The columns of Metrics are labeled *Cumulative* and *Window*.
>
>    - *Cumulative*: Element j is the model performance, as measured by metric j, from the time the model became warm (*IsWarm* is 1).
>    - *Window*: Element j is the model performance, as measured by metric j, evaluated over all observations within the window specified by the *MetricsWindowSize* property. The software updates *Window* after it processes *MetricsWindowSize* observations.
>
>    评价指标 j 由 *incrementalClassificationLinear( )* 的输入 *Metrics* 决定：
>
>    Model performance metrics to track during incremental learning, specified as a built-in loss function name, string vector of names, function handle (@metricName), structure array of function handles, or cell vector of names, function handles, or structure arrays. When *Mdl* is warm, *updateMetrics* and *updateMetricsAndFit* track performance metrics in the *Metrics* property of *Mdl*. The following table lists the built-in loss function names. You can specify more than one by using a string vector.
>
>    ![image-20220714224640777](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220714224640777.png?raw=true)
>



## Implement Incremental Learning

Use the flexible workflow to (1) <u>update model performance metrics</u> and (2) <u>fit the incremental model</u> to the training data by calling the (1) *updateMetrics* and (2) *fit* functions separately.

> 将更新模型性能指标和拟合模型的步骤分开，使工作流更加灵活。



### Preallocate data set

```matlab
% Preallocation
idxil = ~idxtt; 
nil = sum(idxil); % 12022
numObsPerChunk = 50; % the number of observations in single chunk of data
nchunk = floor(nil/numObsPerChunk); % 240, the number of the chunks 
ce = array2table(zeros(nchunk,2),'VariableNames',["Cumulative" "Window"]);% 240-by-2 table, to record metrics
beta1 = [IncrementalMdl.Beta(end); zeros(nchunk,1)]; % record the initial and subsequent values of the last coefficient of 60, which is the number of predictors
Xil = X(:,idxil);  % 60-by-12022
Yil = Y(idxil);    % 12022-by-1
```



### Single interation of incremental fitting

**（1）Select chunk of data**

```matlab
ibegin = min(nil, 1);
iend   = min(nil, numObsPerChunk);
idx = ibegin:iend;
```



**（2）Update performance metrics of the model given a new chunk of data using *updateMetrics***.

Call updateMetrics to update the cumulative and window classification error of the model given the incoming chunk of observations. Overwrite the previous incremental model to update the losses in the Metrics property. **Note that the *updateMetrics* does not fit the model to the chunk of data** — the chunk is "new" data for the model.

```matlab
IncrementalMdl = updateMetrics(IncrementalMdl, Xil(:,idx), Yil(idx), 'ObservationsIn', 'columns'); % update metrics
ce{1,:} = IncrementalMdl.Metrics{"ClassificationError", :}; % record metrics
```



**（3）Fit the model to the data using *fit***

Call *fit* to fit the model to the incoming chunk of observations. Overwrite the previous incremental model to update the model parameters.

```matlab
IncrementalMdl = fit(IncrementalMdl,Xil(:,idx),Yil(idx),'ObservationsIn','columns'); % fit model using input data
beta1(1) = IncrementalMdl.Beta(end); % record the updated value of the last coefficient
```

> 注:
>
> 在 MATLAB 的官方文档中([Implement Incremental Learning for Classification Using Flexible Workflow](https://ww2.mathworks.cn/help/stats/implement-incremental-learning-using-flexible-workflow-classification.html?searchHighlight=Implement%20Incremental%20Learning%20for%20Classification%20Using%20Flexible%20Workflow&s_tid=srchtitle_Implement%2520Incremental%2520Learning%2520for%2520Classification%2520Using%2520Flexible%2520Workflow_1)), 记录的线性系数不统一, 初始系数记录的是第一个线性系数, 在迭代的过程中记录的是最后一个记录的值, 如下图所示. 
>
> <img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220714233058067.png?raw=true" alt="image-20220714233058067" style="zoom:50%;" />
>
> 这应该是个小小的错误. 我这里采用的是记录最后一个线性系数的方式. 



### Make a Loop

```matlab
% Incremental fitting
for j = 1:nchunk
    % (1) Select chunk of data
    ibegin = min(nil, numObsPerChunk*(j-1) + 1);
    iend   = min(nil, numObsPerChunk*j);
    idx = ibegin:iend;
    
    % (2) Update performance metrics of the model given a new chunk of data using 'updateMetrics'
    IncrementalMdl = updateMetrics(IncrementalMdl, Xil(:,idx), Yil(idx), 'ObservationsIn', 'columns');
    ce{j,:} = IncrementalMdl.Metrics{"ClassificationError", :};

    % (3) Fit the model to the data using 'fit'
    IncrementalMdl = fit(IncrementalMdl, Xil(:,idx), Yil(idx), 'ObservationsIn', 'columns');
    beta1(j + 1) = IncrementalMdl.Beta(end); 
end
```



## Inspect Model Evolution

Plot a trace plot of the performance metrics and estimated coefficient $\beta_{60}$.

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220714233613852.png?raw=true" alt="image-20220714233613852" style="zoom:67%;" />

- The cumulative loss is stable and decreases gradually, whereas the window loss jumps.
- $\beta_{60}$ changes abruptly at first, and then gradually levels off as fit processes more chunks of observations.

<br>

# Conclusion

(1)  该示例是一个二分类 Incremental Learning 模型, 但是可以拓展到多分类的情形;

(2)  该示例中增量训练模型的数据和预训练模型其实来自同一个数据集, 具有局限性; 

(3)  该示例是一个 Warm start 的例子, 既有预训练模型, 数据也有标签, 这更像是放缓了传统模型训练过程, 并用验证集实时监测模型性能. 在实际工程应用中, Cold start 更具有实践意义. 

(4) 增量训练模型还有一个重要意义是: 增量训练的实时性可以解决存储空间有限的问题----当存储空间有限时, 新数据用于实时训练模型后, 就可以扔掉. 

(5) Incremental Learning 更多的是代码实现的问题. 

<br>

<div id="ref"></div>

**References**

[1] [Implement Incremental Learning for Classification Using Flexible Workflow -MathWorks](https://ww2.mathworks.cn/help/stats/implement-incremental-learning-using-flexible-workflow-classification.html).

[2] El Helou, A. Sensor HAR recognition App. MathWorks File Exchange. [Sensor HAR recognition App - File Exchange - MATLAB Central](https://ww2.mathworks.cn/matlabcentral/fileexchange/54138-sensor-har-recognition-app).

[3] STMicroelectronics, AN4508 Application note. “Parameters and calibration of a low-g 3-axis accelerometer.” 2014. 

[4]  El Helou, A. Sensor Data Analytics. MathWorks File Exchange. [Sensor Data Analytics (French Webinar Code) - File Exchange - MATLAB Central](https://ww2.mathworks.cn/matlabcentral/fileexchange/54139-sensor-data-analytics-french-webinar-code).
