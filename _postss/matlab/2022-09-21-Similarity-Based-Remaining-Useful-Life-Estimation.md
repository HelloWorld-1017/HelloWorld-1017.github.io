---
layout: single
title: Similarity-Based Remaining Useful Life Estimation in MATLAB
date: 2022-09-21 19:28:29 +0800
categories: 
 - MATLAB
 - Machine Learning
tags:
 - Probability Theory and Mathematical Statistics
 - MATLAB Predictive Maintenance Toolbox
 - Remaining Useful Life
---

# Introduction

本文的示例来自MATLAB Predictive Maintenance Toolbox：[Similarity-Based Remaining Useful Life Estimation](https://ww2.mathworks.cn/help/predmaint/ug/similarity-based-remaining-useful-life-estimation.html)，目的是对设备进行RUL估计，使用的数据集为：PHM2008 challenge dataset。

该示例具有以下特点：

- 数据集包含了从健康状态到故障状态整个发展过程的数据；
- 假设设备的退化过程为线性退化过程，不考虑累积退化(cumulative degradation)；

<br>

# Work Flow

## Data preparation

使用自定义函数`degradationData`读取数据文件`train_FD002.txt`，将每个机器的数据都保存在一个table中，最终将所有机器的table组合成一个cell。

`helperLoadData`函数：

```matlab
function degradationData = helperLoadData(filename)
% Copyright 2017-2018 The MathWorks, Inc.

% Load the text file as a table
t = readtable(filename);

% Add variable names to the table
VarNames = {...
    'id', 'time', 'op_setting_1', 'op_setting_2', 'op_setting_3', ...
    'sensor_1', 'sensor_2', 'sensor_3', 'sensor_4', 'sensor_5', ...
    'sensor_6', 'sensor_7', 'sensor_8', 'sensor_9', 'sensor_10', ...
    'sensor_11', 'sensor_12', 'sensor_13', 'sensor_14', 'sensor_15', ...
    'sensor_16', 'sensor_17', 'sensor_18', 'sensor_19', 'sensor_20', ...
    'sensor_21'};
t.Properties.VariableNames = VarNames;

% Split the signals from each machine ID into individual tables 
% and collect the tables in a cell array.
IDs = t{:,1};
nID = unique(IDs);
degradationData = cell(numel(nID),1);
for ct=1:numel(nID)
    idx = IDs == nID(ct);
    degradationData{ct} = t(idx,:);
end
end
```

读取训练数据文件`train_FD002.txt`：

```matlab
% Load train data
degradationData = helperLoadData('train_FD002.txt');
```

```matlab
>> degradationData
ans =
  260×1 cell array
    {149×26 table}
    {269×26 table}
    {206×26 table}
    ...
    {205×26 table}
    {316×26 table}
```

其中，cell变量`degradationData`中的第$i$个元素代表第$i$个机器的数据集，每个元素的行数是不一样的，表示每个机器的数据集数量是不一样的，但是列数是一样的，都是26列，第1列表示machine ID，第2列是time stamp，第3~5列表示3个operating conditions，第6~26列表示21个sensor measurements。

之后，将数据集分割为训练集和验证集：

```matlab
% Split the degradation data into a training data set 
% and a validation data set for later performance evaluation
rng('default')  % For repeatablility
numEnsemble = length(degradationData);
numFold = 5;
cv = cvpartition(numEnsemble, 'KFold', numFold);
trainData = degradationData(training(cv, 1));
validationData = degradationData(test(cv, 1));
```

此时，`trainData`为`208x1 cell`，`validationData`为`52x1 cell`。

之后，将数据表的列名，分为时间列、condition列、变量列，供后续使用：

```matlab
% Specify groups of variables of interest
varNames = string(degradationData{1}.Properties.VariableNames);
timeVariable = varNames{2};
conditionVariables = varNames(3:5);
dataVariables = varNames(6:26);
```

```matlab
timeVariable =
    'time'

conditionVariables = 
  1×3 string array
  Column 1
    "op_setting_1"
  Column 2
    "op_setting_2"
  Column 3
    "op_setting_3"

dataVariables = 
  1×21 string array
  Columns 1 through 2
    "sensor_1"    "sensor_2"
  Columns 3 through 4
    "sensor_3"    "sensor_4"
    ...
  Column 21
    "sensor_21"
```

使用自定义函数`helperPlotEnsemble`随机选取10个机器的数据，并且绘制这10个机器`op_setting_1`列、`op_setting_2`列、`sensor_1`列、`sensor_2`列**随时间变化**的曲线（每张图像有10条曲线）。

`helperPlotEnsemble`函数：

```matlab
function helperPlotEnsemble(ensemble, TimeVariable, DataVariables, nsample, varargin)
% Copyright 2017-2018 The MathWorks, Inc.
% ensemble, 208x1 cell

% Randomly select 10(nsample) machines
randIdx = randperm(length(ensemble));
ensembleSample = ensemble(randIdx(1:nsample));

% Plot profiles
numData = length(DataVariables);
for i = 1:numData
    data2plot = DataVariables(i);
    subplot(numData, 1, i)
    hold on
    for j = 1:length(ensembleSample)
        ensembleMember = ensembleSample{j};
        if isa(ensembleMember, 'double') % Determine if input is 'double' class
            % TimeVariable and DataVariables are doubles
            if isempty(TimeVariable)
                plot(ensembleMember(:, DataVariables), varargin{:})
            else
                plot(ensembleMember(:, TimeVariable), ensembleMember(:, DataVariables), varargin{:})
            end
            xlblstr = "time";
            ylblstr = "Var " + data2plot;
        else
            % ensembleMember is a table
            plot(ensembleMember.(char(TimeVariable)), ensembleMember.(char(data2plot)), varargin{:})
            xlblstr = TimeVariable;
            ylblstr = data2plot;
        end
    end
    hold off
    ylabel(ylblstr, 'Interpreter', 'none')
end
xlabel(xlblstr)
end
```

绘制图像：

```matlab
% Visualize a sample of the ensemble data
nsample = 10;
figure('Units', 'pixels', 'Position', [299, 101, 1100, 789])
helperPlotEnsemble(trainData, timeVariable, [conditionVariables(1:2) dataVariables(1:2)], nsample)
```

![image-20220915195348310](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220915195348310.png?raw=true)

为了看得清楚一点，我们可以修改`nsample`，只可视化2个机器的情况：

![image-20220915195455130](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220915195455130.png?raw=true)

可以看到，这些数据随时间变化是杂乱无章的，没有明显的退化趋势。但是处理后的曲线就可能会表现出一种趋势。

## Working Regime Clustering

把`208x1 cell`的`trainData`展开成`43352x26 table`的`trainDataUnwrap`，之后选中3个operating conditions列，并使用自定义函数`helperPlotClusters`将它们绘制在三维空间上：

`helperPlotClusters`函数：

```matlab
function helperPlotClusters(X, idx, C)
% Copyright 2017-2018 The MathWorks, Inc.

if(nargin>1)
    hold on
    for i = 1:max(idx)
        scatter3(X{idx==i,1}, X{idx==i,2}, X{idx==i,3});
    end
    scatter3(C(:,1),C(:,2),C(:,3), 'x', 'MarkerFaceColor', [0 0 0], ...
        'MarkerEdgeColor', [0 0 0], 'LineWidth', 2);
    legendStr = ["Cluster "+(1:6), "Centroids"];
    legend(cellstr(legendStr), 'Location', 'NW');
    hold off
    view(-30,30)
    grid on
else
    scatter3(X{:,1}, X{:,2}, X{:,3});
end
xlabel(X.Properties.VariableNames{1}, 'Interpreter', 'none')
ylabel(X.Properties.VariableNames{2}, 'Interpreter', 'none')
zlabel(X.Properties.VariableNames{3}, 'Interpreter', 'none')
end
```

绘制图像：

```matlab
% Notice that each ensemble member contains 3 operating conditions: "op_setting_1", "op_setting_2", and "op_setting_3". 
% Firstly, extract the table from each cell and concatenate them into a single table.
trainDataUnwrap = vertcat(trainData{:});
opConditionUnwrap = trainDataUnwrap(:, cellstr(conditionVariables));

% Visualize all operating points on a 3D scatter plot.
% It clearly shows 6 regimes and the points in each regime are in very close proximity.
figure(2)
helperPlotClusters(opConditionUnwrap)
```

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220917133313874.png?raw=true" alt="image-20220917133313874" style="zoom:50%;" />

可以看到，所有数据的operating conditions列聚集在三维空间中的6个regime。

之后使用多次k-means找到聚类中心点，并绘制效果图：

```matlab
% Use clustering techniques to locate the 6 clusters automatically. 
% Repeat the K-means clustering algorithm several times with different initial conditions and pick the results with the lowest cost
opts = statset('Display', 'final');
[clusterIndex, centers] = kmeans(table2array(opConditionUnwrap), 6, ... 
    'Distance', 'sqeuclidean', 'Replicates', 5, 'Options', opts);
% Visualize the clustering results and the identified cluster centroids
figure(3)
helperPlotClusters(opConditionUnwrap, clusterIndex, centers)
```

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220917134135495.png?raw=true" alt="image-20220917134135495" style="zoom:50%;" />

## Working Regime Normalization

当聚类工作完成后，就可以计算每条数据的3个operating conditions列距离6个中心点的距离，距离哪个中心点的距离最小就将数据分为哪一类，并按照类别计算均值和标准差，之后使用`regimeNormalization`函数对每一类数据的传感器数据进行标准化。

`regimeNormalization`函数：

```matlab
function data = regimeNormalization(data, centers, centerstats)
% Perform normalization for each observation (row) of the data
% according to the cluster the observation belongs to.
conditionIdx = 3:5;
dataIdx = 6:26;

% Perform row-wise operation
data{:, dataIdx} = table2array(...
    rowfun(@(row) localNormalize(row, conditionIdx, dataIdx, centers, centerstats), ...
    data, 'SeparateInputs', false));
end
```

其中的`localNormalize`函数：

```matlab
function data = regimeNormalization(data, centers, centerstats)
% Perform normalization for each observation (row) of the data
% according to the cluster the observation belongs to.
conditionIdx = 3:5;
dataIdx = 6:26;

% Perform row-wise operation
data{:, dataIdx} = table2array(...
    rowfun(@(row) localNormalize(row, conditionIdx, dataIdx, centers, centerstats), ...
    data, 'SeparateInputs', false));
end
```

实现代码：

```matlab
%% Working Regime Normalization
centerstats = struct('Mean', table(), 'SD', table());
for v = dataVariables
    centerstats.Mean.(char(v)) = splitapply(@mean, trainDataUnwrap.(char(v)), clusterIndex);
    centerstats.SD.(char(v))   = splitapply(@std,  trainDataUnwrap.(char(v)), clusterIndex);
end

trainDataNormalized = cellfun(@(data) regimeNormalization(data, centers, centerstats), ...
    trainData, 'UniformOutput', false);
```

之后，绘制标准化后的前四个传感器监测量随时间变化曲线：

```matlab
figure(4)
helperPlotEnsemble(trainDataNormalized, timeVariable, dataVariables(1:4), nsample)
```

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220917134737300.png?raw=true" alt="image-20220917134737300" style="zoom:50%;" />

标准化后，一些传感器值就表现一定的随时间变化的趋势，之后就针对每一个传感器数据进行趋势分析。

## Trendability Analysis `linearDegradationModel`

将训练集中所有机器的同一种传感器随时间变化数据都挑选出来赋给变量`tmp`，因此变量`tmp`是一个`208x1 cell`变量，其中第i个元素为`nx1 table`的变量，`n`为机器i的数据数量（即时间长度）。使用数据集`tmp`拟合线性模型`mdl = linearDegradationModel()`，之后将参数`mdl.Theta`保存在变量`signalSlope`中：

```matlab
numSensors = length(dataVariables);
signalSlope = zeros(numSensors, 1);
warn = warning('off');
for ct = 1:numSensors
    tmp = cellfun(@(tbl) tbl(:, cellstr(dataVariables(ct))), trainDataNormalized, 'UniformOutput', false);
    mdl = linearDegradationModel(); % create model
    fit(mdl, tmp); % train mode
    signalSlope(ct) = mdl.Theta;
end
warning(warn);
```

最终，斜率参数`signalSlope`是一个`21x1 double`变量。

之后，将斜率参数的**绝对值**进行降序排序，选取斜率最大的前8个传感器作为特征量：

```matlab
[~, idx] = sort(abs(signalSlope), 'descend');
sensorTrended = sort(idx(1:8));
```

并绘制其中排序为3~6的传感器检测值随时间变化曲线：

```matlab
figure(5)
helperPlotEnsemble(trainDataNormalized, timeVariable, dataVariables(sensorTrended(3:6)), nsample)
```

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220917135051477.png?raw=true" alt="image-20220917135051477" style="zoom:50%;" />

## Construct Health Condition

由于这里的数据集中的数据都是run-to-failure数据，每一个机器最开始都是健康状态，最后都是故障状态。我们需要构造一个随时间线性变化的Health condition，向所有数据添加`health_condition`列，初始状态时Health condition为1，故障状态时Health condition为0。

```matlab
for j=1:numel(trainDataNormalized)
    data = trainDataNormalized{j};
    rul = max(data.time)-data.time;
    data.health_condition = rul / max(rul);
    trainDataNormalized{j} = data;
end

figure(6)
helperPlotEnsemble(trainDataNormalized, timeVariable, "health_condition", nsample)
```

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220917135509415.png?raw=true" alt="image-20220917135509415" style="zoom:50%;" />

## Construct Health Indicator

之后，我们需要将8个传感器值融合成一个Health indicator，并寻找它和`health_condition`列之间的关系，这里假设是线性关系：

Health Condition ~ 1 + Sensor2 + Sensor3 + Sensor4 + Sensor7 + Sensor11 + Sensor12 + Sensor15 + Sensor17

这实际上就是一个参数估计问题，使用的是`fitlm`函数：

```matlab
trainDataNormalizedUnwrap = vertcat(trainDataNormalized{:});

sensorToFuse = dataVariables(sensorTrended);
X = trainDataNormalizedUnwrap{:, cellstr(sensorToFuse)};
y = trainDataNormalizedUnwrap.health_condition;
regModel = fitlm(X, y);
bias = regModel.Coefficients.Estimate(1);
weights = regModel.Coefficients.Estimate(2:end);
```

```matlab
bias =
    0.5000

weights =
   -0.0323
   -0.0300
   -0.0527
    0.0057
   -0.0646
    0.0054
   -0.0431
   -0.0379
```

之后，基于bias和weights融合传感器信息，使用`degradationSensorFusion`函数构造一个Health indicator列（但是并没有添加到数据表中，这点和Health condition不同）。

`degradationSensorFusion`函数：

```matlab
function dataFused = degradationSensorFusion(data, sensorToFuse, weights)
% Combine measurements from different sensors according 
% to the weights, smooth the fused data and offset the data
% so that all the data start from 1

% Fuse the data according to weights
dataToFuse = data{:, cellstr(sensorToFuse)};
dataFusedRaw = dataToFuse*weights;

% Smooth the fused data with moving mean
stepBackward = 10;
stepForward = 10;
dataFused = movmean(dataFusedRaw, [stepBackward stepForward]);

% Offset the data to 1
dataFused = dataFused + 1 - dataFused(1);
end
```

实现代码：

```matlab
% Construct a single health indicator by multiplying the sensor measurements with their associated weights
trainDataFused = cellfun(@(data) degradationSensorFusion(data, sensorToFuse, weights), trainDataNormalized, ...
    'UniformOutput', false);% trainDataFused, 208x1 cell
```

并可视化10个机器的Health indicator：

```matlab
% Visualize the fused health indicator for training data
figure(7)
helperPlotEnsemble(trainDataFused, [], 1, nsample)
xlabel('Time')
ylabel('Health Indicator')
title('Training Data')
```

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220917140923094.png?raw=true" alt="image-20220917140923094" style="zoom:50%;" />

注：在`degradationSensorFusion`函数中可以看到，这些数据（即曲线）是经过了`movmean`滑动平均的，并且考虑到了滑动平均技术可能引起的offset。
{: .notice--primary}

之后，使用验证集进行验证Health Indicator的趋势性：

```matlab
validationDataNormalized = cellfun(@(data) regimeNormalization(data, centers, centerstats), ...
    validationData, 'UniformOutput', false);
validationDataFused = cellfun(@(data) degradationSensorFusion(data, sensorToFuse, weights), ...
    validationDataNormalized, 'UniformOutput', false);

figure(8)
helperPlotEnsemble(validationDataFused, [], 1, nsample)
xlabel('Time')
ylabel('Health Indicator')
title('Validation Data')
```

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220917141344560.png?raw=true" alt="image-20220917141344560" style="zoom:50%;" />

## Build and Fit Similarity RUL Model `residualSimilarityModel`

现在，我们基于Health condition构造出了Health indicator曲线，Health indicator曲线就代表了整个退化趋势和过程。接下来就是构建并拟合RUL模型，这里采用`residualSimilarityModel`函数构建：

`residualSimilarityModel`官方文档：[residualSimilarityModel](https://ww2.mathworks.cn/help/predmaint/ref/residualsimilaritymodel.html)
{: .notice--primary}

```matlab
mdl = residualSimilarityModel(...
    'Method', 'poly2',...
    'Distance', 'absolute',...
    'NumNearestNeighbors', 50,...
    'Standardize', 1);

fit(mdl, trainDataFused);
```

```matlab
mdl = 
  residualSimilarityModel with properties:
                 Models: {208×1 cell}
               ModelMSE: [208×1 double]
               LifeSpan: [208×1 double]
    NumNearestNeighbors: 50
                 Method: "poly2"
               Distance: "absolute"
            IncludeTies: 1
            Standardize: 1
       LifeTimeVariable: ""
           LifeTimeUnit: ""
          DataVariables: ""
               UserData: []
            UseParallel: 0
```

这里的拟合实际上就是拟合一个二阶多项式来表示一个机器的Health indicator的曲线。

我们可以验证一下，首先查看`mdl.Models`元素的参数：

```matlab
>> mdl.Models{1}
ans =
   -0.0000    0.0023    0.9812
```

其中，三个值分别表示常数项系数，一阶系数和二阶系数。将该多项式曲线和真实曲线做对比：

```matlab
truedata = trainDataFused{1, 1};
coefficients = mdl.Models{1};
time = 1:numel(truedata);
fitdata = coefficients(3)+ coefficients(2)*time + coefficients(1)*time.^2;

figure
hold on
plot(truedata)
plot(fitdata)
legend('True data', 'Fit data');
hold off
grid on
box on
```

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220917150443681.png?raw=true" alt="image-20220917150443681" style="zoom:50%;" />

## Performance Evaluation

当我们构建并使用训练数据拟合了一个RUL模型后，就需要使用验证集测试模型的效果，即使用`predictRUL`函数进行预测。

首先选取验证集中的一个Health indicator曲线，并且截取其前50%，70%，90%的数据进行预测：

```matlab
% To evaluate the similarity RUL model, use 50%, 70% and 90% of a sample validation data to predict its RUL.
breakpoint = [0.5, 0.7, 0.9];
validationDataTmp = validationDataFused{3}; % use one validation data for illustration
```

### Use 50% of a sample validation data

```matlab
% Use the validation data before the first breakpoint, 50% of the lifetime
bpidx = 1;
validationDataTmp50 = validationDataTmp(1:ceil(end*breakpoint(bpidx)),:);
trueRUL = length(validationDataTmp) - length(validationDataTmp50);
[estRUL, ciRUL, pdfRUL] = predictRUL(mdl, validationDataTmp50);
% Visualize the validation data truncated at 50% 
% and its nearest neighbors.
figure(9)
compare(mdl, validationDataTmp50);
```
```matlab
estRUL =
  100.9366

ciRUL =
   65.0099  137.9562

pdfRUL =
  68×2 table
     RUL      ProbabilityDensity
    ______    __________________

    49.436         0.0015362    
      :               :         
    177.56        0.00065188    
```
<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220917151505271.png?raw=true" alt="image-20220917151505271" style="zoom:50%;" />

之后，使用自定义函数`helperPlotRULDistribution`对比真实RUL与预测RUL。

`helperPlotRULDistribution`函数：

```matlab
function helperPlotRULDistribution(trueRUL, estRUL, pdfRUL, ciRUL)
% HELPERPLOTRULDISTRIBUTION Plot RUL distribution
%
% This function supports the Similarity-based Remaining Useful Life
% Estimation example. It may change in a future release.

%  Copyright 2017-2018 The MathWorks, Inc.

hold on
plot(pdfRUL.RUL, pdfRUL.ProbabilityDensity, 'b');
idx = find(pdfRUL.RUL > trueRUL, 1, 'first');
if isempty(idx)
    y = pdfRUL.ProbabilityDensity(end);
else
    y = pdfRUL.ProbabilityDensity(idx);
end
plot([trueRUL, trueRUL], [0, y], 'r');
idx = find(pdfRUL.RUL > estRUL, 1, 'first');
if isempty(idx)
    y = pdfRUL.ProbabilityDensity(end);
else
    y = pdfRUL.ProbabilityDensity(idx);
end
plot([estRUL, estRUL], [0, y], 'g');
idx = pdfRUL.RUL >= ciRUL(1) & pdfRUL.RUL<=ciRUL(2);
area(pdfRUL.RUL(idx), pdfRUL.ProbabilityDensity(idx), ...
    'FaceAlpha', 0.2, 'FaceColor', 'y', 'EdgeColor', 'none');
hold off
legend('Probability Density Function', 'True RUL', 'Estimated RUL', '90% Confidence Inteval');
xlabel('Cycle')
ylabel('Probability Density')
title('RUL Estimation')
end
```

实现函数：

```matlab
% Visualize the estimated RUL compared to the true RUL and the probability distribution of the estimated RUL.
figure(10)
helperPlotRULDistribution(trueRUL, estRUL, pdfRUL, ciRUL)
```

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220917154126424.png?raw=true" alt="image-20220917154126424" style="zoom:50%;" />

对于得到的结果需要有几点说明。

#### Explanation 1: `'NumNearestNeighbors'`

上图中蓝色的曲线是训练集中和`validationDataTmp50`最接近的50条曲线，这个曲线的个数是之前在`residualSimilarityModel`函数中使用`'NumNearestNeighbors'`进行设置的，如果属性值改为10：

```matlab
mdl = residualSimilarityModel(...
    'Method', 'poly2',...
    'Distance', 'absolute',...
    'NumNearestNeighbors', 50,...
    'Standardize', 1);
```

```matlab
estRUL =
  111.9934

ciRUL =
   89.4586  129.1621

pdfRUL =
  38×2 table
     RUL      ProbabilityDensity
    ______    __________________

    86.517        0.0081863     
    87.732        0.0086341       
      :               :           
    131.48         0.015314
```

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220917151752167.png?raw=true" alt="image-20220917151752167" style="zoom:50%;" />

可以看到，修改了`'NumNearestNeighbors'`属性会影响`estRUL`、`ciRUL`和`pdfRUL`的值。

#### Explanation 2: `predictRUL` function

上面的代码预测用的是`predictRUL`函数：

`predictRUL`官方文档：[predictRUL](https://ww2.mathworks.cn/help/predmaint/ref/lineardegradationmodel.predictrul.html)
{: .notice--primary}

```matlab
[estRUL, ciRUL, pdfRUL] = predictRUL(mdl, validationDataTmp50);
```

```matlab
estRUL =
  100.9366

ciRUL =
   65.0099  137.9562

pdfRUL =
  68×2 table
     RUL      ProbabilityDensity
    ______    __________________

    49.436         0.0015362    
      :               :         
    177.56        0.00065188
```

其中，返回参数：

- `estRUL`，表示`mdl`预测的设备剩余使用寿命，是一个标量；
- `ciRUL`，表示变量`estRUL`的置信区间，是一个二元行向量，用户可以通过指定`predictRUL`函数的`Alpha`参数来更改置信度；
- `pdfRUL`，表示RUL的概率密度方程。

至于是如何计算出置信区间和概率密度函数的，我不是很清楚。

Given one ensemble member in the validation data set, the model will find the nearest 50 ensemble members in the training data set, fit a probability distribution based on the 50 ensemble members, and use the median of the distribution as an estimate of RUL.
{: .notice--primary}

#### Explanation 4: custom function `helperPlotRULDistribution`

```matlab
function helperPlotRULDistribution(trueRUL, estRUL, pdfRUL, ciRUL)
% HELPERPLOTRULDISTRIBUTION Plot RUL distribution
%
% This function supports the Similarity-based Remaining Useful Life
% Estimation example. It may change in a future release.

%  Copyright 2017-2018 The MathWorks, Inc.

hold on
plot(pdfRUL.RUL, pdfRUL.ProbabilityDensity, 'b');
idx = find(pdfRUL.RUL > trueRUL, 1, 'first');
if isempty(idx)
    y = pdfRUL.ProbabilityDensity(end);
else
    y = pdfRUL.ProbabilityDensity(idx);
end
plot([trueRUL, trueRUL], [0, y], 'r');
idx = find(pdfRUL.RUL > estRUL, 1, 'first');
if isempty(idx)
    y = pdfRUL.ProbabilityDensity(end);
else
    y = pdfRUL.ProbabilityDensity(idx);
end
plot([estRUL, estRUL], [0, y], 'g');
idx = pdfRUL.RUL >= ciRUL(1) & pdfRUL.RUL<=ciRUL(2);
area(pdfRUL.RUL(idx), pdfRUL.ProbabilityDensity(idx), ...
    'FaceAlpha', 0.2, 'FaceColor', 'y', 'EdgeColor', 'none');
hold off
legend('Probability Density Function', 'True RUL', 'Estimated RUL', '90% Confidence Inteval');
xlabel('Cycle')
ylabel('Probability Density')
title('RUL Estimation')
end
```

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220917154126424.png?raw=true" alt="image-20220917154126424" style="zoom:50%;" />

`helperPlotRULDistribution`函数将预测结果与真实结果进行对比并可视化，这是一个比较漂亮的呈现方式。

### Use 70% of  a sample validation data

```matlab
% Use the validation data before the second breakpoint, 70% of the lifetime
bpidx = 2;
validationDataTmp70 = validationDataTmp(1:ceil(end*breakpoint(bpidx)), :);
trueRUL = length(validationDataTmp) - length(validationDataTmp70);
[estRUL, ciRUL, pdfRUL] = predictRUL(mdl, validationDataTmp70);
figure(11)
compare(mdl, validationDataTmp70);
figure(12)
helperPlotRULDistribution(trueRUL, estRUL, pdfRUL, ciRUL)
```

<figure class="half">
    <img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220917154718923.png?raw=true" alt="image-20220917154718923" style="zoom:50%;" />
    <img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220917154753728.png?raw=true" alt="image-20220917154753728" style="zoom:50%;" />
</figure>


### Use 90% of a sample validation data

```matlab
% Use the validation data before the second breakpoint, 90% of the lifetime
bpidx = 3;
validationDataTmp90 = validationDataTmp(1:ceil(end*breakpoint(bpidx)), :);
trueRUL = length(validationDataTmp) - length(validationDataTmp90);
[estRUL, ciRUL, pdfRUL] = predictRUL(mdl, validationDataTmp90);
figure(13)
compare(mdl, validationDataTmp90);
figure
helperPlotRULDistribution(trueRUL, estRUL, pdfRUL, ciRUL)
```

<figure class="half">
    <img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220917155027647.png?raw=true" alt="image-20220917155027647" style="zoom:50%;" />
    <img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220917155035903.png?raw=true" alt="image-20220917155035903" style="zoom:50%;" />
</figure>


### Conclusion

三次RUL估计真实值与估计值之间的差值分别是：23.0634，13.8251，10.0474，单位是小时。我们可以得出以下的结论：

- 该模型可以在真正故障前做出预警，可以达到预测检修的效果（只是针对这一条曲线）
- There is a relatively large error between the estimated RUL and the true RUL when the machine is **in an intermediate health stage**. In this example, the most similar 10 curves are close at the beginning, but bifurcate when they approach the failure state, resulting in **roughly two modes in the RUL distribution**.
- When more data is observed, the RUL estimation is enhanced.
- When the machine is close to failure, the RUL estimation is even more enhanced in this example.

### Repeat the same evaluation procedure for the whole validation data set

对所有的测试集数据重复上述步骤，并且计算预测误差：

```matlab
% Repeat the same evaluation procedure fo the whole validation data set
numValidation = length(validationDataFused);
numBreakpoint = length(breakpoint);
error = zeros(numValidation, numBreakpoint);
for dataIdx = 1:numValidation
    tmpData = validationDataFused{dataIdx};
    for bpidx = 1:numBreakpoint
        tmpDataTest = tmpData(1:ceil(end*breakpoint(bpidx)), :);
        trueRUL = length(tmpData) - length(tmpDataTest);
        [estRUL, ~, ~] = predictRUL(mdl, tmpDataTest);
        error(dataIdx, bpidx) = estRUL - trueRUL;
    end
end
```

使用核函数估计误差的分布，并绘制图像：

```matlab
numValidation = length(validationDataFused);
numBreakpoint = length(breakpoint);
error = zeros(numValidation, numBreakpoint);
for dataIdx = 1:numValidation
    tmpData = validationDataFused{dataIdx};
    for bpidx = 1:numBreakpoint
        tmpDataTest = tmpData(1:ceil(end*breakpoint(bpidx)), :);
        trueRUL = length(tmpData) - length(tmpDataTest);
        [estRUL, ~, ~] = predictRUL(mdl, tmpDataTest);
        error(dataIdx, bpidx) = estRUL - trueRUL;
    end
end
[pdf50, x50] = ksdensity(error(:, 1));
[pdf70, x70] = ksdensity(error(:, 2));
[pdf90, x90] = ksdensity(error(:, 3));
figure(14)
ax(1) = subplot(3,1,1);
hold on
histogram(error(:, 1), 'BinWidth', 5, 'Normalization', 'pdf')
plot(x50, pdf50)
hold off
title('RUL Prediction Error using first 50% of each validation ensemble member')
ax(2) = subplot(3,1,2);
hold on
histogram(error(:, 2), 'BinWidth', 5, 'Normalization', 'pdf')
plot(x70, pdf70)
hold off
title('RUL Prediction Error using first 70% of each validation ensemble member')
ax(3) = subplot(3,1,3);
hold on
histogram(error(:, 3), 'BinWidth', 5, 'Normalization', 'pdf')
plot(x90, pdf90)
hold off
xlabel('Prediction Error')
title('RUL Prediction Error using first 90% of each validation ensemble member')
linkaxes(ax, 'x')
```

![image-20220917161704527](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220917161704527.png?raw=true)

并且绘制误差的箱线图，查看四分位点：

```matlab
figure
boxplot(error, 'Labels', {'50%', '70%', '90%'})
ylabel('Prediction Error')
title('Prediction error using different percentages of each validation ensemble member')
```

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220917161931275.png?raw=true" alt="image-20220917161931275" style="zoom:50%;" />

之后，计算预测误差的均值和标准差，并绘制errorbar：

```matlab
errorMean = mean(error)
errorMedian = median(error)
errorSD = std(error)
```

```matlab
errorMean =
   -1.1217    9.5186    9.6540

errorMedian =
    1.3798   11.8172   10.3457

errorSD =
   21.7315   13.5194   12.3083
```

![image-20220917162202780](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220917162202780.png?raw=true)

<br>

# Conclusion

综上，对本示例进行总结：

- 数据集包含了从健康状态到故障状态整个发展过程的传感器数据；

- 本实例假设退化过程为线性的，不考虑累积退化，这表现在：在拟合标准化后的传感器量的趋势时，采用的是`linearDegradationModel`，并且体现在Health indicator的构建上；

- 本示例在融合传感器信息时，即在构造Health indicator时，采用的是比较简单的技术：即挑选8个趋势性最明显的传感器数据，之后采用线性模型，参数估计出出它们与Health condition之间的关系（即线性系数）。除此之外，还可以使用更为丰富的技术，MATLAB官方提供了几个参考文献$^{[1-4]}$。

另外，在这个示例中，还存在一些我不是很清楚的部分：

- `predictRUL`函数根据`residualSimilarityModel`函数构建出的模型`mdl`计算出RUL估计的置信区间和PDF的方法；
- 核函数估计的`ksdensity`函数；

<br>

**参考**

[1] Roemer, Michael J., Gregory J. Kacprzynski, and Michael H. Schoeller. "Improved diagnostic and prognostic assessments using health management information fusion." AUTOTESTCON Proceedings, 2001. IEEE Systems Readiness Technology Conference. IEEE, 2001.

[2] Goebel, Kai, and Piero Bonissone. "Prognostic information fusion for constant load systems." Information Fusion, 2005 8th International Conference on. Vol. 2. IEEE, 2005.

[3] Wang, Peng, and David W. Coit. "Reliability prediction based on degradation modeling for systems with multiple degradation measures." Reliability and Maintainability, 2004 Annual Symposium-RAMS. IEEE, 2004.

[4] Jardine, Andrew KS, Daming Lin, and Dragan Banjevic. "A review on machinery diagnostics and prognostics implementing condition-based maintenance." Mechanical systems and signal processing 20.7 (2006): 1483-1510.
