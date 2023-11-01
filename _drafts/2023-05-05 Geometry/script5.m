clc,clear,close all

hold(gca,"on")
box(gca,"on")
grid(gca,"on")
axis(gca,"equal")
vecA = [1,1];
vecB = [0.4,1.6];
vecA1 = (vecA*vecB')/(vecB*vecB')*vecB;
vecA2 = vecA-(vecA*vecB')/(vecB*vecB')*vecB;

scatter3(0,0,0,50, ...
    'filled','o','MarkerFaceColor','k','HandleVisibility','off')
q1 = quiver(0,0,vecA(1),vecA(2), ...
    'LineWidth',1.5,'AutoScale','off','DisplayName','$a$');
q2 = quiver(0,0,vecB(1),vecB(2), ...
    'LineWidth',1.5,'AutoScale','off','DisplayName','$b$');
q3 = quiver(0,0,vecA1(1),vecA1(2), ...
    'LineWidth',1.5,'AutoScale','off','DisplayName','$a_1$');
q4 = quiver(vecA1(1),vecA1(2),vecA2(1),vecA2(2), ...
    'LineWidth',1.5,'AutoScale','off','DisplayName','$a_1$');
legend('Interpreter','latex')