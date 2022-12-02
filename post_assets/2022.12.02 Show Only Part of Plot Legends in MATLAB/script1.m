clc, clear, close all

rng("default")

x = 1:20;
y1 = randn(1, 20);
y2 = randn(1, 20);
y3 = randn(1, 20);

figure
nexttile
hold(gca, "on")
box(gca, "on")
LineWidth = 1.5;
plot(x, y1, "LineWidth", LineWidth, "Color", 'r')
plot(x, y2, "LineWidth", LineWidth, "Color", 'g', "handlevisibility", 'off')
plot(x, y3, "LineWidth", LineWidth, "Color", 'b')
legend("y1", "y3")
