clc,clear,close all

% B-H curve for material "Cold Rolled Steel"
H1 = [0.0,1080,1480,2090,3120,5160,9930,1.55e4,2.50e4,3.50e4];
B1 = [0.0,0.858,1.06,1.26,1.44,1.61,1.77,1.86,1.88,1.90];

% B-H curve for material "SS430"
H2 = [0.0,143,180,219,259,298,338,378,438,517,597,716,955,1590,3980,6370,1.19e4,2.39e4,3.98e4];
B2 = [0.0,0.125,0.206,0.394,0.589,0.743,0.853,0.932,1.01,1.08,1.11,1.16,1.20,1.27,1.37,1.43,1.49,1.55,1.59];

figure
hold(gca,"on"),grid(gca,"on"),box(gca,"on")

plot(H1,B1,"LineWidth",1.5,"Color",[7,84,213]/255,"Marker","o","DisplayName","Cold Rolled Steel")
plot(H2,B2,"LineWidth",1.5,"Color",[249,82,107]/255,"Marker","square","DisplayName","SS430")
xlabel("H (A/m)")
ylabel("B (T)")
legend("Location","southeast");