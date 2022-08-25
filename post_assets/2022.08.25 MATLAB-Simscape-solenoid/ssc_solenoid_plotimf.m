% Code to plot simulation results from ssc_solenoid
% Copyright 2015 The MathWorks, Inc.

% Reuse figure if it exists, else create new figure
try
    figure(h1_ssc_solenoid)
catch
    h1_ssc_solenoid=figure('Name', 'ssc_solenoid', 'Position',[843, 466, 890, 720]);
end

% Generate simulation results if they don't exist
if(~exist('simlog_ssc_solenoid','var'))
    sim('ssc_solenoid')
end

% Get simulation results
temp_soli = simlog_ssc_solenoid.Solenoid.R1.i.series;
temp_solmf = simlog_ssc_solenoid.Solenoid.Position_Velocity_Force_Interface.Magnetic_Force.f.series;
temp_solpos = simlog_ssc_solenoid.Position_Sensor.Translational_Motion_Sensor.P.series;

% Plot results
ah(1) = subplot(3,1,1);
plot(temp_soli.time,temp_soli.values,'LineWidth',1);
grid on
title('Solenoid Current');
ylabel('Current (A)');

ah(2) = subplot(3,1,2);
plot(temp_solmf.time,temp_solmf.values,'LineWidth',1);
grid on
title('Solenoid Magnetic Force');
ylabel('Force (N)');

ah(3) = subplot(3,1,3);
plot(temp_solpos.time,temp_solpos.values,'LineWidth',1);
grid on
title('Position');
ylabel('Position (m)');
xlabel('Time (s)');

linkaxes(ah, 'x');

% Remove temporary variables
clear temp_soli temp_solmf temp_solpos ah
