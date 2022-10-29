clc, clear, close all

A = [1, 3, 6, 17, 7;
    8, 9, 2, 5, 8;
    7, 7, 0, 2, 5];
mu = mean(A);
sigma = std(A);

A_normalized = (A-mu)./sigma;

mean(A_normalized), var(A_normalized)