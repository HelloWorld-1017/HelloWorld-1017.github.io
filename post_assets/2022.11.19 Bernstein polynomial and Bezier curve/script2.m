clc, clear, close all

LineWidth = 1.5;
syms t

b3 = selfbernstein(@(t) sin(2*pi*t), 3, t);
b10 = selfbernstein(@(t) sin(2*pi*t), 10, t);
b100 = selfbernstein(@(t) sin(2*pi*t), 100, t);

hold(gca, "on")
grid(gca, "on")
box(gca, "on")
fplot(sin(2*pi*t), [0,1], LineWidth=LineWidth)
fplot(b3, [0, 1], LineWidth=LineWidth)
fplot(b10, [0,1], LineWidth=LineWidth)
fplot(b100, [0,1], LineWidth=LineWidth)
legend('sine function', ...
    '2th-degree polynomial',...
    '10th-degree polynomial',...
    '100th-degree polynomial')
title('Bernstein polynomials')