clc,clear,close all

load data.mat

% Calculate fitting polynomials and create corresponding flux data grid
[b, a]=meshgrid(x,current+1e-5); % 1e-5 offset to avoid zero current
a=a(:); % Current
b=b(:); % Stroke
data_coeff = flux_linkage(:);
X = [a.^3 b.*a.^2 a.^2 a b a.*b]; % X, 55-by-6
Coeff = (X'*X)\(X'*data_coeff);% 6-by-1
flux_linkage1 = reshape(X*Coeff,length(current),length(x));% flux_linkage1

% Create smoothed flux linakge data grid
new_current = linspace(0,1,200)'; % Current 
new_stroke = linspace(0,0.2e-3,200)';% Stroke
[b, a]=meshgrid(new_stroke, new_current+1e-5); % 1e-5 offset to avoid zero current
a = a(:);
b = b(:);
new_X = [a.^3 b.*a.^2 a.^2 a b a.*b];
flux_linkage2 = reshape(new_X*Coeff,length(new_current),length(new_stroke));

figure('Position',[149,360,1339,396])
tiledlayout(1,3)

nexttile
axis(gca,"equal")
imagesc(current, x, flux_linkage)
xlabel("Current")
ylabel("Stroke")
title("Flux Linkage Data")
colormap("jet")
colorbar
set(gca, "YDir", "normal")

nexttile
axis(gca,"equal")
imagesc(current,x,flux_linkage1)
xlabel("Current")
ylabel("Stroke")
title("Polynomial Fit")
colormap("jet")
colorbar
set(gca, "YDir", "normal")

nexttile
axis(gca,"equal")
imagesc(new_current,new_stroke,flux_linkage2)
xlabel("Current")
ylabel("Stroke")
title("Smoothed Polynomial Fit")
colormap("jet")
colorbar
set(gca, "YDir", "normal")
