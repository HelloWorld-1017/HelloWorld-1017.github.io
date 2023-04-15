clc,clear,close all

nexttile
hold(gca,"on")
grid(gca,"on")
box(gca,"on")

helperDiffusion(101)

function helperDiffusion(nx)
x_sym = sym('x');
nu_sym = sym('nu');
t_sym = sym('t');

phi_sym = (exp(-(x_sym-4*t_sym)^2/(4*nu_sym*(t_sym+1)))+...
    exp(-(x_sym-4*t_sym-2*pi)^2/(4*nu_sym*(t_sym+1))));
phiprime_sym = diff(phi_sym,x_sym,1);
u_sym = -2*nu_sym*(phiprime_sym/phi_sym)+4;

nt = 100;
xrange = 2*pi;
dx = xrange/(nx-1);
nu = 0.07;
dt = dx*nu;

% Set initial condition
t = 0;
x = linspace(0,xrange,nx);
un = nan(nt,nx);
for i = 1:nx
    un(1,i) = subs(u_sym,[t_sym,x_sym,nu_sym],[t,x(i),nu]);
end

for n = 2:nt
    un(n,2:end-1) = un(n-1,2:end-1)...
        -un(n-1,2:end-1).*dt/dx.*(un(n-1,2:end-1)-un(n-1,1:end-2))... % Attention end-1 and end-2
        +nu*dt/(dx)^2*(un(n-1,3:end)-2*un(n-1,2:end-1)+un(n-1,1:end-2));
    un(n,1) = un(n-1,1)-un(n-1,1)*dt/dx*(un(n-1,1)-un(n-1,end-1))...
        +nu*dt/dx^2*(un(n-1,2)-2*un(n-1,1)+un(n-1,end-1)); % Attetion n-1
    un(n,end) = un(n,1);
    
    % Plot every timestep
    plot(x,un(n,:), ...
        'LineWidth',1,'LineStyle','-','Color',[0.5,0.5,0.5], ...
        'HandleVisibility','off')
end

% Plot the first and the last timestep
plot(x,un(1,:), ...
    'LineWidth',1,'DisplayName','$u^{t=0}$','Color','b')
plot(x,un(end,:), ...
    'LineWidth',1,'DisplayName','$u^{t=n}$','Color','r')

% Calculate and plot analytical
un_analytical = nan(1,width(un));
for i = 1:nx
    un_analytical(i) = subs(u_sym,[t_sym,x_sym,nu_sym],[t+dt*nt,x(i),nu]);
end
plot(x,un_analytical,...
    'LineWidth',1,'DisplayName','Analytical','Color','g')
title('$u$ after advancing in time','Interpreter','latex')
xlim([0,xrange])
ylim([0,10])
xlabel('x','Interpreter','latex')
ylabel('u','Interpreter','latex')
legend('Interpreter','latex')
end