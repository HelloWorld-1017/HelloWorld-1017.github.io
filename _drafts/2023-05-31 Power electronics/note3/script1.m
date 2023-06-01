clc,clear,close all

% Set elements parameters
R = 3;
L = 4;
C = 5;

% Solve omega_0
syms omega0
omega0 = solve(omega0*L-1/(omega0*C)==0,omega0); % 1/(2*sqrt(5))
omega0 = double(omega0(omega0>0));

% Calculate Phase shift characteristic and Amplitude frequency characteristic
omega = linspace(0.01,1,1e3);
phi = atan((omega*L-1./(omega*C))/R);
Z = R./cos(phi);
[ZMin,ZMinPos] = min(Z);

% Plot Phase shift characteristic and Amplitude frequency characteristic
figure('Units','pixels','Position',[717,329.67,1116,420])
tiledlayout(1,2)
nexttile
hold(gca,'on'),grid(gca,'on'),box(gca,'on')
plot(omega,phi,'LineWidth',1.5,'Color','k','DisplayName','$\varphi(\mathrm{j}\omega)$')
xline(omega0,'--','LineWidth',1.5,'Color',[0.5,0.5,0.5],'HandleVisibility','off')
scatter(omega0,0,'filled','Color','r','DisplayName','$\omega_0$')
xlabel('$\omega$','Interpreter','latex')
ylabel('$\varphi(\mathrm{j}\omega)$','Interpreter','latex')
title('Phase shift characteristic')
legend('Interpreter','latex','Location','best')
nexttile
hold(gca,'on'),grid(gca,'on'),box(gca,'on')
plot(omega,Z,'LineWidth',1.5,'Color','k','DisplayName','$|Z(\mathrm{j}\omega)|$')
xline(omega0,'--','LineWidth',1.5,'Color',[0.5,0.5,0.5],'HandleVisibility','off')
scatter(omega(ZMinPos),ZMin,'filled','Color','r','DisplayName','$\omega_0$')
xlabel('$\omega$','Interpreter','latex')
ylabel('$|Z(\mathrm{j}\omega)|$','Interpreter','latex')
title('Amplitude frequency characteristic')
legend('Interpreter','latex','Location','best')