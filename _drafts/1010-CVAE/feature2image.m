function Y = feature2image(X,outputSize)
% Y = feature2image(X,outputSize) reshapes input with format "CB" to have
% format "SSCB" to have size given by outputSize.
Y = reshape(X, outputSize(1), outputSize(2), outputSize(3), []);
Y = dlarray(Y,'SSCB');
end