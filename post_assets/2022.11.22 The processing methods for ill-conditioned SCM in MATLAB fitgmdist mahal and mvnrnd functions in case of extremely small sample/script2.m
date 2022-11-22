clc, clear, close all

numSamples = 7;
numDimension = 11;
Samples = randn(numSamples, numDimension);

Y = ones(1, numDimension);

d2_mahal = mahal(Y, Samples);