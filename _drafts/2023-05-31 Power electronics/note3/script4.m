clc,clear,close all

Q1 = 1.1;
Q2 = 0.1;

eta = linspace(0.01,2,1e3);

phiL = @(Q,eta) -atan(1./(Q*(eta-1./eta)));
HL = @(Q,eta) sqrt(Q^4*(1-1./eta.^2).^2+Q^2./eta.^2)./(1./eta.^2+Q^2*(1-1./eta.^2).^2);
phiL1 = phiL(Q1,eta)/(2*pi)*360; % convert rad/s to degree
phiL2 = phiL(Q2,eta)/(2*pi)*360; % convert rad/s to degree
HL2 = HL(Q2,eta);
HL1 = HL(Q1,eta);

phiC = @(Q,eta) atan((eta*Q)./(Q^2*(eta.^2-1)));
HC = @(Q,eta) sqrt(Q^4*(eta.^2-1).^2+eta.^2*Q^2)./(eta.^2+Q^2*(eta.^2-1).^2);
phiC1 = phiC(Q1,eta)/(2*pi)*360; % convert rad/s to degree
phiC2 = phiC(Q2,eta)/(2*pi)*360; % convert rad/s to degree
HC1 = HC(Q1,eta);
HC2 = HC(Q2,eta);

figure('Units','pixels','Position',[717,329.67,1116,420])
tiledlayout(1,2)
nexttile
hold(gca,'on'),grid(gca,'on'),box(gca,'on')
plot(eta,phiL1,'LineWidth',1.5,'Color',[249,82,107]/255,'DisplayName',['$L: Q_1=$',num2str(Q1)])
plot(eta,phiC1,'--','LineWidth',1.5,'Color',[249,82,107]/255,'DisplayName',['$C: Q_1=$',num2str(Q1)])
plot(eta,phiL2,'LineWidth',1.5,'Color',[7,84,213]/255,'DisplayName',['$L: Q_2=$',num2str(Q2)])
plot(eta,phiC2,'--','LineWidth',1.5,'Color',[7,84,213]/255,'DisplayName',['$C: Q_2=$',num2str(Q2)])
xline(1,'Color',[0.5,0.5,0.5],'LineWidth',1.5,'DisplayName','Resonance')
legend('Interpreter','latex','Location','southeast')
xlabel('$\eta$','Interpreter','latex')
ylabel('$\varphi(\eta)\ ({}^{\circ})$','Interpreter','latex')
yticks(-90:30:90)
title('Phase shift characteristic')

nexttile
hold(gca,'on'),grid(gca,'on'),box(gca,'on')
plot(eta,HL1,'LineWidth',1.5,'Color',[249,82,107]/255,'DisplayName',['$L: Q_1=$',num2str(Q1)])
plot(eta,HC1,'--','LineWidth',1.5,'Color',[249,82,107]/255,'DisplayName',['$C: Q_1=$',num2str(Q1)])
plot(eta,HL2,'LineWidth',1.5,'Color',[7,84,213]/255,'DisplayName',['$L: Q_2=$',num2str(Q2)])
plot(eta,HC2,'--','LineWidth',1.5,'Color',[7,84,213]/255,'DisplayName',['$C: Q_2=$',num2str(Q2)])
xline(1,'Color',[0.5,0.5,0.5],'LineWidth',1.5,'DisplayName','Resonance')
legend('Interpreter','latex','Location','southeast')
xlabel('$\eta$','Interpreter','latex')
ylabel('$U_R(\mathrm{j}\eta)/U_S(\mathrm{j}1)$','Interpreter','latex')
title('Amplitude frequency characteristic')
