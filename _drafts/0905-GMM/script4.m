clc, clear, close all

% Generate a correlated bivariate sample data set
mu = [0; 0];
Sigma = [1 .9; .9 1];
rng('default') % For reproducibility
X = mvnrnd(mu, Sigma,1000); 
meanX = mean(X);

% Specify four observations that are equidistant from the mean of X in Euclidean distance
Y = [1 1;1 -1;-1 1;-1 -1];

% Compute the Mahalanobis distance of each observation in Y to the reference samples in X.
d2_mahal = mahal(Y, X);

% Compute the squared Euclidean distance of each observation in Y from the mean of X .
d2_Euclidean = sum((Y-mean(X)).^2, 2);

scatter(X(:,1), X(:,2), 10, 'filled') % Scatter plot with points of size 10
hold on
scatter(Y(:,1), Y(:,2), 100, d2_mahal, 'o', 'filled')
scatter(meanX(1), meanX(2), 100, 'ko', 'filled')
colormap("jet")
hb = colorbar;
box on
grid on
ylabel(hb, 'Mahalanobis Distance')
xlabel('x1')
ylabel('x2')
legend('X', 'Y', 'Sample mean', 'Location', 'best')