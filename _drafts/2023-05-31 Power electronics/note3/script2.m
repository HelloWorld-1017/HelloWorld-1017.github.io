clc,clear,close all

% Set Q values
Q1 = 10;
Q2 = 3;

% Calculate phase shift and amplitude frequency characteristic with
% different Q values
eta = linspace(0.01,2,1e3);
phi = @(Q,eta) -atan(Q*(eta-1./eta));
HR = @(Q,eta) 1./sqrt(1+Q^2*(eta-1./eta).^2);
phi1 = phi(Q1,eta)/(2*pi)*360; % convert rad/s to degree
phi2 = phi(Q2,eta)/(2*pi)*360; % convert rad/s to degree
HR1 = HR(Q1,eta);
HR2 = HR(Q2,eta);

% Plot phase shift characteristic with different Q values
figure('Units','pixels','Position',[717,329.67,1116,420])
tiledlayout(1,2)
nexttile
hold(gca,'on'),grid(gca,'on'),box(gca,'on')
plot(eta,phi1,'LineWidth',1.5, ...
    'Color',[249,82,107]/255,'DisplayName',['$Q_1=$',num2str(Q1)])
plot(eta,phi2,'LineWidth',1.5, ...
    'Color',[7,84,213]/255,'DisplayName',['$Q_2=$',num2str(Q2)])
legend('Interpreter','latex')
xlabel('$\eta$','Interpreter','latex')
ylabel('$\varphi(\mathrm{j}\eta)\ ({}^\circ)$','Interpreter','latex')
yticks(-90:30:90)
title('Phase shift characteristic')

% Plot amplitude frequency characteristic with different Q values
nexttile
hold(gca,'on'),grid(gca,'on'),box(gca,'on')
plot(eta,HR1,'LineWidth',1.5, ...
    'Color',[249,82,107]/255,'DisplayName',['$Q_1=$',num2str(Q1)])
plot(eta,HR2,'LineWidth', ...
    1.5,'Color',[7,84,213]/255,'DisplayName',['$Q_2=$',num2str(Q2)])
xline(1,'Color',[0.5,0.5,0.5],'LineWidth',1.5,'DisplayName','Resonance')
legend('Interpreter','latex')
xlabel('$\eta$','Interpreter','latex')
ylabel('$U_R(\mathrm{j}\eta)$','Interpreter','latex')
title('Amplitude frequency characteristic')