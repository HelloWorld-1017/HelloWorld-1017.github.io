clc, clear, close all

% Generate a correlated bivariate sample data set
mu = [0; 0];
Sigma = [1 .9; .9 1];
rng('default') % For reproducibility
X = mvnrnd(mu, Sigma,1000); 

% Specify four observations that are equidistant from the mean of X in Euclidean distance
Y = [1 1;1 -1;-1 1;-1 -1];

% Compute the Mahalanobis distance of each observation in Y to the reference samples in X.
d2_mahal = mahal(Y, X);

% Compute the squared Euclidean distance of each observation in Y from the mean of X .
meanX = mean(X);
d2_Euclidean = sum((Y-meanX).^2, 2);


% Plot schematics
figure('Units', 'pixels', 'Position', [381, 314, 1059, 442])
tiledlayout(1, 2)
colormap("jet")
% Plot sample in Euclidean space
nexttile
hold(gca, "on")
scatter(X(:,1), X(:,2), 5, 'filled') % Scatter plot with points of size 10
scatter(Y(:,1), Y(:,2), 100, d2_mahal, 'o', 'filled')
scatter(meanX(1), meanX(2), 100, 'ko', 'filled')
hb1 = colorbar;
ylabel(hb1, 'Mahalanobis Distance')
xlabel('x1')
ylabel('x2')
legend('X', 'Y', 'Sample mean', 'Location', 'best')
title('(a) Mahalanobis Distance in Euclidean Space')
box on
grid on

% Calculate the the inverse of the Sigma
Sigma_inv = inv(Sigma);

% Operate Cholesky factorization for the Sigma^{-1}
% Sigma_inv = W*W^T;
W = chol(Sigma_inv, "lower");

% Transform Euclidean disatance
d_Euclidean = Y-meanX;   % d_Euclidean = x-mu
d_mahal = d_Euclidean*W; % d_mahal = (x-mu)W
d2_mahal_cal = sum(d_mahal.^2, 2); % d2_mahal_cal = [(x-mu)W][W^T(x-mu)^T]

% Transform sample
X_trans = X*W;
d2_mahal_trans = mahal(Y, X_trans);
meanX_trans = mean(X_trans);
d2_Euclidean_trans = sum((Y-meanX_trans).^2, 2);

% Plot samples in transformed space
nexttile
hold(gca, "on")
scatter(X_trans(:, 1), X_trans(:, 2), 5, 'filled')
scatter(Y(:,1), Y(:,2), 100, d2_mahal_trans, 'o', 'filled')
scatter(meanX_trans(1), meanX_trans(2), 100, 'ko', 'filled')
hb2 = colorbar;
ylabel(hb2, 'Euclidean Disatance in Transfored Space')
xlabel('x1')
ylabel('x2')
legend('X', 'Y', 'Sample mean', 'Location', 'best')
title('(b) Mahalanobis Distance in Transformed Space')
box on
grid on




