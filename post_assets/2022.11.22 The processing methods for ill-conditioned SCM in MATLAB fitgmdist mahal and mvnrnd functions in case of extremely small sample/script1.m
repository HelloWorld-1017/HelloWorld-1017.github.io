clc, clear, close all

numSamples = 7;
numFeatures = 11;
features = randn(numSamples, numFeatures);

k = 3; % The number of GMM components

gmm = selffitgmdist(features, 3);