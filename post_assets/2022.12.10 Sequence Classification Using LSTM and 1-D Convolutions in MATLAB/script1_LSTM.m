clc, clear, close all

[XTrain, YTrain] = japaneseVowelsTrainData;

% figure
% plot(XTrain{1}')
% xlabel("Time Step")
% title("Training Observation 1")
% numFeatures = size(XTrain{1},1);
% legend("Feature " + string(1:numFeatures), Location="northeastoutside")

sequenceLengths = nan(1, numel(XTrain));
numObservations = numel(XTrain);
for i=1:numObservations
    sequence = XTrain{i};
    sequenceLengths(i) = size(sequence,2);
end

[sequenceLengths,idx] = sort(sequenceLengths);
XTrain = XTrain(idx);
YTrain = YTrain(idx);

% figure
% bar(sequenceLengths)
% ylim([0 30])
% xlabel("Sequence")
% ylabel("Length")
% title("Sorted Data")

miniBatchSize = 27;
inputSize = 12;
numHiddenUnits = 100;
numClasses = 9;

layers = [ ...
    sequenceInputLayer(inputSize)
    bilstmLayer(numHiddenUnits,OutputMode="last")
    fullyConnectedLayer(numClasses)
    softmaxLayer
    classificationLayer];

options = trainingOptions("adam", ...
    ExecutionEnvironment="auto", ...
    GradientThreshold=1, ...
    MaxEpochs=50, ...
    MiniBatchSize=miniBatchSize, ...
    SequenceLength="longest", ...
    Shuffle="never", ...
    Verbose=0, ...
    Plots="none");


net = trainNetwork(XTrain,YTrain,layers,options);


[XTest,YTest] = japaneseVowelsTestData;

sequenceLengthsTest = nan(1, numel(XTest));
numObservationsTest = numel(XTest);
for i=1:numObservationsTest
    sequence = XTest{i};
    sequenceLengthsTest(i) = size(sequence,2);
end

[sequenceLengthsTest,idx] = sort(sequenceLengthsTest);
XTest = XTest(idx);
YTest = YTest(idx);

YPred = classify(net,XTest, ...
    MiniBatchSize=miniBatchSize, ...
    SequenceLength="longest");

acc = sum(YPred == YTest)./numel(YTest);

