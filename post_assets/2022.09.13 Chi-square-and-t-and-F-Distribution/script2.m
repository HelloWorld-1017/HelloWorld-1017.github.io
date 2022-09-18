clc, clear, close all

% Compute the pdf of a Student's t distribution 
% with degrees of freedom equal to 5, 10, and 50.
x = -5:.1:5;
tp1 = tpdf(x, 5);
tp2 = tpdf(x, 10);
tp3 = tpdf(x, 50);
% Compute the pdf of standard normal dist.
tpn = normpdf(x,0,1);

figure('Units', 'pixels', 'Position', [335, 352, 886, 669])
LineWidth = 1;
% Plot the pdf for all three choices n, and standard normal dist. on the same axis.
nexttile
hold on
plot(x, tp1, 'Color', 'green', 'LineStyle', '-', LineWidth=LineWidth)
plot(x, tp2, 'Color', 'red', 'LineStyle','-.', LineWidth=LineWidth)
plot(x, tp3, 'Color', 'blue', 'LineStyle','--', LineWidth=LineWidth)
plot(x, tpn, 'Color', 'black', 'LineStyle','-', LineWidth=LineWidth)
xlabel('Observation')
ylabel('Probability Density')
legend({'n = 5', 'n = 10', 'n = 50', 'Standard norm'})
grid on
box on

% Compute the cdf of a Student's t distribution 
% with degrees of freedom equal to 5, 10, and 50.
tc1 = tcdf(x, 5);
tc2 = tcdf(x,10);
tc3 = tcdf(x, 50);
% Compute CDF of standard normal dist.
tcn = normcdf(x, 0, 1);

% Plot the cdf for all three choices of nu, and standard normal dist. on the same axis.
nexttile
hold on
plot(x, tc1, 'Color', 'green', 'LineStyle', '-', LineWidth=LineWidth)
plot(x, tc2, 'Color', 'red', 'LineStyle', '-.', LineWidth=LineWidth)
plot(x, tc3, 'Color', 'blue', 'LineStyle', '--', LineWidth=LineWidth)
plot(x, tcn, 'Color', 'black', 'LineStyle', '--', LineWidth=LineWidth)
xlabel('Observation')
ylabel('Cumulative Probability')
legend({'n = 5','n = 10','n = 50', 'Standard norm'})
grid on
box on
