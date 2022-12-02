clc, clear, close all

x = categorical({'Class1', 'Class2'});
y = [10, 9; 7, 11];

errhigh_D1 = [2, 3];
errlow_D1 = [0.5, 0.5];
errhigh_D2 = [0.5, 0.5];
errlow_D2 = [3, 2];


figure
hold(gca, "on")
box(gca, "on")

% Plot bar for class1 and class2
b = bar(x, y);

% Plot errorbar for class1
err1 = errorbar(b(1).XEndPoints, y(:, 1), errlow_D1, errhigh_D1);
err1.Color = [0 0 0];                            
err1.LineStyle = 'none';  
err1.LineWidth = 1.5;

% Plot errorbar for class2
err2 = errorbar(b(2).XEndPoints, y(:, 2), errlow_D2, errhigh_D2);
err2.Color = [0 0 0];                            
err2.LineStyle = 'none';  
err2.LineWidth = 1.5;
legend("D1", "D2")