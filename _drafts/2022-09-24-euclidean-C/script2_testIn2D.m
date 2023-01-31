clc, clear, close all
% Load the test data
load euclidean_data.mat

% Create 2-D versions of x and cb
x2d=x(1:2, :);
cb2d=cb(1:2,1:6:216);

% Determine closest and farthest points and corresponding distances
[y_min, y_max, idx, distance] = euclidean(x2d, cb2d);

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