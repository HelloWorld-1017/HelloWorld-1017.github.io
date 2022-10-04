clc, clear, close all

N = 50;
p = 0.6;
x1 = 0:N;
y1 = binopdf(x1, N, p);

mu = N*p;
sigma = sqrt(N*p*(1-p));
x2 = 0:0.1:N;
y2 = normpdf(x2, mu, sigma);

figure
hold(gca, "on")
grid(gca, "on")
box(gca, "on")
bar(x1, y1, 1)
plot(x2, y2, 'LineWidth',2)
xlabel('Observation')
ylabel('Probability')
title('Binomial and Normal pdfs')
legend('Binomial Distribution','Normal Distribution','location','northwest')

