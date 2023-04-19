% 初始化三元相图(Init ternary plot)
STA1=STernary();


A=rand(1,20);
B=rand(1,20);
C=rand(1,20);
STA1.SScatter(A,B,C,40,'filled','CData',[0,0,0]);
legend()

% 设置A轴颜色和粗细(Set A_Axis's 'Color' and 'LineWidth')
set(STA1,'A_Axis','Color',[0,0,.8],'LineWidth',3)
% 设置A轴主网格颜色和粗细(Set A_Grid's 'Color' and 'LineWidth')
set(STA1,'A_Grid','Color',[0,0,.8],'LineWidth',1.2)
% 设置A轴次网格颜色线形
set(STA1,'A_MinorGrid','Color',[0,0,.8],'LineStyle','-.')
% 设置A轴主刻度颜色
set(STA1,'A_Tick','Color',[0,0,.8])
% 设置A轴次刻度颜色
set(STA1,'A_MinorTick','Color',[0,0,.8])
% 设置A轴刻度标签字体和颜色
set(STA1,'A_TickLabel','Color',[0,0,.8],'FontSize',16)
% 设置A轴标签字体和颜色及位置以及文本内容
set(STA1,'A_Label','Color',[0,0,.8],'FontSize',18,'Position',[.88,.6],'String',{'Ternary plot';'by Slandarer'})