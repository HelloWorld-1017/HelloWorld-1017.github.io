clc, clear, close all

load fisheriris


% Split the features of 3 kinds of species
idx = strcmp(species, "setosa");
Features_seto = meas(idx, :);
idx = strcmp(species, "versicolor");
Features_vers = meas(idx, :);
idx = strcmp(species, "virginica");
Features_virg = meas(idx, :);


Sigma_seto = cov(Features_seto);
