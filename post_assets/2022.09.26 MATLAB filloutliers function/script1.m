clc, clear, close all

A = [57 59 60 100 59 58 57 58 300 61 62 60 62 58 57];
[cleanedA, outlierIndices, thresholdL, thresholdH, center] = ...
    filloutliers(A, "linear", "mean");

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
    [thresholdH(:)*ones(numel(A), 1); missing; thresholdL(:)*ones(numel(A), 1)], ...
    "Color", [145 145 145]/255, ...
    "DisplayName", "Outlier thresholds")
% Plot outlier center
plot(center*ones(numel(A), 1), "k", "LineWidth", 1.5, "DisplayName", "Outlier center")
title("Number of outliers cleaned: " + nnz(outlierIndices))
legend('Location', 'best')