clc,clear,close all

load fisheriris
meas = meas(:,1:3);

mdl_linear = fitcdiscr(meas,species); % DiscrimType: linear
mus_linear = mdl_linear.Mu;
Sigmas_linear = mdl_linear.Sigma;

mdl_quadratic = fitcdiscr(meas,species,"DiscrimType","quadratic"); % DiscrimType: quadratic
mus_quadratic = mdl_quadratic.Mu;
Sigmas_quadratic = mdl_quadratic.Sigma;

numNew = 50;

newSetosa_linear = mvnrnd(mus_linear(1,:),Sigmas_linear,numNew);
newSetosa_quadratic = mvnrnd(mus_quadratic(1,:),Sigmas_quadratic(:,:,1),numNew);

newVersicolor_linear = mvnrnd(mus_linear(2,:),Sigmas_linear,numNew);
newVersicolor_quadratic = mvnrnd(mus_quadratic(2,:),Sigmas_quadratic(:,:,2),numNew);

newVirginica_linear = mvnrnd(mus_linear(3,:),Sigmas_linear,numNew);
newVirginica_quadratic = mvnrnd(mus_quadratic(3,:),Sigmas_quadratic(:,:,3),numNew);

meas_setosa = meas(strcmp(species,"setosa"),:);
meas_versicolor = meas(strcmp(species,"versicolor"),:);
meas_virginica = meas(strcmp(species,"virginica"),:);

figure("Units","pixels","Position",[390.3333333333333,465,1550,420])
tiledlayout(1,3)
markerSize = 20;
nexttile
hold(gca,"on"),box(gca,"on"),grid(gca,"on"),view(3)
scatter3(meas_setosa(:,1),meas_setosa(:,2),meas_setosa(:,3), ...
    markerSize,"filled","DisplayName","Original","MarkerFaceColor",[7,84,213]/255)
scatter3(newSetosa_linear(:,1),newSetosa_linear(:,2),newSetosa_linear(:,3), ...
    markerSize,"filled","DisplayName","Linear model","MarkerFaceColor",[249,82,107]/255)
scatter3(newSetosa_quadratic(:,1),newSetosa_quadratic(:,2),newSetosa_quadratic(:,3), ...
    markerSize,"filled","DisplayName","Quadratic model","MarkerFaceColor","g")
legend("Location","northeast","Orientation","horizontal");
title("Species: Setosa")
xlabel("Feature 1")
ylabel("Feature 2")
zlabel("Feature 3")

nexttile
hold(gca,"on"),box(gca,"on"),grid(gca,"on"),view(3)
scatter3(meas_versicolor(:,1),meas_versicolor(:,2),meas_versicolor(:,3), ...
    markerSize,"filled","DisplayName","Original","MarkerFaceColor",[7,84,213]/255)
scatter3(newVersicolor_linear(:,1),newVersicolor_linear(:,2),newVersicolor_linear(:,3), ...
    markerSize,"filled","DisplayName","Linear model","MarkerFaceColor",[249,82,107]/255)
scatter3(newVersicolor_quadratic(:,1),newVersicolor_quadratic(:,2),newVersicolor_quadratic(:,3), ...
    markerSize,"filled","DisplayName","Quadratic model","MarkerFaceColor","g")
legend("Location","north","Orientation","horizontal");
title("Species: Versicolor")
xlabel("Feature 1")
ylabel("Feature 2")
zlabel("Feature 3")

nexttile
hold(gca,"on"),box(gca,"on"),grid(gca,"on"),view(3)
scatter3(meas_virginica(:,1),meas_virginica(:,2),meas_virginica(:,3), ...
    markerSize,"filled","DisplayName","Original","MarkerFaceColor",[7,84,213]/255)
scatter3(newVirginica_linear(:,1),newVirginica_linear(:,2),newVirginica_linear(:,3), ...
    markerSize,"filled","DisplayName","Linear model","MarkerFaceColor",[249,82,107]/255)
scatter3(newVirginica_quadratic(:,1),newVirginica_quadratic(:,2),newVirginica_quadratic(:,3), ...
    markerSize,"filled","DisplayName","Quadratic model","MarkerFaceColor","g")
legend("Location","northeast","Orientation","horizontal");
title("Species: Virginica")
xlabel("Feature 1")
ylabel("Feature 2")
zlabel("Feature 3")


fprintf("Linear model, Avarage Mahalanobis distance: \n" + ...
    "(setosa): %.4f\n" + ...
    "(versicolor): %.4f\n" + ...
    "(Virginica): %.4f\n", ...
    mean((sqrt(mahal(newSetosa_linear,meas_setosa)))), ...
    mean((sqrt(mahal(newVersicolor_linear,meas_versicolor)))), ...
    mean((sqrt(mahal(newVirginica_linear,meas_virginica)))));
disp(newline)
fprintf("Quadratic model, Avarage Mahalanobis distance: \n" + ...
    "(setosa): %.4f\n" + ...
    "(versicolor): %.4f\n" + ...
    "(Virginica): %.4f\n", ...
    mean((sqrt(mahal(newSetosa_quadratic,meas_setosa)))), ...
    mean((sqrt(mahal(newVersicolor_quadratic,meas_versicolor)))), ...
    mean((sqrt(mahal(newVirginica_quadratic,meas_virginica)))));