classdef projectAndReshapeLayer < nnet.layer.Layer ...
        & nnet.layer.Formattable ...
        & nnet.layer.Acceleratable

    properties
        % Layer properties.
        OutputSize
    end

    properties (Learnable)
        % Layer learnable parameters.
        
        Weights
        Bias
    end
    
    methods
        function layer = projectAndReshapeLayer(outputSize,numChannels,NameValueArgs)
            % layer = projectAndReshapeLayer(outputSize,numChannels)
            % creates a projectAndReshapeLayer object that projects and
            % reshapes the input to the specified output size using and
            % specifies the number of input channels.
            %
            % layer = projectAndReshapeLayer(outputSize,numChannels,Name=name)
            % also specifies the layer name.
            
            % Parse input arguments.
            arguments
                outputSize
                numChannels
                NameValueArgs.Name = "";
            end
                        
            % Set layer name.
            name = NameValueArgs.Name;
            layer.Name = name;

            % Set layer description.
            layer.Description = "Project and reshape to size " + ...
                join(string(outputSize));
            
            % Set layer type.
            layer.Type = "Project and Reshape";
            
            % Set output size.
            layer.OutputSize = outputSize;
            
            % Initialize fully connect weights and bias.
            sz = [prod(outputSize) numChannels];
            numOut = prod(outputSize);
            numIn = numChannels;
            layer.Weights = initializeGlorot(sz,numOut,numIn);
            layer.Bias = initializeZeros([prod(outputSize) 1]);
        end
        
        function Z = predict(layer, X)
            % Forward input data through the layer at prediction time and
            % output the result.
            %
            % Inputs:
            %         layer - Layer to forward propagate through
            %         X     - Input data, specified as a formatted dlarray
            %                 with a "C" and optionally a "B" dimension.
            % Outputs:
            %         Z     - Output of layer forward function returned as 
            %                 a formatted dlarray with format "SSCB".

            % Fully connect.
            weights = layer.Weights;
            bias = layer.Bias;
            X = fullyconnect(X,weights,bias);
            
            % Reshape.
            outputSize = layer.OutputSize;
            Z = reshape(X,outputSize(1),outputSize(2),outputSize(3),[]);
            Z = dlarray(Z,"SSCB");
        end
    end
end