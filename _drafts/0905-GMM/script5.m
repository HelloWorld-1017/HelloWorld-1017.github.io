clc, clear, close all

% Define the parameters mu and Sigma
mu = [0 0];
Sigma_1 = [1 0; 0 1];
Sigma_2 = [0.25 0.3; 0.3 1];

% Create a grid of evenly spaced points in two-dimensional space
x1 = -3:0.1:3;
x2 = -3:0.1:3;
[X1, X2] = meshgrid(x1,x2);
X = [X1(:) X2(:)];

% Evaluate the PDF of the normal distribution at the grid points
pdf_1 = mvnpdf(X, mu, Sigma_1);
pdf_1 = reshape(pdf_1, length(x2), length(x1));
pdf_2 = mvnpdf(X, mu, Sigma_2);
pdf_2 = reshape(pdf_2, length(x2), length(x1));

figure('Units', 'normalized', 'Position', [0.2164, 0.2532, 0.4328, 0.5255])
colormap("jet")
LineWidth = 1.5;
% Tile1
nexttile
contour(x1, x2, pdf_1, LineWidth=LineWidth)
colorbar
xlabel('x1')
ylabel('x2')
title('contour')
axis equal

% Tile2
nexttile
contour(x1, x2, pdf_2, LineWidth=LineWidth)
colorbar
xlabel('x1')
ylabel('x2')
title('contour')
axis equal

% Tile3
md_1 = mahal(repmat(mu, height(X), 1), X);
md_1 = sqrt(md_1);
% md_1 = reshape(md_1, length(x2), length(x1));
% nexttile
% contour(x1, x2, md_1, LineWidth=LineWidth)
% colorbar
% xlabel('x1')
% ylabel('x2')
title('contour')
axis equal

