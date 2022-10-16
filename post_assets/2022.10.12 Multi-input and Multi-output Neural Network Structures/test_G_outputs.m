clc, clear, close all


numLatentInputs = 3;
numClasses = 7;

LayersG = [
    featureInputLayer(numLatentInputs)
    concatenationLayer(1, 2, 'Name','cat')
    fullyConnectedLayer(5)
    batchNormalizationLayer
    reluLayer
    fullyConnectedLayer(6)
    batchNormalizationLayer
    reluLayer
    fullyConnectedLayer(7)
    batchNormalizationLayer
    reluLayer
    ];
Layersf1 = [
    featureInputLayer(1)
    fullyConnectedLayer(5)
    batchNormalizationLayer
    reluLayer
    fullyConnectedLayer(1, 'Name', 'LabelsG')
    ];
lgraphG = layerGraph(LayersG);
lgraphG = addLayers(lgraphG, Layersf1);
lgraphG = connectLayers(lgraphG, 'LabelsG', 'cat/in2');

Input1 = randn(numLatentInputs, 1);
Input1 = dlarray(Input1, "CB");

Input2 = randn(1, 1);
Input2 = dlarray(Input2, "CB");

helperTestLayerOutput(lgraphG, Input1, Input2)

function helperTestLayerOutput(Layers, Input1, Input2)
% Select the former 'idx' layers
for idx = 1:numel(Layers)
    RestLayers = Layers(1:idx);
    % Convert to dlnetwork object
    RestNet = dlnetwork(RestLayers);
    % Forward process
    Output = predict(RestNet, Input1, Input2);
    % Show output size in command line
    fprintf(sprintf('The output size of the %s layer is: ', num2str(idx)))
    disp(size(Output))
end
end

