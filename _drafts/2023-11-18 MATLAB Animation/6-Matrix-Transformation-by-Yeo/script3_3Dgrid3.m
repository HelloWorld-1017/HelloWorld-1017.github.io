clc,clear,close all

[x,y,z] = meshgrid(-2:2,-2:2,-2:2);
[m,n,k] = size(x);

figure
hold(gca,"on")
view(3)
axis([-3,3,-3,3,-3,3])

xs = [];
ys = [];
zs = [];

beginningPoints = [];
enddingPoints = [];


% 2-3
for i = 1:n
    for j = 1:k
        beginningPoints = [beginningPoints;x(i,1,j),y(i,1,j),z(i,1,j)];
        enddingPoints = [enddingPoints;x(i,end,j),y(i,end,j),z(i,end,j)];
    end
end

% 1-3
for i = 1:m
    for j = 1:k
        beginningPoints = [beginningPoints;x(1,i,j),y(1,i,j),z(1,i,j)];
        enddingPoints = [enddingPoints;x(end,i,j),y(end,i,j),z(end,i,j)]
    end
end

% 2-3
for i = 1:m
    for j = 1:n
%         xs = [xs;x(i,j,1),x(i,j,end)];
%         ys = [ys;y(i,j,1),y(i,j,end)];
%         zs = [zs;z(i,j,1),z(i,j,end)];
        beginningPoints = [beginningPoints;x(i,j,1),y(i,j,1),z(i,j,1)];
        enddingPoints = [enddingPoints;x(i,j,end),y(i,j,end),z(i,j,end)]
    end
end

for i = 1:height(beginningPoints)
    plot3([beginningPoints(i,1),enddingPoints(i,1)], ...
        [beginningPoints(i,2),enddingPoints(i,2)], ...
        [beginningPoints(i,3),enddingPoints(i,3)], ...
        "Color","k","LineWidth",0.1)
end



