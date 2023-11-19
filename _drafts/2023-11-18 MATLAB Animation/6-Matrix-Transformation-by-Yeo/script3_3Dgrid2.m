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

% 2-3
for i = 1:n
    for j = 1:k
        xs = [xs;x(i,1,j),x(i,end,j)];
        ys = [ys;y(i,1,j),y(i,end,j)];
        zs = [zs;z(i,1,j),z(i,end,j)];
    end
end

% 1-3
for i = 1:m
    for j = 1:k
        xs = [xs;x(1,i,j),x(end,i,j)];
        ys = [ys;y(1,i,j),y(end,i,j)];
        zs = [zs;z(1,i,j),z(end,i,j)];
    end
end

% 2-3
for i = 1:m
    for j = 1:n
        xs = [xs;x(i,j,1),x(i,j,end)];
        ys = [ys;y(i,j,1),y(i,j,end)];
        zs = [zs;z(i,j,1),z(i,j,end)];
    end
end

for i = 1:height(xs)
    plot3([xs(i,1),xs(i,2)],[ys(i,1),ys(i,2)],[zs(i,1),zs(i,2)], ...
        "Color","k","LineWidth",0.1)
end



