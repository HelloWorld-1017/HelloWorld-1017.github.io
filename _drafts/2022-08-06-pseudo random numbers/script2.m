% Failed
clc, clear

rng(42, 'v4')
xmat = rand(1,5);

% -------------------------------
num = 10000000;
a = 16807;
m = 2^31 - 1;
x0 = 42;

x = zeros(num, 1);
u = zeros(num, 1);

x(1) = x0;
u(1) = x0/m;

for i = 2:num
    x(i) = mod(a*x(i-1), m);
    u(i) = x(i)/m;
end
