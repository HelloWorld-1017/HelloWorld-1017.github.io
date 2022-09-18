% Compute the pdf and cdf of an F distribution 
% with 5 numerator degrees of freedom and 3 denominator degrees of freedom.
x = 0:0.01:10;
fp = fpdf(x, 5, 3);
fc = fcdf(x, 5, 3);

figure('Units', 'pixels', 'Position', [335, 352, 886, 669])
LineWidth = 1;
% Plot the PDF
nexttile
plot(x, fp, LineWidth=LineWidth)
xlabel('Observation')
ylabel('Probability Density')
grid on
box on
% The plot shows that the F distribution exists on positive real numbers and is skewed to the right.

% Plot the CDF
nexttile
plot(x, fc, LineWidth=LineWidth)
xlabel('Observation')
ylabel('Cumulative Probability')
grid on
box on
