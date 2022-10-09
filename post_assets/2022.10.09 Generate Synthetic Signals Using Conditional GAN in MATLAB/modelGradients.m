function [gradientsGenerator, gradientsDiscriminator, stateGenerator, scoreGenerator, scoreDiscriminator] = ...
    modelGradients(dlnetGenerator, dlnetDiscriminator, dlX, dlT, dlZ)
%MODELGRADIENTS Compute the gradients for generator and discriminator.

% Copyright 2020 The MathWorks, Inc.

% Calculate predictions for real data with discriminator network
dlYPred = forward(dlnetDiscriminator, dlX, dlT);

% Calculate predictions for generated data with discriminator network
[dlXGenerated,stateGenerator] = forward(dlnetGenerator, dlZ, dlT);
dlYPredGenerated = forward(dlnetDiscriminator, dlXGenerated, dlT);

% Calculate probabilities
probGenerated = sigmoid(dlYPredGenerated);
probReal = sigmoid(dlYPred);

% Calculate generator and discriminator scores
scoreGenerator = mean(probGenerated);
scoreDiscriminator = (mean(probReal) + mean(1-probGenerated)) / 2;

% Calculate GAN loss
[lossGenerator, lossDiscriminator] = ganLoss(probReal, probGenerated);

% For each network, calculate gradients with respect to loss
gradientsGenerator = dlgradient(lossGenerator, dlnetGenerator.Learnables, 'RetainData', true);
gradientsDiscriminator = dlgradient(lossDiscriminator, dlnetDiscriminator.Learnables);
end