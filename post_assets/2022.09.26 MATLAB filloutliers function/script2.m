clc, clear, close all
rng('default')

A = ceil(randn(100, 1)*10); A(20) = 200;
[cleanedA, outlierIndices, thresholdL, thresholdH, center] = ...
    filloutliers(A, "linear", "movmedian",  15);

figure, axes 
hold(gca, "on")
box(gca, "on")
grid(gca, "on")

% Plot original data
plot(A, "Color", [77 190 238]/255, "DisplayName", "Input data")
% Plot results
plot(cleanedA, "Color", [0 114 189]/255, "LineWidth", 1.5,...
    "DisplayName", "Cleaned data")
% Plot outliers
plot(find(outlierIndices), A(outlierIndices), "x", "MarkerSize", 10, ...
    "Color", [64 64 64]/255, "DisplayName", "Outliers")
% Plot filled outliers
plot(find(outlierIndices), cleanedA(outlierIndices), ".", "MarkerSize", 20,...
    "Color", [217 83 25]/255, "DisplayName", "Filled outliers")
% Plot outlier thresholds
plot([(1:numel(A))'; missing; (1:numel(A))'],...
    [thresholdH(:); missing; thresholdL(:)], ...
    "Color", [145 145 145]/255, ...
    "DisplayName", "Outlier thresholds")
% Plot outlier center
plot(center, "k", "LineWidth", 1.5, "DisplayName", "Outlier center")
title("Number of outliers cleaned: " + nnz(outlierIndices))
legend('Location', 'best')

contrast1 = movmedian(A, 15) == center;
c = -1/(sqrt(2)*erfcinv(3/2));
contrast2 = center+3*c*movmedian(abs(A - movmedian(A, 15)), 15)-thresholdH;
contrast3 = center-3*c*movmedian(abs(A - movmedian(A, 15)), 15)-thresholdL;
nnz(contrast1), nnz(contrast2), nnz(contrast3)

