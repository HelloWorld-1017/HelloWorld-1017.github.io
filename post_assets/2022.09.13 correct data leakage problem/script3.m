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
% 'Average of accuracies is 1.0000,
%   Standard diviation of accuracies is 0.0000'

function accu = TrainAndTest(obs, grp)
idx = strcmp(grp, "Cancer");
Features_cancer = obs(idx, :);
idx = strcmp(grp, "Normal");
Features_normal = obs(idx, :);

mu_cancer = mean(Features_cancer);
Sigma_cancer = cov(Features_cancer);
mu_normal = mean(Features_normal);
SIgma_normal = cov(Features_normal);

numPerClass = 1000;
X_generate = [mvnrnd(mu_cancer, Sigma_cancer, numPerClass);
    mvnrnd(mu_normal, SIgma_normal, numPerClass)];
Y_generate = [repmat("Cancer", numPerClass, 1);
    repmat("Normal", numPerClass, 1)];

t = templateSVM('Standardize', true);
mdl = fitcecoc(X_generate, Y_generate, 'Learners', t, 'ClassNames', {'Cancer', 'Normal'});

pred = mdl.predict(obs);
accu = sum(strcmp(pred, grp))/numel(grp);
end