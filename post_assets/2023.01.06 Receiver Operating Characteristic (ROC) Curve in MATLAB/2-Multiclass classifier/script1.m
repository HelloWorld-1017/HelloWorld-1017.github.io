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