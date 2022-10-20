clc, clear, close all

load ionosphere.mat

numInput = 7;
numOutput = 34;
numHiddenLayer1 = 2*7+1;
numHiddenLayer2 = ceil((numHiddenLayer1+numOutput)/2);


layers = [
    featureInputLayer(numInput)
    fullyConnectedLayer(numHiddenLayer1)
    reluLayer
    fullyConnectedLayer(numHiddenLayer2)
    reluLayer
    fullyConnectedLayer(numOutput)
    regressionLayer
    ];

Input = randn(numInput, 1);
Input = dlarray(Input, "CB");

helperTestLayerOutput(layers, Input)


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



