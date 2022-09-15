[Similarity-Based Remaining Useful Life Estimation](https://ww2.mathworks.cn/help/predmaint/ug/similarity-based-remaining-useful-life-estimation.html)

## Data preparation

使用自定义函数`degradationData`读取数据文件`train_FD002.txt`，

文件中读取数据，将每一个



```matlab
>> degradationData(1:5)
ans =
  5×1 cell array
    {149×26 table}
    {269×26 table}
    {206×26 table}
    {235×26 table}
    {154×26 table}
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

使用自定义函数`helperPlotEnsemble`随机选取10个机器的数据，并且绘制这10个机器`op_setting_1`列、`op_setting_2`列、`sensor_1`列、`sensor_2`列随时间变化的曲线（每张图像有10条曲线）：

![image-20220915195348310](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20220915195348310.png)

为了看得清楚一点，我们可以修改`nsample`，只可视化2个机器的情况：

![image-20220915195455130](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20220915195455130.png)

可以看到，这些数据随时间变化是杂乱无章的，没有明显的退化趋势。



从传感器信号中提取明显的趋势。

把`208x1 cell`的`trainData`展开成`43352x26 table`的`trainDataUnwrap`，之后选中3个operating conditions列，并使用自定义函数`helperPlotClusters`将它们绘制在三维空间上：

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

==hanshu==

==图像==

之后使用k-means自动找到聚类中心点，并绘制效果图：

```matlab
```



当聚类工作完成后，就可以计算每一类的传感器数据的均值和标准差：

```matlab

```



之后，使用自定义函数`regimeNormalization`对于每一类数据的传感器数据进行标准化：



每一行数据都有3个operating conditions列，计算它们到每一个聚类中心点的距离，距离哪个聚类中心最小改行就属于哪一类，之后就进行标准化。如果标准化后的标准差接近于0，说明这个传感器的监测量是没有用的，因此就把它置为0.

之后，绘制标准化后的前四个传感器监测量随时间变化曲线：



# Appendix

函数解释

