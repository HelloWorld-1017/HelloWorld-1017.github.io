clc,clear,close all

nx = 81;
ny = 81;
nt = 100;
c = 1;
dx = 2/(nx-1);
dy = 2/(ny-1);
sigma = 0.2;
dt = sigma*dx;

x = linspace(0,2,nx);
y = linspace(0,2,ny);

u = ones(ny,nx);
un = ones(ny,nx);

u(floor(.5/dy):floor(1/dy+1),floor(.5/dx):floor(1/dx+1)) = 2;

figure('Units','pixels','Position',[661,412.33,1240,419.99])
tiledlayout(1,2)
nexttile
box(gca,"on")
grid(gca,"on")
[X,Y] = meshgrid(x,y);
surf(X,Y,u,'EdgeColor','none')
colormap("jet")
colorbar
title("Initial interations")

for i = 2:nt
    un = u;
    u(2:end,2:end) = un(2:end,2:end)...
        -(c*dt/dx)*(un(2:end,2:end)-un(1:end-1,2:end))...
        -(c*dt/dy)*(un(2:end,2:end)-un(2:end,1:end-1));
    u(1,:) = 1;
    u(end,:) = 1;
    u(:,1) = 1;
    u(:,end) = 1;
end

nexttile
box(gca,"on")
grid(gca,"on")
surf(X,Y,u,'EdgeColor','none')
colormap("jet")
colorbar
title("After simulation")
