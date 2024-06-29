---
layout: single
title:  Receiver Operating Characteristic (ROC) Curve in MATLAB
categories: 
 - MATLAB
 - Machine Learning
tags:
 - MATLAB Statistics and Machine Learning Toolbox
date: 2023-01-06 13:37:31 +0800
last_modified_at0: 2023-01-06 13:37:31 +0800
last_modified_at1: 2024-04-23 14:40:04 +0800
---

# ROC and AUC

## ROC Curve

Receiver operating characteristic curve(AKA ROC curve，受试者操作特征曲线)[^1]用于表征二元分类系统的诊断能力。ROC曲线上数据点的横坐标是false positive rate (FPR)，纵坐标是true positive rate (TPR)，每个数据点都对应着一个都对应着一个threshold。TPR也被称作也被称作sensitivity，recall或者probability of detection；FPR也被称作probability of false alarm，fall-out或者1-specificity。

ROC也可以被认为是决策规则的I型误差函数的幂函数图(当性能仅从总体样本中计算时，它可以被认为是这些量的估计量)。【The ROC can also be thought of as a plot of the power as a function of the Type I Error of the decision rule (when the performance is calculated from just a sample of the population, it can be thought of as estimators of these quantities).】通常，如果detection和false alarm的概率分布已知，那么可以通过在y轴上绘制detection probability的累积分布函数以及在x轴上绘制false-alarm的累积分布函数生成ROC曲线。

ROC分析为挑选可能的最优(possibly optimal)模型、独立于成本背景或类别分布丢弃次优模型提供了有利的工具。ROC分析以一种直接和自然的方式与诊断决策的成本/效益分析相关。【ROC analysis is related in a direct and natural way to cost/benefit analysis of diagnostic decision making.】

ROC曲线还被称为是relative operating characteristic curve，因为这条曲线对比了两种operating characteristics——TPR和FPR——随criterion变化的情况。

在机器学习领域，ROC曲线也有着广泛的应用。在训练好一个分类模型后，我们通常会使用指定的测试集数据来测试算法的性能。一个常用的方法是计算总体性能(gross measure of performance)，比如二次损失(quadratic loss)或者准确率，这些指标测量的是算法在整个训练集上的平均性能。我们可以通过绘制ROC曲线和计算性能指标进一步地分析分类器的性能。比如，可以找到最大化分类准确率的threshold，或者评估分类器在high sensitivity和high specificity区域的表现[^2]。

## Area Under ROC Curve (AUC)

ROC曲线与FPR轴所围成的面积对应着ROC关于FPR在区间$[0,1]$上的积分值。AUC值提供了综合所有可能threshold下分类器的performance measure。AUC的取值范围是$[0,1]$，AUC值越大，分类器的性能越好[^3]。

- 完美的分类器总是能给正类样本打上正类的标签，并且对于任何阈值都具有1的TPR。因此，完美的classifier所对应的ROC曲线穿过平面上的点$[0,0]$，$[0,1]$和$[1,1]$，AUC值为1；
- 随机分类器（random classifier）能够返回一个random score，并且对于任何的threshold都具有相同的FPR和TPR值。因此，随机分类器所对应的ROC曲线就落在对角线(diagonal line)上，AUC值为0.5。

<br>

# Ploting ROC Curves

## Confusion Matrix 

ROC曲线的绘制依赖于FPR和TPR值的计算，而FPR和TPR的计算则基于混淆矩阵。二分类问题的混淆矩阵如下表所示：

![image-20230105104620218](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230105104620218.png?raw=true)

其中：

- TP，True Positive
- FN，False Negative
- FP，False Positive
- TN，True Negative

混淆矩阵是比较好记忆的，只需要记住**T(True)或者F(False)都是修饰预测标签的**，就可以简单地推导出来了。

## FPR and TPR

FPR和TPR的计算公式：

![image-20230105103025989](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230105103025989.png?raw=true)

> 默认情况下，混淆矩阵中行和列的顺序都是“先正类后负类”，并且TPR和FPR都是针对“正类”进行计算的。如果我们要针对此时的“负类”计算TPR和FPR，则需要首先将混淆矩阵行和列的顺序对换，再进行相应的计算：
>
> ![image-20230105102959896](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230105102959896.png?raw=true)
>
> 这时候需要注意的是，第一行计算的是FPR，第二行计算的是TPR，和上面的情况是相反的。

除了FPR和TPR，基于混淆矩阵还可以计算出许多其他的指标[^1]：

注：这些指标也都是在默认的“正类”和“负类”下进行计算的。
{: .notice--warning}

![image-20230104222716589](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230104222716589.png?raw=true)

## ROC curve

如前文所述，ROC曲线上的每个数据点都是一个FPR-TPR pair，并且对应着一个threshold。要理解这一点，我们需要从分类器的预测机制说起。

通常而言，如果我们将测试集数据输入到训练好的分类器中，后者将会给出预测标签。但是更精确地讲，在给出预测标签之前，分类器首先会对“测试数据属于某一类别”这个事件给出一个score，然后根据score和预设的threshold来预测测试数据的分类。因此很容易理解，threshold的设置会影响到最终的分类结果。例如，如果二元分类器给observation的score是0.2，那么当threshold为0时（一般情况），分类器会将其预测为P类；而若threshold为0.25，分类器则会将其预测为N类[^4]。

上述这种根据score和threshold进行预测的方式也被称作是软分类。当我们不断调整threshold的设置，测试集的预测标签会发生改变，混淆矩阵也会发生相应的改变，进而导致FPR和TPR值的变化，因此我们就可以获得ROC曲线上的一个一个不同的FPR-TPR pair。

