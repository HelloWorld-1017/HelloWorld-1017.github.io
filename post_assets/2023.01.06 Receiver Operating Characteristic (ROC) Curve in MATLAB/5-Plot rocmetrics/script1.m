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