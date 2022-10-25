clc, clear, close all

A = [2, 5;
    3, 3;
    4, 2;
    7, 4;
    9, 6];
mus = mean(A);

cov11 = mean( (A(:, 1)-mus(1)) .* (A(:, 1)-mus(1)) );
cov12 = mean( (A(:, 1)-mus(1)) .* (A(:, 2)-mus(2)) );
cov21 = mean( (A(:, 2)-mus(2)) .* (A(:, 1)-mus(1)) );
cov22 = mean( (A(:, 2)-mus(2)) .* (A(:, 2)-mus(2)) );

covself = [cov11, cov12; cov21, cov22];
covself - cov(A, 1)
var(A)