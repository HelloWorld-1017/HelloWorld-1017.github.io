clc, clear, close all

load fisheriris;
X = meas(:,1:2);
[n, p] = size(X);

figure(1)
plot(X(:,1), X(:, 2), '.', 'MarkerSize', 15);
title('Fisher''s Iris Data Set');
xlabel('Sepal length (cm)');
ylabel('Sepal width (cm)');


rng(3);
% Specify number of GMM components
k = 3; 
% Specify maximum iterations for EM algorith
options = statset('MaxIter',1000); 

% Specify coviarance structure options
Sigma = {'diagonal', 'full'}; % Options for covariance matrix type
nSigma = numel(Sigma);
SharedCovariance = {true, false}; % Indicator for identical or nonidentical covariance matrices
SCtext = {'true' ,'false'};
nSC = numel(SharedCovariance);

% Create a 2-D grid covering the plane composed of extremes of the measurements. 
% Later use this grid later to draw confidence ellipsoids over the clusters.
d = 500; % Grid length
x1 = linspace(min(X(:,1))-2, max(X(:,1))+2, d);
x2 = linspace(min(X(:,2))-2, max(X(:,2))+2, d);
[x1grid, x2grid] = meshgrid(x1, x2);
X0 = [x1grid(:) x2grid(:)];


% chi2inv, returns the inverse cumulative distribution function (icdf) of the chi-square distribution 
% with degrees of freedom 2, evaluated at the probability values in 0.99.
threshold = sqrt(chi2inv(0.99, 2));

figure('Units', 'pixels', 'Position', [585, 307, 1120, 793])
count = 1;
for i = 1:nSigma
    for j = 1:nSC
        gmfit = fitgmdist(X, k, 'CovarianceType', Sigma{i}, ...
            'SharedCovariance', SharedCovariance{j}, 'Options', options); % Fitted GMM
        clusterX = cluster(gmfit, X); % Cluster index 
        mahalDist = mahal(gmfit, X0); % Distance from each grid point to each GMM component
        % Draw ellipsoids over each GMM component and show clustering result.
        subplot(2, 2, count);
        h1 = gscatter(X(:,1), X(:,2), clusterX);
        hold on
            for m = 1:k
                idx = mahalDist(:, m)<=threshold;
                Color = h1(m).Color*0.75 - 0.5*(h1(m).Color - 1);
                h2 = plot(X0(idx, 1), X0(idx, 2), '.', 'Color', Color, 'MarkerSize', 1);
                uistack(h2, 'bottom');
            end    
        plot(gmfit.mu(:,1), gmfit.mu(:, 2), 'kx', 'LineWidth', 2, 'MarkerSize', 10)
        title(sprintf('Sigma is %s\nSharedCovariance = %s', Sigma{i}, SCtext{j}), 'FontSize', 8)
        legend(h1, {'1', '2', '3'})
        hold off
        count = count+1;
    end
end

figure('Units', 'pixels', 'Position', [585, 307, 1120, 793])
% For the first GMM, assign most data points to the first cluster
initialCond1 = [ones(n-8, 1); [2; 2; 2; 2]; [3; 3; 3; 3]]; 
% For the second GMM, randomly assign data points to clusters
initialCond2 = randsample(1:k, n, true); 
% For the third GMM, make another random assignment of data points to clusters
initialCond3 = randsample(1:k, n, true); 
% For the fourth GMM, use k-means++ to obtain initial cluster centers
initialCond4 = 'plus'; 
cluster0 = {initialCond1; initialCond2; initialCond3; initialCond4};

% Record convergence situation
converged = nan(4, 1);
% For all instances, use k = 3 components, unshared and full covariance matrices, 
% the same initial mixture proportions, and the same initial covariance matrices. 
% For stability when you try different sets of initial values,
% increase the number of EM algorithm iterations. Also, draw confidence ellipsoids over the clusters.
for j = 1:4
    gmfit = fitgmdist(X, k, 'CovarianceType', 'full', ...
        'SharedCovariance', false, 'Start', cluster0{j}, ...
        'Options', options);
    clusterX = cluster(gmfit, X); % Cluster index 
    mahalDist = mahal(gmfit, X0); % Distance from each grid point to each GMM component
    % Draw ellipsoids over each GMM component and show clustering result.
    subplot(2, 2, j);
    h1 = gscatter(X(:, 1), X(:, 2), clusterX); % Distance from each grid point to each GMM component
    hold on;
    nK = numel(unique(clusterX));
    for m = 1:nK
        idx = mahalDist(:,m)<=threshold;
        Color = h1(m).Color*0.75 + -0.5*(h1(m).Color - 1);
        h2 = plot(X0(idx, 1),X0(idx, 2), '.', 'Color', Color, 'MarkerSize', 1);
        uistack(h2, 'bottom');
    end
	plot(gmfit.mu(:,1), gmfit.mu(:,2), 'kx', 'LineWidth', 2, 'MarkerSize', 10)
    legend(h1, {'1', '2', '3'});
    hold off
    converged(j) = gmfit.Converged; % Indicator for convergence
end
sum(converged)
