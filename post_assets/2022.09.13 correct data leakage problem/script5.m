clc, clear, close all

% Load the training data into memory
[xTrainImages, tTrain] = digitTrainCellArrayData;

numTimes = 100;
accus = zeros(numTimes, 1);
for i = 1:numel(accus)
    accus(i) = TrainAndTest(xTrainImages, tTrain);
    disp(i)
end
accu_ave = mean(accus);
accu_std = std(accus);

sprintf('Average of accuracies is %.4f,\n Standard diviation of accuracies is %.4f', ...
    accu_ave, accu_std)
% 'Average of accuracies is 0.9590,
%   Standard diviation of accuracies is 0.0020'


function accu = TrainAndTest(xTrainImages, tTrain)
X = zeros(5000, 28*28);
for i = 1:numel(xTrainImages)
    X(i, :) = xTrainImages{i}(:);
end
[Y, ~] = find(tTrain == 1);

X_generate = [];
Y_generate = [];
numPerClass = 2000;
for i = 1:10
    idx = Y==i;
    expression = ['Image_', num2str(i), '=', 'X(idx, :);'];
    eval(expression);
    expression = ['mu_', num2str(i), '=', 'mean(Image_', num2str(i), ');'];
    eval(expression);
    expression = ['Sigma_', num2str(i), '=', 'cov(Image_', num2str(i), ');'];
    eval(expression);
    expression = ['X_generate=', '[X_generate; ', 'mvnrnd(mu_', num2str(i), ', ', 'Sigma_', num2str(i), ', numPerClass)];'];
    eval(expression);
    expression = ['Y_generate=', '[Y_generate;',  num2str(i), '*ones(numPerClass, 1)];'];
    eval(expression);
end

t = templateSVM('Standardize', true);
mdl = fitcecoc(X_generate, Y_generate, 'Learners', t);

pred = mdl.predict(X);
accu = sum(pred==Y)/numel(Y);
end
