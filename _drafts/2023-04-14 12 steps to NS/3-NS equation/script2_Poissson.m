clc,clear,close all

nx = 50;
ny = 50;
nt = 100;
xmin = 0;
xmax = 2;
ymin = 0;
ymax = 1;

dx = (xmax-xmin)/(nx-1);
dy = (ymax-ymin)/(ny-1);

p = zeros(nx,ny);
pd = zeros(nx,ny);
b = zeros(nx,ny);
x = linspace(xmin,xmax,nx);
y = linspace(xmin,xmax,ny);

% Source term
b(floor(ny/4),floor(nx/4)) = 100;
b(floor(3*ny/4),floor(3*nx/4)) = -100;

figure('Units','pixels', ...
    'Position',[728.33,386.33,940.67,369.99])
tiledlayout(1,2)
nexttile
box(gca,"on")
grid(gca,"on")
[X,Y] = meshgrid(x,y);
surf(X,Y,p+b,'EdgeColor','none')
colormap("jet")
colorbar
title("The combination of initial condition and initial spikes",'Interpreter','latex')
xlabel('x','Interpreter','latex')
ylabel('y','Interpreter','latex')
zlabel('$p_{i,j}+b_{i,j}$','Interpreter','latex')

l1norm_target = 1e-4;
l1norm = 1;
numIteration = 0;
while l1norm > l1norm_target
    pd = p;
    p(2:end-1,2:end-1) = (dy^2*(pd(3:end,2:end-1)+pd(1:end-2,2:end-1))...
        +dx^2*(pd(2:end-1,3:end)+pd(2:end-1,1:end-2))...
        +b(2:end-1,2:end-1)*dx^2*dy^2)...
        ./(2*dx^2+2*dy^2);
    p(1,:) = 0;
    p(end,:) = 0;
    p(:,1) = 0;
    p(:,end) = 0;

    l1norm = sum(abs(p(:))-abs(pd(:)),'all')/sum(abs(pd(:)),'all');
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