clc,clear,close all

load fisheriris
meas = meas(:,1:3);

mdl_linear = fitcdiscr(meas,species); % DiscrimType: linear
mus_linear = mdl_linear.Mu;
Sigmas_linear = mdl_linear.Sigma;

mdl_quadratic = fitcdiscr(meas,species,"DiscrimType","quadratic"); % DiscrimType: quadratic
mus_quadratic = mdl_quadratic.Mu;
Sigmas_quadratic = mdl_quadratic.Sigma;

numNew = 100;

newSetosa_linear = mvnrnd(mus_linear(1,:),Sigmas_linear,numNew);
newSetosa_quadratic = mvnrnd(mus_quadratic(1,:),Sigmas_quadratic(:,:,1),numNew);

newVersicolor_linear = mvnrnd(mus_linear(2,:),Sigmas_linear,numNew);
newVersicolor_quadratic = mvnrnd(mus_quadratic(2,:),Sigmas_quadratic(:,:,2),numNew);

newVirginica_linear = mvnrnd(mus_linear(3,:),Sigmas_linear,numNew);
newVirginica_quadratic = mvnrnd(mus_quadratic(3,:),Sigmas_quadratic(:,:,3),numNew);

meas_setosa = meas(strcmp(species,"setosa"),:);
meas_versicolor = meas(strcmp(species,"versicolor"),:);
meas_virginica = meas(strcmp(species,"virginica"),:);







