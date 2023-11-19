clc,clear,close all

[x,y,z] = meshgrid(-2:2,-2:2,-2:2);
[m,n,k] = size(x);

figure
hold(gca,"on")
view(3)
axis([-3,3,-3,3,-3,3])

% 2-3
for i = 1:n
    for j = 1:k
        plot3([x(i,1,j),x(i,end,j)],[y(i,1,j),y(i,end,j)],[z(i,1,j),z(i,end,j)], ...
            "Color","k","LineWidth",0.1)
    end
end

% 1-3
for i = 1:m
    for j = 1:k
        plot3([x(1,i,j),x(end,i,j)],[y(1,i,j),y(end,i,j)],[z(1,i,j),z(end,i,j)], ...
            "Color","k","LineWidth",0.1)
    end
end

% 2-3
for i = 1:m
    for j = 1:n
        plot3([x(i,j,1),x(i,j,end)],[y(i,j,1),y(i,j,end)],[z(i,j,1),z(i,j,end)], ...
            "Color","k","LineWidth",0.1)
    end
end




