clc, clear, close all

% Define the parameters mu and Sigma
mu_1 = [0 0];
Sigma_1 = [0.25 0.3; 0.3 1];

mu_2 = [0, 0];
Sigma_2 = [1, 0; 0, 1];

% Create a grid of evenly spaced points in two-dimensional space
x1 = -3:0.1:3;
x2 = -3:0.1:3;
[X1, X2] = meshgrid(x1,x2);
X = [X1(:) X2(:)];

% Evaluate the PDF of the normal distribution at the grid points
y_1 = mvnpdf(X, mu_1, Sigma_1);
y_1 = reshape(y_1, length(x2), length(x1));

y_2 = mvnpdf(X, mu_2, Sigma_2);
y_2 = reshape(y_2, length(x2), length(x1));

t = tiledlayout(1, 2);
colormap("jet")
% Tile1, contour
nexttile
contour(x1, x2, y_1)
colorbar
axis equal
xlabel('x1')
ylabel('x2')
title('$\mu$ = [0, 0], $\Sigma$ = [0.25 0.3; 0.3 1]', Interpreter='latex')

% Tile1, contour
nexttile
contour(x1, x2, y_2)
colorbar
axis equal
xlabel('x1')
ylabel('x2')
title('$\mu$ = [0, 0], $\Sigma$ = [1, 0; 0, 1]', Interpreter='latex')
