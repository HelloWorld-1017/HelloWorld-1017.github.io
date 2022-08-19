clc, clear, close
[t, y] = ode45(@StateFunction, [0, 100], [0; 1]);

LineWidth = 1.7;

figure, axes
hold(gca, 'on');
plot(y(:,1), y(:,2), LineWidth=LineWidth);
scatter(y(1,1), y(1,2), "filled");
scatter(y(end, 1), y(end, 2), "filled");

legend("Phase Trajectory:R=0.1", "Initial point: R=0.1", "Terminal point: R=0.1")
xlabel("$x_1$", Interpreter="latex")
ylabel("$x_2$", Interpreter="latex")
title("$\delta^2<\omega_0^2$ ($U_0=1$) ", Interpreter="latex")

function dydt = StateFunction(t, y)
R=0.1;
L=1;
C=1;
delta = R/(2*L);
omega_s = 1/(L*C);
dydt = [y(2); -omega_s*y(1)-2*delta*y(2)];
end