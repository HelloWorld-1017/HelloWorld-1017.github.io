clc,clear,close all

nx = 200;
dx = 2/(nx-1); % deta x: 0.05
nt = 25;       % nt is the number of timesteps we want to calculate
dt = .025;     % delt t: 0.025
c = 1;         % assume wavespeed of c = 1

% Set initial condition
un = nan(nt,nx);
u0 = ones(1,nx);
u0(ceil(0.5/dx):ceil(1/dx+1)) = 2;
un(1,:) = u0;

figure
axes
hold(gca,"on")
grid(gca,"on")
box(gca,"on")

for n = 2:nt
    un(n,:) = un(n-1,:);
    for i = 2:nx
        un(n,i) = un(n-1,i)-c*dt/dx*(un(n-1,i)-un(n-1,i-1));
    end
    % Plot every timestep
    plot(linspace(0,2,nx),un(n,:), ...
        'LineWidth',1,'LineStyle','-','Color',[0.5,0.5,0.5], ...
        'HandleVisibility','off')
end

% Plot the first and the last timestep
plot(linspace(0,2,nx),un(1,:), ...
    'LineWidth',1,'DisplayName','$u^{t=0}$','Color','b')
plot(linspace(0,2,nx),un(end,:), ...
    'LineWidth',1,'DisplayName','$u^{t=n}$','Color','r')
title('$u$ after advancing in time (25 timestep)','Interpreter','latex')
xlabel('x','Interpreter','latex')
ylabel('u','Interpreter','latex')
legend('Interpreter','latex')