在后面的章节中，我使用MATLAB验证了这一想法，并将结果与MATLAB函数`rocmetrics`的结果进行了对比。

<br>

# Plot ROC Curve for Binary Classifier

本节以二元分类问题为例解释ROC曲线，参考示例来自MATLAB示例“Plot ROC Curve for Binary Classifier”[^5].

## Code Implementation

本示例采用二分类数据集`ionosphere.mat`：

```matlab
load ionosphere.mat
```

```
>> whos X Y
  Name        Size            Bytes  Class     Attributes
  X         351x34            95472  double              
  Y         351x1             37206  cell                
```

其中，`X`为features，`Y`为labels。数据分为两类，分别是`"b"`和`"g"`：

```
>> unique(Y)
ans =
  2×1 cell array
    {'b'}
    {'g'}
```

之后划分数据集，使用训练集训练一个binary SVM classifier，并使用`predict`函数[^6]预测测试集数据的标签`Predictions`和`Scores`：

```matlab
% Partion dataset
cv = cvpartition(Y, Holdout=0.2);
XTrain = X(cv.training, :);
YTrain = Y(cv.training);
XTest = X(cv.test, :);
YTest = Y(cv.test);

% Train an SVM classification model
Mdl = fitcsvm(XTrain, YTrain);

% Compute the classification scores for the test set.
[Predictions, Scores] = predict(Mdl, XTest);
```

将真实标签和预测标签都转换为`categorical`类型的变量：

```matlab
YTest = categorical(YTest);
Predictions = categorical(Predictions);
```

此时可以简单观察一下`Score`和预测标签之间的关系：

```matlab
PredictTable = table(YTest, Predictions, Scores, 'VariableNames',...
    {'TrueLabel', 'PredictedLabel', 'Score'});
PredictTable = sortrows(PredictTable, "Score");
```

```
PredictTable =
  70×3 table
    TrueLabel    PredictedLabel            Score        
    _________    ______________    _____________________

        g              g            -3.5985       3.5985
        g              g            -3.1295       3.1295
        g              g            -2.7863       2.7863
        ...
        g              g           -0.41095      0.41095
        b              g           -0.38885      0.38885
        g              g           -0.25707      0.25707
        b              b           0.052364    -0.052364
        b              b            0.18753     -0.18753
        b              b            0.61398     -0.61398
        ...
        b              b              7.553       -7.553
        b              b             7.7741      -7.7741
```

可以看到，对于二分类SVM classifier：

- 每个observation关于"b"类别和"g"类别的`Score`互为相反数；

- threshold大概在0附近，即当关于"b"类别的Score(`Score`的第一列值)大于0时，分类器预测为"b"类，否则预测为"g"类。


之后，我们自定义一个函数`helperClculateROC`，该函数将真实标签`YTest`和预测标签`Predictions`作为函数输入：

```matlab
function [FPR_TPR_b, FPR_TPR_g, acc] = helperCalculateROC(YTest, Predictions)
% Calcultate confusion matrix
cm = confusionmat(YTest, Predictions, "Order", [categorical("b"), categorical("g")]);

% View "b" as positive class
FPR_b = cm(2,1)/(cm(2,1)+cm(2,2));
TPR_b = cm(1,1)/(cm(1,1)+cm(1,2));

% View "g" as positive class
FPR_g = cm(1,2)/(cm(1,1)+cm(1,2));
TPR_g = cm(2,2)/(cm(2,1)+cm(2,2));

FPR_TPR_b = [FPR_b, TPR_b];
FPR_TPR_g = [FPR_g, TPR_g];

acc = (cm(1,1)+cm(2,2))/sum(cm, "all");
end
```

该函数的输出：

- `FPR_TPR_b`表示以类别"b"作为P类计算得到的FPR-TPR pair；
- `FPR_TPR_g`表示以类别"g"作为P类计算得到的FPR-TPR pair；
- `acc`表示总体的准确率；

对于默认情况下`predict`函数输出的预测标签`Predictions`有：

```matlab
[FPR_TPR_b_default, FPR_TPR_g_default, acc] = helperCalculateROC(YTest, Predictions);
```

```
FPR_TPR_b_default =
    0.0222    0.6800

FPR_TPR_g_default =
    0.3200    0.9778

acc =
    0.8714
```

之后，更改threshold，并根据score值和threshold的关系确定预测标签：当关于"b"类别的Score(`Score`的第一列值)大于threshold时，分类器预测为"b"类，否则预测为"g"类。之后，将真实标签`YTest`和预测标签`preds`传入到函数`helperCalculateROC`得到混淆矩阵，进而得到关于"b"类和关于"g"类的FPR-TPR pair和总体预测准确率：

```matlab
Thresholds = -ceil(max(abs(Scores(:)))):0.01:ceil(max(abs(Scores(:))));
FPR_TPR_ACC_b = nan(numel(Thresholds), 2);
FPR_TPR_ACC_g = nan(numel(Thresholds), 2);
ACC = nan(numel(Thresholds), 1);
for i = 1:numel(Thresholds)
    
    % Soft classification
    threshvalue = Thresholds(i);
    preds = categorical(nan(numel(YTest), 1));
    idx = Scores(:,1) >= threshvalue;
    preds(idx) = categorical("b");
    preds(~idx) = categorical("g");

    % Get FPR-and-TPR pair
    [FPR_TPR_ACC_b(i,:), FPR_TPR_ACC_g(i,:), ACC(i)] = helperCalculateROC(YTest, preds);
end
```

