clc, clear, close all

load test.mat

stopTime = 0.2;
sampleTime = 1e-3;

% Shaft properties
fShaft.Material = 'Aluminum Alloy';
fShaft.ShearModulus = 26E9;
fShaft.Diameter = 0.025;
fShaft.Length = 5;
fShaft.Density = 2.7E3;
fShaft.DampingCoeff = 0.02;

% Derived properties
fShaft.Stiffness = pi/32 * (fShaft.Diameter)^4 ...
    * fShaft.ShearModulus / fShaft.Length;

fShaft.Inertia = pi/32 * (fShaft.Diameter)^4 ...
    * fShaft.Density * fShaft.Length;

numObservationsTest = numel(dataTest);
outputStatesTest = 4;
for i = 1:numObservationsTest
    TTest{i} = dataTest{i}(outputStatesTest,2:end);
end

errs = [];
for i = 1:numObservationsTest
    maxPressure = maxPressuresTest(i);
    simout = sim("ex_sdl_flexible_shaft_lstm");

    YTest{i} = simout.simout.Data(1:end-1,4)';
end

Real = [TTest{:}];
Pred = [YTest{:}];

figure("Units", "pixels", "Position", [248,294,1289,339])
tiledlayout(1,3)
nexttile
hold(gca, "on")
box(gca, "on")
plot(1:numel(Real), Real, DisplayName="Real signals")
plot(1:numel(Pred), Pred, DisplayName="Predicted signals")
legend
xlabel("Sample points")

nexttile
hold(gca, "on")
box(gca, "on")
scatter(Real, Pred)
m = min([Real, Pred]);
M = max([Real, Pred]);
plot([m M],[m M],"r--")
xlabel("Target")
ylabel("Prediction")
xlim([m M])
ylim([m M])

nexttile
histogram(Real-Pred)
xlabel("Error")
ylabel("Frequency")