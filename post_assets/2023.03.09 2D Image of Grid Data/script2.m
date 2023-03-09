clc,clear,close all

load data.mat

% Calculate partial derivatives for block parameterization in terms of
% dPhi(i,x)/dx and dPhi(i,x)/di. To do this, use least squares to find
% a smooth differentiable function fit to flux.
[b,a]=meshgrid(x,current+1e-5); % 1e-5 offset to avoid zero current; b and a, 11-by-5
a=a(:); b=b(:); data_coeff = flux_linkage(:);% Unwrapped to column vectors
X = [a.^3 b.*a.^2 a.^2 a b a.*b]; % X, 55-by-6
Coeff = (X'*X)\(X'*data_coeff);% Solve normal equation to get least square solution, ie Coeff; Coeff, 6-by-1
flux_linkage2 = reshape(X*Coeff,length(current),length(x));% flux_linkage2, 11-by-5.

view(-37.5,30)
hold(gca,"on")
% Plot 'Flux linkage'
surf(x,current,flux_linkage,'FaceColor',[1 0 0],'FaceAlpha',0.5);
% Plot 'Polynomial fit'
surf(x,current,flux_linkage2,'FaceColor',[0 0 1],'FaceAlpha',0.5);
% Plot settings
title('Flux Linkage vs. Current and Displacement')
xlabel('Displacement (m)')
ylabel('Current (A)')
zlabel('Flux linkage (Wb)')
axis([0 2e-4 0 1 0 0.06])
legend({'Flux Linkage Data','Polynomial Fit'},'Location','Best')
grid on
hold(gca, "off")