clc,clear,close all

load fisheriris.mat

[coeff,score,latent,tsquared,explained,mu] = pca(meas);

features1 = meas*coeff(:,1:2);

figure("Position",[602.33,375,1054.67,420])
tiledlayout(1,2)
nexttile
hold(gca,"on"),box(gca,"on"),grid(gca,"on")
ps = andrewsplot(features1,"group",species,"LineWidth",1);
for i = 1:numel(ps)
    ps(i).Color(4) = 0.7;
end
xlim([-pi,pi])
legend("Location","north","Orientation","horizontal")
title("Order: 1st principle component, 2nd principle component")

features2 = fliplr(features1);
nexttile
hold(gca,"on"),box(gca,"on"),grid(gca,"on")
ps = andrewsplot(features2,"group",species,"LineWidth",1);
for i = 1:numel(ps)
    ps(i).Color(4) = 0.7;
end
xlim([-pi,pi])
legend("Location","north","Orientation","horizontal")
title("Order: 2nd principle component, 1st principle component")
exportgraphics(gcf,"pic-2.jpg","Resolution",600)


