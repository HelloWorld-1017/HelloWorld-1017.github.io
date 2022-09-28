clc, clear, close all

numTimes = 1e2;
numPerClass = 1e3;

load fisheriris
Loop(meas, species, numTimes, numPerClass, "fisheriris Dataset");

load ionosphere.mat
Loop(X, Y, numTimes, numPerClass, "ionosphere Dataset");

load ovariancancer.mat
Loop(obs, grp, numTimes, numPerClass, "ovariancancer Dataset");

load simulatedDataset.mat
flow = flow';
labels = labels';
Loop(flow, labels, numTimes, numPerClass, "simulatedDataset");

[xTrainImages, tTrain] = digitTrainCellArrayData;
for i = 1:numel(xTrainImages)
    X5(i, :) = xTrainImages{i}(:);
end
[Y5, ~] = find(tTrain == 1);
Loop(X5, Y5, numTimes, numPerClass, "digitTrainCellArrayData");
