function [dlnetGenerator, dlnetDiscriminator] = trainGAN(dlnetGenerator, dlnetDiscriminator, flow, labels, params)
%TRAINGAN Train GAN using custom training loop.

% Copyright 2020 The MathWorks, Inc.

%% Set up training parameters
numLatentInputs = params.numLatentInputs;
numClasses = params.numClasses;
sizeData = params.sizeData;
numEpochs = params.numEpochs;
miniBatchSize = params.miniBatchSize;
learnRate = params.learnRate;
executionEnvironment = params.executionEnvironment;
gradientDecayFactor = params.gradientDecayFactor;
squaredGradientDecayFactor = params.squaredGradientDecayFactor;

%% Set up training plot
f = figure;
f.Position(3) = 2*f.Position(3);

scoreAxes = subplot(1,2,2);
lineScoreGenerator = animatedline(scoreAxes, 'Color', [0 0.447 0.741]);
lineScoreDiscriminator = animatedline(scoreAxes, 'Color', [0.85 0.325 0.098]);
legend('Generator', 'Discriminator');
ylim([0 1])
xlabel("Iteration")
ylabel("Score")
grid on

%% Initialize parameters for Adam optimizer
trailingAvgGenerator = [];
trailingAvgSqGenerator = [];
trailingAvgDiscriminator = [];
trailingAvgSqDiscriminator = [];

%% Set up validation inputs
rng('default')

numValidationImagesPerClass = 1;
ZValidation = randn(1, 1, numLatentInputs, numValidationImagesPerClass*numClasses, 'single');
TValidation = single(repmat(1:numClasses, [1 numValidationImagesPerClass]));
TValidation = permute(TValidation, [1 3 4 2]);
dlZValidation = dlarray(ZValidation, 'SSCB');
dlTValidation = dlarray(TValidation, 'SSCB');

%% Switch to gpuArray when GPU is used
if executionEnvironment == "gpu"
    dlZValidation = gpuArray(dlZValidation);
    dlTValidation = gpuArray(dlTValidation);
end

%% Loop over epochs
ct = 1; % total interation count
start = tic;

S = single(reshape(flow, sizeData)); % training data
L = single(reshape(labels, 1, 1, 1, sizeData(4))); % labels

totIter =  floor(size(S, 4)/miniBatchSize);
    
for epoch = 1:numEpochs
    
    % Reset and shuffle data
    idx = randperm(size(S, 4));
    S = S(:, :, :, idx);
    L = L(:, :, :, idx);
    
    % Loop over mini-batches.
    for iteration = 1:totIter
        % Use iteration number instead of total iteration count (ct) for
        % bias correction in adam algorithm
        
        % Read mini-batch of data and generate latent inputs for generator
        % network
        idx = (iteration-1)*miniBatchSize+1:iteration*miniBatchSize;
        
        X = S(:, :, 1, idx);
        T = L(:, :, 1, idx);        
        Z = randn(1, 1, numLatentInputs, miniBatchSize, 'single');
                
        % Convert mini-batch of data to dlarray and specify dimension
        % labels 'SSCB' (spatial, spatial, channel, batch)
        dlX = dlarray(X, 'SSCB');
        dlZ = dlarray(Z, 'SSCB');
        dlT = dlarray(T, 'SSCB');
        
        % If training on a GPU, then convert data to gpuArray
        if (executionEnvironment == "auto" && canUseGPU) || executionEnvironment == "gpu"
            dlX = gpuArray(dlX);
            dlZ = gpuArray(dlZ);
            dlT = gpuArray(dlT);
        end
        
        % Evaluate model gradients and generator state using
        % dlfeval and modelGradients functions
        [gradientsGenerator, gradientsDiscriminator, stateGenerator, scoreGenerator, scoreDiscriminator] = ...
            dlfeval(@modelGradients, dlnetGenerator, dlnetDiscriminator, dlX, dlT, dlZ);
        dlnetGenerator.State = stateGenerator;
        
        % Update discriminator network parameters
        [dlnetDiscriminator, trailingAvgDiscriminator, trailingAvgSqDiscriminator] = ...
            adamupdate(dlnetDiscriminator, gradientsDiscriminator, ...
            trailingAvgDiscriminator, trailingAvgSqDiscriminator, iteration, ...
            learnRate, gradientDecayFactor, squaredGradientDecayFactor);
        
        % Update generator network parameters
        [dlnetGenerator, trailingAvgGenerator, trailingAvgSqGenerator] = ...
            adamupdate(dlnetGenerator, gradientsGenerator, ...
            trailingAvgGenerator, trailingAvgSqGenerator, iteration, ...
            learnRate, gradientDecayFactor, squaredGradientDecayFactor);
        
        if mod(ct,50) == 0 || ct == 1     
            % Generate signals using held-out generator input
            dlXGeneratedValidation = predict(dlnetGenerator, dlZValidation, dlTValidation);
            dlXGeneratedValidation = squeeze(extractdata(gather(dlXGeneratedValidation)));
            
            % Display spectra of validation signals
            subplot(1,2,1);  
            pspectrum(dlXGeneratedValidation);
            set(gca, 'XScale', 'log')
            legend('Healthy', 'Faulty')
            title("Spectra of Generated Signals")
        end
        
        % Update scores plot
        subplot(1,2,2)
        addpoints(lineScoreGenerator,ct,...
            double(gather(extractdata(scoreGenerator))));
        
        addpoints(lineScoreDiscriminator,ct,...
            double(gather(extractdata(scoreDiscriminator))));
        
        % Update title with training progress information
        D = duration(0,0,toc(start),'Format','hh:mm:ss');
        title(...
            "Epoch: " + epoch + ", " + ...
            "Iteration: " + ct + ", " + ...
            "Elapsed: " + string(D))
        
        drawnow
        
        ct = ct+1;
    end
end

end