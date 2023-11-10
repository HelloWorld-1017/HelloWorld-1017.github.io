load fisheriris

rng("default")

meas = meas(strcmp(species,"setosa"),1);
disp(var(meas,0,1))

% Calculate Andrews' curve for each sample
[~,p] = size(meas);
t = -pi:.001:pi;
omega = 1:floor(p/2);
omegaSin = omega(1:floor(p/2));
omegaCos = omega(1:floor((p-1)/2));
A = [ones(1,length(t))./sqrt(2); sin(omegaSin' * t); cos(omegaCos' * t)];
F = meas(:,[1 (2:2:p) (3:2:p)])*A;

disp(mean(var(F,0,1)))
