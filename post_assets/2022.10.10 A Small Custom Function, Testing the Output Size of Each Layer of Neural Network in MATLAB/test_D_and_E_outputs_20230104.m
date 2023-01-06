clc, clear, close all

imageSize = [28 28 1];

% For Encoder
numLatentChannels = 16;
layersE = [
    imageInputLayer(imageSize, Normalization="none")   
    convolution2dLayer(3, 32, Padding="same", Stride=2) 
    reluLayer                                                              
    convolution2dLayer(3, 64, Padding="same", Stride=2) 
    reluLayer                                          
    fullyConnectedLayer(2*numLatentChannels)            
    samplingLayer                                       
    ];

% For Decoder
projectionSize = [7 7 64];
numInputChannels = size(imageSize,1);
layersD = [
    featureInputLayer(numLatentChannels)                       
    projectAndReshapeLayer(projectionSize, numLatentChannels)  
    transposedConv2dLayer(3, 64, Cropping="same",Stride=2)    
    reluLayer                                                  
    transposedConv2dLayer(3, 32, Cropping="same",Stride=2)    
    reluLayer                                                  
    transposedConv2dLayer(3, numInputChannels, Cropping="same")
    sigmoidLayer                                              
    ];

NetE = layerGraph(layersE);
NetD = layerGraph(layersD);

% analyzeNetwork(NetE)
% analyzeNetwork(NetD)

analyzeNetwork(NetE, TargetUsage="dlnetwork")
analyzeNetwork(NetD, TargetUsage="dlnetwork")


