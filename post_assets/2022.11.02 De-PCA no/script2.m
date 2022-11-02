clc, clear, close all

load hald

A = hald;
mu = mean(A);
sigma = std(A);

ANormalized = (A-mu)./sigma;
[coeff, score, latent, tsquared, explained, mu] = ...
    pca(ANormalized);
for idx = 1:width(ANormalized)
    B = coeff(:, 1:idx);
    C = A*B;
    D = C*B';
%     % If anti-normalize
%     D = D.*sigma+mu;
    disp(norm(D-A, 2))
end