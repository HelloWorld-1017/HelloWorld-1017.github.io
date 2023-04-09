clc, clear, close all

pRange = 1e-3:5e-3:1-1e-3;
[p1,p2] = meshgrid(pRange);
p3 = 1-p1-p2; % Plane: p1+p2+p3=1
p3(p3<0) = nan;% prevent producing complex number in matrix C
entropy = -(p1.*log(p1)+p2.*log(p2)+p3.*log(p3));

figure('Units','pixels','Position',[671.67,473.67,1015.33,420])
tiledlayout(1,2)
nexttile
hold(gca,"on")
box(gca,"on")
grid(gca,"on")
view(3)
surf(p1,p2,p3,entropy, ...
    'FaceAlpha',0.9,...
    'DisplayName','Entropy', ...
    'EdgeColor','none')
[xPos,yPos] = find(entropy==max(max(entropy)));
xPos = xPos(1);
yPos = yPos(1);
scatter3(p1(xPos,yPos),p2(xPos,yPos),p3(xPos,yPos), ...
    100,'filled','MarkerFaceColor','g',...
    'DisplayName','Maximum entropy')

% % Plot area border
% x = 0:0.01:1;
% y = 1-x;
% z = zeros(1,numel(x));
% plot3(x,y,z, ...
%     'LineWidth',3,'Color','r',...
%     'DisplayName','$p(v_1)+p(v_2)=1$') % x-y border
% plot3(x,z,y,'LineWidth',3,'Color',[0.8,0.8,0.8],...
%     'DisplayName','$p(v_1)+p(v_3)=1$') % x-z border
% plot3(z,x,y,'LineWidth',3,'Color',[0,0,0],...
%     'DisplayName','$p(v_2)+p(v_3)=1$') % y-z border

% Figure settings
legend('Location','best','Interpreter','latex')
colorbar
colormap("jet")
title('Entropy as function of $p(v_1)$, $p(v_2)$, and $p(v_3)$', ...
    'Interpreter','latex')
xlabel('$p(v_1)$','Interpreter','latex')
ylabel('$p(v_2)$','Interpreter','latex')
zlabel('$p(v_3)$','Interpreter','latex')
xlim([0,1])
ylim([0,1])
zlim([0,1])

nexttile
hold(gca,"on")
box(gca,"on")
imagesc(pRange,pRange,entropy)
scatter(p1(xPos,yPos),p2(xPos,yPos), ...
    100,'filled','MarkerFaceColor','g')
legend('Maximum entropy')
set(gca, "YDir", "normal")
colorbar
title('Entropy as function of $p(v_1)$ and $p(v_2)$', ...
    'Interpreter','latex')
xlabel('$p(v_1)$','Interpreter','latex')
ylabel('$p(v_2)$','Interpreter','latex')



