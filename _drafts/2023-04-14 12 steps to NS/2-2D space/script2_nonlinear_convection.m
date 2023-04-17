clc,clear,close all

nx = 81;
ny = 81;
nt = 100;
dx = 2/(nx-1);
dy = 2/(ny-1);
sigma = 0.2;
dt = sigma*dx;

x = linspace(0,2,nx);
y = linspace(0,2,ny);

u = ones(ny,nx);
v = ones(ny,nx);
un = ones(ny,nx);
vn = ones(ny,nx);

u(floor(.5/dy):floor(1/dy+1),floor(.5/dx):floor(1/dx+1)) = 2;
v(floor(.5/dy):floor(1/dy+1),floor(.5/dx):floor(1/dx+1)) = 2;

figure('Units','pixels','Position',[170,432,1492,371])
tiledlayout(1,3)
nexttile
box(gca,"on")
grid(gca,"on")
[X,Y] = meshgrid(x,y);
surf(X,Y,u,'EdgeColor','none')
colormap("jet")
colorbar
title("Initial condition")
xlabel('x','Interpreter','latex')
ylabel('y','Interpreter','latex')
zlabel('$u_{i,j},v_{i,j}$','Interpreter','latex')

for i = 2:nt
    un = u;
    vn = v;
    u(2:end,2:end) = un(2:end,2:end)...
        -(un(2:end,2:end).*dt/dx).*(un(2:end,2:end)-un(1:end-1,2:end))...
        -(vn(2:end,2:end).*dt/dy).*(un(2:end,2:end)-un(2:end,1:end-1));
    v(2:end,2:end) = vn(2:end,2:end)...
        -(un(2:end,2:end).*dt/dx).*(vn(2:end,2:end)-vn(1:end-1,2:end))...
        -(vn(2:end,2:end).*dt/dy).*(vn(2:end,2:end)-vn(2:end,1:end-1));

    u(1,:) = 1;
    u(end,:) = 1;
    u(:,1) = 1;
    u(:,end) = 1;

    v(1,:) = 1;
    v(end,:) = 1;
    v(:,1) = 1;
    v(:,end) = 1;
end

nexttile
box(gca,"on")
grid(gca,"on")
surf(X,Y,u,'EdgeColor','none')
colormap("jet")
colorbar
title("$u_{i,j}$ after advancing in time",'Interpreter','latex')
xlabel('x','Interpreter','latex')
ylabel('y','Interpreter','latex')
zlabel('$u_{i,j}$','Interpreter','latex')

nexttile
box(gca,"on")
grid(gca,"on")
surf(X,Y,v,'EdgeColor','none')
colormap("jet")
colorbar
title("$v_{i,j}$ after advancing in time",'Interpreter','latex')
xlabel('x','Interpreter','latex')
ylabel('y','Interpreter','latex')
zlabel('$v_{i,j}$','Interpreter','latex')