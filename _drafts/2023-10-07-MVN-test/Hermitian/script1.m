clc,clear,close all

load ovariancancer.mat
rng("default")

obs = double(obs);

obs = normalise(obs);

meas_1 = obs(grp=="Cancer",:);
cov_1 = cov(meas_1);

meas_2 = obs(grp=="Normal",:);
cov_2 = cov(meas_2);

EigValues_1 = eig(cov_1);

EigValues_2 = eig(cov_2);
EigValues_2(end) = EigValues_2(end-1)+1;

cond(cov_1)
% sqrt(max(eig(H'*H)))*sqrt(max(eig(inv(H)'*inv(H))))-cond(H)

% Random ponits drawn from uniform distribution
RandomPoints_1 = rand(1,1201)*(max(EigValues_1)-min(EigValues_1))+min(EigValues_1);
RandomPoints_1 = sort(RandomPoints_1);
RandomPoints_2 = rand(1,1201)*(max(EigValues_2)-min(EigValues_2))+min(EigValues_2);
RandomPoints_2 = sort(RandomPoints_2);

% sum(diff(EigValues_1)), sum(diff(RandomPoints_1))
% sum(diff(EigValues_2)), sum(diff(RandomPoints_2))
% std(diff(EigValues_1)), std(diff(RandomPoints_1))
% std(diff(EigValues_2)), std(diff(RandomPoints_2))

histogram(EigValues_1)

% figure('Units','pixels','Position',[71,482.33,2399.33,253.99])
% hold(gca,'on')
% box(gca,'on')
% grid(gca,'on')
% scatter(EigValues_1,2*ones(1,numel(EigValues_1)),10, ...
%  'filled','MarkerFaceColor',[7,84,213]/255, ...
%  'DisplayName','Eigenvalues of Class 1')
% scatter(RandomPoints_1,ones(1,numel(RandomPoints_1)),10, ...
%  'filled',...
%  'DisplayName','Uniform distribution random points (Class 1)')
% scatter(EigValues_2,3*ones(1,numel(EigValues_2)),10, ...
%  'filled',...
%  'DisplayName','Eigenvalues of Class 2')
% scatter(RandomPoints_2,4*ones(1,numel(RandomPoints_2)),10, ...
%  'filled',...
%  'DisplayName','Uniform distribution random points (Class 2)')
% 
% legend("Location","northoutside","Orientation","horizontal")
% set(gca,'yticklabel',[])
% xlabel("Value")