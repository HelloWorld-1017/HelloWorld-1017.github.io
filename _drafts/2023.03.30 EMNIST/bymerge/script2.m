clc,clear,close all

load nums.mat

SampleNums = [training_nums,test_nums];

figure("Units","pixels","Position",[80,454,1746,334])
axes
grid(gca,"on")
box(gca,"on")
hold(gca,"on")

b = bar(Classes,SampleNums);
b(1).FaceColor = [7,84,213]/255;
b(2).FaceColor = [249,82,107]/255;

legend("Training","Test")
set(gca,"FontSize",15)
