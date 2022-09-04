clc, clear, close all

x0 = -0.21503361460851339;
y0 = 0.67999116792639069;
resolution_x = 1920; % resolution x
resolution_y = 1080; % resolution y
R = 8; % if abs(z)>R then z is considered as infinity
maxIterations = 80; % maximal number of iterations, 100 is close to infinity

figure('units', 'normalized', 'position', [0.1-0.08 0.073 0.3 0.4]);

maxZoom=150;
fc=1; % Iteration of frames
lc=1;
for zm = 1:1:maxZoom

    zmf = exp(-zm/20);
    x1 = x0-2*zmf;
    x2 = x0+2*zmf;
    y1 = y0-1.5*exp(-zm/20);
    y2 = y0+1.5*exp(-zm/20);
    x = linspace(x1, x2, resolution_x);
    y = linspace(y1, y2, resolution_y);

    [xGrid, yGrid] = meshgrid(x, y); % for vectorized calculation
    c = complex(xGrid, yGrid);

    z = zeros(size(c), 'gpuArray');     % starts from z=0
    count = zeros(size(c), 'gpuArray');

    for nc = 1:maxIterations
        z = z.^2+c;
        bw = abs(z)<R;
        count(bw) = nc;
    end

    cla % Clear current axes
    imagesc(x, y, count);
    set(gca, 'YDir', 'normal');
    colormap("jet")
    xlabel('Re(c)');
    ylabel('Im(c)');
    axis equal;
    axis off
    set(gca, 'clim', [0 maxIterations]);
    set(gca,'units','normalized','position',[0 0 1 1]);
    f = getframe(gcf);

    if lc == 1
        colorbar
        [im, map] = rgb2ind(f.cdata, 256, 'nodither'); % Convert RGB image to indexed image
        colorbar('off');
        im(1, 1, 1, 20) = 0;
    else
        im(:, :, 1, lc-1) = rgb2ind(f.cdata, map, 'nodither');
    end
    fc = fc+1;
    lc = lc+1;
end

% Write to .gif file
imwrite(im, map, 'mandelbrot_gif.gif', 'DelayTime', 0, 'LoopCount', inf) 
    