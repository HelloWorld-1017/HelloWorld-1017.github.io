% https://ww2.mathworks.cn/help/stats/classificationecoc.html
clc, clear, close all
% Load Fisher's iris data set. Specify the predictor data X and the response data Y
load fisheriris
X = meas; % 150-by-4 double, features
Y = species; % 150-by-1 cell, corresponding labels
rng(1); % For reproducibility


% Create an SVM template, and standardize the predictors
t = templateSVM('Standardize',true);

% Train the ECOC classifier, and specify the class order
mdl = fitcecoc(X, Y, 'Learners', t,...
    'ClassNames',{'setosa','versicolor','virginica'});

% Cross-validate Mdl using 10-fold cross-validation
CVmdl = crossval(mdl);

% Estimate the generalized classification error
genError = kfoldLoss(CVmdl);