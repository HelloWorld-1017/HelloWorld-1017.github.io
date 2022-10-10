clc, clear, close all

numLatentInputs = 100;
embeddingDimension = 50;
numFilters = 64;
numClasses = 5;
filterSize = 5;
projectionSize = [4 4 1024];

layersGenerator = [
    featureInputLayer(numLatentInputs)
    fullyConnectedLayer(prod(projectionSize))
    functionLayer(@(X) feature2image(X,projectionSize),Formattable=true)
    concatenationLayer(3,2,Name="cat");

    transposedConv2dLayer(filterSize,4*numFilters)
    batchNormalizationLayer
    reluLayer
    transposedConv2dLayer(filterSize,2*numFilters,Stride=2,Cropping="same")
    batchNormalizationLayer
    reluLayer
    transposedConv2dLayer(filterSize,numFilters,Stride=2,Cropping="same")
    batchNormalizationLayer
    reluLayer
    transposedConv2dLayer(filterSize,3,Stride=2,Cropping="same")
    tanhLayer];

lgraphGenerator = layerGraph(layersGenerator);

layers = [
    featureInputLayer(1)                           % Output size, [1, 1]
    embeddingLayer(embeddingDimension,numClasses)  % Output size, [50, 1]
    fullyConnectedLayer(prod(projectionSize(1:2))) % Output size, [16, 1]
    functionLayer(@(X) feature2image(X,[projectionSize(1:2) 1]), ...
    Formattable=true,Name="emb_reshape")           % Output size, [4, 4, 1, 1]
    ];

lgraphGenerator = addLayers(lgraphGenerator,layers);
lgraphGenerator = connectLayers(lgraphGenerator,"emb_reshape","cat/in2");

ZValidation = randn(numLatentInputs,1,"single");
ZValidation = dlarray(ZValidation,"CB");
TValidation = single(1);
TValidation = dlarray(TValidation,"CB");

helperTestLayerOutput(lgraphGenerator, ZValidation, TValidation)

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




