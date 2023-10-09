clc,clear,close all

load fisheriris
meas = meas(:,1:3);

mdl = fitcdiscr(meas,species,"DiscrimType","quadratic"); % DiscrimType: quadratic
mus = mdl.Mu;
Sigmas = mdl.Sigma;

[ClassVariables,Classes] = findgroups(species);
means = splitapply(@mean,meas,ClassVariables);
Covs = splitapply(@(x){cov(x)},meas,ClassVariables);
