clc, clear, close all

% Given data points in X-Y plane
x = linspace(-16, 10, 20000);
y = sin(x);

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
% The endpoints of unit tangent vectors
t_hat1_end = V0+t_hat1;
t_hat2_end = V3+t_hat2;

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
BezierCurve = arrayfun(@(x) Bni(3,0,x),ts).*V0+arrayfun(@(x) Bni(3,1,x),ts).*V1+...
    arrayfun(@(x) Bni(3,2,x),ts).*V2+arrayfun(@(x) Bni(3,3,x),ts).*V3;
[SSE1, MSE1, RMSE1, SSR1, SST1, Rsquare1] = helperStatisticalMeasures(BezierCurve(:, 2), y');

% Fit by 3-rd order polynomial
C = [2*sum(x.^6), 2*sum(x.^5),  2*sum(x.^4),  2*sum(x.^3), x(1)^3, x(end)^3;
    2*sum(x.^5), 2*sum(x.^4),  2*sum(x.^3),  2*sum(x.^2), x(1)^2, x(end)^2;
    2*sum(x.^4), 2*sum(x.^3),  2*sum(x.^2),  2*sum(x.^1), x(1), x(end);
    2*sum(x.^3), 2*sum(x.^2),  2*sum(x.^1),  2*numel(x), 1, 1;
    x(1)^3, x(1)^2, x(1), 1, 0, 0;
    x(end)^3, x(end)^2, x(end), 1, 0, 0];
B = [2*sum(x.^3.*y); 2*sum(x.^2.*y); 2*sum(x.*y); 2*sum(x); y(1); y(end)];
coeffs = inv(C)*B;
fitcurve2 = coeffs(1)*x.^3+coeffs(2)*x.^2+coeffs(3)*x+coeffs(4);
[SSE2, MSE2, RMSE2, SSR2, SST2, Rsquare2] = helperStatisticalMeasures(fitcurve2(:), y');

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

plot([V0(1), t_hat1_end(1)], [V0(2), t_hat1_end(2)], LineWidth=2.5, LineStyle="--", ...
    DisplayName="Tangent vector of the left endpoint")
plot([V3(1), t_hat2_end(1)], [V3(2), t_hat2_end(2)], LineWidth=2.5, LineStyle="--", ...
    DisplayName="Tangent vector of the right endpoint")

scatter([V1(1), V2(1)], [V1(2), V2(2)], "filled", "r", "DisplayName", "Fitting control points(V1 and V2)")

plot(BezierCurve(:, 1), BezierCurve(:, 2), LineWidth=1.5, ...
    DisplayName="Bezier curve", Color=[249, 82, 107]/255)
plot(x, fitcurve2, LineWidth=1.5, DisplayName="Third order polynomial curve")
sbt = sprintf("RMSE(Bezier): %.4f, RMSE(3-rd order polynomial): %.4f", RMSE1, RMSE2);
title("Curve fitting", sbt)
legend("Location", "best")


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

% Calculate the statistical measures
function [SSE, MSE, RMSE, SSR, SST, Rsquare] = helperStatisticalMeasures(yhat, y)
SSE = sum((yhat-y).^2);       % The sum of sauqres due to error
MSE = mean((yhat-y).^2);      % Mean squared error
RMSE = sqrt(MSE);             % Root mean squared error
SSR = sum((yhat-mean(y)).^2); % Sum of squares of the regression
SST = sum((y-mean(y)).^2);    % Total sum of squares
Rsquare = 1-(sum((yhat-y).^2)/(sum((y-mean(y)).^2)));         % Coefficient of determination
end
