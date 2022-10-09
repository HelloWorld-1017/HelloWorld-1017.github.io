function [lossGenerator, lossDiscriminator] = ganLoss(probReal, probGenerated)
%GANLOSS Compute the total loss of the GAN.
% Copyright 2020 The MathWorks, Inc.

% Calculate losses for discriminator network
lossDiscriminator = -mean(log(probReal)) + -mean(log(1 - probGenerated));

% Calculate loss for generator network
lossGenerator = -mean(log(probGenerated));
end
