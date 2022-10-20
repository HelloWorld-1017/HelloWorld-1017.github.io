clc, clear, close all

load hald

A = hald;
[coeff, score, latent, tsquared, explained, mu] = pca(A);
for idx = 1:width(A)
    B = coeff(:, 1:idx);
    C = A*B;
    D = C*B';
    disp(norm(D-A, 2))
end
