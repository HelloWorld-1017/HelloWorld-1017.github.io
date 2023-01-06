clc, clear, close all

X1 = 0:pi/100:pi;
Y1 = sin(X1);

X2 = fliplr(X1);
Y2 = fliplr(Y1);

Q1 = trapz(X1,Y1);
Q2 = trapz(X2,Y2);