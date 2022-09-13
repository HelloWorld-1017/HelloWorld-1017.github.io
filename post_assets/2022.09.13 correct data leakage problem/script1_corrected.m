clc, clear, close all
% Load real dataset
load fisheriris

numTimes = 100;
accus = zeros(numTimes, 1);
for i = 1:numel(accus)
    accus(i) = TrainAndTest(meas, species);
end
accu_ave = mean(accus);
accu_std = std(accus);


sprintf('Average of accuracies is %.4f,\n Standard diviation of accuracies is %.4f', ...
    accu_ave, accu_std)
% 'Average of accuracies is 0.9767,
%   Standard diviation of accuracies is 0.0266'

function accu = TrainAndTest(meas, species)
% Split the features of 3 kinds of species
idx = strcmp(species, "setosa");
Features_seto = meas(idx, :);
idx = strcmp(species, "versicolor");
Features_vers = meas(idx, :);
idx = strcmp(species, "virginica");
Features_virg = meas(idx, :);

% Split train and test set
% For setosa
idx = randperm(50);
idx_train = idx(11:end);
Features_seto_train = Features_seto(idx_train, :);
idx_test = idx(1:10);
Features_seto_test = Features_seto(idx_test, :);
% For versicolor
idx = randperm(50);
idx_train = idx(11:end);
Features_vers_train = Features_vers(idx_train, :);
idx_test = idx(1:10);
Features_vers_test = Features_vers(idx_test, :);
% For virginica
idx = randperm(50);
idx_train = idx(11:end);
Features_virg_train = Features_virg(idx_train, :);
idx_test = idx(1:10);
Features_virg_test = Features_virg(idx_test, :);

% Calculate the mu and Sigma of features of each sepices from train set
mu_seto = mean(Features_seto_train);
Sigma_seto = cov(Features_seto_train);
mu_vers = mean(Features_vers_train);
Sigma_vers = cov(Features_vers_train);
mu_virg = mean(Features_virg_train);
Sigma_virg = cov(Features_virg_train);

% Generate the features and the corresponding labels
numPerSpecies = 500;
X_generate = [mvnrnd(mu_seto, Sigma_seto, numPerSpecies);
    mvnrnd(mu_vers, Sigma_vers, numPerSpecies);
    mvnrnd(mu_virg, Sigma_virg, numPerSpecies)];
Y_generate = [repmat("setosa", numPerSpecies, 1);
    repmat("versicolor", numPerSpecies, 1);
    repmat("virginica", numPerSpecies, 1)];

% Create an SVM template, and standardize the predictors
t = templateSVM('Standardize', true);

% Train the ECOC classifier using generated dataset
mdl = fitcecoc(X_generate, Y_generate, 'Learners', t, ...
    'ClassNames', {'setosa','versicolor','virginica'});

% Construct test set, including features and labels
Features_test = [Features_seto_test; Features_vers_test; Features_virg_test];
Y_test = [repmat("setosa", 10, 1); repmat("versicolor", 10, 1); repmat("virginica", 10, 1)];

% Predict the labels using the true fetures
pred = mdl.predict(Features_test);

% Calculate the accuracy
accu = sum(strcmp(pred, Y_test))/numel(Y_test);
end


