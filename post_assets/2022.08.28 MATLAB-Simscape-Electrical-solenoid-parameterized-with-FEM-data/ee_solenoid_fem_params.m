% Initialization for the Finite Element Parameterized Solenoid example,
% ee_solenoid_fem.slx.
% 
% It is assumed that the flux linkage and force as a function of current
% and distance are provided by a finite element magnetic field package.
% Flux linkage is the product of flux and the number of turns.
% Sometimes inductance is given instead of flux. Inductance may be quoted
% as total inductance (inductance per turn times number of turns) or
% inductance per turn. You can obtain the flux linkage by multiplying each
% total inductance data point by the corresponding current.

% Copyright 2009-2018 The MathWorks, Inc.

% Vector of currents for which data is defined
current = [0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0]; % A
% Vector of displacements for which data is defined
x = [0 0.05 0.1 0.15 0.2]*1e-3; % m
% Flux linkage, Phi(current,x)
flux_linkage = [0         0         0         0         0;
  8.4997e-003  7.9390e-003  7.4582e-003  7.0518e-003  6.7144e-003
  1.7097e-002  1.6045e-002  1.5133e-002  1.4349e-002  1.3683e-002
  2.5367e-002  2.3914e-002  2.2640e-002  2.1528e-002  2.0561e-002
  3.2966e-002  3.1222e-002  2.9675e-002  2.8304e-002  2.7086e-002
  3.9631e-002  3.7726e-002  3.6016e-002  3.4474e-002  3.3073e-002
  4.5179e-002  4.3263e-002  4.1519e-002  3.9916e-002  3.8420e-002
  4.9509e-002  4.7751e-002  4.6123e-002  4.4587e-002  4.3106e-002
  5.2600e-002  5.1190e-002  4.9847e-002  4.8527e-002  4.7188e-002
  5.4509e-002  5.3657e-002  5.2789e-002  5.1855e-002  5.0807e-002
  5.5379e-002  5.5314e-002  5.5130e-002  5.4770e-002  5.4181e-002];
% Force(current,x)
force = [0      0      0      0      0;
        -0.6   -0.5   -0.4   -0.3   -0.3;
        -2.3   -2.0   -1.7   -1.4   -1.2;
        -4.9   -4.3   -3.7   -3.2   -2.7;
        -8.3   -7.3   -6.4   -5.5   -4.7;
        -12.2  -10.7   -9.4   -8.2   -7.2;
        -16.2  -14.4  -12.7  -11.3  -10.0;
        -20.0  -17.9  -15.9  -14.3  -12.9;
        -23.3  -20.9  -18.8  -17.1  -15.7;
        -25.7  -23.1  -21.1  -19.4  -18.2;
        -26.5  -24.1  -22.2  -20.9  -20.1];
% Total winding resistance
R = 14;
% Hard stops for plunger range of travel
xmax = x(end);
xmin = x(1);


% Calculate partial derivatives for block parameterization in terms of
% dPhi(i,x)/dx and dPhi(i,x)/di. To do this, use least squares to find
% a smooth differentiable function fit to flux.
[b,a]=meshgrid(x,current+1e-5); % 1e-5 offset to avoid zero current; b and a, 11-by-5
a=a(:); b=b(:); data_coeff = flux_linkage(:);% Unwrapped to column vectors
X = [a.^3 b.*a.^2 a.^2 a b a.*b]; % X, 55-by-6
Coeff = (X'*X)\(X'*data_coeff);% Solve normal equation to get least square solution, ie Coeff; Coeff, 6-by-1
flux_linkage2 = reshape(X*Coeff,length(current),length(x));% flux_linkage2, 11-by-5.


% Figure 1
if ~exist('h2_ee_solenoid_fem', 'var') || ...
        ~isgraphics(h2_ee_solenoid_fem, 'figure')
    h2_ee_solenoid_fem = figure('Name', 'ee_solenoid_fem');
end
figure(h2_ee_solenoid_fem)
clf(h2_ee_solenoid_fem)
hold(gca, "on")
view(-37.5,30)
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



% Calculate partial derivatives
zeros_like_b = zeros(length(b),1);
ones_like_b = ones(length(b),1);

