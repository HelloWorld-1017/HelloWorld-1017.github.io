clc, clear, close
[t1, y1] = ode45(@StateFunction1, [0, 100], [0; 1]);
[t2, y2] = ode45(@StateFunction2, [0, 100], [0; 1]);
[t3, y3] = ode45(@StateFunction3, [0, 100], [0; 1]);
[t4, y4] = ode45(@StateFunction4, [0, 100], [0; 1]);

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

legend("Phase Trajectory: R=3", "Initial point: R=3", "Terminal point: R=3",...
   "Phase Trajectory: R=4", "Initial point: R=4", "Terminal point: R=4",...
   "Phase Trajectory: R=5", "Initial point: R=5", "Terminal point: R=5",...
   "Phase Trajectory: R=100", "Initial point: R=100", "Terminal point: R=100")
xlabel("$x_1$", Interpreter="latex")
ylabel("$x_2$", Interpreter="latex")
title("$\delta^2>\omega_0^2$ ($U_0=1$) ", Interpreter="latex")


function dydt = StateFunction1(t, y)
R=3;
L=1;
C=1;
delta = R/(2*L);
omega_s = 1/(L*C);
dydt = [y(2); -omega_s*y(1)-2*delta*y(2)];
end

function dydt = StateFunction2(t, y)
R=4;
L=1;
C=1;
delta = R/(2*L);
omega_s = 1/(L*C);
dydt = [y(2); -omega_s*y(1)-2*delta*y(2)];
end

function dydt = StateFunction3(t, y)
R=5;
L=1;
C=1;
delta = R/(2*L);
omega_s = 1/(L*C);
dydt = [y(2); -omega_s*y(1)-2*delta*y(2)];
end

function dydt = StateFunction4(t, y)
R=100;
L=1;
C=1;
delta = R/(2*L);
omega_s = 1/(L*C);
dydt = [y(2); -omega_s*y(1)-2*delta*y(2)];
end
