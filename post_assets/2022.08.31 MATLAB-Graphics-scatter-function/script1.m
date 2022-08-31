clc, clear, close

% Points
data = randn(1,20);

% Plot
figure, axes
hold(gca, "on")
scatter(1:numel(data), data, 200, 'rx', LineWidth=2)