function [y_min, y_max, idx, distance] = euclidean(x, cb)%#codegen
%   Copyright 2018 The MathWorks, Inc.

% Initialize minimum distance as distance to first element of cb
% Initialize maximum distance as distance to first element of cb
idx = ones(1,2);
distance = ones(1,2)*norm(x-cb(:,1));

% Initialize minimum distance as distance to first element of cb
% Initialize maximum distance as distance to first element of cb
idx(1)=1;
idx(2)=1;

distance(1)=norm(x-cb(:,1));
distance(2)=norm(x-cb(:,1));

% Find the vector in cb with minimum distance to x
% Find the vector in cb with maximum distance to x
for index = 2:size(cb, 2)
    d = norm(x-cb(:, index));
    if d < distance(1)
        distance(1) = d;
        idx(1) = index;
    end
    if d > distance(2)
        distance(2) = d;
        idx(2) = index;
    end
end

% Output the minimum and maximum distance vectors
y_min=cb(:, idx(1));
y_max=cb(:, idx(2));

end