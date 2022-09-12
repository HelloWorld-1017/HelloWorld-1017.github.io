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
% 'Average of accuracies is 0.9833,
%  Standard diviation of accuracies is 0.0053'

function accu = TrainAndTest(flow, labels)
idx = labels==1;
signals_1 = flow(idx, :);
idx = labels==2;
signals_2 = flow(idx, :);

mu_1 = mean(signals_1);
Sigma_1 = cov(signals_1);
mu_2 = mean(signals_2);
Sigma_2 = cov(signals_2);

numPerClass = 1000;
X_generate = [mvnrnd(mu_1, Sigma_1, numPerClass);
    mvnrnd(mu_2, Sigma_2, numPerClass)];
Y_generate = [ones(numPerClass, 1);
    2*ones(numPerClass, 1)];

t = templateSVM('Standardize', true);
mdl = fitcecoc(X_generate, Y_generate, 'Learners', t);

pred = mdl.predict(flow);
accu = sum(pred==labels)/numel(labels);
end