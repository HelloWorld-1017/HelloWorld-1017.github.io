clc,clear,close all

p1 = 1e-3:0.001:1-1e-3;
p2 = 1-p1;
entropy = -(p1.*log(p1)+p2.*log(p2));
[maxEngropy,pos] = max(entropy);

figure('Units','pixels','Position',[439.66,521.66,1448.66,420])
tiledlayout(1,3,'TileSpacing','tight')
nexttile
hold(gca,"on")
box(gca,"on")
grid(gca,"on")
view(3)
plot3(p1,p2,entropy, ...
    'LineWidth',1.5,'Color',[7,84,213]/255, ...
    'DisplayName','Entropy')
plot(p1,p2, ...
    'Color','g','LineWidth',1.5,'LineStyle','--', ...
    'DisplayName','$p(v_2)=1-p(v_1)$')
scatter3(p1(pos),p2(pos),maxEngropy, ...
    'filled','MarkerFaceColor',[249, 82, 107]/255,...
    'DisplayName','Maximum entropy')
legend('Interpreter','latex','Location','best')
xlabel('$p(v_1)$','Interpreter','latex')
ylabel('$p(v_2)$','Interpreter','latex')
zlabel('Entropy','Interpreter','latex')
title('Entropy as function of $p(v_1)$ and $p(v_2)$','Interpreter','latex')

nexttile
hold(gca,"on")
box(gca,"on")
grid(gca,"on")
plot(p1,entropy, ...
    'Color',[7,84,213]/255,'LineWidth',1.5,...
    'DisplayName','Entropy')
scatter(p1(pos),maxEngropy, ...
    'filled','MarkerFaceColor',[249, 82, 107]/255,...
    'DisplayName','Maximum entropy')
legend('Interpreter','latex','Location','southeast')
xlabel('$p(v_1)$','Interpreter','latex')
ylabel('Entropy','Interpreter','latex')
title('Entropy as function of $p(v_1)$','Interpreter','latex')

nexttile
hold(gca,"on")
box(gca,"on")
grid(gca,"on")
plot(p2,entropy, ...
    'Color',[7,84,213]/255,'LineWidth',1.5,...
    'DisplayName','Entropy')
scatter(p2(pos),maxEngropy, ...
    'filled','MarkerFaceColor',[249, 82, 107]/255,...
    'DisplayName','Maximum entropy')
legend('Interpreter','latex','Location','southeast')
xlabel('$p(v_2)$','Interpreter','latex')
ylabel('Entropy','Interpreter','latex')
title('Entropy as function of $p(v_2)$','Interpreter','latex')