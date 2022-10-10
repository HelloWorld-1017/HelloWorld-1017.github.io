clc, clear, close all

[xTrainImages, tTrain] = digitTrainCellArrayData;
xTrainImages = xTrainImages';
[Labels, ~] = find(tTrain == 1);
Labels(Labels==10) = 0;



