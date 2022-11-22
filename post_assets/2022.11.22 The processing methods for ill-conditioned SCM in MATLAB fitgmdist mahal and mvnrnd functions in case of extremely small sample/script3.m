clc, clear, close all
rng("default")

numSamples = 7;
numDimension = 11;
Samples = randn(numSamples, numDimension);

Y = ones(1, numDimension);

d2_mahal = mahal(Y, Samples);

function d = mahal(Y,X)
% MAHAL Mahalanobis distance.
% Copyright 1993-2007 The MathWorks, Inc. 

[rx,cx] = size(X);
[ry,cy] = size(Y);

if cx ~= cy
   error(message('stats:mahal:InputSizeMismatch'));
end

% if rx < cx
%    error(message('stats:mahal:TooFewRows'));
% end

if any(imag(X(:))) | any(imag(Y(:)))
   error(message('stats:mahal:NoComplex'));
end

m = mean(X,1);
M = m(ones(ry,1),:);
C = X - m(ones(rx,1),:);
[Q,R] = qr(C,0);

ri = R'\(Y-M)';
d = sum(ri.*ri,1)'*(rx-1);
end