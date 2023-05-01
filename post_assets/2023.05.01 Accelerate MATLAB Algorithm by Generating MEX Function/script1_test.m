% Load test data 
load euclidean_data.mat

% Determine closest and farthest points and corresponding distances
[y_min,y_max,idx,distance] = euclidean(x,cb);

% Display output for the closest point
disp('Coordinates of the closest point are: ');
disp(num2str(y_min'));
disp(['Index of the closest point is ', num2str(idx(1))]);
disp(['Distance to the closest point is ', num2str(distance(1))]);

disp(newline);

% Display output for the farthest point
disp('Coordinates of the farthest point are: ');
disp(num2str(y_max'));
disp(['Index of the farthest point is ', num2str(idx(2))]);
disp(['Distance to the farthest point is ', num2str(distance(2))]);