clc, clear, close all

numLatentInputs = 100;
embeddingDimension = 50;
numFilters = 64;
numClasses = 5;
filterSize = 5;
projectionSize = [4 4 1024];

layersG = [
    featureInputLayer(numLatentInputs)         % Output size, [100, 1]
    fullyConnectedLayer(prod(projectionSize))  % Output size, [16384, 1]
    functionLayer(@(X) feature2image(X,projectionSize), ...
    Formattable=true)                          % Output size, [4, 4, 1024, 1]
    ];

ZValidation = randn(numLatentInputs,1,"single");
ZValidation = dlarray(ZValidation,"CB");

helperTestLayerOutput(layersG, ZValidation)

function helperTestLayerOutput(Layers, Input)
% Select the former 'idx' layers
for idx = 1:numel(Layers)
    RestLayers = Layers(1:idx);
    % Convert to dlnetwork object
    RestNet = dlnetwork(RestLayers);
    % Forward process
    Output = predict(RestNet, Input);
    % Show output size in command line
    fprintf(sprintf('The output size of the %s layer is: ', num2str(idx)))
    disp(size(Output))
end
end