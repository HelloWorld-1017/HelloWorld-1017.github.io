clc, clear, close all

A = [1, 3, 6, 17, 7;
    8, 9, 2, 5, 8;
    7, 7, 0, 2, 5];

[A_normalized, mu, sigma] = normalize(A);

mu, sigma, A_normalized