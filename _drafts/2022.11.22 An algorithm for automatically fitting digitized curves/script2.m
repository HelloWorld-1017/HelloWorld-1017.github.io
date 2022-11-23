clc, clear, close all

% Given data points in X-Y plane
x = linspace(0, 3, 20000);
y = exp(x);

% Function B^n_i(t)
Bni = @(n, i, t) nchoosek(n, i)*t^i*(1-t)^(n-i);

% Two Endpoints V0 and V3
V0 = [x(1), y(1)];
V3 = [x(end), y(end)];

% Calculate the tangent slopes in of the two endpoints
[ka1, ka2] = helperTangentSlop(x, y, 10);
theta1 = atan(ka1);
theta2 = atan(ka2);
b1 = y(1)-ka1*x(1);
b2 = y(end)-ka2*x(end);
% Tangent lines of the two endpoints
tangentline1 = ka1*x+b1;
tangentline2 = ka2*x+b2;
% Unit tangent vector of the two endpoints
t_hat1 = [cos(theta1), sin(theta1)];
t_hat2 = -[cos(theta2), sin(theta2)];

% Chord-length parameterization
ts = helperParameterization(x, y);

% Construct and solve the linear equations
d = [x; y]';
c11 = sum(t_hat1.*arrayfun(@(x) Bni(3,1,x),ts).*t_hat1.*arrayfun(@(x) Bni(3,1,x),ts), "all");
c12 = sum(t_hat1.*arrayfun(@(x) Bni(3,1,x),ts).*t_hat2.*arrayfun(@(x) Bni(3,2,x),ts), "all");
c21 = sum(t_hat1.*arrayfun(@(x) Bni(3,1,x),ts).*t_hat2.*arrayfun(@(x) Bni(3,2,x),ts), "all");
c22 = sum(t_hat2.*arrayfun(@(x) Bni(3,2,x),ts).*t_hat2.*arrayfun(@(x) Bni(3,2,x),ts), "all");
right1 = sum((d - ((arrayfun(@(x) Bni(3,0,x),ts)+arrayfun(@(x) Bni(3,1,x),ts)).*V0 + ...
    (arrayfun(@(x) Bni(3,2,x),ts)+arrayfun(@(x) Bni(3,3,x),ts)).*V3)).*t_hat1.*arrayfun(@(x) Bni(3,1,x),ts), "all");
right2 = sum((d - ((arrayfun(@(x) Bni(3,0,x),ts)+arrayfun(@(x) Bni(3,1,x),ts)).*V0 + ...
    (arrayfun(@(x) Bni(3,2,x),ts)+arrayfun(@(x) Bni(3,3,x),ts)).*V3)).*t_hat2.*arrayfun(@(x) Bni(3,2,x),ts), "all");
Left = [c11, c12;
    c21, c22];
Right = [right1; right2];
alphas = inv(Left)*Right;

% Fitting control points in the two tangent line
V1 = V0+t_hat1*alphas(1);
V2 = V3+t_hat2*alphas(2);

% Fitting curve
fitcurve = arrayfun(@(x) Bni(3,0,x),ts).*V0+arrayfun(@(x) Bni(3,1,x),ts).*V1+...
    arrayfun(@(x) Bni(3,2,x),ts).*V2+arrayfun(@(x) Bni(3,3,x),ts).*V3;
SSE1 = sum((fitcurve(:, 2)-y').^2);

% Fit by 3-order polynomial
C = [2*sum(x.^6), 2*sum(x.^5),  2*sum(x.^4),  2*sum(x.^3), x(1)^3, x(end)^3;
    2*sum(x.^5), 2*sum(x.^4),  2*sum(x.^3),  2*sum(x.^2), x(1)^2, x(end)^2;
    2*sum(x.^4), 2*sum(x.^3),  2*sum(x.^2),  2*sum(x.^1), x(1), x(end);
    2*sum(x.^3), 2*sum(x.^2),  2*sum(x.^1),  2*numel(x), 1, 1;
    x(1)^3, x(1)^2, x(1), 1, 0, 0;
    x(end)^3, x(end)^2, x(end), 1, 0, 0];
B = [2*sum(x.^3.*y); 2*sum(x.^2.*y); 2*sum(x.*y); 2*sum(x); y(1); y(end)];
coeffs = inv(C)*B;
fitcurve2 = coeffs(1)*x.^3+coeffs(2)*x.^2+coeffs(3)*x+coeffs(4);
SSE2 = sum((fitcurve2(:)-y').^2);

% Plot schematic
figure
ax = gca;
hold(ax, "on")
box(ax, "on")
axis(ax, "equal")
ax.LineWidth = 1.2;
LineWidth = 1.5;
plot(x, y, LineWidth=1.5, DisplayName="Data curve", Color=[7, 84, 213]/255)
scatter([V0(1), V3(1)], [V0(2), V3(2)], "filled", "k", "DisplayName", "Endpoints(V0 and V3)")



% plot([V0(1), V1(1)], [V0(2), V1(2)], LineWidth=1, LineStyle="--", ...
%     DisplayName="Tangent line of the left endpoint")
% plot([V3(1), V2(1)], [V3(2), V2(2)], LineWidth=1, LineStyle="--", ...
%     DisplayName="Tangent line of the right endpoint")

scatter([V1(1), V2(1)], [V1(2), V2(2)], "filled", "r", "DisplayName", "Fitting control points(V1 and V2)")

plot(fitcurve(:, 1), fitcurve(:, 2), LineWidth=1.5, ...
    DisplayName="Fitting curve",  Color=[249, 82, 107]/255)
plot(x, fitcurve2, LineWidth=1.5)
legend("Location", "northwest")

% Calculate the average tangent slope at the endpoints
function [ka1, ka2] = helperTangentSlop(x, y, pieceLength)
k1 = zeros(1, pieceLength);
k2 = zeros(1, pieceLength);
for i = 1:pieceLength
    k1(i) = (y(i+1)-y(1))/(x(i+1)-x(1));
    k2(i) = (y(end)-y(end-i))/(x(end)-x(end-i));
end
ka1 = mean(k1);
ka2 = mean(k2);
end

% Chord-length parameterization function
function ts = helperParameterization(x, y)
ChordLength = @(x, y) sqrt(sum((x-y).^2));
chords = zeros(1, width(x)-1);
for i = 1:numel(x)-1
    chords(i) = ChordLength([x(i), y(i)], [x(i+1), y(i+1)]);
end
ts = cumsum(chords)/sum(chords);
ts = [0, ts]';
end