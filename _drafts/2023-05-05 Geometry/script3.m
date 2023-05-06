clc,clear,close all

xt = @(t) cos(t);
yt = @(t) sin(t);

hold(gca,"on")
box(gca,"on")
grid(gca,"on")
axis equal
fplot(xt,yt,[0,2*pi],'LineWidth',1.5)
