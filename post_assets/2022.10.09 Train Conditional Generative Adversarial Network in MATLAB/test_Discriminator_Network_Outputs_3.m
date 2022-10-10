clc, clear, close all

dropoutProb = 0.75;
numFilters = 64;
scale = 0.2;

inputSize = [64 64 3+1];
filterSize = 5;

layersD = [
    featureInputLayer(prod(inputSize))             % Output size, [16384, 1]
    functionLayer(@(X) feature2image(X, inputSize), ...
    Formattable=true,Name="emb_reshape")           % Output size, [64, 64, 4, 1]
    convolution2dLayer(filterSize,numFilters, ...
    Stride=2,Padding="same")                       % Output size, [32, 32, 64, 1]
    leakyReluLayer(scale)                          % Output size, [32, 32, 64, 1]
    convolution2dLayer(filterSize,2*numFilters, ...
    Stride=2,Padding="same")                       % Output size, [16, 16, 128, 1]
    batchNormalizationLayer                        % Output size, [16, 16, 128, 1]
    leakyReluLayer(scale)                          % Output size, [16, 16, 128, 1]
    convolution2dLayer(filterSize,4*numFilters, ...
    Stride=2,Padding="same")                       % Output size, [8, 8, 256, 1]
    batchNormalizationLayer                        % Output size, [8, 8, 256, 1]
    leakyReluLayer(scale)                          % Output size, [8, 8, 256, 1]
    convolution2dLayer(filterSize,8*numFilters, ...
    Stride=2,Padding="same")                       % Output size, [4, 4, 512, 1]
    batchNormalizationLayer                        % Output size, [4, 4, 512, 1]
    leakyReluLayer(scale)                          % Output size, [4, 4, 512, 1]
    convolution2dLayer(4,1)                        % Output size, [1, 1, 1, 1]
    ];

ZValidation = randn(prod(inputSize), 1, "single");
ZValidation = dlarray(ZValidation,"CB");
helperTestLayerOutput(layersD, ZValidation)

function helperTestLayerOutput(Layers, Input1)
% Select the former 'idx' layers
for idx = 1:numel(Layers)
    RestLayers = Layers(1:idx);
    % Convert to dlnetwork object
    RestNet = dlnetwork(RestLayers);
    % Forward process
    Output = predict(RestNet, Input1);
    % Show output size in command line
    fprintf(sprintf('The output size of the %s layer is: ', num2str(idx)))
    disp(size(Output))
end
end