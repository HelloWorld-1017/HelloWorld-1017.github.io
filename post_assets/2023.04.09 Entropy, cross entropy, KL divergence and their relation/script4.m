clc, clear, close all

x = 1e-3:5e-3:1-1e-3;
y = x;

[X,Y] = meshgrid(x,y);
Z = (1-X-Y);
Z(Z<0) = nan;
entropy = -(X.*log(X)+Y.*log(Y)+Z.*log(Z));

figure('Units','pixels','Position',[671.67,473.67,1015.33,420])
tiledlayout(1,2)
nexttile
hold(gca,"on")
box(gca,"on")
grid(gca,"on")
view(3)
surf(X,Y,entropy,'EdgeColor','none')
colorbar
xlabel('$x$','Interpreter','latex')
ylabel('$y$','Interpreter','latex')
zlabel('S(x,y)','Interpreter','latex')
title('$S(x,y)=x\log x+y\log y+(1-x-y)\log (1-x-y)$', ...
    'Interpreter','latex')
xlim([0,1])
ylim([0,1])

nexttile
hold(gca,"on")
box(gca,"on")
grid(gca,"on")
imagesc(x,y,entropy)
colorbar
xlabel('$x$','Interpreter','latex')
ylabel('$y$','Interpreter','latex')
title('$S(x,y)=x\log x+y\log y+(1-x-y)\log (1-x-y)$', ...
    'Interpreter','latex')
xlim([0,1])
ylim([0,1])
