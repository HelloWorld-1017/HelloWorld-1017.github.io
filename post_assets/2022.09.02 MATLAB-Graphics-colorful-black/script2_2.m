clc, clear, close all

points_x = [0, 2];
points_y = [0, 0];
interval = linspace(0, 2, 100);
[xGrid, yGrid] = meshgrid(interval, interval);
x = xGrid(:);
y = yGrid(:);
d1 = (x-points_x(1)).^2+(y-points_y(1)).^2;
d2 = (x-points_x(2)).^2+(y-points_y(2)).^2;
D = [d1, d2];
[~, idx] = min(D, [], 2);
contourf(xGrid, yGrid, ...
    reshape(idx, size(xGrid, 1), size(yGrid, 2)),...
    'EdgeColor','none');
colorbar
