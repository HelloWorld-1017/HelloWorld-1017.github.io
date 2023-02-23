clc, clear, close all

f = figure('Menubar','none','Toolbar','none','Position',[500 500 200 45]);
mainLayout = uiextras.HBox('Parent',f,'Padding',10);

uicontrol('Parent',mainLayout,'Style','text','String','Find what:','FontSize',10);
uicontrol('Parent',mainLayout,'Style','popupmenu','string','prev1|prev2|prev3','Background','white');

set(mainLayout,'Sizes',[120,-1],'Spacing',10);

