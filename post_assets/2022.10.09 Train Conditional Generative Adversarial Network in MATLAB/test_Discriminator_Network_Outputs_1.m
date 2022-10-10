clc, clear, close all

dropoutProb = 0.75;
numFilters = 64;
scale = 0.2;
inputSize = [64 64 3];
filterSize = 5;

layers = [
    imageInputLayer(inputSize,Normalization="none") % Output size, [64, 64, 3, 1]
    dropoutLayer(dropoutProb)                       % Output size, [64, 64, 3, 1]
    ];


TValidation = single(randn(inputSize));
TValidation = dlarray(TValidation,"SSCB");

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
