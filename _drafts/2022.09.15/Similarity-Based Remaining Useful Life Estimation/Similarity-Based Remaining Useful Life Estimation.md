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





将所有机器的同一种传感器随时间变化数据都挑选出来赋给变量`tmp`，因此变量`tmp`是一个`208x1 cell`变量，其中第i个元素为`nx1 table`的变量，`n`为机器i的数据数量。使用数据集`tmp`拟合线性模型`mdl = linearDegradationModel()`，之后将参数`mdl.Theta`保存在变量`signalSlope`中：

```matlab
```

最终，斜率参数`signalSlope`是一个`21x1 double`变量。

之后，将斜率参数的**绝对值**进行降序排序，选取前8个传感器：

```matlab

```

并绘制其中排序为3~6的传感器检测值随时间变化曲线：

```matlab

```



## Construct Health Indicator

传感器融合

假设所有的数据都是从健康状态开始，值为1；最后是故障状态，值为0

假设是线性退化的

这个线性退化的，This linear degradation is used to help fuse the sensor values. More sophisticated sensor fusion techniques are described in the literature [2-5].

并添加`health_condition`列：

```matlab
figure
helperPlotEnsemble(trainDataNormalized, timeVariable, "health_condition", nsample)
```

The health condition of all ensemble members change from 1 to 0 with varying degrading speeds.

Now fit a linear regression model of Health Condition with the most trended sensor measurements as regressors:

拟合Health Condition和传感器值之间的关系：

Health Condition ~ 1 + Sensor2 + Sensor3 + Sensor4 + Sensor7 + Sensor11 + Sensor12 + Sensor15 + Sensor17



拟合出偏置和系数：

```matlab

```



之后，使用自定义函数`degradationSensorFusion`

此时，多个传感器值已经融合为一个health indicator，`degradationSensorFusion`对曲线做了滑动平均滤波



## Apply same operation to validation data

之后使用验证集进行验证：

```matlab
```



## Build Similarity RUL Model

使用二阶多项式拟合fused data



Given one ensemble member in the validation data set, the model will find the nearest 50 ensemble members in the training data set, fit a probability distribution based on the 50 ensemble members, and use the median of the distribution as an estimate of RUL.



有较大误差



When more data is observed, the RUL estimation is enhanced.

When the machine is close to failure, the RUL estimation is even more enhanced in this example.





# Appendix

这是一个很漂亮的示例，代码中用到了很多陌生但很简洁的函数，和一些漂亮的技术，这里记录一下。

## Function 1: linearDegradationModel

`linearDegradationModel`函数文档：[linearDegradationModel](https://ww2.mathworks.cn/help/predmaint/ref/lineardegradationmodel.html)。

模型
$$
S(t)=\phi+\theta(t)t+\varepsilon(t)\notag
$$
==这里使用$\theta$好像是不随时间变化的==

## Function 2: residualSimilarityModel

`residualSimilarityModel`官方文档：[residualSimilarity](https://ww2.mathworks.cn/help/predmaint/ref/lineardegradationmodel.html)
{: .notice--primary}

该函数是对linear degradation process的建模，用于预测设备RUL。

- Degradation models 是通过预测监测信号何时会越过阈值来估计RUL
- Linear Degradation models适用于：（1）监测信号是对数刻度信号(log scale signal)；或者（2）设备不经历cumulative degradation。

`linearDegradationModel`对象的执行的如下的时间连续线性退化模型(continuous-time linear degradation model)：
$$
S(t)=\phi+\theta(t)+\varepsilon(t)\notag
$$
其中：

- $\phi$为模型截距，是一个常数，可以通过











不经历cumulative degradation。



## Function 3: predictRUL

`predictRUL`官方文档：[predictRUL](https://ww2.mathworks.cn/help/predmaint/ref/lineardegradationmodel.predictrul.html)









## Function XX: ksdensity

`ksdensity`函数
