maxIterations = 500;
gridSize = 5000;
xlim = [-2, 2];
ylim = [-2, 2];

x = gpuArray.linspace(xlim(1), xlim(2), gridSize);
y = gpuArray.linspace(ylim(1), ylim(2), gridSize);
whos x y

[xGrid, yGrid] = meshgrid(x, y);
z0 = complex(xGrid, yGrid); % 1000-by-1000, Complex matrix
count = ones(size(z0), 'gpuArray');

z = z0;

for n = 0:maxIterations
    z = z.^2 + 0.5;
    inside = abs(z) <= 2;
    count = count + inside;
end

imagesc(x, y, count)
colormap([jet(); flipud(jet()); 0 0 0]);
colorbar
axis off