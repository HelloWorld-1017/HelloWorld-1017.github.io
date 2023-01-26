clc, clear, close all

figure
hold(gca, "on")
box(gca, "on")
grid(gca, "on")
t = linspace(-2,2,1000)';
x = square((2*pi)*t);
plot(t, x, 'k', LineWidth=1.5)
xlabel('t')
ylabel('f(t)')
set(gca, 'DataAspectRatio', [1 1 1]) 
set(gca, 'YTick', [-1,0,1])
set(gca, 'Xtick', [-1.5,-1,-0.5,0,0.5,1,1.5])
set(gca, 'XTickLabel', ["-3T/2","-T","-T/2","0","T/2","T","3T/2"])
set(gca, 'TickLabelInterpreter', 'latex')
set(gca, 'FontName', 'Times New Roman')
set(gca, 'FontSize', 13)