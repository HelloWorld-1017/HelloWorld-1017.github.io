clc, clear, close all

numLatentChannels = 16;
imageSize = [28 28 1];

layersE = [
    imageInputLayer(imageSize, Normalization="none")    % Output size, [28, 28, 1, 1]
    convolution2dLayer(3, 32, Padding="same", Stride=2) % Output size, [14, 14, 32, 1]
    reluLayer                                           % Output size, [14, 14, 32, 1]                   
    convolution2dLayer(3, 64, Padding="same", Stride=2) % Output size, [7, 7, 64, 1]
    reluLayer                                           % Output size, [7, 7, 64, 1]
    fullyConnectedLayer(2*numLatentChannels)            % Output size, [32, 1]
    samplingLayer                                       % Output siez, [16, 1]
    ];

Input = randn(imageSize);
Input = dlarray(Input, "SSCB");

helperTestLayerOutput(layersE, Input)

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