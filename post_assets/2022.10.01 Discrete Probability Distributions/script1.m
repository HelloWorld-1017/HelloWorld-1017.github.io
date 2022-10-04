clc, clear, close all

x = 0:10;

figure
nexttile
bar(x, binopdf(x, 10, 0.5), 1)
xlabel('Observation')
ylabel('PMF')
grid on

nexttile
stairs(x, binocdf(x,10, 0.5), LineWidth=1.5)
xlabel('Observation')
ylabel('CDF')
grid on
