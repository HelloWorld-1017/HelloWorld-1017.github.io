m = 3.600;     % kg
k = 400;    % N/m
b = 10;      % Ns/m
x0=1; %m
g = 9.81;

springHeight = 5;
ballHeight = 20;

syms Deltax
equation = m*g*ballHeight == 0.5*k*Deltax^2+m*g*(springHeight-Deltax);
double(solve(equation))