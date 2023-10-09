clc,clear,close all

load fisheriris
meas = meas(:,1:3);

mdl = fitcdiscr(meas,species); % DiscrimType: 'linear'(fault)
mus = mdl.Mu;
Sigmas = mdl.Sigma;

numNew = 200;
newSetosa = mvnrnd(mus(1,:),Sigmas,numNew);
newVersicolor = mvnrnd(mus(2,:),Sigmas,numNew);
newVirginica = mvnrnd(mus(3,:),Sigmas,numNew);

meas_setosa = meas(strcmp(species,"setosa"),:);
meas_versicolor = meas(strcmp(species,"versicolor"),:);
meas_virginica = meas(strcmp(species,"virginica"),:);

figure("Units","pixels","Position",[390.3333333333333,465,1550,420])
tiledlayout(1,3,"TileSpacing","tight")
markerSize = 20;
nexttile
hold(gca,"on"),box(gca,"on"),grid(gca,"on"),view(3)
scatter3(meas_setosa(:,1),meas_setosa(:,2),meas_setosa(:,3), ...
    markerSize,"filled","DisplayName","Original","MarkerFaceColor",[7,84,213]/255)
scatter3(newSetosa(:,1),newSetosa(:,2),newSetosa(:,3), ...
    markerSize,"filled","DisplayName","Generated","MarkerFaceColor",[249,82,107]/255)
legend("Location","north","Orientation","horizontal");
title("Species: Setosa")
xlabel("Feature 1")
ylabel("Feature 2")
zlabel("Feature 3")

nexttile
hold(gca,"on"),box(gca,"on"),grid(gca,"on"),view(3)
scatter3(meas_versicolor(:,1),meas_versicolor(:,2),meas_versicolor(:,3), ...
    markerSize,"filled","DisplayName","Original","MarkerFaceColor",[7,84,213]/255)
scatter3(newVersicolor(:,1),newVersicolor(:,2),newVersicolor(:,3), ...
    markerSize,"filled","DisplayName","Generated","MarkerFaceColor",[249,82,107]/255)
legend("Location","north","Orientation","horizontal");
title("Species: Versicolor")
xlabel("Feature 1")
ylabel("Feature 2")
zlabel("Feature 3")

nexttile
hold(gca,"on"),box(gca,"on"),grid(gca,"on"),view(3)
scatter3(meas_virginica(:,1),meas_virginica(:,2),meas_virginica(:,3), ...
    markerSize,"filled","DisplayName","Original","MarkerFaceColor",[7,84,213]/255)
scatter3(newVirginica(:,1),newVirginica(:,2),newVirginica(:,3), ...
    markerSize,"filled","DisplayName","Generated","MarkerFaceColor",[249,82,107]/255)
legend("Location","north","Orientation","horizontal");
title("Species: Virginica")
xlabel("Feature 1")
ylabel("Feature 2")
zlabel("Feature 3")
