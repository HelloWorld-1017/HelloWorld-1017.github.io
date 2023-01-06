clc, clear, close all

load ionosphere.mat
rng("default")

% Partion dataset
cv = cvpartition(Y, Holdout=0.2);
XTrain = X(cv.training, :);
YTrain = Y(cv.training);
XTest = X(cv.test, :);
YTest = Y(cv.test);

% Train an SVM classification model
Mdl = fitcsvm(XTrain,YTrain);

% Compute the classification scores for the test set.
[Predictions, Scores] = predict(Mdl, XTest);

save("results.mat", "Predictions", "Scores", "YTest")