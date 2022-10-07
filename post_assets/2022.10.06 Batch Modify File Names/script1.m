clc, clear, close all

file = dir("*.jpg");
for i = 1:numel(file)
    oldname = file(i).name;
    matchStr = regexp(oldname, '[0-9][0-9]', "match");
    newname = [num2str(matchStr{1}), ' Peaky Blinders.jpg'];
    eval(['!rename', ' "', oldname, '" "', newname, '"']);
end
