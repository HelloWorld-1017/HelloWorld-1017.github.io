clc, clear, close all

% Define the parameters mu and Sigma
mu = [0 0];
Sigma = [0.25 0.3; 0.3 1];

% Create a grid of evenly spaced points in two-dimensional space
x1 = -3:0.1:3;
x2 = -3:0.1:3;
[X1, X2] = meshgrid(x1,x2);
X = [X1(:) X2(:)];

% Evaluate the PDF of the normal distribution at the grid points
y = mvnpdf(X, mu, Sigma);
y = reshape(y, length(x2), length(x1));

figure('Units', 'normalized', 'Position', [0.2164, 0.2532, 0.4328, 0.5255])
colormap("jet")
% Tile1, pdf values
nexttile
surf(x1, x2, y)
axis([-3 3 -3 3 0 0.4])
view(-22.38, 54.15)
colorbar
xlabel('x1')
ylabel('x2')
zlabel('Probability Density')
title('surf')

% Tile2, contour
nexttile
contour(x1, x2, y)
colorbar
xlabel('x1')
ylabel('x2')
title('contour')

% Tile3, imagesc
nexttile
imagesc(x1, x2, y)
colorbar
xlabel('x1')
ylabel('x2')
title('imagesc')

% Tile 4, plot3
nexttile
plot3(x1, x2, y)
view(5.57, 24.20)
colorbar
xlabel('x1')
ylabel('x2')
zlabel('Probability Density')
title('plot3')
