clc, clear, close all

gridSize = 2e3;
x = gpuArray.linspace(-2, 2, gridSize);
y = gpuArray.linspace(-2, 2, gridSize);

[xGrid, yGrid] = meshgrid(x,y); % for vectorized calculation
c = complex(xGrid, yGrid);

R = 10; % if abs(z)>R then z is considered as infinity
maxIterations = 100; % maximal number of iterations, 100 is close to infinity
z = zeros(size(c), 'gpuArray'); % starts from zeros

for i = 1:maxIterations
    z = z.^2+c; 
end

logicalImage = abs(z)<R; % Logical image
imagesc(x, y, logicalImage);
xlabel('Re(c)');
ylabel('Im(c)');
set(gca, 'yDir', 'normal')
colormap("jet")
cbar = colorbar;
cbar.Limits = [0, 1];