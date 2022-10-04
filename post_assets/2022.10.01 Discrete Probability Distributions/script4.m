clc, clear, close all

N = 20;
p = 0.05;
x = 0:N;
y1 = binopdf(x, N, p);

mu = N*p;
y2 = poisspdf(x, mu);

figure
hold(gca, "on")
grid(gca, "on")
box(gca, "on")
bar(x, [y1; y2])
xlabel('Observation')
ylabel('Probability')
title('Binomial and Poisson pdfs')
legend('Binomial Distribution', 'Poisson Distribution', ...
    'location','northeast')