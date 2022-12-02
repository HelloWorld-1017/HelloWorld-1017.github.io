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

exportgraphics(gcf, "results.jpg")

function [data_mean, data_errhigh, data_errlow] = helperErrorLimits(data)
data_mean = mean(data);
data_errhigh = std(data);
data_errlow = std(data);
end














