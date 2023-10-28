clc,clear,close all

load fisheriris.mat
rng(1)

Classes = unique(species);
numClasses = numel(Classes);
Pvalues = nan(numClasses,1);
logics = nan(numClasses,1);

numG = 100;
W = 2e3;
alpha = 0.05;

for i = 1:numClasses
    feature = meas(strcmp(species,Classes(i)),:);

    data_mean = mean(feature);
    data_cov = cov(feature);

    Y = mvnrnd(data_mean,data_cov,numG);

    T0 =  helperCalculateTprime(feature,Y);
    [logics(i),Pvalues(i)] = helperMonteCarlo(data_mean,data_cov,numG,T0,W,alpha);

end

figure
hold(gca,"on"),box(gca,"on"),grid(gca,"on")
idx0 = logics == 0;
pos0 = find(idx0);
idx1 = logics == 1;
pos1 = find(idx1);
stem(pos0,Pvalues(idx0),"filled","LineWidth",1.5,"Color",[7,84,213]/255,"HandleVisibility","off")
stem(pos1,Pvalues(idx1),"filled","LineWidth",1.5,"Color",[249,82,107]/255,"HandleVisibility","off")
yline(alpha,"LineWidth",1.5,"LineStyle","--","Color","k","DisplayName","Significance value")
legend("Location","northwest","FontName","Times New Roman");
xticks(1:numClasses)
xticklabels(Classes)
xlim([0,numClasses+1])
ylabel("p-value")
% set(gca,"FontName","Times New Roman")
% exportgraphics(gca,"pic1.jpg","Resolution",600)