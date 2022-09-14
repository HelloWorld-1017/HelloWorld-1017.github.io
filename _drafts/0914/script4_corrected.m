clc, clear, close all
load simulatedDataset.mat
flow = flow';
labels = labels';

numTimes = 100;
accus = zeros(numTimes, 1);
for i = 1:numel(accus)
    accus(i) = TrainAndTest(flow, labels);
end
accu_ave = mean(accus);
accu_std = std(accus);

sprintf('Average of accuracies is %.4f,\n Standard diviation of accuracies is %.4f', ...
    accu_ave, accu_std)
% 'Average of accuracies is 0.9801,
% Standard diviation of accuracies is 0.0108'

function accu = TrainAndTest(flow, labels)
% Split features of different class 
idx = labels==1;
signals_1 = flow(idx, :);
idx = labels==2;
signals_2 = flow(idx, :);

% Split train and test set
% For class 1
[numRows, ~] = size(signals_1);
idx = randperm(numRows);
idx_train = idx(round(numRows*0.2)+1:end);
signals_1_train = signals_1(idx_train, :);
idx_test = idx(1:round(numRows*0.2));
signals_1_test = signals_1(idx_test, :);
% For class 1
[numRows, ~] = size(signals_2);
idx = randperm(numRows);
idx_train = idx(round(numRows*0.2)+1:end);
signals_2_train = signals_2(idx_train, :);
idx_test = idx(1:round(numRows*0.2));
signals_2_test = signals_2(idx_test, :);

% Caculate mu and Sigma from train set
mu_1 = mean(signals_1_train);
Sigma_1 = cov(signals_1_train);
mu_2 = mean(signals_2_train);
Sigma_2 = cov(signals_2_train);

% Generate the features and the corresponding labels
numPerClass = 1000;
X_generate = [mvnrnd(mu_1, Sigma_1, numPerClass);
    mvnrnd(mu_2, Sigma_2, numPerClass)];
Y_generate = [ones(numPerClass, 1);
    2*ones(numPerClass, 1)];

% Set and train the ECOC classifier using generated dataset
t = templateSVM('Standardize', true);
mdl = fitcecoc(X_generate, Y_generate, 'Learners', t);

% Construct test set, including features and labels
signals_test = [signals_1_test; signals_2_test];
[rows_1, ~] = size(signals_1_test);
[rows_2, ~] = size(signals_2_test);
Y_test = [ones(rows_1, 1); 2*ones(rows_2, 1)];

% Make prediction
pred = mdl.predict(signals_test);
accu = sum(pred==Y_test)/numel(Y_test);
end