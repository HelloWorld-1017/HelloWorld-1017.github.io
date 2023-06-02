clc,clear,close all

% Set Q values
Q1 = 1.5;
Q2 = 1.1;

% Calculate phase shift and amplitude frequency characteristic with
% different Q values
eta = linspace(0.01,2,1e3);
% phiC = @(Q,eta) atan(-eta./(Q*(eta.^2-1)));
% HC = @(Q,eta) sqrt(Q^4*(eta.^2-1).^2+Q^2*eta.^2)./(eta.^2+Q^2*(eta.^2-1).^2);
% phiC1 = phiC(Q1,eta)/(2*pi)*360; % convert rad/s to degree
% phiC2 = phiC(Q2,eta)/(2*pi)*360; % convert rad/s to degree
% HC1 = HC(Q1,eta);
% HC2 = HC(Q2,eta);
HC = @(Q,eta) -1i*Q./(eta+1i*Q*(eta.^2-1));
phiC1 = angle(HC(Q1,eta))/(2*pi)*360;
phiC2 = angle(HC(Q2,eta))/(2*pi)*360;
HC1 = abs(HC(Q1,eta));
HC2 = abs(HC(Q2,eta));

% phiL = @(Q,eta) atan(eta./(Q*(eta.^2-1)));
% HL = @(Q,eta) sqrt(Q^4*(1-1./eta.^2).^2+Q^2./eta.^2)./(1./eta.^2+Q^2*(1-1./eta.^2).^2);
% phiL1 = phiL(Q1,eta)/(2*pi)*360; % convert rad/s to degree
% phiL2 = phiL(Q2,eta)/(2*pi)*360; % convert rad/s to degree
% HL2 = HL(Q2,eta);
% HL1 = HL(Q1,eta);
HL = @(Q,eta) 1i*Q./(1./eta+1i*Q.*(1-1./eta.^2));
phiL1 = angle(HL(Q1,eta))/(2*pi)*360;
phiL2 = angle(HL(Q2,eta))/(2*pi)*360;
HL1 = abs(HL(Q1,eta));
HL2 = abs(HL(Q2,eta));

% Plot phase shift characteristic with different Q values
figure('Units','pixels','Position',[717,329.67,1116,420])
tiledlayout(1,2)
nexttile
hold(gca,'on'),grid(gca,'on'),box(gca,'on')
plot(eta,phiC1,'--','LineWidth',1.5,'Color',[249,82,107]/255,'DisplayName',['$C: Q_1=$',num2str(Q1)])
plot(eta,phiL1,'LineWidth',1.5,'Color',[249,82,107]/255,'DisplayName',['$L: Q_1=$',num2str(Q1)])
plot(eta,phiC2,'--','LineWidth',1.5,'Color',[7,84,213]/255,'DisplayName',['$C: Q_2=$',num2str(Q2)])
plot(eta,phiL2,'LineWidth',1.5,'Color',[7,84,213]/255,'DisplayName',['$L: Q_2=$',num2str(Q2)])
xline(1,'Color',[0.5,0.5,0.5],'LineWidth',1.5,'DisplayName','Resonance')
legend('Interpreter','latex','Location','southeast')
xlabel('$\eta$','Interpreter','latex')
ylabel('$\varphi(\eta)\ ({}^{\circ})$','Interpreter','latex')
yticks(-180:30:180)
title('Phase shift characteristic')

% Plot amplitude frequency characteristic with different Q values
nexttile
hold(gca,'on'),grid(gca,'on'),box(gca,'on')
plot(eta,HC1,'--','LineWidth',1.5,'Color',[249,82,107]/255,'DisplayName',['$C: Q_1=$',num2str(Q1)])
plot(eta,HL1,'LineWidth',1.5,'Color',[249,82,107]/255,'DisplayName',['$L: Q_1=$',num2str(Q1)])
plot(eta,HC2,'--','LineWidth',1.5,'Color',[7,84,213]/255,'DisplayName',['$C: Q_2=$',num2str(Q2)])
plot(eta,HL2,'LineWidth',1.5,'Color',[7,84,213]/255,'DisplayName',['$L: Q_2=$',num2str(Q2)])
xline(1,'Color',[0.5,0.5,0.5],'LineWidth',1.5,'DisplayName','Resonance')
legend('Interpreter','latex','Location','southeast')
xlabel('$\eta$','Interpreter','latex')
ylabel('$U_R(\mathrm{j}\eta)/U_S(\mathrm{j}1)$','Interpreter','latex')
title('Amplitude frequency characteristic')
