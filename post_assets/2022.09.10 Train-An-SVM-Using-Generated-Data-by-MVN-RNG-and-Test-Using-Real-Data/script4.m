clc, clear, close all

load ovariancancer.mat

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

accu = sum(strcmp(pred, grp))/numel(grp)*100;