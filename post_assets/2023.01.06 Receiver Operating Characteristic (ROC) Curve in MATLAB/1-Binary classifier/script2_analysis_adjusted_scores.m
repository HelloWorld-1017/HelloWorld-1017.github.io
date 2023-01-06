clc, clear, close all

load results.mat

YTest = categorical(YTest);
Predictions = categorical(Predictions);

% Adjust score
AdjustedScore = nan(size(Scores));
AdjustedScore(:, 1) = Scores(:, 1) - Scores(:, 2);
AdjustedScore(:, 2) = Scores(:, 2) - Scores(:, 1);

PredictTable = table(YTest, Predictions, AdjustedScore, 'VariableNames',...
    {'TrueLabel', 'PredictedLabel', 'Score'});
PredictTable = sortrows(PredictTable, "Score");

[FPR_TPR_b_default, FPR_TPR_g_default, acc] = helperCalculateROC(YTest, Predictions);

Thresholds = -ceil(max(abs(AdjustedScore(:)))):0.01:ceil(max(abs(AdjustedScore(:))));
FPR_TPR_ACC_b = nan(numel(Thresholds), 2);
FPR_TPR_ACC_g = nan(numel(Thresholds), 2);
ACC = nan(numel(Thresholds), 1);
for i = 1:numel(Thresholds)
    
    % Soft classification
    threshvalue = Thresholds(i);
    preds = categorical(nan(numel(YTest), 1));
    idx = AdjustedScore(:,1) >= threshvalue;
    preds(idx) = categorical("b");
    preds(~idx) = categorical("g");

    % Get FPR-and-TPR pair
    [FPR_TPR_ACC_b(i,:), FPR_TPR_ACC_g(i,:), ACC(i)] = helperCalculateROC(YTest, preds);
end

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
title("Caculating ROC Using Adjusted Score Matrix")
subtitle(sprintf("AUC(b)=%.4f; AUC(g)=%.4f", AUC_b, AUC_g))

nexttile
rocObj = rocmetrics(YTest, Scores, [categorical("b"), categorical("g")]);
plot(rocObj)
% plot(rocObj, ClassNames="b")
set(gca, 'PlotBoxAspectRatio', [1 1 1])
box(gca, "on")
xlim([0, 1])
ylim([0, 1])

figure
hold(gca, "on")
box(gca, "on")
plot(Thresholds, ACC*100, "b")
scatter(0, acc*100, "filled", "MarkerFaceColor", "r")
xlabel("Threshold")
ylabel("Accuracy (%)")



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