clc, clear, close all

u = linspace(0, 1, 50);
v = linspace(0, 1, 50);

f = [-cos(pi/2*u.^2); sin(pi/2*v.^2)];
g = [sin(pi/2*u.^2); cos(pi/2*v.^2)];

figure("Units", "pixels", "Position", [420, 334, 939, 502])
tiledlayout(1, 2)
axislimits = [-1.5, 1.5, 0, 1.5];
LineWidth = 1.5;
FontSize = 10;

nexttile
hold(gca, "on")
grid(gca, "on")
box(gca, "on")
axis(gca, "equal")
axis(axislimits)
set(gca, 'PlotBoxAspectRatio', [1 1 1])
ax = gca;
ax.GridLineStyle = '--';
ax.LineWidth = 1.2;
title("Curves corresponding to parametric equations")
text(-0.1342, 1.1074, 'B(0,1)', FontSize=FontSize)
text(-1.4630, 0.1409, 'A(-1, 0)', FontSize=FontSize)
text(1.0201, 0.1409, 'C(1, 0)', FontSize=FontSize)
plot(f(1, :), f(2, :), LineWidth=LineWidth, Color='r')
plot(g(1, :), g(2, :), LineWidth=LineWidth, Color='b')
legend("f(u)", "g(v)")

nexttile
hold(gca, "on")
grid(gca, "on")
box(gca, "on")
axis(gca, "equal")
axis(axislimits)
set(gca, 'PlotBoxAspectRatio', [1 1 1])
ax = gca;
ax.GridLineStyle = '--';
ax.LineWidth = 1.2;
text(-0.1342, 1.1074, 'B(0,1)', FontSize=FontSize)
text(-1.4630, 0.1409, 'A(-1, 0)', FontSize=FontSize)
text(1.0201, 0.1409, 'C(1, 0)', FontSize=FontSize)
title("Movements of u and v from 0 to 1")
h1 = animatedline(LineWidth=1.5, Color='r');
h2 = animatedline(LineWidth=1.5, Color='b');
for i = 1:width(u)
    addpoints(h1, f(1, i), f(2, i))
    addpoints(h2, g(1, i), g(2, i))
    drawnow
    pause(0.05)
    exportgraphics(gcf, "gif.gif","Append", true)
end
