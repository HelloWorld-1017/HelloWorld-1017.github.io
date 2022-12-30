clc, clear, close all

load data.mat

timeInterval = 5e-5;
numObservations = 20;
numTimeSteps = length(times);
maxPressures = linspace(1e5,1e6,numObservations);

%% Prepare data for training
sampleTime = 1e-3;
intervalDownsampled = sampleTime / timeInterval;
timeStepsDownsampled = 1:intervalDownsampled:numTimeSteps;
for i = 1:numObservations
    dataDownsampled{i} = data{i}(:,timeStepsDownsampled);
end

%% Partition the training data evenly into training and test partitions using the trainingPartitions function
[idxTrain, idxTest] = trainingPartitions(numObservations, [0.5 0.5]);

maxPressuresTrain = maxPressures(idxTrain);
maxPressuresTest = maxPressures(idxTest);
dataTrain = dataDownsampled(idxTrain);
dataTest = dataDownsampled(idxTest);

inputStatesTrain  = [1 2 3];
outputStatesTrain = [1 2];

numObservationsTrain = numel(dataTrain);
for i = 1:numObservationsTrain
    XTrain{i} = dataTrain{i}(inputStatesTrain,1:end-1);
    TTrain{i} = dataTrain{i}(outputStatesTrain,2:end);
end

%% Define Network Architecture
numHiddenUnits = 200;

numFeatures = numel(inputStatesTrain);
numResponses = numel(outputStatesTrain);

layers = [
    sequenceInputLayer(numFeatures,Normalization="rescale-zero-one")

    fullyConnectedLayer(numHiddenUnits)
    reluLayer

    lstmLayer(numHiddenUnits)
    lstmLayer(numHiddenUnits)
    reluLayer
    
    fullyConnectedLayer(numResponses)

    regressionLayer];

%% Specify Training Options and Train LSTM Network 
options = trainingOptions("adam", ...
    MaxEpochs=3e4, ...
    GradientThreshold=1, ...
    InitialLearnRate=5e-3, ...
    LearnRateSchedule="piecewise", ...
    LearnRateDropPeriod=1e4, ...
    LearnRateDropFactor=0.6, ...
    Verbose=0, ...
    Plots="training-progress");
net = trainNetwork(XTrain, TTrain, layers, options);

filename = "flexibleShaftLoadNet.mat";

save(filename,"net")

save("test.mat", "dataTest", "maxPressuresTest")


