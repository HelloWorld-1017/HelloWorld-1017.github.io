% Code to plot simulation results from ee_solenoid_fem
%% Plot Description:
%
% The plot below shows the difference in behavior between a linear solenoid
% model and a solenoid model parameterized with data provided from a finite
% element magnetic field modeling tool.

% Copyright 2016-2021 The MathWorks, Inc.

% Generate new simulation results if they don't exist or if they need to be updated
if ~exist('simlog_ee_solenoid_fem', 'var') || ...
        simlogNeedsUpdate(simlog_ee_solenoid_fem, 'ee_solenoid_fem') 
    sim('ee_solenoid_fem')
    % Model StopFcn callback adds a timestamp to the Simscape simulation data log
end

% Reuse figure if it exists, else create new figure
if ~exist('h1_ee_solenoid_fem', 'var') || ...
        ~isgraphics(h1_ee_solenoid_fem, 'figure')
    h1_ee_solenoid_fem = figure('Name', 'ee_solenoid_fem');
end
figure(h1_ee_solenoid_fem)
clf(h1_ee_solenoid_fem)

% Get simulation results
simlog_t = simlog_ee_solenoid_fem.Spring_FEM.x.series.time;
simlog_xFEM = simlog_ee_solenoid_fem.FEM_Parameterized_Linear_Actuator.x.series.values('mm');
simlog_xlin = simlog_ee_solenoid_fem.Linear_Solenoid.Position_Velocity_Force_Interface.Translational_Motion_Sensor.P.series.values('mm');
simlog_iFEM = simlog_ee_solenoid_fem.FEM_Parameterized_Linear_Actuator.i.series.values('A');
simlog_ilin = simlog_ee_solenoid_fem.Linear_Solenoid.R1.i.series.values('A');

% Plot results
simlog_handles(1) = subplot(2, 1, 1);
plot(simlog_t, simlog_xFEM, 'LineWidth', 1)
hold on
% plot(simlog_t, simlog_xlin, 'LineWidth', 1)
% hold off
grid on
title('Plunger Position')
ylabel('x(mm)')
% legend({'FEM','Linear'},'Location','Best');

simlog_handles(2) = subplot(2, 1, 2);
plot(simlog_t, simlog_iFEM, 'LineWidth', 1)
hold on
% plot(simlog_t, simlog_ilin, 'LineWidth', 1)
% hold off
grid on
title('Solenoid Current')
ylabel('Current (A)')
xlabel('Time (s)')
% legend({'FEM','Linear'},'Location','Best');

linkaxes(simlog_handles, 'x')

% Remove temporary variables
clear simlog_t simlog_handles
clear simlog_xFEM simlog_xlin simlog_iFEM simlog_ilin