clc, clear, close

numpoints = 3000;
T = 50;
t = linspace(0, T, numpoints);
x1 = @(t) 2*exp(-0.1*t).*cos(t);
x2 = @(t) 2*exp(-0.1*t).*sin(t);

LineWidth = 1.5;
fig = figure('Position',[504, 471,1030, 420]);
subplot(1,2,1)
hold(gca, "on")
plot(t, x1(t), LineWidth=LineWidth)
plot(t, x2(t), LineWidth=LineWidth)
legend('$x_1(t)$', '$x_2(t)$', ...
    Interpreter='latex')
xlabel('$t$', Interpreter='latex')
ylabel('$x$', Interpreter='latex')
title('State variables varies over time')

subplot(1,2,2)
hold(gca, "on")
plot(x1(t), x2(t), LineWidth=LineWidth)
scatter(x1(t(1)), x2(t(1)), 'filled')
scatter(x1(t(end)), x2(t(end)), 'filled')
legend('Phase trajectory', 'Initial point', 'End point')
xlabel('$x_1$', Interpreter='latex')
ylabel('$x_2$', Interpreter='latex')
title('Phase plain')

