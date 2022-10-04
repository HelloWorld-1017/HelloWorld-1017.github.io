clc, clear, close all

x = 0:10;
M = 10;
K = 5;
N = 5;

figure
nexttile
bar(x, hygepdf(x, M, K, N), 1)
xlabel('Observation')
ylabel('PMF')
grid on

nexttile
stairs(x, hygecdf(x, M, K, N), LineWidth=1.5)
xlabel('Observation')
ylabel('CDF')
grid on