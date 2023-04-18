clc,clear,close all

nx = 31;
ny = 31;
c = 1;
dx = 2/(nx-1);
dy = 2/(ny-1);

p = zeros(nx,ny);
x = linspace(0,2,nx);
y = linspace(0,1,ny);

p(1,:) = 0;              % p = 0 at x = 0
p(end,:) = y;            % p = y at x = 2
p(:,1) = p(:,2);         % dp/dy = 0 at y = 0
p(:,end) = p(:,end-1);   % dp/dy = 0 at y = 1

figure('Units','pixels', ...
    'Position',[728.33,386.33,940.67,369.99])
tiledlayout(1,2)
nexttile
box(gca,"on")
grid(gca,"on")
[X,Y] = meshgrid(x,y);
surf(X,Y,p,'EdgeColor','none')
colormap("jet")
colorbar
title("Initial condition",'Interpreter','latex')
xlabel('x','Interpreter','latex')
ylabel('y','Interpreter','latex')
zlabel('$p_{i,j}$','Interpreter','latex')

l1norm_target = 1e-4;
l1norm = 1;

numIteration = 0;
while l1norm > l1norm_target
    pn = p;
    p(2:end-1,2:end-1) = (dy^2*(pn(3:end,2:end-1)+pn(1:end-2,2:end-1))...
        +dx^2*(pn(2:end-1,3:end)+pn(2:end-1,1:end-2)))...
        ./(2*dx^2+2*dy^2);
    p(1,:) = 0;              % p = 0 at x = 0
    p(end,:) = y;            % p = y at x = 2
    p(:,1) = p(:,2);         % dp/dy = 0 at y = 0
    p(:,end) = p(:,end-1);   % dp/dy = 0 at y = 1

    l1norm = sum(abs(p(:))-abs(pn(:)),'all')/sum(abs(pn(:)),'all');
    numIteration = numIteration+1;
end

nexttile
box(gca,"on")
grid(gca,"on")
surf(X,Y,p,'EdgeColor','none')
colormap("jet")
colorbar
title(sprintf("After %s-times iterations",num2str(numIteration)), ...
    'Interpreter','latex')
xlabel('x','Interpreter','latex')
ylabel('y','Interpreter','latex')
zlabel('$p_{i,j}$','Interpreter','latex')