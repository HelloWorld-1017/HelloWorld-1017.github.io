clc, clear, close all

mu = 0;
sigma = 1;
x = -5:0.01:5;
y = normpdf(x, mu, sigma);

figure(1)
plot(x, y, LineWidth=1.5);
title(sprintf('Normal Distribution PDf\n mu = %d, sigma = %d', mu, sigma))
box on
grid on

figure(2)
plot(x, y, LineWidth=1.5);
t = ['Normal Distribution PDF'; 
    '$\mu$ = ', num2str(mu), ', $\sigma$ = ', num2str(sigma)];
title(t, Interpreter="latex")
box on
grid on

figure(3)
plot(x, y, LineWidth=1.5);
t = 'Normal Distribution PDF';
subt = ['$\mu$ = ', num2str(mu), ', $\sigma$ = ', num2str(sigma)];
[tt, ss] = title(t, subt, Interpreter="latex");
box on
grid on
