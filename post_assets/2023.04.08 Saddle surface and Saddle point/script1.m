clc,clear,close all

figure('Units','pixels','Position',[717.67,170.33,1364.67,953.33])
tiledlayout(2,2,'TileSpacing','compact')

% 3-D view
nexttile
view(3)
helperPlotSaddle

% z-y plane
nexttile
view(90,0)
helperPlotSaddle

% z-x plane
nexttile
view(180,0)
helperPlotSaddle

% y-x plane
nexttile
view(2)
helperPlotSaddle


function helperPlotSaddle
x = -7:0.2:7;
y = -7:0.2:7;
func = @(x,y) x.^2-y.^2;
[X,Y] = meshgrid(x,y);
Z = func(X,Y);

box(gca,"on")
grid(gca,"on")
hold(gca,"on")

LineWidth = 3;
% Plot saddle surface
surf(X,Y,Z,...
    'DisplayName','Saddle surface',...
    'FaceAlpha',0.5,'EdgeColor','none');

% Plot z = x^2-y^2, x=0
x0 = zeros(1,numel(y));
plot3(x0,y,func(x0,y), ...
    'LineWidth',LineWidth,'Color','r', ...
    'DisplayName','$z = x^2-y^2, x=0$')

% Plot z = x^2-y^2, y=0
y0 = zeros(1,numel(x));
plot3(x,y0,func(x,y0), ...
    'LineWidth',LineWidth,'Color','b',...
    'DisplayName','$z = x^2-y^2, y=0$')

% Plog saddle point
scatter3(0,0,func(0,0),200, ...
    'filled','MarkerFaceColor','k',...
    'DisplayName','Saddle point','Marker','hexagram');
legend('Interpreter','latex','Location','best')

xlim([-7,7])
ylim([-7,7])
colorbar

set(gca,'FontSize',13)
title("Saddle surface")
xlabel("$x$","Interpreter","latex")
ylabel("$y$","Interpreter","latex")
zlabel("$z$","Interpreter","latex")
end
