clc, clear ,close all

miniBatchSize = 128;

imageFolder = fullfile(pwd, "digitdataset");
datasetFolder = fullfile(imageFolder);
imds = imageDatastore(datasetFolder,IncludeSubfolders=true,LabelSource="foldernames");
classes = categories(imds.Labels);
numClasses = numel(classes);

augmenter = imageDataAugmenter(RandXReflection=true);
augimds = augmentedImageDatastore([28 28],imds,DataAugmentation=augmenter);

augimds.MiniBatchSize = miniBatchSize;

mbq = minibatchqueue(augimds, ...
    MiniBatchSize=miniBatchSize, ...
    PartialMiniBatch="discard", ...
    MiniBatchFcn=@preprocessData, ...
    MiniBatchFormat=["SSCB" "BC"]);

[X, L] = next(mbq);

figure
fig = extractdata(X(:, :, 1, 1));
ll = extractdata(L(1));
imshow(fig)

function [X,T] = preprocessData(XCell, TCell)
% Extract image data from cell and concatenate
X = cat(4, XCell{:});
% Extract label data from cell and concatenate
T = cat(1, TCell{:});
% Rescale the images in the range [-1 1].
X = rescale(X, 0, 1, InputMin=0, InputMax=255);
end