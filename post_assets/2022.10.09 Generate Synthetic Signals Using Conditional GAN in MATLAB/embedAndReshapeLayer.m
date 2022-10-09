classdef embedAndReshapeLayer < nnet.layer.Layer
%EMBEDANDRESHAPELAYER Embed and reshape layer.
    
% Copyright 2020 The MathWorks, Inc.

    properties
        % Layer properties (optional)
        OutputSize
    end

    properties (Learnable)
        % Layer learnable parameters
        
        EmbeddingWeights
        FullyConnectWeights
        FullyConnectBias
    end
    
    methods
        function layer = embedAndReshapeLayer(outputSize, embeddingDimension, inputDimension, name)
            % Create an embedAndReshapeLayer object with the specified
            % output size, embedding dimension, input dimension, and name.
            
            % Set layer name
            layer.Name = name;

            % Set layer description
            layer.Description = "Reshape layer with output size " + join(string(outputSize));

            % Set output size
            layer.OutputSize = outputSize;
            
            % Initialize embedding weights
            layer.EmbeddingWeights = randn(embeddingDimension, inputDimension);
            
            % Initialize fully connected weights and bias
            sz = outputSize(1) * outputSize(2);
            layer.FullyConnectWeights = initializeGlorot(sz, embeddingDimension);
            layer.FullyConnectBias = zeros(sz, 1, 'single');
        end
        
        function Z = predict(layer, X)
            % Forward input data through the layer at prediction time and
            % output the result.
            %
            % Inputs:
            %         layer - Layer to forward propagate through
            %         X     - Numeric indices, specified as a
            %                 1-by-1-by-1-by-N dlarray, where N is the 
            %                 mini-batch size.
            % Outputs:
            %         Z     - Output of layer forward function, returned as 
            %                 an sz(1)-by-sz(2)-by-1-by-N dlarray, where sz
            %                 is the layer output size and N is the 
            %                 mini-batch size.

            % Embedding
            X = embedding(layer,X);
            
            % Fully connect
            weights = layer.FullyConnectWeights;
            bias = layer.FullyConnectBias;
            X = fullyconnect(X, weights, bias, 'DataFormat', 'SSCB');
            
            % Reshape
            sz = layer.OutputSize;
            Z = reshape(X, sz(1), sz(2), 1, []);
        end
        
        function Z = embedding(layer, X)
            % Z = embedding(layer, X) maps numeric indices in X to the
            % corresponding vector using the layer embedding weights.

            % Embedding weights
            weights = layer.EmbeddingWeights;
            
            % Reshape inputs into a vector
            N = size(X, 4);
            X = reshape(X, N, 1);
            
            % Index into embedding matrix
            Z = weights(:, X);
            
            % Reshape outputs by separating out batch and sequence
            % dimensions
            Z = reshape(Z, 1, 1, [], N);
            
            % If necessary, cast to GPU
            if isa(extractdata(X),'gpuArray')
                Z = gpuArray(Z);
            end
        end
    end
end

function weights = initializeGlorot(numOut, numIn)
% Initialize weights using Glorot initializer.

varWeights = sqrt( 6 / (numIn + numOut) );
weights = varWeights * (2 * rand([numOut, numIn], 'single') - 1);

end

