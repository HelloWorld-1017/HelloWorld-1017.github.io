load fisheriris

figure
hold(gca,"on"),box(gca,"on"),grid(gca,"on")
ps = andrewsplot(meas,"group",species,"quantile",0.25,"LineWidth",1);
for i = 1:numel(ps)
    ps(i).Color(4) = 0.7;
end
xlim([-pi,pi])