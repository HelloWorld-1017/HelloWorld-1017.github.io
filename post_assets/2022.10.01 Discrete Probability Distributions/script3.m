clc, clear, close all

x = 0:10;

figure
nexttile
bar(x, poisspdf(x, 2), 1)
xlabel('Observation')
ylabel('PMF')
grid on

nexttile
stairs(x, poisscdf(x, 2), LineWidth=1.5)
xlabel('Observation')
ylabel('CDF')
grid on