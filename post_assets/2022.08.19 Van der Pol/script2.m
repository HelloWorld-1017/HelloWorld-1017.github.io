clc, clear, close
gifFile = 'PhaceTractories.gif';
if exist(gifFile, 'file')
    delete(gifFile)
end

% Figure settings
LineWidth = 1;
xyaxislimit = [-4, 6, -4, 10];
sz = 40;
numpoints = 100;

figure, axes
hold(gca, 'on')
axis(xyaxislimit)
xlabel("$x_1$", Interpreter="latex")
ylabel("$x_2$", Interpreter="latex")
title('The trajectories with $\varepsilon$=0.1 and various initial points.', Interpreter="latex")


% Specify various intitial points and solve state function
y0_1 = [0; 1];
[t1, y1] = ode45(@StateFunction, [0, numpoints], y0_1);
y0_2 = [0; 5];
[t2, y2] = ode45(@StateFunction, [0, numpoints], y0_2);
y0_3 = [0; 9];
[t3, y3] = ode45(@StateFunction, [0, numpoints], y0_3);


% Plot trajectory1
scatter(y0_1(1),y0_1(2), sz, 'filled')
h1 = animatedline(gca, LineWidth=LineWidth, Color='#C85C5C');
legend(['Initial point: ', '(', num2str(y0_1(1)), ',', num2str(y0_1(2)), ')'], ...
    ['Trajectory: ', '(', num2str(y0_1(1)), ',', num2str(y0_1(2)), ')'])
for i = 1:numel(y1(:,1))
    addpoints(h1, y1(i,1), y1(i,2))
    drawnow
    exportgraphics(gcf, gifFile, 'Append', true);
end
scatter(y1(end,1), y1(end,2), 'filled');
legend(['Initial point: ', '(', num2str(y0_1(1)), ',', num2str(y0_1(2)), ')'], ...
    ['Trajectory: ', '(', num2str(y0_1(1)), ',', num2str(y0_1(2)), ')'], ...
    ['End point: ', '(', num2str(y0_1(1)), ',', num2str(y0_1(2)), ')'])

% Plot trajectory2
scatter(y0_2(1),y0_2(2), 'filled')
h2 = animatedline(gca, LineWidth=LineWidth, Color='#5CC85C');
legend(['Initial point: ', '(', num2str(y0_1(1)), ',', num2str(y0_1(2)), ')'], ...
    ['Trajectory: ', '(', num2str(y0_1(1)), ',', num2str(y0_1(2)), ')'], ...
    ['End point: ', '(', num2str(y0_1(1)), ',', num2str(y0_1(2)), ')'], ...
    ['Initial point: ', '(', num2str(y0_2(1)), ',', num2str(y0_2(2)), ')'], ...
    ['Trajectory: ', '(', num2str(y0_2(1)), ',', num2str(y0_2(2)), ')']);
for i = 1:numel(y2(:,1))
    addpoints(h2, y2(i,1), y2(i,2))
    drawnow
    exportgraphics(gcf, gifFile, 'Append', true);
end
scatter(y2(end,1), y2(end,2), 'filled');
legend(['Initial point: ', '(', num2str(y0_1(1)), ',', num2str(y0_1(2)), ')'], ...
    ['Trajectory: ', '(', num2str(y0_1(1)), ',', num2str(y0_1(2)), ')'], ...
    ['End point: ', '(', num2str(y0_1(1)), ',', num2str(y0_1(2)), ')'], ...
    ['Initial point: ', '(', num2str(y0_2(1)), ',', num2str(y0_2(2)), ')'], ...
    ['Trajectory: ', '(', num2str(y0_2(1)), ',', num2str(y0_2(2)), ')'], ...
    ['End point: ', '(', num2str(y0_2(1)), ',', num2str(y0_2(2)), ')']);

% Plot trajectory3
scatter(y0_3(1),y0_3(2), 'filled')
h3 = animatedline(gca, LineWidth=LineWidth, Color='#5C5CC8');
legend(['Initial point: ', '(', num2str(y0_1(1)), ',', num2str(y0_1(2)), ')'], ...
    ['Trajectory: ', '(', num2str(y0_1(1)), ',', num2str(y0_1(2)), ')'], ...
    ['End point: ', '(', num2str(y0_1(1)), ',', num2str(y0_1(2)), ')'], ...
    ['Initial point: ', '(', num2str(y0_2(1)), ',', num2str(y0_2(2)), ')'], ...
    ['Trajectory: ', '(', num2str(y0_2(1)), ',', num2str(y0_2(2)), ')'], ...
    ['End point: ', '(', num2str(y0_2(1)), ',', num2str(y0_2(2)), ')'], ...
    ['Initial point: ', '(', num2str(y0_3(1)), ',', num2str(y0_3(2)), ')'], ...
    ['Trajectory: ', '(', num2str(y0_3(1)), ',', num2str(y0_3(2)), ')']);
for i = 1:numel(y3(:,1))
    addpoints(h3, y3(i,1), y3(i,2))
    drawnow
    exportgraphics(gcf, gifFile, 'Append', true);
end
scatter(y3(end,1), y3(end,2), 'filled');
legend(['Initial point: ', '(', num2str(y0_1(1)), ',', num2str(y0_1(2)), ')'], ...
    ['Trajectory: ', '(', num2str(y0_1(1)), ',', num2str(y0_1(2)), ')'], ...
    ['End point: ', '(', num2str(y0_1(1)), ',', num2str(y0_1(2)), ')'], ...
    ['Initial point: ', '(', num2str(y0_2(1)), ',', num2str(y0_2(2)), ')'], ...
    ['Trajectory: ', '(', num2str(y0_2(1)), ',', num2str(y0_2(2)), ')'], ...
    ['End point: ', '(', num2str(y0_2(1)), ',', num2str(y0_2(2)), ')'], ...
    ['Initial point: ', '(', num2str(y0_3(1)), ',', num2str(y0_3(2)), ')'], ...
    ['Trajectory: ', '(', num2str(y0_3(1)), ',', num2str(y0_3(2)), ')'], ...
    ['End point: ', '(', num2str(y0_3(1)), ',', num2str(y0_3(2)), ')']);


function dydt = StateFunction(t, y)
epsilon = 0.1;
dydt = [y(2); epsilon*(1-y(1)^2)*y(2)-y(1)];
end