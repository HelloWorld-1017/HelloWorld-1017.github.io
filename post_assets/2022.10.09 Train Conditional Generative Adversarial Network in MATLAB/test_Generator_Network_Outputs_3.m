clc, clear, close all

numLatentInputs = 100;
embeddingDimension = 50;
numFilters = 64;
numClasses = 5;
filterSize = 5;
projectionSize = [4 4 1024+1];


layersG = [
    featureInputLayer(prod(projectionSize))             % Output size, [16400, 1]
    functionLayer(@(X) feature2image(X, projectionSize), ...
    Formattable=true,Name="emb_reshape")                % Output size, [4, 4, 1025, 1]
    transposedConv2dLayer(filterSize,4*numFilters)      % Output size, [8, 8, 256, 1]
    batchNormalizationLayer                             % Output size, [8, 8, 256, 1]
    reluLayer                                           % Output size, [8, 8, 256, 1]
    transposedConv2dLayer(filterSize,2*numFilters, ...
    Stride=2,Cropping="same")                           % Output size, [16, 16, 128, 1]
    batchNormalizationLayer                             % Output size, [16, 16, 128, 1]
    reluLayer                                           % Output size, [16, 16, 128, 1]
    transposedConv2dLayer(filterSize,numFilters, ...
    Stride=2,Cropping="same")                           % Output size, [32, 32, 64, 1]
    batchNormalizationLayer                             % Output size, [32, 32, 64, 1]
    reluLayer                                           % Output size, [32, 32, 64, 1]
    transposedConv2dLayer(filterSize,3,Stride=2, ...
    Cropping="same")                                    % Output size, [64, 64, 3, 1]
    tanhLayer                                           % Output size, [64, 64, 3, 1]
    ];

ZValidation = randn(prod(projectionSize), 1, "single");
ZValidation = dlarray(ZValidation,"CB");

helperTestLayerOutput(layersG, ZValidation)

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