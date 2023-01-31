clc, clear, close all

% Define encoder structure
numLatentChannels = 16;
projectionSize = [7 7 64];
imageSize = [28 28 1];
numInputChannels = size(imageSize,1);


layersD = [
    featureInputLayer(numLatentChannels)                       % Output size, [16, 1]
    projectAndReshapeLayer(projectionSize, numLatentChannels)  % Output size, [7, 7, 64, 1]
    transposedConv2dLayer(3, 64, Cropping="same",Stride=2)     % Output size, [14, 14, 64, 1]
    reluLayer                                                  % Output size, [14, 14, 64, 1]
    concatenationLayer(3, 2, Name="cat");                      % Output size, [14, 14, 66, 1]
    transposedConv2dLayer(3, 32, Cropping="same",Stride=2)     % Output size, [28, 28, 32, 1]
    reluLayer                                                  % Output size, [28, 28, 32, 1]
    transposedConv2dLayer(3, numInputChannels, Cropping="same")% Output size, [28, 28, 1, 1]
    sigmoidLayer                                               % Output size, [28, 28, 1, 1]
    ];
layersf2 = [
    featureInputLayer(1)                            % Output size, [1, 1]
    embeddingLayer(50, 5)                           % Output size, [50, 1]
    fullyConnectedLayer(prod([14, 14, 2]))          % Output size, [16, 1]
    functionLayer(@(X) feature2image(X, [14, 14, 2]), ...
    Formattable=true, Name="emb_reshape")            % Output size, [14, 14, 2, 1]
    ];

lgraphD = layerGraph(layersD);
lgraphD = addLayers(lgraphD, layersf2);
lgraphD = connectLayers(lgraphD, "emb_reshape", "cat/in2");

ZValidation = randn(16, 1, "single");
ZValidation = dlarray(ZValidation, "CB");
TValidation = single(1);
TValidation = dlarray(TValidation, "CB");

helperTestLayerOutput(lgraphD, ZValidation, TValidation)


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
