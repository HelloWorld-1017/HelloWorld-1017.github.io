clc, clear, close all

load census1994

classNames = unique(adultdata.salary);

MdlTree = fitctree(adultdata, "salary", ClassNames=classNames);
MdlGAM = fitcgam(adultdata, "salary", ClassNames=classNames); 
MdlNB = fitcnb(adultdata, "salary", ClassNames=classNames);

[~, ScoresTree] = predict(MdlTree,adulttest);
[~, ScoresGAM] = predict(MdlGAM,adulttest);
[~, ScoresNB] = predict(MdlNB,adulttest);

rocTree = rocmetrics(adulttest.salary, ScoresTree, classNames);
rocGAM = rocmetrics(adulttest.salary, ScoresGAM, classNames);
rocNB = rocmetrics(adulttest.salary, ScoresNB, classNames);

figure
c = cell(3,1);
g = cell(3,1);
[c{1},g{1}] = plot(rocTree,ClassNames=classNames(1));
hold(gca, "on")
[c{2},g{2}] = plot(rocGAM,ClassNames=classNames(1));
[c{3},g{3}] = plot(rocNB,ClassNames=classNames(1));
modelNames = ["Decision Tree Model", ...
    "Generalized Additive Model","Naive Bayes Model"];
for i = 1 : 3
    c{i}.DisplayName = replace(c{i}.DisplayName, ...
        string(classNames(1)),modelNames(i));
    g{i}(1).DisplayName = join([modelNames(i),"Operating Point"]);
end
box(gca, "on")