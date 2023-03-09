clc,clear,close all
load data.mat

% Plot 'Flux linkage'
surf(x,current,flux_linkage,'FaceColor',[1 0 0],'FaceAlpha',0.5);
% Plot settings
title('Flux Linkaget')
xlabel('Displacement (m)')
ylabel('Current (A)')
zlabel('Flux linkage (Wb)')