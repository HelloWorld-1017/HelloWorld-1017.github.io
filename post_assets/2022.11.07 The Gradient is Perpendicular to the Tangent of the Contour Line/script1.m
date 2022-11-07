clc, clear, close all

x = -5:0.2:5;
y = x;

[X, Y] = meshgrid(x, y);
Z = X.^2+Y.^2;
[px, py] = gradient(Z);

figure("Units", "pixels", "Position", [544,390,959,347])
tiledlayout(1, 2)

nexttile
view(3)
hold(gca, "on")
box(gca, "on")
grid(gca, "on")
colormap("jet")
surfc(X, Y, Z)

nexttile
hold(gca, "on")
box(gca, "on")
grid(gca, "on")
colormap("jet")
axis equal
contour(X,Y,Z, LineWidth=1.5)
interval = 3;
quiver(x(1:interval:end), y(1:interval:end), ...
    px(1:interval:end, 1:interval:end), ...
    py(1:interval:end, 1:interval:end), 'k', "filled")
