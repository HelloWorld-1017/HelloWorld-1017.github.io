clc, clear, close all

xdata = linspace(0, 10, 10)';
ydata1 = xdata + 1;
ydata2 = xdata - 1;

figure, axes
hold(gca, "on")
grid(gca, "on")
box(gca, "on")
plot(xdata, ydata1, LineWidth=1.5)
plot(xdata, ydata2, LineWidth=1.5)
fill([xdata; flipud(xdata)], [ydata1; flipud(ydata2)], ...
    'b', 'FaceAlpha', 0.2, 'EdgeColor', 'none')
legend("y=x+1", "y=x-1", "Location", "best")