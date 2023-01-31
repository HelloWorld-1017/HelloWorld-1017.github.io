clc, clear, close all

numFilters = 64;
numClasses = 5;
filterSize = 5;


layers = [
    featureInputLayer(1)                            % Output size, [1, 1]
    embeddingLayer(50,numClasses)                   % Output size, [50, 1]
    fullyConnectedLayer(prod([14, 14, 2]))          % Output size, [16, 1]
    functionLayer(@(X) feature2image(X,[14 14 2]), ...
    Formattable=true,Name="emb_reshape")            % Output size, [14, 14, 2, 1]
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