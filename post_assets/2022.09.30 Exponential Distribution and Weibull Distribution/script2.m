clc, clear, close all

x = linspace(0, 30);

figure
LineWidth = 1.5;

nexttile
hold(gca, "on")
grid(gca, "on")
box(gca, "on")
plot(x, wblpdf(x, 10, 1), 'DisplayName', 'A=10,  B=1', LineWidth=LineWidth)
plot(x, wblpdf(x, 10, 2), 'DisplayName', 'A=10,  B=2', LineWidth=LineWidth)
plot(x, wblpdf(x, 10, 4), 'DisplayName', 'A=10,  B=4', LineWidth=LineWidth)
plot(x, wblpdf(x, 10, 0.5), 'DisplayName', 'A=10,  B=0.5', LineWidth=LineWidth)
plot(x, wblpdf(x, 10, 0.25), 'DisplayName', 'A=10,  B=0.25', LineWidth=LineWidth)
plot(x, wblpdf(x, 5, 1), 'DisplayName', 'A=5,  B=1', LineWidth=LineWidth)
legend('Location', 'best')
xlabel('x')
ylabel('PDF')

nexttile
hold(gca, "on")
grid(gca, "on")
box(gca, "on")
plot(x, wblcdf(x, 10, 1), 'DisplayName', 'A=10,  B=1', LineWidth=LineWidth)
plot(x, wblcdf(x, 10, 2), 'DisplayName', 'A=10,  B=2', LineWidth=LineWidth)
plot(x, wblcdf(x, 10, 4), 'DisplayName', 'A=10,  B=4', LineWidth=LineWidth)
plot(x, wblcdf(x, 10, 0.5), 'DisplayName', 'A=10,  B=0.5', LineWidth=LineWidth)
plot(x, wblcdf(x, 10, 0.25), 'DisplayName', 'A=10,  B=0.25', LineWidth=LineWidth)
plot(x, wblcdf(x, 5, 1), 'DisplayName', 'A=5,  B=1', LineWidth=LineWidth)
legend('Location', 'best')
xlabel('x')
ylabel('CDF')