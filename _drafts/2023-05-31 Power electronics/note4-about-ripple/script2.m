clc,clear,close all

Vg = 30;
V = -20;
fs = 40e3;
Ts = 1/fs;
R = 4;
ripple = 0.1;
DeltaV = 0.1; % Δv is 0.1 V

D = V/(V-Vg); % Duty cycle
I = Vg*D/R/(1-D)^2;

L = (Vg*D*Ts)/(2*ripple*I);
C = 0.1*I*Ts/(8*DeltaV);

disp(D)
disp(L)
disp(C)