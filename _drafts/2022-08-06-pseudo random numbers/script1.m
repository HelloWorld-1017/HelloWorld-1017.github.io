clc, clear
num = 100;
a = 13;
b = 0;
m = 31;
x0 = 4;

x = zeros(num, 1);
u = zeros(num, 1);

x(1) = x0;
u(1) = x0/m;

for i = 2:num
    x(i) = mod(a*x(i-1), m);
    u(i) = x(i)/m;
end

figure, axes
hold(gca, 'on')
plot(1:30, x(1:30), '-o')
plot(31:60, x(31:60), '-o')
plot(61:90, x(61:90), '-o')
hold(gca, 'off')