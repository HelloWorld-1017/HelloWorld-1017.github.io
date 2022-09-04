clc, clear, close all

x0 = -0.21503361460851339;
y0 = 0.67999116792639069;
resolution_x = 1920; % resolution x
resolution_y = 1080; % resolution y
R = 8; % if abs(z)>R then z is considered as infinity
maxIterations = 100; % maximal number of iterations, 100 is close to infinity

figure('units', 'normalized', 'position', [0.1-0.08 0.073 0.8 0.8]);
maxZoom = 200; % Maximum zoom
fc = 1; % Iteration of frames

for zm = 1:0.35:maxZoom
    zmf = exp(-zm/20);
    x1 = x0-2*zmf;
    x2 = x0+2*zmf;
    y1 = y0-1.13*exp(-zm/20);
    y2 = y0+1.13*exp(-zm/20);
    x = gpuArray.linspace(x1, x2, resolution_x);
    y = gpuArray.linspace(y1, y2, resolution_y);

    [xGrid, yGrid] = meshgrid(x,y); 
    c = complex(xGrid, yGrid);

    z = zeros(size(c), 'gpuArray');        % starts from z=0
    count = zeros(size(c), 'gpuArray');

    for i=1:maxIterations
        z = z.^2+c; 
        bw = abs(z)<R;
        count(bw) = i;
    end

    cla % Clear current axes
    imagesc(x, y, count);
    colormap("jet")
    set(gca,'YDir','normal');
    axis equal
    axis off
    colorbar
    set(gca, 'clim', [0 maxIterations]); % Set the limits of the colorbar
%     set(gca, 'units', 'normalized', 'position', [0 0 1 1]); % Full the gcf with the gca, so we can not see colorbar, xlabel, ylabel etc.
    drawnow 
    frames(fc) = getframe(gcf);
    fc = fc+1;
end
frames=[frames(2:end) frames(end:-5:2)];

% Write frames to .avi file
V = VideoWriter('mandelbrot_avi.avi');
open(V)
writeVideo(V, frames)
close(V) % DO NOT forget to close, otherwise, the .avi file could not be played