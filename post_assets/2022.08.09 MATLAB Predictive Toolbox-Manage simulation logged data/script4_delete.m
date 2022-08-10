%% Failed
clc, clear
% Create ensemble
ens = simulationEnsembleDatastore(fullfile(pwd,'Data'));

ens.SelectedVariables = ens.DataVariables;
data = read(ens);
data = removevars(data, {'A1', 'f1', 'A2', 'f2'});

ens.DataVariables = ["SineWave"; "CosineWave"; "CompositeWave";
    "Maximum"; "SimulationInput"; "SimulationMetadata"];

writeToLastMemberRead(ens, data);
