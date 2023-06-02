clc,clear,close all

% Set Q values
Q1 = 1.5;
Q2 = 1.1;

eta = linspace(0.01,2,1e3);
figure('Units','pixels','Position',[87,233,1555,420])
tiledlayout(1,3)
nexttile
hold(gca,'on'),grid(gca,'on'),box(gca,'on')

% Way 1
phiC = @(Q,eta) atan(-eta./(Q*(eta.^2-1)));
phiC1 = phiC(Q1,eta)/(2*pi)*360;
phiC2 = phiC(Q2,eta)/(2*pi)*360; 
phiL = @(Q,eta) atan(eta./(Q*(eta.^2-1)));
phiL1 = phiL(Q1,eta)/(2*pi)*360;
phiL2 = phiL(Q2,eta)/(2*pi)*360;
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


nexttile
hold(gca,'on'),grid(gca,'on'),box(gca,'on')
% Way 2
HC = @(Q,eta) -1i*Q./(eta+1i*Q*(eta.^2-1));
phiC1 = angle(HC(Q1,eta))/(2*pi)*360;
phiC2 = angle(HC(Q2,eta))/(2*pi)*360;
HL = @(Q,eta) 1i*Q./(1./eta+1i*Q.*(1-1./eta.^2));
phiL1 = angle(HL(Q1,eta))/(2*pi)*360;
phiL2 = angle(HL(Q2,eta))/(2*pi)*360;
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

nexttile
hold(gca,'on'),grid(gca,'on'),box(gca,'on')
plot(eta,atan(tan(phiC1/360*2*pi))*360/(2*pi),'--','LineWidth',1.5,'Color',[249,82,107]/255,'DisplayName',['$C: Q_1=$',num2str(Q1)])
plot(eta,atan(tan(phiL1/360*2*pi))*360/(2*pi),'LineWidth',1.5,'Color',[249,82,107]/255,'DisplayName',['$L: Q_1=$',num2str(Q1)])
plot(eta,atan(tan(phiC2/360*2*pi))*360/(2*pi),'--','LineWidth',1.5,'Color',[7,84,213]/255,'DisplayName',['$C: Q_2=$',num2str(Q2)])
plot(eta,atan(tan(phiL2/360*2*pi))*360/(2*pi),'LineWidth',1.5,'Color',[7,84,213]/255,'DisplayName',['$L: Q_2=$',num2str(Q2)])
xline(1,'Color',[0.5,0.5,0.5],'LineWidth',1.5,'DisplayName','Resonance')
legend('Interpreter','latex','Location','southeast')
xlabel('$\eta$','Interpreter','latex')
ylabel('$\varphi(\eta)\ ({}^{\circ})$','Interpreter','latex')
yticks(-180:30:180)
title('Phase shift characteristic')
