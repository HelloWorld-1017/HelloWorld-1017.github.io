clc,clear,close all

rng(17)

a = rand(3,1);
b = rand(2,1);

x1 = rand(2,1);
x2 = rand(2,1);
x3 = rand(2,1);

x11 = kron(a,b)*x1; % x11 = a*b'*x1;
x22 = kron(a,b)*x2; % x22 = a*b'*x2;
x33 = kron(a,b)*x3; % x33 = a*b'*x3;

colors = [1,0,0;
    0,0.545,0;
    0,0,1];

figure("Position",[925,453,560,420])
ax = axes;
view(ax,40.30,34.80)
lineWidth = 1.5;
markerSize = 20;
hold(ax,"on"),box(ax,"on"),grid(ax,"on")
plot3([0,a(1)],[0,a(2)],[0,a(3)], ...
    "LineWidth",lineWidth+0.5,"Marker",".","MarkerSize",markerSize, ...
    "Color","k","DisplayName","$a$")

plot3([0,x1(1)],[0,x1(2)],[0,0], ...
    "LineWidth",lineWidth,"Marker",".","MarkerSize",markerSize, ...
    "LineStyle","-.","Color",colors(1,:),"DisplayName","$x_1$")
plot3([0,x2(1)],[0,x2(2)],[0,0], ...
    "LineWidth",lineWidth,"Marker",".","MarkerSize",markerSize, ...
    "LineStyle","-.","Color",colors(2,:),"DisplayName","$x_2$")
plot3([0,x3(1)],[0,x3(2)],[0,0], ...
    "LineWidth",lineWidth,"Marker",".","MarkerSize",markerSize, ...
    "LineStyle","-.","Color",colors(3,:),"DisplayName","$x_3$")

plot3([0,x11(1)],[0,x11(2)],[0,x11(3)], ...
    "LineWidth",lineWidth,"Marker",".","MarkerSize",markerSize, ...
    "Color",colors(1,:),"DisplayName","$ab^Tx_1$")
plot3([0,x22(1)],[0,x22(2)],[0,x22(3)], ...
    "LineWidth",lineWidth,"Marker",".","MarkerSize",markerSize, ...
    "Color",colors(2,:),"DisplayName","$ab^Tx_2$")
plot3([0,x33(1)],[0,x33(2)],[0,x33(3)], ...
    "LineWidth",lineWidth,"Marker",".","MarkerSize",markerSize, ...
    "Color",colors(3,:),"DisplayName","$ab^Tx_3$")
legend("Location","east","Interpreter","latex")