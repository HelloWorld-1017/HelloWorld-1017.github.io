clc,clear,close all

nexttile
hold(gca,"on")
grid(gca,"on")
box(gca,"on")
helperDiffusion(41)

function helperDiffusion(nx)
dx = 2/(nx-1); % deta x: 0.05
nt = 20;       % nt is the number of timesteps we want to calculate
nu = 0.3;      % the value of viscosity
sigma = 0.2;
dt = sigma*(dx)^2/nu;

% Set initial condition
un = nan(nt,nx);
u0 = ones(1,nx);
u0(ceil(0.5/dx):ceil(1/dx+1)) = 2;
un(1,:) = u0;

for n = 2:nt
    un(n,:) = un(n-1,:);
    for i = 2:nx-1
        un(n,i) = un(n-1,i)+nu*dt/(dx)^2*(un(n-1,i+1)-2*un(n-1,i)+un(n-1,i-1));
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
title(sprintf('$u$ after advancing in time (nx=%s)',num2str(nx)),'Interpreter','latex')
xlabel('x','Interpreter','latex')
ylabel('u','Interpreter','latex')
legend('Interpreter','latex')
end