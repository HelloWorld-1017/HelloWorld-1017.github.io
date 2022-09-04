clc, clear, close all

x = [5 8];
y = [3 6];
C = [0 2 4 6; 8 10 12 14; 16 18 20 22];
imagesc(x, y, C)
% imagesc('xData', x, 'yData', y,'CData', C) % Method 1
set(gca, 'yDir', 'normal') % Method 2
colorbar