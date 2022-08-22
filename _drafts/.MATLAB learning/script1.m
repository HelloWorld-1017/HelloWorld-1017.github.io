clc, clear, close

x0 = [2; 0];
A = [-0.1 -1; 1 -0.1];
func = @(t, y) A*y;

numTimeSteps = 3000;
T = 50;
odeOptions = odeset(RelTol=1.e-7);
t = linspace(0, T, numTimeSteps);

[~, x]  = ode45(func, t, x0, odeOptions);

LineWidth = 1.5;
fig = figure('Position',[504, 471,1030, 420]);
subplot(1,2,1)
hold(gca, "on")
plot(t, x(:,1), LineWidth=LineWidth)
plot(t, x(:,2), LineWidth=LineWidth)
legend('$x_1(t)$', '$x_2(t)$', ...
    Interpreter='latex')
xlabel('$t$', Interpreter='latex')
ylabel('$x$', Interpreter='latex')
title('State variables varies over time')

subplot(1,2,2)
hold(gca, "on")
plot(x(:,1), x(:,2), LineWidth=LineWidth)
scatter(x0(1), x0(2), 'filled')
scatter(x(end, 1), x(end, 2), 'filled')
legend('Phase trajectory', 'Initial point', 'End point')
xlabel('$x_1$', Interpreter='latex')
ylabel('$x_2$', Interpreter='latex')
title('Phase plain')