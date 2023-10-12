clc,clear,close all

% Load data set
load examgrades
x = grades(:,1);

n = numel(x);

% Construct test statistic
t = (mean(x)-75)/(std(x)/sqrt(n))
t_degrees = n-1;
significance_level = 0.05;

% Interval estimation for \bar{x}, using pivot
u_lowAlphaDiv2 = abs(tinv(significance_level/2,t_degrees));
interval = [mean(x)-std(x)*u_lowAlphaDiv2/sqrt(n),...
    mean(x)+std(x)*u_lowAlphaDiv2/sqrt(n)]

% Calculate p-value
pValue = 2*tcdf(-abs(t),t_degrees)

% Test null hypothesis
if pValue < significance_level
    h = 1
else
    h = 0
end

% % Plot schematics
% xx = -70:0.01:80;
% figure
% hold(gca,"on"),box(gca,"on"),grid(gca,"on")
% plot(xx,tpdf(xx,t_degrees))
% stem([tinv(pValue/2,t_degrees),-tinv(pValue/2,t_degrees)],...
%     tpdf([tinv(pValue/2,t_degrees),-tinv(pValue/2,t_degrees)],t_degrees))