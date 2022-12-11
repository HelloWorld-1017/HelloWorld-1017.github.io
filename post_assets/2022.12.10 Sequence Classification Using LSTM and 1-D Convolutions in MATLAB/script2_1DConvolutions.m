clc, clear, close all

[XTrain,TTrain] = japaneseVowelsTrainData;
[XValidation,TValidation] = japaneseVowelsTestData;

numFeatures = size(XTrain{1},1);
classes = categories(TTrain);
numClasses = numel(classes);


filterSize = 3;
numFilters = 32;

layers = [ ...
    sequenceInputLayer(numFeatures)

    convolution1dLayer(filterSize,numFilters,Padding="causal")
    reluLayer
    layerNormalizationLayer

    convolution1dLayer(filterSize,2*numFilters,Padding="causal")
    reluLayer
    layerNormalizationLayer

    globalAveragePooling1dLayer

    fullyConnectedLayer(numClasses)
    softmaxLayer
    classificationLayer];

miniBatchSize = 27;

options = trainingOptions("adam", ...
    MiniBatchSize=miniBatchSize, ...
    MaxEpochs=15, ...
    SequencePaddingDirection="left", ...
    ValidationData={XValidation,TValidation}, ...
    Plots="none", ...
    Verbose=0);

net = trainNetwork(XTrain,TTrain,layers,options);

YPred = classify(net,XValidation, ...
    MiniBatchSize=miniBatchSize, ...
    SequencePaddingDirection="left");
acc = mean(YPred == TValidation);
confusionchart(TValidation,YPred)


