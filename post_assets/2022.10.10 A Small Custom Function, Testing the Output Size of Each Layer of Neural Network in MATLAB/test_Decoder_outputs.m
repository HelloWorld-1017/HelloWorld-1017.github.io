clc, clear, close all

imageSize = [28 28 1];
numLatentChannels = 16;
projectionSize = [7 7 64];
numInputChannels = size(imageSize,1);

% Construct computational graph
layersD = [
    featureInputLayer(numLatentChannels)                       % Output size, [16, 1]
    projectAndReshapeLayer(projectionSize, numLatentChannels)  % Output size, [7, 7, 64, 1]
    transposedConv2dLayer(3, 64, Cropping="same",Stride=2)     % Output size, [14, 14, 64, 1]
    reluLayer                                                  % Output size, [14, 14, 64, 1]
    transposedConv2dLayer(3, 32, Cropping="same",Stride=2)     % Output size, [28, 28, 32, 1]
    reluLayer                                                  % Output size, [28, 28, 32, 1]
    transposedConv2dLayer(3, numInputChannels, Cropping="same")% Output size, [28, 28, 1, 1]
    sigmoidLayer                                               % Output size, [28, 28, 1, 1]
    ];

% New a Input and convert it to dlarray 
Input = randn([16, 1]);
Input = dlarray(Input, "CB");

helperTestLayerOutput(layersD, Input)

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



