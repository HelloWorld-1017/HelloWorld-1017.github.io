clc,clear,close all

load fisheriris
meas = meas(:,1:3);

mdl = fitcdiscr(meas,species,"DiscrimType","quadratic"); % DiscrimType: quadratic
mus = mdl.Mu;
Sigmas = mdl.Sigma;

numNew = 200;
newSetosa1 = mvnrnd(mus(1,:),Sigmas(:,:,1),numNew);
newSetosa2 = mvnrnd(mus(1,:),Sigmas(:,:,2),numNew);
newSetosa3 = mvnrnd(mus(1,:),Sigmas(:,:,3),numNew);

newVersicolor1 = mvnrnd(mus(2,:),Sigmas(:,:,2),numNew);
newVersicolor2 = mvnrnd(mus(2,:),Sigmas(:,:,1),numNew);
newVersicolor3 = mvnrnd(mus(2,:),Sigmas(:,:,3),numNew);

newVirginica1 = mvnrnd(mus(3,:),Sigmas(:,:,3),numNew);
newVirginica2 = mvnrnd(mus(3,:),Sigmas(:,:,1),numNew);
newVirginica3 = mvnrnd(mus(3,:),Sigmas(:,:,2),numNew);

meas_setosa = meas(strcmp(species,"setosa"),:);
meas_versicolor = meas(strcmp(species,"versicolor"),:);
meas_virginica = meas(strcmp(species,"virginica"),:);

figure("Units","pixels","Position",[390.3333333333333,465,1550,420])
tiledlayout(1,3)
markerSize = 20;
markerAlpha = 0.7;
nexttile
hold(gca,"on"),box(gca,"on"),grid(gca,"on"),view(3)
scatter3(meas_setosa(:,1),meas_setosa(:,2),meas_setosa(:,3), ...
    markerSize,"filled","DisplayName","Original","MarkerFaceColor",[7,84,213]/255)
scatter3(newSetosa1(:,1),newSetosa1(:,2),newSetosa1(:,3), ...
    markerSize,"filled","DisplayName","G($\Sigma_1$)","MarkerFaceColor",[249,82,107]/255)
scatter3(newSetosa2(:,1),newSetosa2(:,2),newSetosa2(:,3), ...
    markerSize,"filled","DisplayName","G($\Sigma_2$)","MarkerFaceColor","g","MarkerFaceAlpha",markerAlpha)
scatter3(newSetosa3(:,1),newSetosa3(:,2),newSetosa3(:,3), ...
    markerSize,"filled","DisplayName","G($\Sigma_2$)","MarkerFaceColor","cyan","MarkerFaceAlpha",markerAlpha)
legend("Location","northeast","Orientation","horizontal","Interpreter","latex");
title("Species: Setosa")
xlabel("Feature 1")
ylabel("Feature 2")
zlabel("Feature 3")

nexttile
hold(gca,"on"),box(gca,"on"),grid(gca,"on"),view(3)
scatter3(meas_versicolor(:,1),meas_versicolor(:,2),meas_versicolor(:,3), ...
    markerSize,"filled","DisplayName","Original","MarkerFaceColor",[7,84,213]/255)
scatter3(newVersicolor1(:,1),newVersicolor1(:,2),newVersicolor1(:,3), ...
    markerSize,"filled","DisplayName","G($\Sigma_2$)","MarkerFaceColor",[249,82,107]/255)
scatter3(newVersicolor2(:,1),newVersicolor2(:,2),newVersicolor2(:,3), ...
    markerSize,"filled","DisplayName","G($\Sigma_1$)","MarkerFaceColor","g","MarkerFaceAlpha",markerAlpha)
scatter3(newVersicolor3(:,1),newVersicolor3(:,2),newVersicolor3(:,3), ...
    markerSize,"filled","DisplayName","G($\Sigma_3$)","MarkerFaceColor","cyan","MarkerFaceAlpha",markerAlpha)
legend("Location","north","Orientation","horizontal","Interpreter","latex");
title("Species: Versicolor")
xlabel("Feature 1")
ylabel("Feature 2")
zlabel("Feature 3")

nexttile
hold(gca,"on"),box(gca,"on"),grid(gca,"on"),view(3)
scatter3(meas_virginica(:,1),meas_virginica(:,2),meas_virginica(:,3), ...
    markerSize,"filled","DisplayName","Original","MarkerFaceColor",[7,84,213]/255)
scatter3(newVirginica1(:,1),newVirginica1(:,2),newVirginica1(:,3), ...
    markerSize,"filled","DisplayName","G($\Sigma_3$)","MarkerFaceColor",[249,82,107]/255)
scatter3(newVirginica2(:,1),newVirginica2(:,2),newVirginica2(:,3), ...
    markerSize,"filled","DisplayName","G($\Sigma_1$)","MarkerFaceColor","g","MarkerFaceAlpha",markerAlpha)
scatter3(newVirginica3(:,1),newVirginica3(:,2),newVirginica3(:,3), ...
    markerSize,"filled","DisplayName","G($\Sigma_2$)","MarkerFaceColor","cyan","MarkerFaceAlpha",markerAlpha)
legend("Location","northeast","Orientation","horizontal","Interpreter","latex");
title("Species: Virginica")
xlabel("Feature 1")
ylabel("Feature 2")
zlabel("Feature 3")


