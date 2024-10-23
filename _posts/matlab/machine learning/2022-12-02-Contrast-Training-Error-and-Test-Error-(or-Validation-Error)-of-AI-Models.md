---
title: Contrast Training Error and Test Error (or Validation Error) of AI Models
categories: 
 - MATLAB
 - Machine Learning
tags:
 - MATLAB Statistics and Machine Learning Toolbox
date: 2022-12-02 12:26:23 +0800
last_modified_at: 2024-10-23 19:55:19 +0800
---

# Introduction

在评价机器学习模型性能时，人们最关注的总是测试准确率(即测试误差的一种体现)，但仅仅关注测试准确率其实是片面的。根据机器学习理论关于模型泛化能力的观点(详见[Generalization of the Artificial Neural Networks](http://whatastarrynight.com/machine%20learning/Generalization-of-the-artificial-neural-networks/))，训练误差的具体大小，以及训练误差和测试误差之间的差值同样很重要，因为前者反映了模型是否欠拟合，而后者则反映了模型是否过拟合。

应当区分的是，当“测试误差”用于在训练过程中，以为训练提供额外的信息时，实际上它是验证误差；真正使用测试误差与训练误差评估模型拟合效果是在整个模型训练之后进行的。下面一个例子为例就分别介绍这两种情形。

<br>

# Stop the training process early using Training error and validation error

MATLAB提供了一个简单的拟合用于分类问题的神经网络函数`fitcnet`，它的输出中包含训练信息。并且在`fitcnet`文档中提供了一个“训练早停”策略的示例([fitcnet: Stop Neural Network Training Early Using Validation Data](https://ww2.mathworks.cn/help/stats/fitcnet.html#mw_d5cde214-3dc8-4fd5-8dc0-56ec49efcb1e))，其中用到了训练过程中的训练误差和验证误差(交叉熵损失)。

首先加载patients数据集，将其转换为`table`变量，并将`Smoker`作为response，将其余特征作为predictors：

```matlab
load patients
tbl = table(Diastolic,Systolic,Gender,Height,Weight,Age,Smoker);
```

之后，划分数据集为训练集和验证集：

注：这里并没有留出test set。
{: .notice--warning}

```matlab
rng("default") % For reproducibility of the partition
c = cvpartition(tbl.Smoker,"Holdout",0.30);
trainingIndices = training(c);
validationIndices = test(c);
tblTrain = tbl(trainingIndices,:);
tblValidation = tbl(validationIndices,:);
```

使用训练集训练神经网络，需要指定验证集：

```matlab
Mdl = fitcnet(tblTrain,"Smoker", ...
    "ValidationData",tblValidation, ...
    "Verbose",1);
```

其中，`"verbose", 1`表示在命令行中打印训练迭代信息。

运行后，变量`Mdl.TrainingHistory`就包含了训练过程中的训练误差和验证误差：

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20221201195921492.png" alt="image-20221201195921492" style="zoom:67%;" />

将它们取出来，并绘制迭代图像：

```matlab
iteration = Mdl.TrainingHistory.Iteration;
trainLosses = Mdl.TrainingHistory.TrainingLoss;
valLosses = Mdl.TrainingHistory.ValidationLoss;

plot(iteration,trainLosses,iteration,valLosses)
legend(["Training","Validation"])
xlabel("Iteration")
ylabel("Cross-Entropy Loss")
```

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20221201200031354.png?raw=true" alt="image-20221201200031354" style="zoom: 67%;" />

之后，找到最小的验证集损失所对应的训练轮数：

```matlab
[~,minIdx] = min(valLosses);
iteration(minIdx)
```

```matlab
ans =
    19
```

表明第19轮训练得到的验证集误差是最小的。并且，最终返回的`Mdl`的参数就是第19轮所得到的参数。

<br>

# Model evaluation using training error and test error

根据上一节最后一张训练误差与验证误差的图，我们可以看到在训练过程中模型的拟合情况。但严谨地讲，使用测试误差与训练误差评估模型拟合效果是在整个模型训练之后进行的，因为测试集是“不可观测的”。仍然使用上面的例子进行分析。

首先还是加载数据集，划分数据集，但是此时就将数据集划分成训练集和测试集，训练集用于训练模型。模型训练完成后，借助`loss`函数计算训练集的交叉熵损失和测试集的交叉熵损失。除此之外：

- 预测准确率也是误差的一种表现形式，我们再观察一下训练准确率和测试准确率的差异；
- 为了能够从拟合的角度对比模型，我们再引入一个SVM分类模型；
- 最后，将这样的过程进行数轮(100 轮)，从统计的角度分析对比神经网络和SVM模型的拟合状况。

```matlab
clc, clear, close all

load patients
tbl = table(Diastolic,Systolic,Gender,Height,Weight,Age,Smoker);

% rng("default") % For reproducibility of the partition

numTimes = 2;

TrainLoss_nn = nan(numTimes, 1);
TrainAccu_nn = nan(numTimes, 1);
TrainLoss_svm = nan(numTimes, 1);
TrainAccu_svm = nan(numTimes, 1);
TestLoss_nn = nan(numTimes, 1);
TestAccu_nn = nan(numTimes, 1);
TestLoss_svm = nan(numTimes, 1);
TestAccu_svm = nan(numTimes, 1);

for i = 1:numTimes
    % Partition dataset
    c = cvpartition(tbl.Smoker, "Holdout", 0.30);
    trainingIndices = training(c);
    testIndices = test(c);
    tblTrain = tbl(trainingIndices,:);
    tblTest = tbl(testIndices,:);

    % NN
    mdl_nn = fitcnet(tblTrain, "Smoker", "Standardize", true);
    TrainLoss_nn(i) = loss(mdl_nn, tblTrain, "Smoker", "LossFun", "crossentropy");
    TrainAccu_nn(i) = sum(predict(mdl_nn, tblTrain)==tblTrain.Smoker)/numel(tblTrain.Smoker);
    TestLoss_nn(i) = loss(mdl_nn, tblTest, "Smoker", "LossFun", "crossentropy");
    TestAccu_nn(i) = sum(predict(mdl_nn, tblTest)==tblTest.Smoker)/numel(tblTest.Smoker);

    % SVM
    mdl_svm = fitcecoc(tblTrain, "Smoker", 'Learners', templateSVM('Standardize', true));
    TrainLoss_svm(i) = loss(mdl_svm, tblTrain, "Smoker", "LossFun", "crossentropy");
    TrainAccu_svm(i) = sum(predict(mdl_svm, tblTrain)==tblTrain.Smoker)/numel(tblTrain.Smoker);
    TestLoss_svm(i) = loss(mdl_svm, tblTest, "Smoker", "LossFun", "crossentropy");
    TestAccu_svm(i) = sum(predict(mdl_svm, tblTest)==tblTest.Smoker)/numel(tblTest.Smoker);
end

[TrainLoss_nn_mean, TrainLoss_nn_errhigh, TrainLoss_nn_errlow] = helperErrorLimits(TrainLoss_nn);
[TrainAccu_nn_mean, TrainAccu_nn_errhigh, TrainAccu_nn_errlow] = helperErrorLimits(TrainAccu_nn);
[TestLoss_nn_mean, TestLoss_nn_errhigh, TestLoss_nn_errlow] = helperErrorLimits(TestLoss_nn);
[TestAccu_nn_mean, TestAccu_nn_errhigh, TestAccu_nn_errlow] = helperErrorLimits(TestAccu_nn);
[TrainLoss_svm_mean, TrainLoss_svm_errhigh, TrainLoss_svm_errlow] = helperErrorLimits(TrainLoss_svm);
[TrainAccu_svm_mean, TrainAccu_svm_errhigh, TrainAccu_svm_errlow] = helperErrorLimits(TrainAccu_svm);
[TestLoss_svm_mean, TestLoss_svm_errhigh, TestLoss_svm_errlow] = helperErrorLimits(TestLoss_svm);
[TestAccu_svm_mean, TestAccu_svm_errhigh, TestAccu_svm_errlow] = helperErrorLimits(TestAccu_svm);

% Plot bar chart with error bars
figure("Units", "pixels", "Position", [712.33, 387.66, 1046.66, 406.66])
tiledlayout(1, 2)
TrainingColor = [7, 84, 213]/255;
TestColor = [249, 82, 107]/255;
X = categorical({'NN', 'SVM'});

nexttile
ax = gca;
hold(ax, "on")
box(ax, "on")
ax.LineWidth = 1.2;
% Plot bars
bar1 = bar(X, [TrainLoss_nn_mean, TestLoss_nn_mean; ...
    TrainLoss_svm_mean, TestLoss_svm_mean]);
bar1(1).FaceColor = TrainingColor;
bar1(2).FaceColor = TestColor;
ylabel("Cross-entropy loss")
legend("Training", "Test", "Location", "northoutside", "Orientation", "horizontal")

% Plot error bar for training loss
err1 = errorbar(bar1(1).XEndPoints, ...
    [TrainLoss_nn_mean, TrainLoss_svm_mean], ...
    [TrainLoss_nn_errlow, TrainLoss_svm_errlow], ...
    [TrainLoss_nn_errhigh, TrainLoss_svm_errhigh], 'handlevisibility', 'off');
err1.Color = [0 0 0];
err1.LineStyle = 'none';  
err1.LineWidth = 1.5;
% Plot error bar for test loss
err2 = errorbar(bar1(2).XEndPoints, ...
    [TestLoss_nn_mean, TestLoss_svm_mean], ...
    [TestLoss_nn_errlow, TestLoss_svm_errlow], ...
    [TestLoss_nn_errhigh, TestLoss_svm_errhigh], 'handlevisibility', 'off');
err2.Color = [0 0 0];
err2.LineStyle = 'none';
err2.LineWidth = 1.5;


nexttile
ax = gca;
hold(ax, "on")
box(ax, "on")
ax.LineWidth = 1.2;
% Plot bars
bar2 = bar(X, [TrainAccu_nn_mean, TestAccu_nn_mean; ...
    TrainAccu_svm_mean, TestAccu_svm_mean]);
bar2(1).FaceColor = TrainingColor;
bar2(2).FaceColor = TestColor;
ylabel("Accuracies")
legend("Train", "Test", "Location", "northoutside", "Orientation", "horizontal")

% Plot error bar for training accuracies
err3 = errorbar(bar1(1).XEndPoints, ...
    [TrainAccu_nn_mean, TrainAccu_svm_mean], ...
    [TrainAccu_nn_errlow, TrainAccu_svm_errlow], ...
    [TrainAccu_nn_errhigh, TrainAccu_svm_errhigh], 'handlevisibility', 'off');
err3.Color = [0 0 0];
err3.LineStyle = 'none';  
err3.LineWidth = 1.5;
% Plot error bar for test accuracies
err4 = errorbar(bar1(2).XEndPoints, ...
    [TestAccu_nn_mean, TestAccu_svm_mean], ...
    [TestAccu_nn_errlow, TestAccu_svm_errlow], ...
    [TestAccu_nn_errhigh, TestAccu_svm_errhigh], 'handlevisibility', 'off');
err4.Color = [0 0 0];
err4.LineStyle = 'none';
err4.LineWidth = 1.5;

exportgraphics(gcf, "results.jpg?raw=true")

function [data_mean, data_errhigh, data_errlow] = helperErrorLimits(data)
data_mean = mean(data);
data_errhigh = std(data);
data_errlow = std(data);
end
```

![results](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/results.jpg?raw=true)

由误差图像可以看出：

- NN的欠拟合现象较轻，过拟合现象比较严重；
- SVM的过拟合现象不明显，欠拟合现象比较严重。

由准确率图像可以看出：

- NN的欠拟合现象较轻，过拟合现象较严重；
- SVM的过拟合现象不明显，而欠拟合现象较严重。

两个图像得到的结论是一致的。过拟合的模型泛化能力较弱，因此我们倾向于使用SVM模型进行分类。

但是为什么SVM模型的test loss比NN高这么多，但是test accuracy反而比SVM高呢？从另一个方面讲，NN的test loss很小，其test accuracy应该更高才对，但是为什么反过来了呢？在网上查找了一些资料，大部分的解释是：此时训练出的模型比较极端，极端预测的错误抬升了Loss值，而出现这种极端的模型的原因是训练数据和测试数据分布不一致。在实际使用时，我们常常关注准确率。

<br>

**Reference**

[1] [fitcnet - MathWorks](https://ww2.mathworks.cn/help/stats/fitcnet.html).

[2] [loss - MathWorks](https://ww2.mathworks.cn/help/stats/classificationknn.loss.html).
