clc, clear, close all

load ovariancancer.mat

numTimes = 100;
accus = zeros(numTimes, 1);
for i = 1:numel(accus)
    accus(i) = TrainAndTest(obs, grp);
end
accu_ave = mean(accus);
accu_std = std(accus);

sprintf('Average of accuracies is %.4f,\n Standard diviation of accuracies is %.4f', ...
    accu_ave, accu_std)
% 'Average of accuracies is 0.9777,
%   Standard diviation of accuracies is 0.0175'

function accu = TrainAndTest(obs, grp)
% Split features of different class 
idx = strcmp(grp, "Cancer");
Features_cancer = obs(idx, :);
idx = strcmp(grp, "Normal");
Features_normal = obs(idx, :);

% Split train and test set
% For class 'Cancer'
[numRows, ~] = size(Features_cancer);
idx = randperm(numRows);
idx_train = idx(round(numRows*0.2)+1:end);
Features_cancer_train = Features_cancer(idx_train, :);
idx_test = idx(1:round(numRows*0.2));
Features_cancer_test = Features_cancer(idx_test, :);
% For class 'Normal'
[numRows, ~] = size(Features_normal);
idx = randperm(numRows);
idx_train = idx(round(numRows*0.2)+1:end);
Features_normal_train = Features_normal(idx_train, :);
idx_test = idx(1:round(numRows*0.2));
Features_normal_test = Features_normal(idx_test, :);

% Caculate mu and Sigma from train set
mu_cancer = mean(Features_cancer_train);
Sigma_cancer = cov(Features_cancer_train);
mu_normal = mean(Features_normal_train);
SIgma_normal = cov(Features_normal_train);

% Generate the features and the corresponding labels
numPerClass = 1000;
X_generate = [mvnrnd(mu_cancer, Sigma_cancer, numPerClass);
    mvnrnd(mu_normal, SIgma_normal, numPerClass)];
Y_generate = [repmat("Cancer", numPerClass, 1);
    repmat("Normal", numPerClass, 1)];

% Set and train the ECOC classifier using generated dataset
t = templateSVM('Standardize', true);
mdl = fitcecoc(X_generate, Y_generate, 'Learners', t, 'ClassNames', {'Cancer', 'Normal'});

% Construct test set, including features and labels
Features_test = [Features_cancer_test; Features_normal_test];
[rows_cancer, ~] = size(Features_cancer_test);
[rows_normal, ~] = size(Features_normal_test);
Y_test = [repmat("Cancer", rows_cancer, 1);
    repmat("Normal", rows_normal, 1)];

% Make prediction
pred = mdl.predict(Features_test);
% Calculate accuracies
accu = sum(strcmp(pred, Y_test))/numel(Y_test);
end