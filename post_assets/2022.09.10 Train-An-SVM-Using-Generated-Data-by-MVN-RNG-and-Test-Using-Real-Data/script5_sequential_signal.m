clc, clear, close all

load simulatedDataset.mat

flow = flow';
labels = labels';

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
accu = sum(pred==labels)/numel(labels)*100;
