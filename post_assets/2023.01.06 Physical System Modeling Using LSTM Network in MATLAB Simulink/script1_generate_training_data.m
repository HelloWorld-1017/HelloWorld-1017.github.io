clc, clear, close all

stopTime = 0.2;  % stop time 
timeInterval = 5e-5; % time interval

% The Pressure block of the model depends on the workspace variable maxPressure, which defines the value of the maximum pressure applied on the clutch. 
% Run the model for 20 different equally spaced values of maxPressure between 10e5 and 10e6.
% Collect the output data in the cell array data, where each element corresponds to a time series observation computed with the specified pressure profile.
numObservations = 20;
maxPressures = linspace(1e5,1e6,numObservations);

data = cell(numObservations,1);

for i = 1:numObservations
    maxPressure = maxPressures(i);
    simout = sim("ex_sdl_flexible_shaft");
    data{i} = simout.simout.Data';
end

% Extract the time steps of the simulations
times = simout.simout.Time;
numTimeSteps = length(times);

figure("Units", "pixels", "Position", [244,262,1006,363])
tiledlayout(1,2)

% Plot the control pressures of the first five simulations.
nexttile
hold(gca, "on")
box(gca, "on")
for i = 1:5
    pressure = data{i}(3,:);
    plot(times, pressure, LineWidth=1.5);
end
title("Input Pressure")
legend("Observation " + (1:5))
xlabel("Time")
ylabel("Pressure (Pa)")


% Plot the B and F signals of the load shaft and the F signal of the motor shaft of one of the simulations.
nexttile
idx = 4;
BLoadShaft = data{idx}(1,:);
FLoadShaft = data{idx}(2,:);
FMotorShaft = data{idx}(4,:);
plot(times,BLoadShaft, ...
    times,FLoadShaft, ...
    times,FMotorShaft)
legend("B - Load Shaft", "F - Load Shaft", "F - Motor Shaft")
title("Model Dynamics (Maximum Pressure =  " + maxPressures(idx) + " Pa)")
% exportgraphics(gcf, "fig-1.jpg", Resolution=600)


figure("Units", "pixels", "Position", [353,408,1145,268])
tiledlayout(1,3)
yLimits = [0, 250];

nexttile
plot(times, BLoadShaft, LineWidth=1.5)
ylim(yLimits)
legend("B - Load Shaft")

nexttile
plot(times, FLoadShaft, LineWidth=1.5)
ylim(yLimits)
legend("F - Load Shaft")

nexttile
plot(times, FMotorShaft, LineWidth=1.5)
ylim(yLimits)
legend("F - Motor Shaft")
exportgraphics(gcf, "fig-2.jpg", Resolution=600)

% Save output signals
save("data.mat", "data", "times")