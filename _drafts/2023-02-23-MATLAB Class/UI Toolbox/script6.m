% fig = uifigure('Position',[782 497 435 311]);
% g = uigridlayout(fig,'Scrollable','on');
% g.RowHeight = {22,40,22,22,400};
% g.ColumnWidth = {400,400};
% 
% lbl = uilabel(g,'Text','Tsunamis');
% lbl.Layout.Row = 2;
% lbl.Layout.Column = [1,2];
% lbl.HorizontalAlignment = 'center';
% lbl.FontSize = 28;
% 
% tsunamis = readtable('tsunamis.xlsx');
% tsunamis.Cause = categorical(tsunamis.Cause);
% t = uitable(g,'Data',tsunamis);
% t.Layout.Row = [3,5];
% t.Layout.Column = 2;
% 
% p = uipanel(g);
% p.Scrollable = 'off';
% p.Layout.Row = [3,5];
% p.Layout.Column = 1;
% gb = geobubble(p,tsunamis.Latitude,tsunamis.Longitude,...
%     tsunamis.MaxHeight,tsunamis.Cause);

f = figure();
p = uix.CardPanel( 'Parent', f, 'Padding', 5 );
uicontrol( 'Parent', p, 'Background', 'r' );
uicontrol( 'Parent', p, 'Background', 'b' );
uicontrol( 'Parent', p, 'Background', 'g' );
p.Selection = 2;