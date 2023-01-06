clc, clear, close all

imds = imageDatastore("flower_photos", IncludeSubfolders=true, LabelSource="foldernames");
[imdsTrain, imdsValidation, imdsTest] = splitEachLabel(imds, 0.6, 0.2, 0.2, "randomize");

numClasses = 5;

inputSize = [224 224 3];

% Model 1
numFilters = 16;
filterSize = 3;
poolSize = 2;

layers = [
    imageInputLayer(inputSize)
    
    convolution2dLayer(filterSize,numFilters,Padding="same")
    batchNormalizationLayer
    reluLayer
    maxPooling2dLayer(filterSize,Stride=2)

    convolution2dLayer(filterSize,2*numFilters,Padding="same")
    batchNormalizationLayer
    reluLayer
    maxPooling2dLayer(poolSize,Stride=2)

    convolution2dLayer(filterSize,4*numFilters,Padding="same")
    batchNormalizationLayer
    reluLayer
    maxPooling2dLayer(poolSize,Stride=2)
   
    dropoutLayer(0.8)

    fullyConnectedLayer(numClasses)
    softmaxLayer
    classificationLayer];

lgraphSmallNet = layerGraph(layers);

% Model 2
lgraphGoogLeNet = layerGraph(googlenet);
% plot(lgraphGoogLeNet)
% NetBefore = lgraphGoogLeNet;

newLearnableLayer = fullyConnectedLayer(numClasses, ...
    WeightLearnRateFactor=10, ...
    BiasLearnRateFactor=10);
lgraphGoogLeNet = replaceLayer(lgraphGoogLeNet,"loss3-classifier",newLearnableLayer);

newOutputLayer = classificationLayer("Name","ClassificationLayer_predictions");
lgraphGoogLeNet = replaceLayer(lgraphGoogLeNet,"output",newOutputLayer);
% NetAfter = lgraphGoogLeNet;

% analyzeNetwork(NetBefore)
% analyzeNetwork(NetAfter)

% Compare networks
% analyzeNetwork(lgraphGoogLeNet)
% analyzeNetwork(lgraphSmallNet)

% % Prepare data
% For train
augmenter = imageDataAugmenter(RandXReflection=true, RandScale=[0.5 1.5]);
augimdsTrain = augmentedImageDatastore(inputSize, imdsTrain, DataAugmentation=augmenter);

% For validation
augimdsValidation = augmentedImageDatastore(inputSize,imdsValidation);

% Set training options for Network 1
optsSmallNet = trainingOptions("sgdm", ...
    MaxEpochs=150, ...
    InitialLearnRate=0.002, ...
    ValidationData=augimdsValidation, ...
    ValidationFrequency=150, ...
    Verbose=false, ...
    Plots="training-progress");

% Set training options for Network 2
optsGoogLeNet = optsSmallNet;
optsGoogLeNet.MaxEpochs = 15;
optsGoogLeNet.InitialLearnRate = 0.0001;

% For Network 1 
netSmallNet = trainNetwork(augimdsTrain, lgraphSmallNet, optsSmallNet);

% For Network 2
netGoogLeNet = trainNetwork(augimdsTrain, lgraphGoogLeNet, optsGoogLeNet);

