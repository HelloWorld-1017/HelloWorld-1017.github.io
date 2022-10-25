clc, clear, close all

A = [2, 5;
    3, 3;
    4, 2;
    7, 4;
    9, 6];
mus = mean(A);
num = height(A);

cov11 = mean( (A(:, 1)-mus(1)) .* (A(:, 1)-mus(1)) )*num/(num-1);
cov12 = mean( (A(:, 1)-mus(1)) .* (A(:, 2)-mus(2)) )*num/(num-1);
cov21 = mean( (A(:, 2)-mus(2)) .* (A(:, 1)-mus(1)) )*num/(num-1);
cov22 = mean( (A(:, 2)-mus(2)) .* (A(:, 2)-mus(2)) )*num/(num-1);

cov_custom = [cov11, cov12; cov21, cov22];
cov_bultin = cov(A);

cov_custom, cov_bultin