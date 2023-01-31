classdef embeddingLayer < nnet.layer.Layer & ...
        nnet.layer.Formattable

    properties (Learnable)
        % Layer learnable parameters.
        Weights
    end
    
    methods
        function layer = embeddingLayer(embeddingDimension, inputDimension, NameValueArgs)
            % layer = embeddingLayer(embeddingDimension,inputDimension)
            % creates a embedAndReshapeLayer object that embeds and
            % reshapes the input to the specified output size using an
            % embedding of the specified size and input dimension.
            %
            % layer = embeddingLayer(embeddingDimension,inputDimension,Name=name)
            % also specifies the layer name.
            
            % Parse input arguments.
            arguments
                embeddingDimension
                inputDimension
                NameValueArgs.Name = "";
            end
            
            name = NameValueArgs.Name;
            
            % Set layer name.
            layer.Name = name;

            % Set layer description.
            layer.Description = "Embedding layer with dimension " + embeddingDimension;
            
            % Initialize embedding weights.
            layer.Weights = randn(embeddingDimension,inputDimension);
            sz = [embeddingDimension inputDimension];
            mu = 0;
            sigma = 0.01;
            layer.Weights = initializeGaussian(sz,mu,sigma);
        end
        
        function Z = predict(layer, X)
            % Forward input data through the layer at prediction time and
            % output the result.
            %
            % Inputs:
            %         layer - Layer to forward propagate through
            %         X     - Numeric indices, specified as a formatted
            %                 dlarray with a "C" and optionally a "B"
            %                 dimension.
            % Outputs:
            %         Z     - Output of layer forward function returned as 
            %                 an dlarray with format "CB".

            % Embedding.
            weights = layer.Weights;
            Z = embed(X,weights);
        end
    end
end