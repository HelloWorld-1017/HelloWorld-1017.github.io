% MATLAB script
clc, clear, close all

% Plot function curve
a = 0.4; b = 1;
x = a:0.01:b;
y = (x-2/3).^3;

LineWidth = 1.7;
Interpreter = 'latex';
plot(x, y, LineWidth=LineWidth), hold on
hline = plot([a, b],[0, 0], ...
    'LineStyle','--', ...
    LineWidth=LineWidth,...
    Color="#7F7F7F"...
    ); hold on
scatter(2/3, 0, 57, 'filled', MarkerFaceColor=[200, 92, 92]/255)
xlabel('$x$', Interpreter=Interpreter)
ylabel('$f(x)$', Interpreter=Interpreter)
title('Function curve')
