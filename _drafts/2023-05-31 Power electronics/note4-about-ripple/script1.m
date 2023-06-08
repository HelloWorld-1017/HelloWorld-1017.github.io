clc,clear,close all

R = 1;
L = 0.01;
C = 1e-6;
omega = 0:1:200;
RC = (-R*1i./omega/C)./(R-1i./omega/C);
H1 = RC./(RC+1i.*omega*L);
H2 = 1./(omega.^2*L*C-1);
% H1 = R
plot(omega,abs(H2))