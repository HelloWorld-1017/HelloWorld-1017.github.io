% The voltage-current profile of the nonlinear resistance
clc, clear, close
figure, axes

i = -3:0.01:3;
u = (1/3)*i.^3-i;
hold(gca, "on")
plot(u, i, LineWidth=1.5);
scatter(0, 0, 'filled');
xlabel('$u_R$', Interpreter='latex')
ylabel('$i_R$', Interpreter='latex')
title('The voltage-current profile of the nonlinear resistance')
grid on