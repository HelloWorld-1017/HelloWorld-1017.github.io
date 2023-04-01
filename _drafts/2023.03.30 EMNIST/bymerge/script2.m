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

nums = training_nums+test_nums;
figure("Units","pixels","Position",[692.3333333333333,369,1036.666666666667,334])
grid(gca,"on")
box(gca,"on")
hold(gca,"on")

b2 = bar(nums);
b2(1).FaceColor = [7,84,213]/255;
legend("Whole dataset")
set(gca,"FontSize",15)
