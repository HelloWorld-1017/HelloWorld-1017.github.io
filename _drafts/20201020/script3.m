clc, clear, close all

load hald

A = hald;
[coeff, score, latent, tsquared, explained, mu] = pca(A);
for idx = 1:width(A)
    B = A*coeff(:, 1:idx);
    X = inv(B'*B)*B'*A;
    D = B*X;
    disp(norm(D-A, 2))
end