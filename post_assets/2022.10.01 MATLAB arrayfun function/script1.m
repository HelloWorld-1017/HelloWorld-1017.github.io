clc, clear, close all
rng("default")

% Create a structure array in which each structure has two fields containing numeric arrays.
S(1).X = 5:5:100; S(1).Y = rand(1, 20);
S(2).X = 10:10:100; S(2).Y = rand(1, 10);
S(3).X = 20:20:100; S(3).Y = rand(1, 5);

% Plot the numeric arrays
figure
hold(gca, "on")
grid(gca, "on")
box(gca, "on")
p = arrayfun(@(a) plot(a.X, a.Y), S);
p(1).Marker = 'o';
p(2).Marker = '+';
p(3).Marker = 's';
