mdl = 'model';
open_system(mdl)

A1s = 3 : 0.5 : 5;
f1s = pi/4 : pi/12 : pi/2;
A2s = 7 : 0.5 : 9;
f2s = pi/3 : pi/6 : pi;

[A1Values, f1Values, A2Values, f2Values] = ndgrid(A1s, f1s, A2s, f2s);

for ct = numel(A1Values):-1:1
    in = Simulink.SimulationInput(mdl);

    in = in.setVariable('A1', A1Values(ct));
    in = in.setVariable('f1', f1Values(ct));
    in = in.setVariable('A2', A2Values(ct));
    in = in.setVariable('f2', f2Values(ct));

    gridSimulationInput(ct) = in;
end

if ~exist(fullfile(pwd,'Data'),'dir')
    mkdir(fullfile(pwd,'Data')) % Create directory to store results
end

runAll = false;
if runAll
    [ok,e] = generateSimulationEnsemble(gridSimulationInput, fullfile(pwd,'Data'),'UseParallel', false);
else
    [ok,e] = generateSimulationEnsemble(gridSimulationInput(1:10), fullfile(pwd,'Data'));
end


