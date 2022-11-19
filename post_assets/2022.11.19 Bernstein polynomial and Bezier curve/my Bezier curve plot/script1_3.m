clc, clear, close all

% The number of control points
n = 3; 

% Points
P1 = [1, 1]';
P2 = [2, 1]';
P3 = [3, 3]';
P = [P1, P2, P3];

figure
LineWidth = 1.5;
colors = [7, 84, 213;
    249, 82, 107;
    167, 51, 58]/255;
hold(gca, "on")
grid(gca, "on")
box(gca, "on")
axis(gca, "equal")

% Draw the characteristic polygon describing the bezier curve
for idx = 2:n
    p1 = P(:,idx-1);
    p2 = P(:,idx);
    x_coordinate = [p1(1), p2(1)];
    y_coordinate = [p1(2), p2(2)];
    plot(x_coordinate, y_coordinate, '--r', LineWidth=LineWidth, Color=colors(1, :))
end
scatter(P(1, :), P(2, :), "filled", MarkerEdgeColor=colors(1, :), MarkerFaceColor=colors(1, :))


% Calculte and plot movement process
points = 0:1/100:1;
values = zeros(2, numel(points));
Values = cell(n*(n-1)/2, numel(points));
for t = 1:numel(points)
    % Directly calculate 
    values(:, t) = (1-points(t))^2.*P1+2*(1-points(t))*points(t).*P2+points(t)^2.*P3;

    % Recursively calculate 
    for i = 2:n
        p1 = P(:,i-1);
        p2 = P(:, i);
        Values{i-1, t} = firstOrderfcn(points(t), p1, p2);
    end
    for i = 1:n-2
        Values{3, t} = firstOrderfcn(points(t), Values{1, t}, Values{2, t});
    end
end

% Directly calculate
plot(values(1,:), values(2, :), Color=colors(3, :), LineWidth=LineWidth)

% Recursively calculte
for t = 1:numel(points)
    h = plot([Values{1,t}(1), Values{2,t}(1)], ...
        [Values{1,t}(2), Values{2,t}(2)], ...
        LineWidth=1, LineStyle="-", Color=colors(2, :), Marker=".");
    s = scatter(Values{3, t}(1), Values{3, t}(2), 20, 'ro', "filled");
    exportgraphics(gcf, 'gif1.gif', 'Append', true);
    h.Visible = "off";
    s.Visible = "off";
end

function P_out = firstOrderfcn(t, P0, P1)
P_out = (1-t).*P0 + t.*P1;
end


