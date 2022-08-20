clc, clear, close
gifFile = 'PhaceTractories2.gif';
if exist(gifFile, 'file')
    delete(gifFile)
end

% Figure settings
LineWidth = 1.5;
xyaxislimit = [-4, 8, -6, 10];
sz = 40;
numpoints = 100;

figure, axes
hold(gca, 'on')
axis(xyaxislimit)
xlabel("$x_1$", Interpreter="latex")
ylabel("$x_2$", Interpreter="latex")
title('The trajectories with various $\varepsilon$ values', Interpreter="latex")


% Specify various intitial points and solve state function
y0 = [0; 5];
[t1, y1] = ode45(@StateFunction1, [0, numpoints], y0);
[t2, y2] = ode45(@StateFunction2, [0, numpoints], y0);
[t3, y3] = ode45(@StateFunction3, [0, numpoints], y0);

scatter(y0(1),y0(2), sz, 'filled')
% Plot trajectory1
h1 = animatedline(gca, LineWidth=LineWidth, Color='#C85C5C');
legend('Initial point', ...
    'Trajectory: $\varepsilon$=0.1', Interpreter="latex")
for i = 1:numel(y1(:,1))
    addpoints(h1, y1(i,1), y1(i,2))
    drawnow
%     exportgraphics(gcf, gifFile, 'Append', true);
end
scatter(y1(end,1), y1(end,2), 'filled');
legend('Initial point', ...
    'Trajectory: $\varepsilon$=0.1', ...
    'End point: $\varepsilon$=0.1', Interpreter="latex")

% Plot trajectory2
h2 = animatedline(gca, LineWidth=LineWidth, Color='#5CC85C');
legend('Initial point', ...
    'Trajectory: $\varepsilon$=0.1', ...
    'End point: $\varepsilon$=0.1', ...
    'Trajectory: $\varepsilon$=0.7', Interpreter="latex")
for i = 1:numel(y2(:,1))
    addpoints(h2, y2(i,1), y2(i,2))
    drawnow
%     exportgraphics(gcf, gifFile, 'Append', true);
end
scatter(y2(end,1), y2(end,2), 'filled');
legend('Initial point', ...
    'Trajectory: $\varepsilon$=0.1', ...
    'End point: $\varepsilon$=0.1', ...
    'Trajectory: $\varepsilon$=0.7', ...
    'End point: $\varepsilon$=0.7', Interpreter="latex")

% Plot trajectory3
h3 = animatedline(gca, LineWidth=LineWidth, Color='#5C5CC8');
legend('Initial point', ...
    'Trajectory: $\varepsilon$=0.1', ...
    'End point: $\varepsilon$=0.1', ...
    'Trajectory: $\varepsilon$=0.7', ...
    'End point: $\varepsilon$=0.7', ...
    'Trajectory: $\varepsilon$=3.5', Interpreter="latex")
for i = 1:numel(y3(:,1))
    addpoints(h3, y3(i,1), y3(i,2))
    drawnow
%     exportgraphics(gcf, gifFile, 'Append', true);
end
scatter(y3(end,1), y3(end,2), 'filled');
legend('Initial point', ...
    'Trajectory: $\varepsilon$=0.1', ...
    'End point: $\varepsilon$=0.1', ...
    'Trajectory: $\varepsilon$=0.7', ...
    'End point: $\varepsilon$=0.7', ...
    'Trajectory: $\varepsilon$=3.5', ...
    'End point: $\varepsilon$=3.5', Interpreter="latex")

function dydt = StateFunction1(t, y)
epsilon = 0.1;
dydt = [y(2); epsilon*(1-y(1)^2)*y(2)-y(1)];
end

function dydt = StateFunction2(t, y)
epsilon = 0.7;
dydt = [y(2); epsilon*(1-y(1)^2)*y(2)-y(1)];
end

function dydt = StateFunction3(t, y)
epsilon = 3.5;
dydt = [y(2); epsilon*(1-y(1)^2)*y(2)-y(1)];
end
