clc, clear, close
figure, axes

i = -3:0.01:3;
u = (1/3)*i.^3-i;
hold(gca, "on")
plot(u, i, LineWidth=1.5);
scatter(0, 0, 'filled');

grid on