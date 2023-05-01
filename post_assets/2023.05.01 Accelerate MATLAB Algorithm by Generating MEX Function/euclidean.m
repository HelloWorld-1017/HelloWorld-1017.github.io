function [y_min,y_max,idx,distance] = euclidean(x,cb)
%EUCLIDEAN  Calculates the minimum and maximum euclidean distance between a 
%           point and a set of other points.
%   [Y_MIN, Y_MAX, IDX, DISTANCE] = EUCLIDEAN(X,CB) computes the euclidean 
%   distance between X and every column of CB. X is an M-by-1 vector and CB 
%   is an M-by-N matrix. Y_MIN and Y_MAX are M-by-1 vectors that are equal  
%   to the columns of CB that have the minimum and the maximun distances to 
%   X, respectively. IDX is a 2-dimensional vector that contains the column 
%   indices of Y_MIN and Y_MAX in CB. DISTANCE is a 2-dimensional vector 
%   that contains the minumum and maximum distances.
% 
%   Copyright 2018 The MathWorks, Inc.

% Initialize minimum distance as distance to first element of cb
% Initialize maximum distance as distance to first element of cb
% Initialize minimum distance as distance to first element of cb
% Initialize maximum distance as distance to first element of cb
idx = ones(1,2);
distance = ones(1,2)*norm(x-cb(:,1));
idx(1)=1;
idx(2)=1;

distance(1)=norm(x-cb(:,1));
distance(2)=norm(x-cb(:,1));

% Find the vector in cb with minimum distance to x
% Find the vector in cb with maximum distance to x
for index=2:size(cb,2)
    d=norm(x-cb(:,index));
    if d < distance(1)
        distance(1)=d;
        idx(1)=index;
    end
    if d > distance(2)
        distance(2)=d;
        idx(2)=index;
    end
end

% Output the minimum and maximum distance vectors
y_min=cb(:,idx(1));
y_max=cb(:,idx(2));
end