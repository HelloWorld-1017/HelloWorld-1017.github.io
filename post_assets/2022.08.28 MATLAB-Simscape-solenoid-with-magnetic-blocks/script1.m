% This script is to verify whether the dR/dx is equal to 1/(mu0*CSA) 
% for Reluctance_Force_Actuator according to eq. R=g/(mu0*mur*CSA).
% https://ww2.mathworks.cn/help/physmod/simscape/ref/reluctanceforceactuator.html
% However, the answer is likely 'no'.

% clc, clear
% 
% sym = 'ssc_solenoid_magnetic';
% open(sym)
% sim(sym)

% Get mmf, phi, x
mmf = simlog_ssc_solenoid_magnetic.Solenoid_with_Magnetic_Effects.Reluctance_Force_Actuator.mmf.series.values('A');     % [A]
phi = simlog_ssc_solenoid_magnetic.Solenoid_with_Magnetic_Effects.Reluctance_Force_Actuator.phi.series.values('Wb');     % [Wb]
x   = simlog_ssc_solenoid_magnetic.Solenoid_with_Magnetic_Effects.Reluctance_Force_Actuator.x.series.values('m');  % [m]


% Calculate R using mmf and phi, according to magnetic Ohm's law.
R = mmf./phi;

% Calculate dR/dx
dR = diff(R);
dx = diff(x);
dRdx = dR./dx;

result = dRdx - 1/(4*pi*(1e-7)*4*(1e-4));
result = result(~isnan(result));
result = result(~isinf(result));
sum(result)