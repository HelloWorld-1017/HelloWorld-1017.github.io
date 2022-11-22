clc, clear, close all
rng("default")

numSamples = 7;
numDimension = 11;
Samples = randn(numSamples, numDimension);

Y = ones(1, numDimension);

mu_samples = mean(Samples);
Sigma_samples = cov(Samples);

d2_selfmahal = (Y-mu_samples)*inv(Sigma_samples)*(Y-mu_samples)';
