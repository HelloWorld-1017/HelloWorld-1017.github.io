clc,clear,close all

load fisheriris
meas = meas(:,1:3);

idx = [1:10,61:80,101:130];
meas(idx,:) = [];
species(idx,:) = [];

mdl = fitcdiscr(meas,species); % DiscrimType: 'linear'(fault)
mus = mdl.Mu;
Sigmas = mdl.Sigma;

[ClassVariables,Classes] = findgroups(species);
means = splitapply(@mean,meas,ClassVariables);
Covs = splitapply(@(x){cov(x)},meas,ClassVariables);
% Cov_all = cov(meas);
% means,celldisp(Covs),Cov_all

