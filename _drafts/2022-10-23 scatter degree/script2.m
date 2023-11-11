clc, clear, close all

y1 = randn(1, 1e6);
sk1 = kurtosis(y1, 1);
disp(sk1)

y2 = 2*randn(1, 1e6)+1;
sk2 = kurtosis(y2, 1);
disp(sk2)