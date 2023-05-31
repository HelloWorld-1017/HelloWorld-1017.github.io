clc,clear,close all

eta = linspace(0.3,1,1e3);

hold(gca,'on')
box(gca,'on')
grid(gca,'on')
plot((1-eta)./eta,eta, ...
    'Color','k','LineWidth',1.5)
ylim([0,1])
xlabel('$1/Q\ (P_{loss}/P_{out})$','Interpreter','latex')
ylabel('$\eta$','Interpreter','latex')