% % Standardize the train set and test set with mu and sigma of train set
clc, clear, close all
% Load dataset
load fisheriris
% rng('default')

numEpoches = 5e2;
accuracy1 = ones(numEpoches, 1);
accuracy2 = ones(numEpoches, 1);
contrast = ones(numEpoches, 1);

for i = 1:numEpoches
    [mdl, accuracy1(i), accuracy2(i), contrast(i)] = contrastBuiltandSelfpredict(meas, species);
end
figure('Units', 'pixels', 'Position', [769, 313, 727, 692])
tiledlayout(2, 1)
nexttile
hold on
plot(accuracy1, LineWidth=1.5, Marker='.', MarkerSize=10)
plot(accuracy2, LineWidth=1.5, Marker='x', MarkerSize=10)
legend('Buit-in predict function', 'Custom prediction process', 'Location', 'best')
title('Contrast of predictive results of built-in predict function and custom prediction process')
grid on
box on

nexttile
plot(contrast, LineWidth=1.5, Marker='.', MarkerSize=10)
title(['The ratio of equally predictive results: ' num2str(sum(contrast == 1)/numel(contrast))])
grid on
box on

function [mdl, accuracy1, accuracy2, contrast] = contrastBuiltandSelfpredict(features, labels)
% Get paramaters of dataset
labels = categorical(labels);
ClassName = categories(labels); % Class name
numClasses = size(ClassName, 1); % Class number

% Partition data
cv = cvpartition(labels, 'Holdout', randperm(5, 1)/10);
X_train = features(cv.training, :);
Y_train = labels(cv.training);
X_test = features(cv.test, :);
Y_test = labels(cv.test);
numTrain = numel(Y_train);
numTest = numel(Y_test);

% Standardize the train set and test set with mu and sigma of train set
mu_train = mean(X_train);
sigma_train = std(X_train);
X_train = (X_train-repmat(mu_train, numTrain, 1))./repmat(sigma_train, numTrain, 1);
X_test = (X_test-repmat(mu_train, numTest, 1))./repmat(sigma_train, numTest, 1);

% Fit a DNN
mdl = fitcnet(X_train, Y_train, 'LayerSizes', [7, 5], 'Activations', 'sigmoid', 'Standardize', false);

% Predict using 'predict' method
prediction1 = mdl.predict(X_test);
accuracy1 = sum(prediction1==Y_test)/numel(Y_test);

% Predict using forward process
sigmoidFcn = @(x) 1/(1+exp(-x));
o1 = arrayfun(sigmoidFcn, X_test*mdl.LayerWeights{1}'+repmat(mdl.LayerBiases{1}, 1, numTest)');
o2 = arrayfun(sigmoidFcn, o1*mdl.LayerWeights{2}'+repmat(mdl.LayerBiases{2}, 1, numTest)');
o3 = o2*mdl.LayerWeights{3}'+repmat(mdl.LayerBiases{3}, 1, numTest)';
o3 = exp(o3)./repmat(sum(exp(o3), 2), 1, numClasses);
[~, I] = max(o3, [], 2);
prediction2 = categorical(I, [1, 2, 3], ClassName);
accuracy2 = sum(prediction2==Y_test)/numel(Y_test);

% Contrast two results of predictions
contrast = sum(prediction1 == prediction2)/numTest;
end