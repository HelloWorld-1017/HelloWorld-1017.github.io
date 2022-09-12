clc, clear, close all

% Specify parameters
x = -7:.1:7;
mu_1 = -2;
sigma_1 = 1;
mu_2 = 2;
sigma_2 = 2;

% The PDF of N1 and N2
y1 = normpdf(x, mu_1, sigma_1);
y2 = normpdf(x, mu_2, sigma_2);

% Sample points
x_1 = sigma_1*randn(50, 1) + mu_1;
x_2 = sigma_2*randn(50, 1) + mu_2;

% The PDF of Single Gaussian distribution
mu = mean([x_1; x_2]);
sigma = cov([x_1; x_2]);
Y = normpdf(x, mu, sigma);

% The weights of Gaussian Mixture PDF
alpha_1s = 0.1:0.2:0.7;

LineWidth = 1.5;
figure('Units', 'pixels', 'Position', [589 ,219, 1260, 1025])
% Plot schematics
for idx = 1:4
    nexttile
    hold(gca, "on")
    scatter(x_1, zeros(size(x_1)), 70, 'x', LineWidth=1)
    scatter(x_2, zeros(size(x_2)), 70, '*', LineWidth=1)
    plot(x, y1, LineWidth=LineWidth)
    plot(x, y2, LineWidth=LineWidth)
    alpha_1 = alpha_1s(idx);
    alpha_2 = 1-alpha_1;
    plot(x, alpha_1*y1+alpha_2*y2, 'k', LineWidth=LineWidth+0.5)
    plot(x, Y, 'b', LineWidth=LineWidth+0.5)
    legend('$x\in N_1$', '$x\in N_2$', '$N_1$', '$N_2$', 'Mixture N', 'Single N', Interpreter="latex")
    xlabel('$x$', Interpreter="latex")
    ylabel('PDF')
    title(['Gaussian Mixture PDF, ', '$\alpha_1=$', num2str(alpha_1), ', $\alpha_2=$', num2str(alpha_2)], Interpreter="latex")
    box on
    grid on
end