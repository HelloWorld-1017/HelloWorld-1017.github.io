clc, clear, close all
% 
% [xTrainImages, tTrain] = digitTrainCellArrayData;
% xTrainImages = xTrainImages';
% [Labels, ~] = find(tTrain == 1);
% Labels(Labels==10) = 0;
% 
% 



auimds = augmentedImageDatastore([100, 100], digitDatastore);% 注意这个28！！
mbq = minibatchqueue(auimds, ...
    MiniBatchSize=128, ...
    PartialMiniBatch="discard", ...
    MiniBatchFcn=@preprocessData, ...
    MiniBatchFormat=["SSCB", "BC"]); % Attention here!!!
A = read(auimds);
head(A,2)

[X, L] = next(mbq);

figure
fig = extractdata(X(:, :, 1, 1));
image(fig)

function [X,T] = preprocessData(XCell,TCell)
% Extract image data from cell and concatenate
X = cat(4, XCell{:});
% Extract label data from cell and concatenate
T = cat(1, TCell{:});
% Rescale the images in the range [-1 1].
X = rescale(X, 0, 1);
end