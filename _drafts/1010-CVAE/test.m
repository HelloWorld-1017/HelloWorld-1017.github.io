numLatentChannels = 16;
numValidationImagesPerClass = 5;
numClasses = 10;

ZValidation = randn(numLatentChannels, numValidationImagesPerClass*numClasses,"single");
TValidation = single(repmat(1:numClasses, [1 numValidationImagesPerClass]));
