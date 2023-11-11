clc, clear, close all

x1 = -1:0.01:-0.2;
x2 = -x1;
y1 = 3./x1.^2;
y2 = 3./x2.^2;

figure
LineWidth = 1.5;
hold(gca, "on")
box(gca, "on")
grid(gca, "on")
plot(x1, y1, 'b', LineWidth=LineWidth)
plot(x2, y2, 'b', LineWidth=LineWidth)
