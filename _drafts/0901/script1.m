clc, clear, close all

x = [0, 0; 2, 0];

interval = linspace(0, 2, 100);
[xGrid, yGrid] = meshgrid(interval, interval);
x = xGrid(:);
y = yGrid(:);
d1 = (x-0).^2+(y-0).^2;
d2 = (x-2).^2+(y-0).^2;
D = [d1, d2];
[~, idx] = min(D, [], 2);
% contourf(xGrid, yGrid, ...
%     reshape(idx, size(xGrid, 1), size(yGrid, 2)));

imagesc(x, y, ...
    reshape(idx, size(xGrid, 1), size(yGrid, 2)));% Top to down
colorbar 