clc,clear,close all

[p1,p2,p3] = meshgrid(0.01:0.01:1);
entropy = -(p1.*log(p1)+p2.*log(p2)+p3.*log(p3));
[xsurf,ysurf] = meshgrid(0.01:0.01:1);
zsurf = 1-xsurf-ysurf;

hold(gca,"on")
grid(gca,"on")
box(gca,"on")
view(3)

s = slice(p1,p2,p3,entropy,xsurf,ysurf,zsurf);
s.EdgeColor = 'none';
[xPos,yPos] = find(s.CData==max(max(s.CData)));
xPos = xPos(1);
yPos = yPos(1);
scatter3(s.XData(xPos,yPos),s.YData(xPos,yPos),s.ZData(xPos,yPos), ...
    100,'filled','MarkerFaceColor','g')

% Figure settings
colorbar
colormap("jet")
legend('Maximum entropy','Maximum entropy', ...
    'Location','best','Interpreter','latex')
title('Entropy as function of $p(v_1)$, $p(v_2)$, and $p(v_3)$', ...
    'Interpreter','latex')
xlabel('$p(v_1)$','Interpreter','latex')
ylabel('$p(v_2)$','Interpreter','latex')
zlabel('$p(v_3)$','Interpreter','latex')
xlim([0,1])
ylim([0,1])
zlim([0,1])
