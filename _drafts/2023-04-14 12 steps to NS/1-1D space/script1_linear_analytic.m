clc,clear,close all

nx = 201;
dx = 2/(nx-1); % deta x: 0.05
nt = 25;       % nt is the number of timesteps we want to calculate
dt = .025;     % delt t: 0.025
c = 1;         % assume wavespeed of c = 1

% Set initial condition
u0 = ones(1,nx);
u0(ceil(0.5/dx):ceil(1/dx+1)) = 2;
un = ones(1,nt-1)'*u0;

figure
axes
hold(gca,"on")
grid(gca,"on")
box(gca,"on")

for n = 2:nt-2
%     Plot every timestep
    plot(linspace(0,2,nx)+c*(n-1)*dt,un(n,:), ...
        'LineWidth',1,'LineStyle','-','Color',[0.5,0.5,0.5], ...
        'HandleVisibility','off')
end

% Plot the first and the last timestep
plot(linspace(0,2,nx),un(1,:), ...
    'LineWidth',1,'DisplayName','$u^{t=0}$','Color','b')
plot(linspace(0,2,nx)+c*(nt-1)*dt,un(end,:), ...
    'LineWidth',1,'DisplayName','$u^{t=n}$','Color','r')
title('$u$ after advancing in time (25 timestep)','Interpreter','latex')
xlabel('$x$','Interpreter','latex')
ylabel('$u$','Interpreter','latex')
legend('Interpreter','latex')
xlim([0,2])