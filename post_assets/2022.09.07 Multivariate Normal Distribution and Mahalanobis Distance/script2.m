clc, clear, close all

% Define the mean vector mu and the covariance matrix Sigma
mu = [0 0];
Sigma = [0.25 0.3; 0.3 1];

% Create a grid of evenly spaced points in two-dimensional space
gridSize = 50;
x1 = linspace(-3, 3, gridSize)';
x2 = linspace(-3, 3, gridSize)';
[X1, X2] = meshgrid(x1, x2);
X = [X1(:) X2(:)];

% Evaluate the cdf of the normal distribution at the grid points
p = mvncdf(X, mu, Sigma);
Z = reshape(p, gridSize, gridSize);

figure('Units', 'pixels', 'Position', [575,327.6667,1205.3333, 903.3333])
colormap("jet")
% Tile1, Plot the CDF values
nexttile
surf(X1, X2, Z)
colorbar
xlabel('x1')
ylabel('x2')
zlabel('CDF values')
title('surf')
xlim([-3, 3])
ylim([-3, 3])
zlim([0, 1])

% Tile2, contour
nexttile
contour(X1, X2, Z, LineWidth=1.5)
colorbar
xlabel('x1')
ylabel('x2')
title('contour')

% Tile3, imagesc
nexttile
imagesc(x1, x2, Z)
xlabel('x1')
ylabel('x2')
title('imagesc')
colorbar

% Tile4, plot3
nexttile
plot3(X1, X2, Z, LineWidth=1.5)
colorbar
xlabel('x1')
ylabel('x2')
zlabel('CDF values')
title('plot3')
xlim([-3, 3])
ylim([-3, 3])
zlim([0, 1])
