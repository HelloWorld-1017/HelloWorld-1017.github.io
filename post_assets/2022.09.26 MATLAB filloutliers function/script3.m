clc, clear, close all

A = [60 59 49 49 58 100 61 57 48 58];
[cleanedA, outlierIndices, thresholdL, thresholdH, center] = ...
    filloutliers(A, "clip");

figure, axes 
hold(gca, "on")
box(gca, "on")

% Plot original data
plot(A, "Color", [77 190 238]/255)
% Plot results
plot(cleanedA, "Color", [0 114 189]/255, "LineWidth", 1.5)
% Plot outliers
plot(find(outlierIndices), A(outlierIndices), "x", "MarkerSize", 10, ...
    "Color", [64 64 64]/255)
% Plot filled outliers
plot(find(outlierIndices), cleanedA(outlierIndices), ".", "MarkerSize", 20,...
    "Color", [217 83 25]/255)
% Plot lower thrshold, upper threshold, and center 
yline([thresholdL thresholdH center], ":", ["Lower Threshold","Upper Threshold","Center Value"])
title("Number of outliers cleaned: " + nnz(outlierIndices))
legend("Input data", "Cleaned data", "Outliers", "Filled outliers", "", "", "", ...
    "Location", "best")