然后，我们绘制出关于"b"类和关于"g"类的ROC曲线，并与MATLAB函数`rocmetrics`的结果进行对比：

```matlab
figure("Units", "pixels", "Position", [222,227,1082,417])
tiledlayout(1,2)
nexttile
set(gca, 'PlotBoxAspectRatio', [1 1 1])
hold(gca, "on")
box(gca, "on")
plot(FPR_TPR_ACC_b(:, 1), FPR_TPR_ACC_b(:, 2), Color="b")
scatter(FPR_TPR_b_default(1), FPR_TPR_b_default(2), "filled", MarkerFaceColor="b")
plot(FPR_TPR_ACC_g(:, 1), FPR_TPR_ACC_g(:, 2), Color="r")
scatter(FPR_TPR_g_default(1), FPR_TPR_g_default(2), "filled", MarkerFaceColor="r")
plot([0,1], [0, 1], "k--")
xlim([0, 1])
ylim([0, 1])
AUC_b = trapz(flipud(FPR_TPR_ACC_b(:, 1)), flipud(FPR_TPR_ACC_b(:, 2)));
AUC_g = trapz(FPR_TPR_ACC_g(:, 1), FPR_TPR_ACC_g(:, 2));
subtitle(sprintf("AUC(b)=%.4f; AUC(g)=%.4f", AUC_b, AUC_g))

nexttile
rocObj = rocmetrics(YTest, Scores, [categorical("b"), categorical("g")]);
plot(rocObj)
set(gca, 'PlotBoxAspectRatio', [1 1 1])
box(gca, "on")
xlim([0, 1])
ylim([0, 1])
```

![image-20230105190707686](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230105190707686.png?raw=true)

可以看到，编写代码得到的结果（左图）与MATLAB函数`rocmetrics`的结果（右图）的结果是一致的。

在上面的实现中，仍然有一些部分需要说明。

## (1) MATLAB `rocmetrics` Function

MATLAB函数`rocmetrics`[^7]用于计算二分类和多分类classifier的ROC曲线和performance metrics：

````matlab
rocObj = rocmetrics(YTest, Scores, [categorical("b"), categorical("g")]);
````

变量`rocObj`是一个`rocmetrics`类的对象，它的属性也非常简单：

```
>> rocObj
rocObj = 
  rocmetrics with properties:
    Metrics: [140×4 table]
        AUC: [0.8587 0.8587]
```

其中的Metrics属性就是绘制ROC曲线的依据：

```
>> rocObj.Metrics
ans =
  140×4 table
    ClassName    Threshold    FalsePositiveRate    TruePositiveRate
    _________    _________    _________________    ________________

        b          15.548              0                    0      
        b          15.548              0                 0.04      
        b          15.106              0                 0.08      
        b          11.425              0                 0.16      
        b          10.079              0                  0.2      

        :            :                :                   :        

        g         -9.9736            0.8                    1      
        g         -10.079           0.84                    1      
        g         -11.425           0.92                    1      
        g         -15.106           0.96                    1      
        g         -15.548              1                    1      
	Display all 140 rows.
```

Tabel的前半部分（ClassName为"b"）用于绘制关于"b"类的ROC曲线，后半部分（ClassName为"g"）用于绘制关于"g"类的ROC曲线。

## (2) Model Operating Point

上面两张图中filled circle marker的位置也是一致的，表示ROC曲线上的model operating point。该点对应着在typical threshold value下得到的FPR和TPR值，在这个问题中，typical threshold value就是0，也就是在之前使用预测标签`Predictions`计算出的FPR和TPR值。

## (3) Calculating AUC: Numerical Interation

求解ROC曲线下的面积AUC对应着一个数值积分问题，MATLAB函数`trapz`[^8]可以满足这个需要。但需要注意的是，该函数计算出的积分值符号是和积分的方向是有关的：

```matlab
clc, clear, close all

X1 = 0:pi/100:pi;
Y1 = sin(X1);

X2 = fliplr(X1);
Y2 = fliplr(Y1);

Q1 = trapz(X1,Y1);
Q2 = trapz(X2,Y2);
```

```
>> Q1,Q2
Q1 =
    1.9998
Q2 =
   -1.9998
```

因此，需要注意AUC值应为正值：

```matlab
AUC_b = trapz(flipud(FPR_TPR_ACC_b(:, 1)), flipud(FPR_TPR_ACC_b(:, 2)));
AUC_g = trapz(FPR_TPR_ACC_g(:, 1), FPR_TPR_ACC_g(:, 2));
```

## (4) Symmetry of Two ROC Curves

实际上，在二分类问题中我们并不需要对两个ROC曲线分别进行测试，因为这两条ROC曲线是对称的，并且AUC值是一致的。对称的原因是：一个分类的TPR值是另一类的TNR值，而$\mathrm{TNR=1-FPR}$，因此一个类别的TPR-FPR曲线和另一类别的(1-FPR)-(1-TRP)曲线是一致的。如果只想绘制关于第一个类别的ROC曲线，只需要指定`ClassNames`的name-value参数即可：

```matlab
plot(rocObj, ClassNames="b")
```

![image-20230105202134903](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230105202134903.png?raw=true)

## (5) Accuracy as the Threshold changes

最后可以绘制一下classifier总体准确率随threshold变化的曲线：

```matlab
figure
hold(gca, "on")
box(gca, "on")
plot(Thresholds, ACC*100, "b")
scatter(0, acc*100, "filled", "MarkerFaceColor", "r")
xlabel("Threshold")
ylabel("Accuracy (%)")
```

