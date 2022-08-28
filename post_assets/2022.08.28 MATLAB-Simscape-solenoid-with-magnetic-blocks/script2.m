% This script is to verify whether the dR/dx is equal to (dR/dt)/(dx/dt)
% The answer is 'maybe yes'.
clc, clear
sym = 'ssc_solenoid_magnetic';
open(sym)
sim(sym)

% Get mmf, phi, x
mmf = simlog_ssc_solenoid_magnetic.Solenoid_with_Magnetic_Effects.Reluctance_Force_Actuator.mmf.series;
phi = simlog_ssc_solenoid_magnetic.Solenoid_with_Magnetic_Effects.Reluctance_Force_Actuator.phi.series;
x = simlog_ssc_solenoid_magnetic.Solenoid_with_Magnetic_Effects.Reluctance_Force_Actuator.x.series;

t = mmf.time;
mmf = mmf.values('A');
phi = phi.values('Wb');
x = x.values('m');

% Calculate R using mmf and phi, according to magnetic Ohm's law.
R = mmf./phi;

% Calculate dR/dx
dR = diff(R);
dx = diff(x);
dRdx = dR./dx;

% Calculate dR/dt
dt = diff(t);
dRdt = dR./dt;

% Calculate dx/dt, ie velocity.
velocity = dx./dt;

% Compare dR/dx and (dR/dt)*(dt/dx)
result = dRdx-dRdt./velocity;
sum(result(~isnan(result)))
