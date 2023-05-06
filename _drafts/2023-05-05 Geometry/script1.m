clc,clear,close all

vec1 = [1;1];
R1 = [sqrt(2)/2,-sqrt(2)/2;
    sqrt(2)/2,sqrt(2)/2];
R2 = [1,-1;
    0,sqrt(2)];

vecR1 = R1*vec1;
vecR2 = R2*vec1;

figure("Units","pixels","Position",[625.66,493.66,1539.33,382.66])
tiledlayout(1,3)
nexttile
hold(gca,"on")
box(gca,"on")
grid(gca,"on")
plot([0,vec1(1)],[0,vec1(2)], ...
    'Marker','.','LineWidth',1.5,'MarkerSize',20,'Color','b')
xlim([-3,3])
ylim([-3,3])
xlabel("$x$","Interpreter","latex")
ylabel("$y$","Interpreter","latex")
title("Before transformation","Interpreter","latex")

nexttile
hold(gca,"on")
box(gca,"on")
grid(gca,"on")
plot([0,vecR1(1)],[0,vecR1(2)], ...
    'Marker','.','LineWidth',1.5,'MarkerSize',20,'Color','b')
xlim([-3,3])
ylim([-3,3])
xlabel("$x$","Interpreter","latex")
ylabel("$y$","Interpreter","latex")
title("After transformation by $R_1$","Interpreter","latex")

nexttile
hold(gca,"on")
box(gca,"on")
grid(gca,"on")
plot([0,vecR2(1)],[0,vecR2(2)], ...
    'Marker','.','LineWidth',1.5,'MarkerSize',20,'Color','b')
xlim([-3,3])
ylim([-3,3])
xlabel("$x$","Interpreter","latex")
ylabel("$y$","Interpreter","latex")
title("After transformation by $R_2$","Interpreter","latex")

