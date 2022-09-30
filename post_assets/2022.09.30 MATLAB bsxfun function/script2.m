clc, clear, close all

xp = linspace(0, 1, 30);
ks = 1:4;
C = bsxfun(@(x, k) exp(k*x), xp', ks);
plot(repmat(xp', 1, numel(ks)), C, LineWidth=1.5);
legend('k=1', 'k=2', 'k=3', 'k=4', "Location", "best")
grid on

