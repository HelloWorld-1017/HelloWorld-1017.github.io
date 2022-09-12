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
% 'Average of accuracies is 0.9052,
%   Standard diviation of accuracies is 0.0052'

function accu = TrainAndTest(X, Y)
idx = strcmp(Y, 'g');
Features_g = X(idx, :);
idx = strcmp(Y, 'b');
Features_b = X(idx, :);

mu_g = mean(Features_g);
Sigma_g = cov(Features_g);
mu_b = mean(Features_b);
Sigma_b = cov(Features_b);

numPerClass = 2000;
X_generate  = [mvnrnd(mu_g, Sigma_g, numPerClass);
    mvnrnd(mu_b, Sigma_b, numPerClass)];
Y_generate  = [repmat("g", numPerClass, 1);
    repmat("b", numPerClass, 1)];

t = templateSVM('Standardize', true);
mdl = fitcecoc(X_generate, Y_generate, 'Learners', t, 'ClassNames', {'g','b'});

pred = mdl.predict(X);

accu = sum(strcmp(pred, Y))/numel(Y);
end