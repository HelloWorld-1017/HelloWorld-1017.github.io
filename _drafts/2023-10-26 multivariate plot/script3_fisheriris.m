clc,clear,close all

load fisheriris

disp(var(meas,0,1)-1/12)

figure
hold(gca,"on"),box(gca,"on"),grid(gca,"on")
ps = andrewsplot(meas,"group",species,"LineWidth",1);
for i = 1:numel(ps)
    ps(i).Color(4) = 0.7;
end
xlim([-pi,pi])

% Calculate Andrews' curve for each sample
[~,p] = size(meas);
t = -pi:.001:pi;
omega = 1:floor(p/2);
omegaSin = omega(1:floor(p/2));
omegaCos = omega(1:floor((p-1)/2));
A = [ones(1,length(t))./sqrt(2); sin(omegaSin' * t); cos(omegaCos' * t)];
F = meas(:,[1 (2:2:p) (3:2:p)])*A;

idx1 = 7;
idx2 = 71;
sum((F(idx1,:)-F(idx2,:)).^2*0.001)
pi*sum((meas(idx1,:)-meas(idx2,:)).^2)

vars = nan(1,width(F));
for i = 1:width(F)
    vars(i) = var(F(:,i))-(1.5/12);
end
disp(sum(vars)/width(F))
disp(mean(var(F,0,1)-(1.5/12)))
