clc, clear, close all

M = [-1, -4;2, 5];% Original linear transformation
[U, Sigma, V] = svd(M); % M = U*Sigma*V'

% Unit circle
theta = 0:0.01:2*pi;
x = cos(theta);
y = sin(theta);
X = [x; y];

% Transformation
X0 = M*X;
X1 = V'*X;
X2 = Sigma*X1;
X3 = U*X2;

figure('Units', 'pixels', 'Position', [110,134,1384,741])
LineWidth = 1.7;
MarkerSize = 50;
ax_lim = [-7, 7];
tiledlayout(2, 3);

nexttile(2)
hold(gca, "on")
plot(x, y, LineWidth=LineWidth)
plot(X0(1, :), X0(2, :),LineWidth=LineWidth)
scatter(0, 0, 50, "filled")
axis equal
xlim(ax_lim)
ylim(ax_lim)
xlabel('$x_1$', Interpreter='latex')
ylabel('$x_2$', Interpreter='latex')
legend("Circle in Original Space", "Ellipsoid in Transformed Space")
title('(a) Transformed by $M$', Interpreter='latex')
box on
grid on

nexttile(4)
hold(gca, "on")
plot(x, y, LineWidth=LineWidth)
plot(X1(1, :), X1(2, :),LineWidth=LineWidth)
scatter(0, 0, 50, "filled")
axis equal
xlim(ax_lim)
ylim(ax_lim)
xlabel('$x_1$', Interpreter='latex')
ylabel('$x_2$', Interpreter='latex')
legend("Circle in Original Space", "Ellipsoid in Transformed Space")
title('(b-1) Transformed by $V^T$', Interpreter='latex')
box on
grid on

nexttile(5)
hold(gca, "on")
plot(x, y, LineWidth=LineWidth)
plot(X2(1, :), X2(2, :),LineWidth=LineWidth)
scatter(0, 0, 50, "filled")
axis equal
xlim(ax_lim)
ylim(ax_lim)
xlabel('$x_1$', Interpreter='latex')
ylabel('$x_2$', Interpreter='latex')
legend("Circle in Original Space", "Ellipsoid in Transformed Space")
title('(b-2) Transformed by $V^T$, and $\Sigma$', Interpreter='latex')
box on
grid on

nexttile(6)
hold(gca, "on")
plot(x, y, LineWidth=LineWidth)
plot(X3(1, :), X3(2, :),LineWidth=LineWidth)
scatter(0, 0, 50, "filled")
axis equal
xlim(ax_lim)
ylim(ax_lim)
xlabel('$x_1$', Interpreter='latex')
ylabel('$x_2$', Interpreter='latex')
legend("Circle in Original Space", "Ellipsoid in Transformed Space")
title('(b-3) Transformed by $V^T$, $\Sigma$, and $U$', Interpreter='latex')
box on
grid on

saveas(gcf, 'pic1.jpg')
