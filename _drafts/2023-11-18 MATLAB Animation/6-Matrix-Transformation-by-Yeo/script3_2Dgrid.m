clc,clear,close all

[x,y] = meshgrid(-2:2);
[m,n] = size(x);

figure
hold(gca,"on")
for i = 1:n
    plot([x(i,1),x(i,end)],[y(i,1),y(i,end)],"Color","k")
end
for i = 1:m
    plot([x(1,i),x(1,i)],[y(1,i),y(end,i)],"Color","k")
end

