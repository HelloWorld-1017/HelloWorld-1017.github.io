clc, clear, close all
load ionosphere.mat

numTimes = 100;
accus = zeros(numTimes, 1);
for i = 1:numel(accus)
    accus(i) = TrainAndTest(X, Y);
end
accu_ave = mean(accus);
accu_std = std(accus);

sprintf('Average of accuracies is %.4f,\n Standard diviation of accuracies is %.4f', ...
    accu_ave, accu_std)
% 'Average of accuracies is 0.8660,
%   Standard diviation of accuracies is 0.0359'

function accu = TrainAndTest(X, Y)
% Split features of different class 
idx = strcmp(Y, 'g');
Features_g = X(idx, :);
idx = strcmp(Y, 'b');
Features_b = X(idx, :);

% Split train and test set
% For class g
[numRows, ~] = size(Features_g);
idx = randperm(numRows);
idx_train = idx(round(numRows*0.2)+1:end);
Features_g_train = Features_g(idx_train, :);
idx_test = idx(1:round(numRows*0.2));
Features_g_test = Features_g(idx_test, :);
% For class b
[numRows, ~] = size(Features_b);
idx = randperm(numRows);
idx_train = idx(round(numRows*0.2)+1:end);
Features_b_train = Features_b(idx_train, :);
idx_test = idx(1:round(numRows*0.2));
Features_b_test = Features_b(idx_test, :);

% Caculate mu and Sigma from train set
mu_g = mean(Features_g_train);
Sigma_g = cov(Features_g_train);
mu_b = mean(Features_b_train);
Sigma_b = cov(Features_b_train);

% Generate the features and the corresponding labels
numPerClass = 2000;
X_generate  = [mvnrnd(mu_g, Sigma_g, numPerClass);
    mvnrnd(mu_b, Sigma_b, numPerClass)];
Y_generate  = [repmat("g", numPerClass, 1);
    repmat("b", numPerClass, 1)];

% Set and train the ECOC classifier using generated dataset
t = templateSVM('Standardize', true);
mdl = fitcecoc(X_generate, Y_generate, 'Learners', t, 'ClassNames', {'g','b'});

% Construct test set, including features and labels
Features_test = [Features_g_test; Features_b_test];
[rowsg, ~] = size(Features_g_test);
[rowsb, ~] = size(Features_b_test);
Y_test = [repmat("g", rowsg, 1); repmat("b", rowsb, 1)];

% Make prediction
pred = mdl.predict(Features_test);
% Calculate accuracie
accu = sum(strcmp(pred, Y_test))/numel(Y_test);
end
