clc, clear, close all

mu = [0 0];
Sigma = [0.25 0.3; 0.3 1];

% Compute the probability over the unit square
[p, err] = mvncdf([0 0], [1 1], mu, Sigma);

x1 = -3:.2:3;
x2 = -3:.2:3;
[X1,X2] = meshgrid(x1,x2);
X = [X1(:) X2(:)];


figure('Units', 'pixels', 'Position', [581.6667, 255, 905.3333, 950])
colormap("jet")
% Tile1, PDF values
nexttile
pdf = mvnpdf(X, mu, Sigma);
pdf = reshape(pdf, length(x2), length(x1));
contour(x1, x2, pdf, [0.0001 0.001 0.01 0.05 0.15 0.25 0.35], LineWidth=1.3)
line([0 0 1 1 0], [1 0 0 1 1], 'Linestyle', '--', 'Color', 'k', LineWidth=1.7)
colormap("jet")
colorbar
xlabel('x1')
ylabel('x2')
title('PDF values')

% Tile2, CDF values
nexttile
cdf = mvncdf(X, mu, Sigma);
cdf = reshape(cdf, length(x2), length(x1));
contour(x1, x2, cdf, LineWidth=1.3)
line([0 0 1 1 0], [1 0 0 1 1], 'Linestyle', '--', 'Color', 'k', LineWidth=1.7)
colormap("jet")
colorbar
xlabel('x1')
ylabel('x2')
title('CDF values')