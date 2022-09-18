# 特征

首先需要一个condition indicator (1) changing over time，(2) observable and connected with the system degradation process (3) in a reliable, measurable。

预测RUL是预测性维修算法的中心目标。

首先选出很多特征，之后从中选出一个有用特征（Evaluate Features)。选择特征的标准：

monotonicity, trendability, and prognosability，从0到1。

- monotonicity： Monotonicity characterizes the trend of a feature as the system evolves toward failure. As a system gets progressively closer to failure, a suitable condition indicator has a monotonic positive or negative trend. For more information, see monotonicity.
- Prognosability is a measure of the variability of a feature at failure relative to the range between its initial and final values. A more prognosable feature has less variation at failure relative to the range between its initial and final values. For more information, see prognosability.
- Trendability provides a measure of similarity between the trajectories of a feature measured in multiple run-to-failure experiments. Trendability of a candidate condition indicator is defined as the smallest absolute correlation between measurements. For more information, see trendability.

# 模型

## RUL Estimation Using Identified Models or State Estimators

选择模型：The term lifetime or usage time here refers to the life of the machine defined in terms of whatever quantity you use to measure system life.

Units of lifetime can be quantities such as the distance travelled (miles), fuel consumed (gallons), repetition cycles performed, or time since the start of operation (days). Similarly time evolution can mean the evolution of a value with any such quantity.

距离，燃料消耗量，重复执行的循环，日子

- A model 可以拟合特征量随时间变化的曲线，看什么时候穿过阈值
- A model 可以和已知的测量时间序列或者模拟时间序列进行对比。这个模型可以计算最有可能

Predictions from such models are statistical estimates with associated uncertainty. They provide a probability distribution of the RUL of the test machine. The model you use can be:

- 动态模型，System Identification Toolbox
- Specialized Predictive Maintenance Toolbox models designed for computing RUL from different types of measured system data.

和构建诊断模型一样，构建模型和确定特征是迭代进行的

![image-20220915103601800](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/img/image-20220915103601800.png)

When you have an identified dynamic model that describes some aspect of system behavior, you can use that model to forecast future behavior. You can identify such a dynamic model from system data. Or, if you have system data that represents the operation of your machines with time or usage, you can extract condition indicators from that data and track the behavior of the condition indicators with time or usage.

（电阻老化）

动态模型mssest, arx, armax, ar, mlarx

ssest：Estimate a state-space model from time-domain input-output data or frequency-responsedata.

arx, armax, ar: Estimate an autoregressive or moving-average (AR or ARMA) model from timeseries data.

nlarx: Model nonlinear behavior using dynamic nonlinearity estimators such as wavelet
networks, tree-partitioning, and sigmoid networks.

You can use functions like `forecast` to predict the future behavior of the identified model.

RUL estimation with state estimators such as unscentedKalmanFilter, extendedKalmanFilter,
and particleFilter works in a similar way.

## RUL Estimation Using RUL Estimator Models

Predictive Maintenance Toolbox includes some specialized models designed for computing RUL from different types of measured system data. These models are useful when you have historical data and information such as:

- Run-to-failure histories of machines similar to the one you want to diagnose
- A known threshold value of some condition indicator that indicates failure
- Data about how much time or how much usage it took for similar machines to reach failure (lifetime)

工作流：

1. 选择一个最好的RUL估计模型
2. 使用历史数据训练Estimation model，使用`fit`函数
3. 使用测试集进行测试，使用`predictRUL`函数，还可以使用测试集来更新模型

![image-20220915111749336](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/img/image-20220915111749336.png)

### Similarity Models

已知类似的设备的行为的数据库。

- 完整的Run-to-failure数据，从健康状态到故障状态；
- 这些Run-to-failure数据表现出相似的老化行为，the data changes in some characteristic way as the system degrades.

三种模型

### Degradation Models

Degradation models extrapolate past behavior to predict the future condition.

- 线性模型
- 指数模型，指数随机过程

只有单个状态变量时才可以使用退化模型，但是可以降维或者融合特征

### 生存模型

一个统计模型，用于建模time-to-event data。当没有完整的run-to-failure历史数据，但是有：

- 只有关于life span of similar components的数据
- both life spans and some other variable data that correlates with the RUL







