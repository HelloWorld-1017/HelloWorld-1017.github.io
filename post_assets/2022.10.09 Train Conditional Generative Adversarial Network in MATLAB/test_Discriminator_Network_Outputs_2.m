clc, clear, close all

dropoutProb = 0.75;
numFilters = 64;
scale = 0.2;

inputSize = [64 64 3];
filterSize = 5;
numClasses = 5;
embeddingDimension = 50;

layers = [
    featureInputLayer(1)                          % Output size, [1, 1]
    embeddingLayer(embeddingDimension,numClasses) % Output size, [50, 1]     
    fullyConnectedLayer(prod(inputSize(1:2)))     % Output size, [4096, 1]
    functionLayer(@(X) feature2image(X,[inputSize(1:2) 1]), ...
    Formattable=true,Name="emb_reshape")          % Output size, [64, 64, 1, 1]
    ];

TValidation = single(1);
TValidation = dlarray(TValidation,"CB");

helperTestLayerOutput(layers, TValidation)

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