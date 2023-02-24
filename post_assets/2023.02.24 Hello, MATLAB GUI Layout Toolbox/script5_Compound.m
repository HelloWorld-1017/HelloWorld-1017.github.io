clc,clear,close all

f = figure('MenuBar','none','ToolBar','none','pos',[200 200 500 300]);
mainLayout = uiextras.HBox('Parent',f,'Spacing',10);
LeftLayout = uiextras.VBox('Parent',mainLayout,'Spacing',10,'Padding',10);
LUpperLayout = uiextras.HBox('Parent',LeftLayout,'Padding',10);
LLowerLayout = uiextras.Grid('Parent',LeftLayout,'Padding',10);
RightLayout = uiextras.VBox('Parent',mainLayout,'Spacing',20,'Padding',10);

% For Upper Left
uicontrol('Parent',LUpperLayout,'Style','text','String','Find what:','FontSize',10);
uicontrol('Parent',LUpperLayout,'Style','popupmenu','string','prev1|prev2|prev3','Background','white');

% For Lower Left
% Fist column
uicontrol('Parent',LLowerLayout,'Style','text','String','Replace with','FontSize',9);
uicontrol('Parent',LLowerLayout,'Style','text','String','Look in','FontSize',9);
uiextras.Empty('Parent',LLowerLayout);
uicontrol('Parent',LLowerLayout,'Style','Radio','String','Math case','FontSize',9);
% Second column
uicontrol('Parent',LLowerLayout,'Style','popupmenu','String','prev1|prev2|prev3','background','w');
uicontrol('Parent',LLowerLayout,'Style','popupmenu','String','prev1|prev2|prev3','background','w');
uiextras.Empty('Parent',LLowerLayout);
uicontrol('Parent',LLowerLayout,'Style','radio','String','Whole word','FontSize',9);
set(LLowerLayout,'RowSizes',[25,25,25,25],'ColumnSizes',[120,150],'Spacing',5);

% For Right
uicontrol('style', 'pushbutton', 'String', 'Find Next', 'Parent', RightLayout);
uicontrol('style', 'pushbutton', 'String', 'Find Previous', 'Parent', RightLayout);
uicontrol('style', 'pushbutton', 'String', 'Replace', 'Parent', RightLayout);
uicontrol('style', 'pushbutton', 'String', 'Replace All', 'Parent', RightLayout);
uicontrol('style', 'pushbutton', 'String', 'Close', 'Parent', RightLayout);



