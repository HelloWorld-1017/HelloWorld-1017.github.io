clc,clear,close all

rng("default")
features = rand(150,3);

% Calculate Andrews' curve for each sample
[n,p] = size(features);
t = -pi:.001:pi;
omega = 1:floor(p/2);
omegaSin = omega(1:floor(p/2));
omegaCos = omega(1:floor((p-1)/2));
A = [ones(1,length(t))./sqrt(2); sin(omegaSin' * t); cos(omegaCos' * t)];
F = features(:,[1 (2:2:p) (3:2:p)])*A;

disp(var(features)-1/12),disp(mean(var(F)-(1.5/12)))