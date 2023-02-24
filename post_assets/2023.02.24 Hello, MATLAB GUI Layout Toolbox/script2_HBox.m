clc, clear, close all

f = figure('Menubar','none','Toolbar','none','Position',[500 500 200 45]);
mainLayout = uiextras.HBox('Parent',f,'Padding',10);
% HBox：横向布局类

uicontrol('Parent',mainLayout,'Style','text','String','Find what:','FontSize',10);
uicontrol('Parent',mainLayout,'Style','popupmenu','string','prev1|prev2|prev3','Background','white');

set(mainLayout,'Sizes',[-1,-1],'Spacing',10);
% 'Sizes',[120,-1]：表示第一个控件的大小为固定的120，而-1表示第二个控件将会填满除去60像素后剩下的空间