clc, clear, close all
rng("default")

numSamples = 100;
numDimension = 11;
Samples = randn(numSamples, numDimension);

Y = ones(1, numDimension);

% Calculate using built-in mahal function
d2_mahal = mahal(Y, Samples);

% Calculate using custom process
mu_samples = mean(Samples);
Sigma_samples = cov(Samples);
d2_selfmahal = (Y-mu_samples)*inv(Sigma_samples)*(Y-mu_samples)';

d2_mahal, d2_selfmahal