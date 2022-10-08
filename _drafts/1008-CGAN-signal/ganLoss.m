function [lossGenerator, lossDiscriminator] = ganLoss(probReal, probGenerated)
%GANLOSS Compute the total loss of the GAN.

% Copyright 2020 The MathWorks, Inc.

% Calculate losses for discriminator network
lossGenerated = -mean(log(1 - probGenerated));
lossReal = -mean(log(probReal));

% Combine losses for discriminator network
lossDiscriminator = lossReal + lossGenerated;

% Calculate loss for generator network
lossGenerator = -mean(log(probGenerated));
end