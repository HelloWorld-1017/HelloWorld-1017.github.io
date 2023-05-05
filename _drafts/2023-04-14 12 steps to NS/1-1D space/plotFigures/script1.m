clc,clear,close all

figure
hold(gca,"on")
box(gca,"on")
grid(gca,"on")

x = linspace(-1,1,1000);
y = x.^2;
plot(x,y,'b')

x = linspace(-1,1,1000)+1;
y = (x-1).^2;
plot(x,y,'k')