clc, clear, close all

% Load real dataset
load fisheriris

% Split the features of 3 kinds of species
idx = strcmp(species, "setosa");
Features_seto = meas(idx, :);
idx = strcmp(species, "versicolor");
Features_vers = meas(idx, :);
idx = strcmp(species, "virginica");
Features_virg = meas(idx, :);

% Calculate the mu and Sigma of features of each sepices
mu_seto = mean(Features_seto);
Sigma_seto = cov(Features_seto);
mu_vers = mean(Features_vers);
Sigma_vers = cov(Features_vers);
mu_virg = mean(Features_virg);
Sigma_virg = cov(Features_virg);

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
mdl = fitcecoc(X_generate, Y_generate, 'Learners', t,...
    'ClassNames', {'setosa','versicolor','virginica'});

% Predict the labels using the true fetures
pred = mdl.predict(meas);

% Calculate the accuracy
accu = sum(strcmp(pred, species))/numel(species)*100;



