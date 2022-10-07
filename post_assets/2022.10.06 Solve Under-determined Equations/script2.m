clc, clear, close all

A1 = [1, 1, 1;
    4, 2, 1;
    2, 1, 0];
b1 = [1;-2;0];
x1 = inv(A1)*b1;

A2 = [1, 1, 1;
    4, 2, 1;
    4, 1, 0];
b2 = [1;-2;0];
x2 = inv(A2)*b2;

xdata = linspace(0, 3, 100);
ydata1 = x1(1)*xdata.^2+x1(2)*xdata+x1(3);
ydata2 = x2(1)*xdata.^2+x2(2)*xdata+x2(3);

figure
tiledlayout(1, 2)

nexttile
hold(gca, "on")
grid(gca, "on")
box(gca, "on")
scatter([1, 2], [1, -2], 'filled', DisplayName='Data')
plot(xdata, ydata1, LineWidth=1.5, DisplayName='Fitting curve')
title(['y=', num2str(x1(1)), '$x^2$+', num2str(x1(2)), '$x+$', num2str(x1(3))], Interpreter='latex')
legend

nexttile
hold(gca, "on")
grid(gca, "on")
box(gca, "on")
scatter([1, 2], [1, -2], 'filled', DisplayName='Data')
plot(xdata, ydata2, LineWidth=1.5, DisplayName='Fitting curve')
title(['y=', num2str(x2(1)), '$x^2$+', num2str(x2(2)), '$x+$', num2str(x2(3))], Interpreter='latex')
legend