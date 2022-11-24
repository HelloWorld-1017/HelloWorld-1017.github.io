clc, clear, close all

% The number of control points
n = 4; 

% 4 control points
P1 = [0, 1]';
P2 = [3.8375, 4.8391]';
P3 = [2.7725, 15.5189]';
P4 = [3.0000, 20.0855]';
P = [P1, P2, P3, P4];

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
    p1 = P(:, idx-1);
    p2 = P(:, idx);
    x_coordinate = [p1(1), p2(1)];
    y_coordinate = [p1(2), p2(2)];
    plot(x_coordinate, y_coordinate, '--r', LineWidth=LineWidth, Color=colors(1, :))
end
scatter(P(1, :), P(2, :), "filled", MarkerEdgeColor=colors(1, :), MarkerFaceColor=colors(1, :))

points = 0:1/100:1;

% Recursive calculate and plot
values = zeros(2, numel(points));
Values = cell(n*(n-1)/2, numel(points));
for t = 1:numel(points)
    % Directly calculate
    values(:, t) = (1-points(t))^3*P1+3*(1-points(t))^2*points(t).*P2+ ...
        3*(1-points(t))*points(t)^2.*P3+ points(t)^3.*P4;

    % Recursively calculate
    for i = 2:n
        p1 = P(:, i-1);
        p2 = P(:, i);
        Values{i-1, t} = firstOrderfcn(points(t), p1, p2);
    end
    for i = 2:n-1
        p1 = Values{i-1, t};
        p2 = Values{i, t};
        Values{i+2, t} = firstOrderfcn(points(t), p1, p2);
    end
    for i = n
        p1 = Values{i, t};
        p2 = Values{i+1, t};
        Values{i+2, t} = firstOrderfcn(points(t), p1, p2);
    end
end

% Directly calculate
plot(values(1,:), values(2, :), Color=colors(3, :), LineWidth=LineWidth)

% Recursively calculte
for t = 1:numel(points)
    h1 = plot([Values{1,t}(1), Values{2,t}(1)], ...
        [Values{1,t}(2), Values{2,t}(2)], ...
        LineWidth=1.5, LineStyle="-", Color=colors(2, :));
    h2 = plot([Values{2,t}(1), Values{3,t}(1)], ...
        [Values{2,t}(2), Values{3,t}(2)], ...
        LineWidth=1.5, LineStyle="-", Color=colors(2, :));
    h3 = plot([Values{4,t}(1), Values{5,t}(1)], ...
        [Values{4,t}(2), Values{5,t}(2)], ...
        LineWidth=1.5, LineStyle="-", Color=colors(2, :));
    s1 = scatter(Values{4, t}(1), Values{4, t}(2), 20, 'ko', "filled");
    s2 = scatter(Values{5, t}(1), Values{5, t}(2), 20, 'ko', "filled");
    s3 = scatter(Values{6, t}(1), Values{6, t}(2), 20, 'ko', "filled");
    exportgraphics(gcf, 'gif2.gif', 'Append', true);
    h1.Visible = "off";
    h2.Visible = "off";
    h3.Visible = "off";
    s1.Visible = "off";
    s2.Visible = "off";
    s3.Visible = "off";
end

function P_out = firstOrderfcn(t, P0, P1)
P_out = (1-t).*P0 + t.*P1;
end