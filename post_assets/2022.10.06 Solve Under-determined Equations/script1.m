clc, clear, close all

A = [1, 1, 1;
    4, 2, 1];
b = [1;-2];
x = A'*inv(A*A')*b;

xdata = linspace(0, 3, 100);
ydata = x(1)*xdata.^2+x(2)*xdata+x(3);

figure, axes
hold(gca, "on")
grid(gca, "on")
box(gca, "on")
scatter([1, 2], [1, -2], 'filled', DisplayName='Data')
plot(xdata, ydata, LineWidth=1.5, DisplayName='Fitting curve')
title(['y=', num2str(x(1)), '$x^2$+', num2str(x(2)), '$x+$', num2str(x(3))], Interpreter='latex')
legend

