clc,clear,close all

nx = 41;
ny = 41;
nt = 100;
nit = 50; % ??
c = 1;
dx = 2/(nx-1);
dy = 2/(ny-1);
x = linspace(0,2,nx);
y = linspace(0,2,ny);
[X,Y] = meshgrid(x,y);

rho = 1;
nu = 0.1;
dt = 0.001;

u = zeros(nx,ny);
v = zeros(nx,ny);
p = zeros(nx,ny);

for i = 1:nt
    un = u;
    vn = v;
    for j = 1:nit
        pn = p;
        p(2:end-1,2:end-1) = ((pn(3:end,2:end-1)-pn(1:end-2,2:end-1))*dy^2+...
            (pn(2:end-1,3:end)-pn(2:end-1,1:end-2))*dx^2)/(2*(dx^2+dy^2))...
            -(rho*(dx^2*dy^2)/(2*(dx^2+dy^2)))*...
            (...
            (1/dt)*((un(3:end,2:end-1)-un(1:end-2,2:end-1))/(2*dx)+(vn(2:end-1,3:end)-vn(2:end-1,1:end-2))/(2*dy))...
            -(un(3:end,2:end-1)-un(1:end-2,2:end-1))/(2*dx).*(un(3:end,2:end-1)-un(1:end-2,2:end-1))/(2*dx)...
            -2*(un(2:end-1,3:end)-un(2:end-1,1:end-2))/(2*dy).*(vn(3:end,2:end-1)-vn(1:end-2,2:end-1))/(2*dx)...
            -(vn(2:end-1,3:end)-vn(2:end-1,1:end-2))/(2*dy).*(vn(2:end-1,3:end)-vn(2:end-1,1:end-2))/(2*dy) ...
            );
        p(end,:) = p(end-1,:); % dp/dx=0 at x=2
        p(:,1) = p(:,2); % dp/dy=0 at y=0
        p(1,:) = p(2,:); % dp/dx=0 at x=0
        p(:,end) = 0;    % p=0 at y=2
    end

    u(2:end-1,2:end-1) = un(2:end-1,2:end-1) ...
        -(dt/dx)*un(2:end-1,2:end-1).*(un(2:end-1,2:end-1)-un(1:end-2,2:end-1))...
        -(dt/dy)*vn(2:end-1,2:end-1).*(un(2:end-1,2:end-1)-un(2:end-1,1:end-2))...
        -(dt)/(2*rho*dx)*(p(3:end,2:end-1)-p(1:end-2,2:end-1))...
        +nu*( ...
        (dt)/(dx^2)*(un(3:end,2:end-1)-2*un(2:end-1,2:end-1)+un(1:end-2,2:end-1))...
        +(dt)/(dy^2)*(un(2:end-1,3:end)-2*un(2:end-1,2:end-1)+un(2:end-1,1:end-2))...
        );

    v(2:end-1,2:end-1) = vn(2:end-1,2:end-1) ...
        -(dt/dx)*un(2:end-1,2:end-1).*(vn(2:end-1,2:end-1)-vn(1:end-2,2:end-1))...
        -(dt/dy)*vn(2:end-1,2:end-1).*(vn(2:end-1,2:end-1)-vn(2:end-1,1:end-2))...
        -(dt)/(2*rho*dy)*(p(2:end-1,3:end)-p(2:end-1,1:end-2))...
        +nu*( ...
        (dt)/(dx^2)*(vn(3:end,2:end-1)-2*vn(2:end-1,2:end-1)+vn(1:end-2,2:end-1))...
        +(dt)/(dy^2)*(vn(2:end-1,3:end)-2*vn(2:end-1,2:end-1)+vn(2:end-1,1:end-2))...
        );

    u(1,:) = 0;
    u(end,:) = 0;
    u(:,1) = 0;
    u(:,end) = 1; % u=1 at y=2;

    v(1,:) = 0;
    v(end,:) = 0;
    v(:,end) = 0;
    v(:,1) = 0;
end

hold(gca,"on")
box(gca,"on")
colorbar
contourf(X,Y,p)
X = X(:);
Y = Y(:);
u = u(:);
v = v(:);
quiver(X,Y,u,v)




