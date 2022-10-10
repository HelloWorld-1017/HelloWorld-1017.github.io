clc, clear, close all

% auimds = augmentedImageDatastore([28, 28], digitDatastore);% Attention
% here!! 

imageFolder = fullfile(pwd, "digitdataset");
datasetFolder = fullfile(imageFolder);
imds = imageDatastore(datasetFolder,IncludeSubfolders=true,LabelSource="foldernames");
classes = categories(imds.Labels);
numClasses = numel(classes);

% augmenter = imageDataAugmenter(RandXReflection=true); % Attention here!
augimds = augmentedImageDatastore([28 28],imds);
%% Define Encoder and Decoder structures
% Define Encoder structure
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
netE = dlnetwork(lgraphE);

% Define Decoder structure
projectionSize = [7 7 64];
numInputChannels = size(imageSize, 1);

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
netD = dlnetwork(lgraphD);

%% Specify Training Options
numEpochs = 1000;
miniBatchSize = 128;
learnRate = 1e-3;
validationFrequency = 100;

%% Train Model
% mbq = minibatchqueue(auimds, ...
%     MiniBatchSize=miniBatchSize, ...
%     PartialMiniBatch="discard", ...
%     MiniBatchFcn=@preprocessData, ...
%     MiniBatchFormat=["SSCB", "BC"]); % Attention here!!!
augimds.MiniBatchSize = miniBatchSize;
executionEnvironment = "auto";

mbq = minibatchqueue(augimds, ...
    MiniBatchSize=miniBatchSize, ...
    PartialMiniBatch="discard", ...
    MiniBatchFcn=@preprocessData, ...
    MiniBatchFormat=["SSCB" "BC"]);

trailingAvgE = [];
trailingAvgSqE = [];
trailingAvgD = [];
trailingAvgSqD = [];

f = figure;
f.Position(3) = 2*f.Position(3);
imageAxes = subplot(1,2,1);
scoreAxes = subplot(1,2,2);
lineLossTrain = animatedline(scoreAxes, Color=[0 0.447 0.741]);
legend("Loss");
ylim([0 inf])
xlabel("Iteration")
ylabel("Score")
grid on

numValidationImagesPerClass = 5;
ZValidation = randn(numLatentChannels, numValidationImagesPerClass*numClasses,"single");
TValidation = single(repmat(1:numClasses, [1 numValidationImagesPerClass]));
ZValidation = dlarray(ZValidation, "CB");
TValidation = dlarray(TValidation, "CB");
if canUseGPU
    ZValidation = gpuArray(ZValidation);
    TValidation = gpuArray(TValidation);
end

iteration = 0;
start = tic;
% Loop over epochs.
for epoch = 1:numEpochs

    % Shuffle data.
    shuffle(mbq);

    % Loop over mini-batches.
    while hasdata(mbq)
        iteration = iteration + 1;

        % Read mini-batch of data.
        [X, L] = next(mbq);

        % Evaluate loss and gradients.
        [loss, gradientsE, gradientsD] = dlfeval(@modelLoss, netE, netD, X, L);

        % Update learnable parameters.
        [netE, trailingAvgE, trailingAvgSqE] = adamupdate(netE, ...
            gradientsE, trailingAvgE, trailingAvgSqE, iteration, learnRate);
        [netD, trailingAvgD, trailingAvgSqD] = adamupdate(netD, ...
            gradientsD,trailingAvgD, trailingAvgSqD, iteration, learnRate);
    
        if mod(iteration, validationFrequency) == 0 || iteration == 1
            % Generate images using the held-out generator input.
            XGeneratedValidation = predict(netD, ZValidation, TValidation);

            % Tile and rescale the images in the range [0 1].
            I = imtile(extractdata(XGeneratedValidation), ...
                GridSize=[numValidationImagesPerClass numClasses]);
            I = rescale(I);

            % Display the images.
            subplot(1,2,1);
            imshow(I) % Attention here!1
            xticklabels([]);
            yticklabels([]);
            title("Generated Images");
        end
        % Update the scores plot.
        subplot(1,2,2)
        addpoints(lineLossTrain, iteration, double(loss));
        % Update the title with training progress information.
        D = duration(0, 0, toc(start), Format="hh:mm:ss");
        title(...
            "Epoch: " + epoch + ", " + ...
            "Iteration: " + iteration + ", " + ...
            "Elapsed: " + string(D) + ", Loss: " + num2str(extractdata(loss)))
        drawnow
    end
end


function [loss, gradientsE, gradientsD] = modelLoss(netE, netD, X, L)
% Forward through encoder.
[Z, mu, logSigmaSq] = forward(netE, X, L);

% Forward through decoder.
Y = forward(netD, Z, L);

% Calculate loss and gradients.
loss = elboLoss(Y, X, mu, logSigmaSq);
[gradientsE, gradientsD] = dlgradient(loss, netE.Learnables, netD.Learnables);
end


function loss = elboLoss(Y, T, mu, logSigmaSq)
% Reconstruction loss.
reconstructionLoss = mse(Y, T);
% KL divergence.
KL = -0.5 * sum(1 + logSigmaSq - mu.^2 - exp(logSigmaSq), 1);
KL = mean(KL);
% Combined loss.
loss = reconstructionLoss + KL;
end


function [X,T] = preprocessData(XCell, TCell)
% Extract image data from cell and concatenate
X = cat(4, XCell{:});
% Extract label data from cell and concatenate
T = cat(1, TCell{:});
% Rescale the images in the range [-1 1].
X = rescale(X, 0, 1, InputMin=0, InputMax=255);
end