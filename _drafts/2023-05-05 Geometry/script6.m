clc,clear,close all

rng(17)

u = rand(3,1);
v = rand(2,1);

x1 = rand(2,1);
x2 = rand(2,1);
x3 = rand(2,1);

x11 = u*v'*x1;
x22 = u*v'*x2;
x33 = u*v'*x3;

figure
view(3)
lineWidth = 1.5;
markerSize = 20;

colors = [1,0,0;
    0,0.545,0;
    0,0,1];

plot3([0,u(1)],[0,u(2)],[0,u(3)], ...
    "LineWidth",lineWidth+0.5,"Marker",".","MarkerSize",markerSize, ...
    "Color","k")

hold(gca,"on"),box(gca,"on"),grid(gca,"on")
plot3([0,x1(1)],[0,x1(2)],[0,0], ...
    "LineWidth",lineWidth,"Marker",".","MarkerSize",markerSize, ...
    "LineStyle","-.","Color",colors(1,:))
plot3([0,x2(1)],[0,x2(2)],[0,0], ...
    "LineWidth",lineWidth,"Marker",".","MarkerSize",markerSize, ...
    "LineStyle","-.","Color",colors(2,:))
plot3([0,x3(1)],[0,x3(2)],[0,0], ...
    "LineWidth",lineWidth,"Marker",".","MarkerSize",markerSize, ...
    "LineStyle","-.","Color",colors(3,:))

plot3([0,x11(1)],[0,x11(2)],[0,x11(3)], ...
    "LineWidth",lineWidth,"Marker",".","MarkerSize",markerSize, ...
    "Color",colors(1,:))
plot3([0,x22(1)],[0,x22(2)],[0,x22(3)], ...
    "LineWidth",lineWidth,"Marker",".","MarkerSize",markerSize, ...
    "Color",colors(2,:))
plot3([0,x33(1)],[0,x33(2)],[0,x33(3)], ...
    "LineWidth",lineWidth,"Marker",".","MarkerSize",markerSize, ...
    "Color",colors(3,:))
