clc,clear,close all

nx = 31;
ny = 31;
nt = 50;
nu = 0.05;
dx = 2/(nx-1);
dy = 2/(ny-1);
sigma = 0.25;
dt = sigma*dx*dy/nu;

x = linspace(0,2,nx);
y = linspace(0,2,ny);

u = ones(ny,nx);
un = ones(ny,nx);

u(floor(.5/dy):floor(1/dy+1),floor(.5/dx):floor(1/dx+1))= 2;

for i = 2:nt
    un = u;
    u(2:end-1,2:end-1) = un(2:end-1,2:end-1)...
        +nu*dt/(dx)^2*(un(3:end,2:end-1)-2*un(2:end-1,2:end-1)+un(1:end-2,2:end-1))...
        +nu*dt/(dy)^2*(un(2:end-1,3:end)-2*un(2:end-1,2:end-1)+un(2:end-1,1:end-2));

    u(1,:) = 1;
    u(end,:) = 1;
    u(:,1) = 1;
    u(:,end) = 1;
end

nexttile
box(gca,"on")
grid(gca,"on")
[X,Y] = meshgrid(x,y);
surf(X,Y,u,'EdgeColor','none')
colormap("jet")
colorbar
title("$u_{i,j}$ after advancing in time"+ sprintf("(nt = %s)",num2str(nt)), ...
    'Interpreter','latex')
xlabel('x','Interpreter','latex')
ylabel('y','Interpreter','latex')
zlabel('$u_{i,j}$','Interpreter','latex')
zlim([1,2.5])


