clc, clear, close all

% Compute the pdf of a chi-square distribution with 4 degrees of freedom.
x = 0:0.2:15;
chi2p = chi2pdf(x, 4);

figure('Units', 'pixels', 'Position', [335, 352, 886, 669])
LineWidth = 1;
% Plot the PDF
nexttile
plot(x, chi2p, LineWidth=LineWidth)
xlabel('Observation')
ylabel('Probability Density')
grid on
box on
% The chi-square distribution is skewed to the right, especially for few degrees of freedom.

% Compute the cdf of a chi-square distribution with 4 degrees of freedom.
chi2c = chi2cdf(x, 4);
% Plot the CDF
nexttile
plot(x, chi2c, LineWidth=LineWidth)
xlabel('Observation')
ylabel('Cumulative Probability')
grid on
box on