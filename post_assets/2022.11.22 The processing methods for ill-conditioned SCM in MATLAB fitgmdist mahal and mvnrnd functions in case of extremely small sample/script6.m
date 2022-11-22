clc, clear, close all
rng("default")

numSamples = 7;
numDimension = 11;
Samples = randn(numSamples, numDimension);

mu_samples = mean(Samples);
Sigma_samples = cov(Samples);

newSample = mvnrnd(mu_samples, Sigma_samples);