![image-20230105211029251](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230105211029251.png?raw=true)

可以看到在model operating point处，总体的准确率基本上就是最高的，此时的threshold基本上是最合适的。

<br>

# Plot ROC Curves for Multiclass Classifier

## One-Versus-All (OVA) Coding Design

> [rocmetrics:One-Versus-All (OVA) Coding Design - MathWorks](https://ww2.mathworks.cn/help/stats/rocmetrics.html#mw_d9f7dc7d-4019-47b7-a295-342aeb2e9fc5_sep_shared-Definition-OVA).

One-Versus-All (OVA) Coding Design可以将多分类问题降为一组二分类的问题。在由这种编码设计得到的每一个二分类问题中，我们都将其中一类视为positve，将其余的类别视为negative。例如，OVA编码设计可以将一个三分类问题转换为3个（$C_3^2$个）二分类问题：

![image-20230105220255127](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230105220255127.png?raw=true)

上表中，每一列对应一个二分类问题，列中的元素对应不同类别的的编码。例如，第一列所对应的二分类问题中Class 1是正类，其他类是负类。`rocmetrics`函数就是基于这种编码模式来计算每一个类别（将其作为正类）的ROC曲线。

## Adjusted Scores for Multiclass Classification Problem

> [rocmetrics: Adjusted Scores for Multiclass Classification Problem - MathWorks](https://ww2.mathworks.cn/help/stats/rocmetrics.html#mw_d9f7dc7d-4019-47b7-a295-342aeb2e9fc5_sep_shared-Algorithm-AdjustedScores_head).

如果我们指定了`rocmetrics`函数的输入参数`Scores`是一个矩阵，那么该函数都会将每一个分类的classification scores进行调整。调整的方式是将observation的score调整为其与其剩余种类scores最大值的差值。例如对于一个三分类问题，如果一个observation输入的原始scores是$[s_1,s_2,s_3]$，则adjusted scores为：

$$
[s_1-\max(s_2,s_3),\ s_2-\max(s_1,s_3),\ s_3-\max(s_1,2_2)]
$$

`rocmetrics`函数会基于adjusted scores计算后续的性能指标。

函数`rocmetircs`的输入参数`Scores`可以接受矩阵输入，也可以接受列向量输入，前者更简单，因为类似`predict`函数就会输出这样的score matrix，因此对于多分类问题我们就以score matrix为例进行分析。

对于简单的二分类问题，我们同样可以指定`Scores`为矩阵或列向量（实际上，传入两者返回的metric values是等价的）。如果传入的是两列矩阵，**那么`rocmetrics`函数会像调整多分类score的方式一样调整score，也就是说二分类问题的score矩阵同样需要调整**，而在上文中我们自己编写的ROC曲线计算过程中是没有考虑到这一点的。于是在此处，我们在代码中加入adjust score的部分：

![image-20230106100654870](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230106100654870.png?raw=true)

并在自定义过程中使用`AdjustedScore`：

![image-20230106100741898](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230106100741898.png?raw=true)

`rocmetrics`函数的输入仍采用未经调整的`Scores`：

![image-20230106100833786](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230106100833786.png?raw=true)

可以看到，ROC曲线的绘制结果以及AUC值并没有发生变化：

![image-20230105224833939](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230105224833939.png?raw=true)

## Code Implementation

在本部分，我们使用多分类数据集`fisheriris.mat`来验证，使用`rocmetrics`函数实现的代码来自文档[^15]。尽管该官方示例采用了交叉验证的方法，和上面的二分类问题有所不同，但第一步还是求得`Scores`：

```matlab
load fisheriris.mat
rng("default")

% Convert to categorical data type
species = categorical(species);

% Train a classification tree
Mdl = fitctree(meas, species, Crossval="on");

% Compute the classification scores for validation-fold observations
[~, Scores] = kfoldPredict(Mdl);
```

接下来就是根据不同的thresholds确定FPR-TPR pair，其中有一些说明的地方。

### Adjust score

上文提到，`rocmetircs`函数会对输入的Score matrix进行调整，我们在编写代码的过程中也需要调整：

```matlab
% Adjust score matrix
AdjustedScores = nan(size(Scores));
AdjustedScores(:,1) = Scores(:,1) - max(Scores(:,2:3), [], 2);
AdjustedScores(:,2) = Scores(:,2) - max(Scores(:,[1,3]), [], 2);
AdjustedScores(:,3) = Scores(:,3) - max(Scores(:,[1,2]), [], 2);
```

并且需要注意的是`AdjustedSocres`需要传入到后面自定义的代码中，例如：

```matlab
[FPR_TPR_setosa(i,1), FPR_TPR_setosa(i,2)]  = ...
    helperCalculateROC(species, AdjustedScores, categorical("setosa"), 1, thresholds(i));
```

而没有调整的`Scores`传入到`rocmetrics`函数中：

```matlab
rocObj = rocmetrics(species, Scores, ...
    [categorical("setosa"), categorical("versicolor"), categorical("virginica")]);
```

一定要注意这一点，否则对比的结果会有所差异。

### Thresholds

在默认情况下，`rocmetrics`函数会依次将adjusted score matrix中每一个distinct value作为threshold[^14]：

![image-20230106094408354](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230106094408354.png?raw=true)

但除此之外，还需要两个additional Thresholds，使得ROC曲线可以通过TPR-FRP曲面上的点$[0,0]$和$[1,1]$：

![image-20230106094608419](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230106094608419.png?raw=true)

因此需要引入两个极端thresholds：

```matlab
thresholds = unique(AdjustedScores(:)); 
thresholds = [-100; thresholds; 100];
```

### Reduce to a set of binary classification problems

之后，我们采用OVA编码策略将这个多分类问题转换成多个二分类问题。对于每一个二分类问题，如果被定为One分类的score值大于threshold，则将其预测为正类，否则预测为负类；另一方面对于真实标签，如果属于One分类，则将视为正类，否则视为负类。以此来构建混淆矩阵，计算FPR和TPR。

```matlab
% Calculte for each thresholds of every binary classification problem
FPR_TPR_setosa = nan(numel(thresholds), 2);
FPR_TPR_versicolor = nan(numel(thresholds), 2);
FPR_TPR_virginica = nan(numel(thresholds), 2);
for i = 1:numel(thresholds)
    % For class "setosa"
    [FPR_TPR_setosa(i,1), FPR_TPR_setosa(i,2)]  = ...
        helperCalculateROC(species, AdjustedScores, categorical("setosa"), 1, thresholds(i));

    % For class "versicolor"
    [FPR_TPR_versicolor(i,1), FPR_TPR_versicolor(i,2)] = ...
        helperCalculateROC(species, AdjustedScores, categorical("versicolor"), 2, thresholds(i));

    % For class "virginica"
    [FPR_TPR_virginica(i,1), FPR_TPR_virginica(i,2)] = ...
        helperCalculateROC(species, AdjustedScores, categorical("virginica"), 3, thresholds(i));
end

function [FPR, TPR] = helperCalculateROC(species, Scores, Class, ClassIdx, threshold)
real = categorical(nan(numel(species),1));
idx = species == Class;
real(idx) = categorical("Positive");
real(~idx) = categorical("Negative");

preds = categorical(nan(numel(species),1));
idx = Scores(:, ClassIdx)>=threshold;
preds(idx) = categorical("Positive");
preds(~idx) = categorical("Negative");

cm = confusionmat(real, preds, ...
    "Order", [categorical("Positive"), categorical("Negative")]);

FPR = cm(2,1)/(cm(2,1)+cm(2,2));
TPR = cm(1,1)/(cm(1,1)+cm(1,2));
end
```

### Comparison

最后，对比上述过程与`rocmetrics`函数得到的结果：

```matlab
% Calculate AUCs
AUC_setosa = trapz(flipud(FPR_TPR_setosa(:, 1)), flipud(FPR_TPR_setosa(:, 2)));
AUC_versicolor = trapz(flipud(FPR_TPR_versicolor(:, 1)), flipud(FPR_TPR_versicolor(:, 2)));
AUC_virginica = trapz(flipud(FPR_TPR_virginica(:, 1)), flipud(FPR_TPR_virginica(:, 2)));

% Model operating points
[FPR_setosa_MOP, TPR_setosa_MOP] = helperCalculateROC(species, AdjustedScores, categorical("setosa"), 1, 0);
[FPR_versicolor_MOP, TPR_versicolor_MOP] = helperCalculateROC(species, AdjustedScores, categorical("versicolor"), 2, 0);
[FPR_virginica_MOP, TPR_virginica_MOP] = helperCalculateROC(species, AdjustedScores, categorical("virginica"), 3, 0);

figure("Units", "pixels", "Position", [222,227,1082,417])
tiledlayout(1,2)
nexttile
set(gca, 'PlotBoxAspectRatio', [1 1 1])
hold(gca, "on")
box(gca, "on")
plot(FPR_TPR_setosa(:, 1), FPR_TPR_setosa(:, 2), ...
    Color="b", DisplayName="setosa"+sprintf(" (AUC=%.4f)", AUC_setosa))
scatter(FPR_setosa_MOP, TPR_setosa_MOP, "filled", MarkerFaceColor="b", ...
    DisplayName="setosa (Model Operating Points)")
plot(FPR_TPR_versicolor(:, 1), FPR_TPR_versicolor(:, 2), ...
    Color="r", DisplayName="versicolor"+sprintf(" (AUC=%.4f)", AUC_versicolor))
scatter(FPR_versicolor_MOP, TPR_versicolor_MOP, "filled", MarkerFaceColor="r", ...
    DisplayName="versicolor (Model Operating Points)")
plot(FPR_TPR_virginica(:, 1), FPR_TPR_virginica(:, 2), ...
    Color="g", DisplayName="virginica"+sprintf(" (AUC=%.4f)", AUC_virginica))
scatter(FPR_virginica_MOP, TPR_virginica_MOP, "filled", MarkerFaceColor="g", ...
    DisplayName="virginica (Model Operating Points)")
plot([0,1], [0, 1], "k--", DisplayName="Random classifier")
xlabel("FPR")
ylabel("TPR")
legend("Location", "southeast");
xlim([0, 1])
ylim([0, 1])

nexttile
rocObj = rocmetrics(species, Scores, ...
    [categorical("setosa"), categorical("versicolor"), categorical("virginica")]);
plot(rocObj)
set(gca, 'PlotBoxAspectRatio', [1 1 1])
box(gca, "on")
xlim([0, 1])
ylim([0, 1])
```

![image-20230106095839299](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230106095839299.png?raw=true)

结果验证了我们自定义获取ROC曲线的有效性。

<br>

# Compare Binary Classifiers

在上面的过程中，无论是简单的二分类问题还是多分类问题，都是只绘制了单个分类器的ROC曲线。除此之外，我们还可以绘制不同分类器的ROC曲线，以对比不同classifiers的分类性能。MATLAB官方示例[^9]就实现了多个分类器分类性能的对比：

```matlab
clc, clear, close all

load census1994

classNames = unique(adultdata.salary);

MdlTree = fitctree(adultdata, "salary", ClassNames=classNames);
MdlGAM = fitcgam(adultdata, "salary", ClassNames=classNames); 
MdlNB = fitcnb(adultdata, "salary", ClassNames=classNames);

[~, ScoresTree] = predict(MdlTree,adulttest);
[~, ScoresGAM] = predict(MdlGAM,adulttest);
[~, ScoresNB] = predict(MdlNB,adulttest);

rocTree = rocmetrics(adulttest.salary, ScoresTree, classNames);
rocGAM = rocmetrics(adulttest.salary, ScoresGAM, classNames);
rocNB = rocmetrics(adulttest.salary, ScoresNB, classNames);

figure
c = cell(3,1);
g = cell(3,1);
[c{1},g{1}] = plot(rocTree,ClassNames=classNames(1));
hold(gca, "on")
[c{2},g{2}] = plot(rocGAM,ClassNames=classNames(1));
[c{3},g{3}] = plot(rocNB,ClassNames=classNames(1));
modelNames = ["Decision Tree Model", ...
    "Generalized Additive Model","Naive Bayes Model"];
for i = 1 : 3
    c{i}.DisplayName = replace(c{i}.DisplayName, ...
        string(classNames(1)),modelNames(i));
    g{i}(1).DisplayName = join([modelNames(i),"Operating Point"]);
end
box(gca, "on")
```

![image-20230106103831816](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230106103831816.png?raw=true)

示例采用的数据集为`census1994`，是一个二分类数据集：

```
classNames = 
  2×1 categorical array
     <=50K 
     >50K 
```

上图中对比了三个分类器关于分类`<=50K `的ROC曲线，结论是分类器Generalized Additive Model具有最高的AUC值，因而具有最好的平均表现；而Decision Tree Model的效果是最差的。并且，根据前面的结论，在二分类问题的情况下，同一个分类器的两个ROC曲线具有对称性，且AUC值相同，因此只考察分类`<=50K `的ROC曲线即可。但是，我们仍然可以绘制出`>50K `分类的曲线：

![image-20230106110727332](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230106110727332.png?raw=true)

得到的结论是一致的。

<br>

# Compare Multiclass Classifiers

在多分类问题的背景下比较不同分类器的平均性能可能更加具有实践意义。多分类分类器的平均性能需要综合考虑各个分类的ROC曲线，平均的方式有三种[^10]：

![image-20230106114625023](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230106114625023.png?raw=true)

MATLAB官方文档[^11]中有更详细的解释：

![image-20230106101550286](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230106101550286.png?raw=true)

我不是太能理解Micro-averaging（微平均）中所描述的： treating all one-versus-all binary classification problems as one binary classification problem。幸运的是，在这三种所支持的平均方式中，最容易理解也是最常见的平均方式是Macro-averaging（宏平均），简单地讲，这种方式就是将每一个threshold对应的所有分类的FPR-TPR pair直接平均。

仍然以上文所使用的多分类数据集`fisheriris.mat`为例，分别使用三种方式求出分类器的平均性能：

- 第一种方式是针对上文中所自定义的ROC计算过程：

  ```matlab
  FPR_TPR_macro = (FPR_TPR_setosa+FPR_TPR_versicolor+FPR_TPR_virginica)/3;
  AUC_macro = trapz(flipud(FPR_TPR_macro(:,1)), flipud(FPR_TPR_macro(:,2)));
  ```

- 第二种方式是通过`rocmetrics`函数得到 one-versus-all ROC curve后，使用`average`函数[^12]计算average ROC curve：

  ```matlab
  rocObj = rocmetrics(species, Scores, Mdl.ClassNames);
  [FPR, TPR, Thresholds, AUC] = average(rocObj, "macro");
  ```

- 第三种方式是通过设置`plot`函数的`AverageROCType`参数绘制ROC曲线：

  ```matlab
  plot(rocObj,AverageROCType="macro",ClassNames=[])
  ```

全部代码如下：

```matlab
clc, clear, close all

load fisheriris.mat
rng("default")

% Convert to categorical data type
species = categorical(species);

% Train a classification tree
Mdl = fitctree(meas, species, Crossval="on");

% Compute the classification scores for validation-fold observations
[~, Scores] = kfoldPredict(Mdl);

% Adjust score matrix
AdjustedScores = nan(size(Scores));
AdjustedScores(:,1) = Scores(:,1) - max(Scores(:,2:3), [], 2);
AdjustedScores(:,2) = Scores(:,2) - max(Scores(:,[1,3]), [], 2);
AdjustedScores(:,3) = Scores(:,3) - max(Scores(:,[1,2]), [], 2);

% Add additional thresholds
thresholds = unique(AdjustedScores(:)); 
thresholds = [-100; thresholds; 100];

% Calculte for each thresholds of every binary classification problem
FPR_TPR_setosa = nan(numel(thresholds), 2);
FPR_TPR_versicolor = nan(numel(thresholds), 2);
FPR_TPR_virginica = nan(numel(thresholds), 2);
for i = 1:numel(thresholds)
    % For class "setosa"
    [FPR_TPR_setosa(i,1), FPR_TPR_setosa(i,2)]  = ...
        helperCalculateROC(species, AdjustedScores, categorical("setosa"), 1, thresholds(i));

    % For class "versicolor"
    [FPR_TPR_versicolor(i,1), FPR_TPR_versicolor(i,2)] = ...
        helperCalculateROC(species, AdjustedScores, categorical("versicolor"), 2, thresholds(i));

    % For class "virginica"
    [FPR_TPR_virginica(i,1), FPR_TPR_virginica(i,2)] = ...
        helperCalculateROC(species, AdjustedScores, categorical("virginica"), 3, thresholds(i));
end


figure("Units", "pixels", "Position", [198,363,1189,321])
tiledlayout(1,3)

nexttile
hold(gca, "on")
box(gca, "on")
set(gca, 'PlotBoxAspectRatio', [1 1 1])
FPR_TPR_macro = (FPR_TPR_setosa+FPR_TPR_versicolor+FPR_TPR_virginica)/3;
AUC_macro = trapz(flipud(FPR_TPR_macro(:,1)), flipud(FPR_TPR_macro(:,2)));
plot(FPR_TPR_macro(:,1), FPR_TPR_macro(:,2), DisplayName="AUC="+num2str(AUC_macro))
plot([0,1], [0, 1], "k--", DisplayName="Random classifier")
xlabel("FPR")
ylabel("TPR")
xlim([0, 1])
ylim([0, 1])
legend("Location", "southeast")
title("Average ROC Curve")


nexttile
set(gca, 'PlotBoxAspectRatio', [1 1 1])
rocObj = rocmetrics(species, Scores, Mdl.ClassNames);
[FPR, TPR, Thresholds, AUC] = average(rocObj, "macro");
plot([0;FPR],[0;TPR])
xlabel("False Positive Rate")
ylabel("True Positive Rate")
title("Average ROC Curve")
hold on
plot([0,1],[0,1],"k--")
legend(join(["Macro-average (AUC =",AUC,")"]), ...
    Location="southeast")
axis padded
hold off
xlim([0, 1])
ylim([0, 1])

nexttile
plot(rocObj,AverageROCType="macro",ClassNames=[])
set(gca, 'PlotBoxAspectRatio', [1 1 1])
box(gca, "on")
xlim([0, 1])
ylim([0, 1])

function [FPR, TPR] = helperCalculateROC(species, Scores, Class, ClassIdx, threshold)
real = categorical(nan(numel(species),1));
idx = species == Class;
real(idx) = categorical("Positive");
real(~idx) = categorical("Negative");

preds = categorical(nan(numel(species),1));
idx = Scores(:, ClassIdx)>=threshold;
preds(idx) = categorical("Positive");
preds(~idx) = categorical("Negative");

cm = confusionmat(real, preds, ...
    "Order", [categorical("Positive"), categorical("Negative")]);

FPR = cm(2,1)/(cm(2,1)+cm(2,2));
TPR = cm(1,1)/(cm(1,1)+cm(1,2));
end
```

![image-20230106120435444](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230106120435444.png?raw=true)

三种方式的结果是一致的~ Niceヾ(≧▽≦*)o

<br>

# Custom Plotting Based on Results of `rocmetrics` 

通过上文自定义计算的过程，我们确认了ROC曲线的计算思路，之后我们就可以放心地使用`rocmetrics`函数计算。但是，在绘制ROC曲线时，上文使用object function绘制曲线的方式，即`plot(rocObj)`，有些僵硬，无法适用于更加灵活的绘图需求，因此我们需要掌握基于`rocmetrics`中保存的计算结果绘制ROC曲线的方法。想要复刻代码`plot(rocObj)`的绘制效果，主要获取以下信息：

- ROC曲线和AUC值

  ```matlab
  idx = rocObj.Metrics.ClassName==categorical("setosa");
  FPR = rocObj.Metrics.FalsePositiveRate(idx);
  TPR = rocObj.Metrics.TruePositiveRate(idx);
  plot(FPR, TPR, DisplayName="setosa AUC="+num2str(rocObj.AUC(1)), Color="r")
  ```

- Model operating point[^13]：

  ```matlab
  X = rocObj.Metrics(idx,:).FalsePositiveRate;
  Y = rocObj.Metrics(idx,:).TruePositiveRate;
  T = rocObj.Metrics(idx,:).Threshold;
  idx_model = find(T>=0, 1, "last");
  scatter(X(idx_model), Y(idx_model), "filled", ...
      MarkerFaceColor="r", DisplayName="setosa Model Operating Point")
  ```

仍然以三分类数据集`fisheriris`为例展示上述绘图代码的效果：

```matlab
clc, clear, close all

load fisheriris.mat
rng("default")

% Convert to categorical data type
species = categorical(species);

% Train a classification tree
Mdl = fitctree(meas, species, Crossval="on");

% Compute the classification scores for validation-fold observations
[~, Scores] = kfoldPredict(Mdl);

rocObj = rocmetrics(species, Scores, ...
    [categorical("setosa"), categorical("versicolor"), categorical("virginica")]);

figure("Units", "pixels", "Position", [400,326,1096,440])
tiledlayout(1, 2)
nexttile
plot(rocObj)
xlim([0,1])
ylim([0,1])
box(gca, "on")

nexttile
hold(gca, "on")
box(gca, "on")
set(gca, 'PlotBoxAspectRatio', [1 1 1])
% For class "setosa"
idx = rocObj.Metrics.ClassName==categorical("setosa");
FPR = rocObj.Metrics.FalsePositiveRate(idx);
TPR = rocObj.Metrics.TruePositiveRate(idx);
plot(FPR, TPR, DisplayName="setosa AUC="+num2str(rocObj.AUC(1)), Color="r")
% Get model operating point
X = rocObj.Metrics(idx,:).FalsePositiveRate;
Y = rocObj.Metrics(idx,:).TruePositiveRate;
T = rocObj.Metrics(idx,:).Threshold;
idx_model = find(T>=0, 1, "last");
scatter(X(idx_model), Y(idx_model), "filled", ...
    MarkerFaceColor="r", DisplayName="setosa Model Operating Point")

% For class "versicolor"
idx = rocObj.Metrics.ClassName==categorical("versicolor");
FPR = rocObj.Metrics.FalsePositiveRate(idx);
TPR = rocObj.Metrics.TruePositiveRate(idx);
plot(FPR, TPR, DisplayName="versicolor AUC="+num2str(rocObj.AUC(2)), Color="g")
% Get model operating point
X = rocObj.Metrics(idx,:).FalsePositiveRate;
Y = rocObj.Metrics(idx,:).TruePositiveRate;
T = rocObj.Metrics(idx,:).Threshold;
idx_model = find(T>=0, 1, "last");
scatter(X(idx_model), Y(idx_model), "filled", ...
    MarkerFaceColor="g", DisplayName="versicolor Model Operating Point")

% For class "virginica"
idx = rocObj.Metrics.ClassName==categorical("virginica");
FPR = rocObj.Metrics.FalsePositiveRate(idx);
TPR = rocObj.Metrics.TruePositiveRate(idx);
plot(FPR, TPR, DisplayName="virginica AUC="+num2str(rocObj.AUC(3)), Color="b")
% Get model operating point
X = rocObj.Metrics(idx,:).FalsePositiveRate;
Y = rocObj.Metrics(idx,:).TruePositiveRate;
T = rocObj.Metrics(idx,:).Threshold;
idx_model = find(T>=0, 1, "last");
scatter(X(idx_model), Y(idx_model), "filled", ...
    MarkerFaceColor="b", DisplayName="virginica Model Operating Point")

legend("Location", "southeast")
```

![image-20230106194839612](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230106194839612.png?raw=true)

<br>

# References

[^1]: [Receiver operating characteristic - Wikipedia](https://en.wikipedia.org/wiki/Receiver_operating_characteristic).
[^2]: [ROC Curve and Performance Metrics: Introduction to ROC Curve - MathWorks](https://ww2.mathworks.cn/help/stats/performance-curves.html#mw_0b428fd7-9376-4f08-9f70-4f4bcfea7547).
[^3]: [ROC Curve and Performance Metrics: Area Under ROC Curve (AUC) - MathWorks](https://ww2.mathworks.cn/help/stats/performance-curves.html#mw_c996e1a2-3800-4e33-bd73-68cc67bb1ccc).
[^4]: [ROC Curve and Performance Metrics: Receiver Operating Characteriestic (ROC) Curve - MathWorks](https://ww2.mathworks.cn/help/stats/performance-curves.html#mw_7d6e3119-05c2-451f-956e-5b2f34edb8a7).
[^5]: [MATLAB `rocmetrics`: Plot ROC Curve for Binary Classifier - MathWorks](https://ww2.mathworks.cn/help/stats/rocmetrics.html#mw_42218da9-f74c-4ad9-8009-5e7e7e1aebdd).
[^6]: [MATLAB `predict`: Classify observations using support vector machine (SVM) classifier - MathWorks](https://ww2.mathworks.cn/help/stats/classreg.learning.classif.compactclassificationsvm.predict.html).
[^7]: [MATLAB `rocmetrics`: Receiver operating characteristic (ROC) curve and performance metrics for binary and multiclass classifiers - MathWorks](https://ww2.mathworks.cn/help/stats/rocmetrics.html).
[^8]: [MATLAB `trapz`: Trapezoidal numerical integration - MathWorks](https://ww2.mathworks.cn/help/matlab/ref/trapz.html).
[^9]: [MATLAB `rocmetrics`: Compare Classification Models - MathWorks](https://ww2.mathworks.cn/help/stats/rocmetrics.html#mw_d693d08c-37ce-44ae-922f-31756b6a246f).
[^10]: [MATLAB `average`: Averaging method - MathWorks](https://ww2.mathworks.cn/help/stats/rocmetrics.average.html#mw_9320ccb8-e4af-41eb-a4fc-87395190101b).
[^11]: [ROC Curve and Performance Metrics: Average of Performance Metrics - MathWorks](https://ww2.mathworks.cn/help/stats/performance-curves.html#mw_0b698efc-b4aa-476f-ac10-7c1c3e5d3778).
[^12]: [MATLAB `average`: Compute performance metrics for average receiver operating characteristic (ROC) curve in multiclass problem - MathWorks](https://ww2.mathworks.cn/help/stats/rocmetrics.average.html).
[^13]: [MATLAB `rocmatrics`: Find Model Operating Point and Optimal Operating Point - MathWorks](https://ww2.mathworks.cn/help/stats/rocmetrics.html#mw_19cecf83-7dec-48be-85ce-858315887dbe).
[^14]: [ROC Curve and Performance Metrics: Thresholds, Fixed Metric, and Fixed Metric Values - MathWorks](https://ww2.mathworks.cn/help/stats/performance-curves.html#mw_4ed5490d-fa83-4f34-9fad-cc3c63daa2d2).
[^15]: [rocmetrics: Plot ROC Curves for Multiclass Classifier - MathWorks](https://ww2.mathworks.cn/help/stats/rocmetrics.html#mw_5e951e43-2be4-45aa-973a-85d45b9d14f2).

