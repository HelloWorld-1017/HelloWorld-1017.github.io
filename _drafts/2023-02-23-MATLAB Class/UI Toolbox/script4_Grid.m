clc, clear, close all

f = figure('MenuBar','none','ToolBar','none','Position',[500 500 300 150]);
mainLayout = uiextras.Grid('Parent',f,'Padding',10);

% Fist column
uicontrol('Parent',mainLayout,'Style','text','String','Replace with','FontSize',9);
uicontrol('Parent',mainLayout,'Style','text','String','Look in','FontSize',9);
uiextras.Empty('Parent',mainLayout);
uicontrol('Parent',mainLayout,'Style','Radio','String','Math case','FontSize',9);

% Second column
uicontrol('Parent',mainLayout,'Style','popupmenu','String','prev1|prev2|prev3','background','w');
uicontrol('Parent',mainLayout,'Style','popupmenu','String','prev1|prev2|prev3','background','w');
uiextras.Empty('Parent',mainLayout);
uicontrol('Parent',mainLayout,'Style','radio','String','Whole word','FontSize',9);
set(mainLayout,'RowSizes',[25,25,25,25],'ColumnSizes',[120,150],'Spacing',5);
