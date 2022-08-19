clc, clear, close
[t1, y1] = ode45(@StateFunction, [0, 100], [0; 1]);
[t2, y2] = ode45(@StateFunction, [0, 100], [0; 5]);
[t3, y3] = ode45(@StateFunction, [0, 100], [0; 10]);

[t4, y4] = ode45(@StateFunction, [0, 100], [0; -1]);
[t5, y5] = ode45(@StateFunction, [0, 100], [0; -5]);
[t6, y6] = ode45(@StateFunction, [0, 100], [0; -10]);

LineWidth = 1.7;

figure, axes
hold(gca, 'on');
plot(y1(:,1), y1(:,2), LineWidth=LineWidth);
scatter(y1(1,1), y1(1,2), "filled");
scatter(y1(end, 1), y1(end, 2), "filled");

plot(y2(:,1), y2(:,2), LineWidth=LineWidth);
scatter(y2(1,1), y2(1,2), "filled");
scatter(y2(end, 1), y2(end, 2), "filled");

plot(y3(:,1), y3(:,2), LineWidth=LineWidth);
scatter(y3(1,1), y3(1,2), "filled");
scatter(y3(end, 1), y3(end, 2), "filled");

plot(y4(:,1), y4(:,2), LineWidth=LineWidth);
scatter(y4(1,1), y4(1,2), "filled");
scatter(y4(end, 1), y4(end, 2), "filled");

plot(y5(:,1), y5(:,2), LineWidth=LineWidth);
scatter(y5(1,1), y5(1,2), "filled");
scatter(y5(end, 1), y5(end, 2), "filled");

plot(y6(:,1), y6(:,2), LineWidth=LineWidth);
scatter(y6(1,1), y6(1,2), "filled");
scatter(y6(end, 1), y6(end, 2), "filled");

legend("Phase Trajectory: U_0=1", "Initial point: U_0=1", "Terminal point: U_0=1",...
   "Phase Trajectory: U_0=5", "Initial point: U_0=5", "Terminal point: U_0=5",...
   "Phase Trajectory: U_0=10", "Initial point: U_0=10", "Terminal point: U_0=10",...
   "Phase Trajectory: U_0=-1", "Initial point: U_0=-1", "Terminal point: U_0=-1",...
   "Phase Trajectory: U_0=-5", "Initial point: U_0=-5", "Terminal point: U_0=-5",...
   "Phase Trajectory: U_0=-10", "Initial point: U_0=-10", "Terminal point: U_0=-10")
xlabel("$x_1$", Interpreter="latex")
ylabel("$x_2$", Interpreter="latex")
title("$\delta^2>\omega_0^2$ ($R=3$)", Interpreter="latex")


function dydt = StateFunction(t, y)
R=3;
L=1;
C=1;
delta = R/(2*L);
omega_s = 1/(L*C);
dydt = [y(2); -omega_s*y(1)-2*delta*y(2)];
end