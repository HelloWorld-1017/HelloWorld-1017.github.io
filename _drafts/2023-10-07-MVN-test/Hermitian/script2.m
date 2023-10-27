clc,clear,close all
load ovariancancer.mat

classes = unique(grp);

signals_normal = obs(strcmp(grp,classes(2)),:);
signals_cancer = obs(strcmp(grp,classes(1)),:);

nums_cancer = height(signals_cancer);
nums_normal = height(signals_normal);

% plot(signals_cancer',"Color",[249,82,107]/255,"LineWidth",0.1)