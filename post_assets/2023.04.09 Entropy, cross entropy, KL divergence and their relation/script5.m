clc, clear, close all


figure('Units','pixels','Position',[505,462.33,1839.33,419.99])
tiledlayout(1,4)
nexttile
view(3)
helperPlotEntropy
title('$S(x,y)=x\log x+y\log y+(1-x-y)\log (1-x-y)$', ...
    'Interpreter','latex')

nexttile
view(90,0)
helperPlotEntropy
title('View from the angle perpendicular to $x=0$',...
    'Interpreter','latex')

nexttile
view(180,0)
helperPlotEntropy
title('View from the angle perpendicular to $y=0$',...
    'Interpreter','latex')

nexttile
view(135,0)
helperPlotEntropy
title('View from the angle perpendicular to $1-x-y=0$',...
    'Interpreter','latex')

function helperPlotEntropy
x = 1e-3:5e-3:1-1e-3;
y = x;

[X,Y] = meshgrid(x,y);
Z = (1-X-Y);
Z(Z<0) = nan;

func = @(x,y,z) -(x.*log(x)+y.*log(y)+z.*log(z));

entropy = func(X,Y,Z);

hold(gca,"on")
box(gca,"on")
grid(gca,"on")

surf(X,Y,entropy, ...
    'EdgeColor','none', ...
    'FaceAlpha',0.9)

% Plot entropy at border x=0
x0 = 1e-3*ones(1,numel(x));
y0 = y;
z0 = 1-x0-y0;
entropy0 = func(x0,y0,z0);
plot3(x0,y0,entropy0, ...
    'LineWidth',2,'Color','r')

% Plot entropy at border y=0
x1 = x;
y1 = 1e-3*ones(1,numel(y));
z1 = 1-x1-y1;
entropy1 = func(x1,y1,z1);
plot3(x1,y1,entropy1, ...
    'LineWidth',2,'Color','g')

% Plot entropy at border 1-x-y=0
x2 = x;
y2 = 1-x;
z2 = 1-x2-y2+1e-3;
entropy2 = func(x2,y2,z2);
plot3(x2,y2,entropy2, ...
    'LineWidth',2,'Color','b')

xlabel('$x$','Interpreter','latex')
ylabel('$y$','Interpreter','latex')
zlabel('S(x,y)','Interpreter','latex')
set(gca,'FontSize',12)
xlim([0,1])
ylim([0,1])
end