dfluxdx = reshape([zeros_like_b, a.^2, zeros_like_b, zeros_like_b, ones_like_b, a]*Coeff,length(current),length(x));
dfluxdi = reshape([3.*a.^2, 2.*b.*a, 2.*a, ones_like_b, zeros_like_b, b]*Coeff,length(current),length(x));
dfluxdx(1,:)=zeros(1,5); % Set partial derivative to exactly zero for zero current, according to official document.


% Figure 2
if ~exist('h3_ee_solenoid_fem', 'var') || ...
        ~isgraphics(h3_ee_solenoid_fem, 'figure')
    h3_ee_solenoid_fem = figure('Name', 'ee_solenoid_fem');
end
figure(h3_ee_solenoid_fem)
clf(h3_ee_solenoid_fem)
surf(x,current,dfluxdi);
xlabel('Displacement (m)')
ylabel('Current (A)')
zlabel('\partial\Phi/\partiali (Wb/A)')
title('Partial Derivative of Flux with Respect to Current')
axis([0 2e-4 0 1 0 0.1])


% Figure 3
if ~exist('h4_ee_solenoid_fem', 'var') || ...
        ~isgraphics(h4_ee_solenoid_fem, 'figure')
    h4_ee_solenoid_fem = figure('Name', 'ee_solenoid_fem');
end
figure(h4_ee_solenoid_fem)
clf(h4_ee_solenoid_fem)
surf(x,current,dfluxdx);
xlabel('Displacement (m)')
ylabel('Current (A)')
zlabel('\partial\Phi/\partialx (Wb/m)')
title('Partial Derivative of Flux with Respect to Distance')
axis([0 2e-4 0 1 -35 0])



% Calculate L and dL/dx for i=0.1A - used by simplified solenoid
L = dfluxdi(2,:);
dLdx = reshape([zeros_like_b, 2.*a, zeros_like_b, zeros_like_b, zeros_like_b, ones_like_b]*Coeff,length(current),length(x));
dLdx = dLdx(2,:);

% Other initialization data
x0 = 0.1e-3; % Initial plunger position
lambda = 20; % Plunger damping (N/(m/s))
mass = 0.1;  % Plunger mass (kg)
f_c = 1e6;   % Frequency up to which flux is differentiated

% If the finite element only gives flux and not force, then force can be
% found by integrating the partial derivative of flux with respect to
% distance over current.
ord = 2; % Use 2nd order polynomial to fit dPhi/dx
p = zeros(length(current),ord+1);
for i=2:length(current)
    flux_x = flux_linkage(i,:);
    p(i,:) = polyfit(x,flux_x,ord); % Use 2th order polynomial
end
force2 = zeros(size(flux_linkage));
force_x = zeros(size(x));
for i=2:length(current)
    % Take average dPhi/dx for the two adjacent currents
    dflux_dx1 = polyval(polyder(p(i-1,:)),x);
    dflux_dx2 = polyval(polyder(p(i,:)),x);
    dflux_dx = (dflux_dx1+dflux_dx2)/2;
    % Integrate dPhi/dx over current to get incremental force
    force_x = force_x + (current(i)-current(i-1))*dflux_dx;
    force2(i,:) = force_x;
end

% Figure 4
if ~exist('h5_ee_solenoid_fem', 'var') || ...
        ~isgraphics(h5_ee_solenoid_fem, 'figure')
    h5_ee_solenoid_fem = figure('Name', 'ee_solenoid_fem');
end
figure(h5_ee_solenoid_fem)
clf(h5_ee_solenoid_fem)
view(-37.5,30)
hold(gca, "on")
% Plot force imported from FEM tool
surf(x,current,abs(force),'FaceColor',[0 0 1],'FaceAlpha',0.5)
% Plot force calculated by numerical integration
surf(x,current,abs(force2),'FaceColor',[1 0 0],'FaceAlpha',0.5)
% Plot settings
xlabel('Displacement (m)')
ylabel('Current (A)')
zlabel('Force (N)')
title('Force Magnitude vs. Current and Displacement')
axis([0 2e-4 0 1 0 30])
legend({'Data from FEM','Calculated'},'Location','Best')
grid on
hold(gca, "off")