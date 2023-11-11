clc,clear,close all

x = -1:0.001:1;
P0 = ones(size(x));
P1 = @(x) x;
P2 = @(x) (3*x.^2-1)/2;
P3 = @(x) (5*x.^3-3*x)/2;
P4 = @(x) (35*x.^4-30*x.^2+3)/8;
P5 = @(x) (63*x.^5-70*x.^3+15*x)/8;
P6 = @(x) (231*x.^6-315*x.^4+105*x.^2-5)/16;

figure
hold(gca,"on")
box(gca,"on")
grid(gca,"on")
plot(x,P0,"LineWidth",1.5,"DisplayName","$P_0$")
plot(x,P1(x),"LineWidth",1.5,"DisplayName","$P_1$")
plot(x,P2(x),"LineWidth",1.5,"DisplayName","$P_2$")
plot(x,P3(x),"LineWidth",1.5,"DisplayName","$P_3$")
plot(x,P4(x),"LineWidth",1.5,"DisplayName","$P_4$")
plot(x,P5(x),"LineWidth",1.5,"DisplayName","$P_5$")
plot(x,P6(x),"LineWidth",1.5,"DisplayName","$P_6$")
yline(0,"LineWidth",1.5,"LineStyle","--","Color","k","HandleVisibility","off")
legend("Interpreter","latex","Location","northoutside","Orientation","horizontal")



