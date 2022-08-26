% This script is to verify whether the dR/dx is equal to dR/(dx/dt)
% The answer is yes.
clc, clear
sym = 'ssc_solenoid_magnetic';
open(sym)
sim(sym)

% Get mmf, phi, x
mmf = simlog_ssc_solenoid_magnetic.Solenoid_with_Magnetic_Effects.Reluctance_Force_Actuator.mmf.series;
phi = simlog_ssc_solenoid_magnetic.Solenoid_with_Magnetic_Effects.Reluctance_Force_Actuator.phi.series;
x = simlog_ssc_solenoid_magnetic.Solenoid_with_Magnetic_Effects.Reluctance_Force_Actuator.x.series;

time = mmf.time;
mmf = mmf.values;
phi = phi.values;
x = x.values;

% Calculate R using mmf and phi, according to magnetic Ohm's law.
R = mmf./phi;

% Calculate dR/dx
diffR = diff(R);
diffx = diff(x);
DRDx = diffR./diffx;

% Calculate dR/dt
difft = diff(time);
DRDt = diffR./difft;
velocity = diffx./difft;

result = DRDx-DRDt./velocity;
