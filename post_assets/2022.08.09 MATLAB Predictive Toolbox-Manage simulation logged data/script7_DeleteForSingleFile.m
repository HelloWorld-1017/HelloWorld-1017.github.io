fens = fileEnsembleDatastore(fullfile(pwd,'Data'),'.mat');
fens.ReadFcn = @readVars;
fens.WriteToMemberFcn = @writeNewData;

fens.DataVariables = ["SineWave"; "CosineWave"; "CompositeWave"; "PMSignalLogName";
    "logsout";"SimulationInput"; "SimulationMetadata"; "A1"; "f1"; "A2"; "f2"; "Maximum"];
fens.SelectedVariables = fens.DataVariables;

data = read(fens);

data = removevars(data, {'A1', 'f1', 'A2', 'f2'});

writeToLastMemberRead(fens, data)

function data = readVars(filename,variables)
data = table();
mfile = matfile(filename); % Allows partial loading
for ct=1:numel(variables)
    val = mfile.(variables{ct});
    if numel(val) > 1
        val = {val};
    end
    data.(variables{ct}) = val;
end
end

function writeNewData(filename,data)
save(filename, '-struct', 'data');
end
