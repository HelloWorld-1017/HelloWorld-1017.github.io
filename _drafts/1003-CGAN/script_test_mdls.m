clc, clear, close all

load Generator.mat
load Discriminator.mat

% Create an array of 36 vectors of random values corresponding to the first class
numObservationsNew = 36;
numLatentInputs = 100;
idxClass = 1;
executionEnvironment = "auto";

ZNew = randn(numLatentInputs,numObservationsNew,"single");
TNew = repmat(single(idxClass),[1 numObservationsNew]);

% Convert the data to dlarray objects with the dimension labels "SSCB" (spatial, spatial, channels, batch)
ZNew = dlarray(ZNew,"CB");
TNew = dlarray(TNew,"CB");

% To generate images using the GPU, also convert the data to gpuArray objects
if (executionEnvironment == "auto" && canUseGPU) || executionEnvironment == "gpu"
    ZNew = gpuArray(ZNew);
    TNew = gpuArray(TNew);
end
% Generate images using the predict function with the generator network
XGeneratedNew = predict(netG,ZNew,TNew);

% Display the generated images in a plot
figure
I = imtile(extractdata(XGeneratedNew));
I = rescale(I);
imshow(I)
title("Class: daisy")