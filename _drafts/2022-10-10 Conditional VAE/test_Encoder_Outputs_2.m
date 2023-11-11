clc, clear, close all

% Define encoder structure
numLatentChannels = 16;
imageSize = [28 28 1];

layersE = [
    imageInputLayer(imageSize, Normalization="none")    % Output size, [28, 28, 1, 1]
    convolution2dLayer(3, 32, Padding="same", Stride=2) % Output size, [14, 14, 32, 1]
    concatenationLayer(3, 2, Name="cat");               % Output size, [14, 14, 34, 1]
    reluLayer                                           % Output size, [14, 14, 34, 1]                   
    convolution2dLayer(3, 64, Padding="same", Stride=2) % Output size, [7, 7, 64, 1]
    reluLayer                                           % Output size, [7, 7, 64, 1]
    fullyConnectedLayer(2*numLatentChannels)            % Output size, [32, 1]
    samplingLayer                                       % Output siez, [16, 1]
    ];

layersf1 = [
    featureInputLayer(1)                            % Output size, [1, 1]
    embeddingLayer(50, 5)                           % Output size, [50, 1]
    fullyConnectedLayer(prod([14, 14, 2]))          % Output size, [16, 1]
    functionLayer(@(X) feature2image(X, [14, 14, 2]), ...
    Formattable=true, Name="emb_reshape")            % Output size, [14, 14, 2, 1]
    ];

lgraphE = layerGraph(layersE);
lgraphE = addLayers(lgraphE, layersf1);
lgraphE = connectLayers(lgraphE, "emb_reshape", "cat/in2");

ZValidation = randn(28, 28, 1, "single");
ZValidation = dlarray(ZValidation, "SSCB");
TValidation = single(1);
TValidation = dlarray(TValidation, "CB");

helperTestLayerOutput(lgraphE, ZValidation, TValidation)


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
