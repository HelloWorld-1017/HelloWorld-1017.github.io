clc, clear, close all

figure
for i = [1, 3, 5, 7, 99, 999]
    nexttile
    Omega = pi;
    SquareObj = Square(Omega);
    SineApproxObj1 = SineApprox(Omega, i);
    SquareObj.Plot()
    SineApproxObj1.Plot()
end