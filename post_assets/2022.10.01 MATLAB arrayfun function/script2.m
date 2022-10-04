clc, clear, close all

X = {5:5:100, 10:10:100, 20:20:100};
Y = {rand(1,20), rand(1,10), rand(1,5)};

figure
hold(gca, "on")
grid(gca, "on")
box(gca, "on")
p = cellfun(@plot, X, Y);
p(1).Marker = 'o';
p(2).Marker = '+';
p(3).Marker = 's';