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