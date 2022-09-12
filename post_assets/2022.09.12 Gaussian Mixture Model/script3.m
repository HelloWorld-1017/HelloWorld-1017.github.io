clc, clear, close all

load fisheriris
X = meas(:, 1:2);
gscatter(X(:, 1), X(:, 2), species)