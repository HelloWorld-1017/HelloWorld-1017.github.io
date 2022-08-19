% The voltage-current profile of the nonlinear resistance
x = -2:0.01:2;

m0 = -1.143;
m1 = -0.714;

h = m1*x+0.5*(m0-m1)*(abs(x+1)-abs(x-1));
f = @(x)m1*x+0.5*(m0-m1)*(abs(x+1)-abs(x-1));

figure, axes
hold(gca, 'on')
plot(x, h, LineWidth=1.7);
scatter(0, 0, 'filled')
scatter(-1, f(-1), 'filled');
scatter(1, f(1), 'filled');
xlabel('$u_R$', Interpreter='latex')
ylabel('$i_R$', Interpreter='latex')
title('The voltage-current profile of the nonlinear resistance')