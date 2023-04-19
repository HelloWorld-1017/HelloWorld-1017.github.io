classdef STernary < handle
    properties
        ax % 三元相图所在坐标区域
        BkgHdl,LabelSep=.001;Color=[1,1,1];
        TriLHdl;TriRHdl
        TickLenth=[.02,.01];
        TickValues=20:20:100;
        GridValues=20:20:100;
        MinorTickValues=5:5:100;
        MinorGridValues=10:10:90;
        A_Axis,B_Axis,C_Axis;
        A_Grid,B_Grid,C_Grid;
        A_Tick,B_Tick,C_Tick;
        A_Label,B_Label;C_Label;
        A_MinorGrid,B_MinorGrid,C_MinorGrid;
        A_MinorTick,B_MinorTick,C_MinorTick;
        A_TickLabel,B_TickLabel,C_TickLabel;
        % A_LabelStr='A-Axis';
        % B_LabelStr='B-Axis';
        % C_LabelStr='C-Axis';
        A_TickLabelStr={'20','40','60','80','100'};
        B_TickLabelStr={'20','40','60','80','100'};
        C_TickLabelStr={'20','40','60','80','100'};
    end
    methods
% Create Ternary Axes =====================================================
        function obj=STernary(ax)
            if nargin<1,ax=gca;end
            obj.ax=ax;
            obj.ax.NextPlot='add'; % Equal to 'hold on'
            obj.ax.XLim=[0-1/40,1+1/40];
            obj.ax.YLim=[0-1/40,sqrt(3)/2+sqrt(3)/80];
            obj.ax.XGrid='off';
            obj.ax.YGrid='off';
            obj.ax.Box='off';
            obj.ax.DataAspectRatio=[1,1,1];
            obj.ax.XColor='none';
            obj.ax.YColor='none';

            % Draw Background 
            obj.BkgHdl=fill(obj.ax,[0,1,1/2],[0,0,sqrt(3)/2],[1,1,1],'EdgeColor','none');
            obj.TriLHdl=fill(obj.ax,[0,1/2+1/40,0],[0,sqrt(3)/2+1/40*sqrt(3),sqrt(3)/2+1/40*sqrt(3)],[1,1,1],'EdgeColor','none');
            obj.TriRHdl=fill(obj.ax,[1,1/2-1/40,1],[0,sqrt(3)/2+1/40*sqrt(3),sqrt(3)/2+1/40*sqrt(3)],[1,1,1],'EdgeColor','none');
            obj.BkgHdl.Annotation.LegendInformation.IconDisplayStyle='off';
            obj.TriLHdl.Annotation.LegendInformation.IconDisplayStyle='off';
            obj.TriRHdl.Annotation.LegendInformation.IconDisplayStyle='off';

            % Draw Minor Grid 
            obj.MinorGridValues=setdiff(obj.MinorGridValues,obj.GridValues);
            AMGX=[1-obj.MinorGridValues./200;obj.MinorGridValues./200;obj.MinorGridValues.*nan];
            AMGY=[obj.MinorGridValues./200.*sqrt(3);obj.MinorGridValues./200.*sqrt(3);obj.MinorGridValues.*nan];
            obj.A_MinorGrid=plot(obj.ax,AMGX(:),AMGY(:),'LineWidth',.5,'Color',[0,0,0,.2],'LineStyle','-');
            obj.A_MinorGrid.Annotation.LegendInformation.IconDisplayStyle='off';
            
            BMGX=[1/2-obj.MinorGridValues./200;1-obj.MinorGridValues./100;obj.MinorGridValues.*nan];
            BMGY=[sqrt(3)/2-obj.MinorGridValues./200.*sqrt(3);obj.MinorGridValues.*0;obj.MinorGridValues.*nan];
            obj.B_MinorGrid=plot(obj.ax,BMGX(:),BMGY(:),'LineWidth',.5,'Color',[0,0,0,.2],'LineStyle','-');
            obj.B_MinorGrid.Annotation.LegendInformation.IconDisplayStyle='off';
            
            CMGX=[obj.MinorGridValues./100;1/2+obj.MinorGridValues./200;obj.MinorGridValues.*nan];
            CMGY=[obj.MinorGridValues.*0;1/2.*sqrt(3)-obj.MinorGridValues./200.*sqrt(3);obj.MinorGridValues.*nan];
            obj.C_MinorGrid=plot(obj.ax,CMGX(:),CMGY(:),'LineWidth',.5,'Color',[0,0,0,.2],'LineStyle','-');
            obj.C_MinorGrid.Annotation.LegendInformation.IconDisplayStyle='off';


            % Draw Grid
            AGX=[1-obj.GridValues./200;obj.GridValues./200;obj.GridValues.*nan];
            AGY=[obj.GridValues./200.*sqrt(3);obj.GridValues./200.*sqrt(3);obj.GridValues.*nan];
            obj.A_Grid=plot(obj.ax,AGX(:),AGY(:),'LineWidth',.8,'Color',[0,0,0,.7],'LineStyle','-');
            obj.A_Grid.Annotation.LegendInformation.IconDisplayStyle='off';

            BGX=[1/2-obj.GridValues./200;1-obj.GridValues./100;obj.GridValues.*nan];
            BGY=[sqrt(3)/2-obj.GridValues./200.*sqrt(3);obj.GridValues.*0;obj.GridValues.*nan];
            obj.B_Grid=plot(obj.ax,BGX(:),BGY(:),'LineWidth',.8,'Color',[0,0,0,.7],'LineStyle','-');
            obj.B_Grid.Annotation.LegendInformation.IconDisplayStyle='off';

            CGX=[obj.GridValues./100;1/2+obj.GridValues./200;obj.GridValues.*nan];
            CGY=[obj.GridValues.*0;1/2.*sqrt(3)-obj.GridValues./200.*sqrt(3);obj.GridValues.*nan];
            obj.C_Grid=plot(obj.ax,CGX(:),CGY(:),'LineWidth',.8,'Color',[0,0,0,.7],'LineStyle','-');
            obj.C_Grid.Annotation.LegendInformation.IconDisplayStyle='off';


            % Draw Minor Tick
            obj.MinorTickValues=setdiff(obj.MinorTickValues,obj.TickValues);
            AMTX=[1-obj.MinorTickValues./200;1-obj.MinorTickValues./200+cos(0).*obj.TickLenth(2);obj.MinorTickValues.*nan];
            AMTY=[obj.MinorTickValues./200.*sqrt(3);obj.MinorTickValues./200.*sqrt(3)+sin(0).*obj.TickLenth(2);obj.MinorTickValues.*nan];
            obj.A_MinorTick=plot(obj.ax,AMTX(:),AMTY(:),'LineWidth',.8,'Color',[0,0,0]);
            obj.A_MinorTick.Annotation.LegendInformation.IconDisplayStyle='off';
            
            BMTX=[1/2-obj.MinorTickValues./200;1/2-obj.MinorTickValues./200+cos(2*pi/3).*obj.TickLenth(2);obj.MinorTickValues.*nan];help STernary
            BMTY=[sqrt(3)/2-obj.MinorTickValues./200.*sqrt(3);sqrt(3)/2-obj.MinorTickValues./200.*sqrt(3)+sin(2*pi/3).*obj.TickLenth(2);obj.MinorTickValues.*nan];
            obj.B_MinorTick=plot(obj.ax,BMTX(:),BMTY(:),'LineWidth',.8,'Color',[0,0,0]);
            obj.B_MinorTick.Annotation.LegendInformation.IconDisplayStyle='off';
            
            CMTX=[obj.MinorTickValues./100;obj.MinorTickValues./100+cos(-2*pi/3).*obj.TickLenth(2);obj.MinorTickValues.*nan];
            CMTY=[obj.MinorTickValues.*0;obj.MinorTickValues.*0+sin(-2*pi/3).*obj.TickLenth(2);obj.MinorTickValues.*nan];
            obj.C_MinorTick=plot(obj.ax,CMTX(:),CMTY(:),'LineWidth',.8,'Color',[0,0,0]);
            obj.C_MinorTick.Annotation.LegendInformation.IconDisplayStyle='off';




            % Draw Tick 
            ATX=[1-obj.TickValues./200;1-obj.TickValues./200+cos(0).*obj.TickLenth(1);obj.TickValues.*nan];
            ATY=[obj.TickValues./200.*sqrt(3);obj.TickValues./200.*sqrt(3)+sin(0).*obj.TickLenth(1);obj.TickValues.*nan];
            obj.A_Tick=plot(obj.ax,ATX(:),ATY(:),'LineWidth',1.2,'Color',[0,0,0]);
            obj.A_Tick.Annotation.LegendInformation.IconDisplayStyle='off';
            
            BTX=[1/2-obj.TickValues./200;1/2-obj.TickValues./200+cos(2*pi/3).*obj.TickLenth(1);obj.TickValues.*nan];
            BTY=[sqrt(3)/2-obj.TickValues./200.*sqrt(3);sqrt(3)/2-obj.TickValues./200.*sqrt(3)+sin(2*pi/3).*obj.TickLenth(1);obj.TickValues.*nan];
            obj.B_Tick=plot(obj.ax,BTX(:),BTY(:),'LineWidth',1.2,'Color',[0,0,0]);
            obj.B_Tick.Annotation.LegendInformation.IconDisplayStyle='off';
            
            CTX=[obj.TickValues./100;obj.TickValues./100+cos(-2*pi/3).*obj.TickLenth(1);obj.TickValues.*nan];
            CTY=[obj.TickValues.*0;obj.TickValues.*0+sin(-2*pi/3).*obj.TickLenth(1);obj.TickValues.*nan];
            obj.C_Tick=plot(obj.ax,CTX(:),CTY(:),'LineWidth',1.2,'Color',[0,0,0]);
            obj.C_Tick.Annotation.LegendInformation.IconDisplayStyle='off';




            % Draw Axis
            obj.A_Axis=plot(obj.ax,[1,1/2],[0,sqrt(3)/2],'Color',[0,0,0],'LineWidth',1.2);
            obj.B_Axis=plot(obj.ax,[1/2,0],[sqrt(3)/2,0],'Color',[0,0,0],'LineWidth',1.2);
            obj.C_Axis=plot(obj.ax,[0,1],[0,0],'Color',[0,0,0],'LineWidth',1.2);
            obj.A_Axis.Annotation.LegendInformation.IconDisplayStyle='off';
            obj.B_Axis.Annotation.LegendInformation.IconDisplayStyle='off';
            obj.C_Axis.Annotation.LegendInformation.IconDisplayStyle='off';


            % Draw Tick Label
            for i=1:length(obj.TickValues)
                obj.A_TickLabel{i}=text(obj.ax,...
                    1-obj.TickValues(i)./200+cos(0).*(obj.TickLenth(1)+.01),...
                    obj.TickValues(i)./200.*sqrt(3)+sin(0).*(obj.TickLenth(1)+.01),...
                    obj.A_TickLabelStr{i},'FontName','Cambria','FontSize',12);
                obj.B_TickLabel{i}=text(obj.ax,...
                    1/2-obj.TickValues(i)./200+cos(2*pi/3).*(obj.TickLenth(1)+.01),...
                    sqrt(3)/2-obj.TickValues(i)./200.*sqrt(3)+sin(2*pi/3).*(obj.TickLenth(1)+.01),...
                    obj.B_TickLabelStr{i},'FontName','Cambria','FontSize',12,...
                    'Rotation',-60,'HorizontalAlignment','right');
                obj.C_TickLabel{i}=text(obj.ax,...
                    obj.TickValues(i)./100+cos(-2*pi/3).*(obj.TickLenth(1)+.01),...
                    sin(-2*pi/3).*(obj.TickLenth(1)+.01),...
                    obj.C_TickLabelStr{i},'FontName','Cambria','FontSize',12,...
                    'Rotation',60,'HorizontalAlignment','right');
            end
            % Draw Label
            obj.A_Label=text(obj.ax,1/2+cos(pi/2).*obj.LabelSep,sqrt(3)/2+sin(pi/2).*obj.LabelSep,'A-Axis',...
                'FontName','Cambria','FontSize',16,'HorizontalAlignment','center','VerticalAlignment','bottom');
            obj.B_Label=text(obj.ax,cos(-5*pi/6).*obj.LabelSep,sin(-5*pi/6).*obj.LabelSep,'B-Axis',...
                'FontName','Cambria','FontSize',16,'HorizontalAlignment','right','VerticalAlignment','top');
            obj.C_Label=text(obj.ax,1+cos(-pi/6).*obj.LabelSep,sin(-pi/6).*obj.LabelSep,'C-Axis',...
                'FontName','Cambria','FontSize',16,'HorizontalAlignment','left','VerticalAlignment','top');
        end

        function set(obj,hdlName,varargin)
            if isa(obj.(hdlName),'double')||(length(obj.(hdlName))>1&&(isa(obj.(hdlName){1},'char')||isa(obj.(hdlName){1},'string')))
                switch true
                    case isequal(hdlName,'Color')
                        obj.Color=varargin{:};
                        set(obj.BkgHdl,'FaceColor',varargin{:});
                    case isequal(hdlName,'TickLenth')
                        obj.TickLenth=varargin{:};
                    case isequal(hdlName(end-2:end),'ues')
                        obj.(hdlName)=varargin{:};
                    case isequal(hdlName(end-2:end),'Str')
                        obj.(hdlName)=varargin{:};
                end
                % Renew Minor Grid >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
                obj.MinorGridValues=setdiff(obj.MinorGridValues,obj.GridValues);
                AMGX=[1-obj.MinorGridValues./200;obj.MinorGridValues./200;obj.MinorGridValues.*nan];
                AMGY=[obj.MinorGridValues./200.*sqrt(3);obj.MinorGridValues./200.*sqrt(3);obj.MinorGridValues.*nan];
                set(obj.A_MinorGrid,'XData',AMGX(:),'YData',AMGY(:));
                %
                BMGX=[1/2-obj.MinorGridValues./200;1-obj.MinorGridValues./100;obj.MinorGridValues.*nan];
                BMGY=[sqrt(3)/2-obj.MinorGridValues./200.*sqrt(3);obj.MinorGridValues.*0;obj.MinorGridValues.*nan];
                set(obj.B_MinorGrid,'XData',BMGX(:),'YData',BMGY(:));
                %
                CMGX=[obj.MinorGridValues./100;1/2+obj.MinorGridValues./200;obj.MinorGridValues.*nan];
                CMGY=[obj.MinorGridValues.*0;1/2.*sqrt(3)-obj.MinorGridValues./200.*sqrt(3);obj.MinorGridValues.*nan];
                set(obj.C_MinorGrid,'XData',CMGX(:),'YData',CMGY(:));
                % Renew Grid >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
                AGX=[1-obj.GridValues./200;obj.GridValues./200;obj.GridValues.*nan];
                AGY=[obj.GridValues./200.*sqrt(3);obj.GridValues./200.*sqrt(3);obj.GridValues.*nan];
                set(obj.A_Grid,'XData',AGX(:),'YData',AGY(:));
                %
                BGX=[1/2-obj.GridValues./200;1-obj.GridValues./100;obj.GridValues.*nan];
                BGY=[sqrt(3)/2-obj.GridValues./200.*sqrt(3);obj.GridValues.*0;obj.GridValues.*nan];
                set(obj.B_Grid,'XData',BGX(:),'YData',BGY(:));
                %
                CGX=[obj.GridValues./100;1/2+obj.GridValues./200;obj.GridValues.*nan];
                CGY=[obj.GridValues.*0;1/2.*sqrt(3)-obj.GridValues./200.*sqrt(3);obj.GridValues.*nan];
                set(obj.C_Grid,'XData',CGX(:),'YData',CGY(:));
                % Renew Minor Tick >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
                obj.MinorTickValues=setdiff(obj.MinorTickValues,obj.TickValues);
                AMTX=[1-obj.MinorTickValues./200;1-obj.MinorTickValues./200+cos(0).*obj.TickLenth(2);obj.MinorTickValues.*nan];
                AMTY=[obj.MinorTickValues./200.*sqrt(3);obj.MinorTickValues./200.*sqrt(3)+sin(0).*obj.TickLenth(2);obj.MinorTickValues.*nan];
                set(obj.A_MinorTick,'XData',AMTX(:),'YData',AMTY(:));
                %
                BMTX=[1/2-obj.MinorTickValues./200;1/2-obj.MinorTickValues./200+cos(2*pi/3).*obj.TickLenth(2);obj.MinorTickValues.*nan];
                BMTY=[sqrt(3)/2-obj.MinorTickValues./200.*sqrt(3);sqrt(3)/2-obj.MinorTickValues./200.*sqrt(3)+sin(2*pi/3).*obj.TickLenth(2);obj.MinorTickValues.*nan];
                set(obj.B_MinorTick,'XData',BMTX(:),'YData',BMTY(:));
                %
                CMTX=[obj.MinorTickValues./100;obj.MinorTickValues./100+cos(-2*pi/3).*obj.TickLenth(2);obj.MinorTickValues.*nan];
                CMTY=[obj.MinorTickValues.*0;obj.MinorTickValues.*0+sin(-2*pi/3).*obj.TickLenth(2);obj.MinorTickValues.*nan];
                set(obj.C_MinorTick,'XData',CMTX(:),'YData',CMTY(:));
                % Renew Tick >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
                ATX=[1-obj.TickValues./200;1-obj.TickValues./200+cos(0).*obj.TickLenth(1);obj.TickValues.*nan];
                ATY=[obj.TickValues./200.*sqrt(3);obj.TickValues./200.*sqrt(3)+sin(0).*obj.TickLenth(1);obj.TickValues.*nan];
                set(obj.A_Tick,'XData',ATX(:),'YData',ATY(:));
                %
                BTX=[1/2-obj.TickValues./200;1/2-obj.TickValues./200+cos(2*pi/3).*obj.TickLenth(1);obj.TickValues.*nan];
                BTY=[sqrt(3)/2-obj.TickValues./200.*sqrt(3);sqrt(3)/2-obj.TickValues./200.*sqrt(3)+sin(2*pi/3).*obj.TickLenth(1);obj.TickValues.*nan];
                set(obj.B_Tick,'XData',BTX(:),'YData',BTY(:));
                %
                CTX=[obj.TickValues./100;obj.TickValues./100+cos(-2*pi/3).*obj.TickLenth(1);obj.TickValues.*nan];
                CTY=[obj.TickValues.*0;obj.TickValues.*0+sin(-2*pi/3).*obj.TickLenth(1);obj.TickValues.*nan];
                set(obj.C_Tick,'XData',CTX(:),'YData',CTY(:));
                % Renew Tick Label >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
                for i=1:length(obj.TickValues)
                    set(obj.A_TickLabel{i},'Position',...
                        [1-obj.TickValues(i)./200+cos(0).*(obj.TickLenth(1)+.01),...
                        obj.TickValues(i)./200.*sqrt(3)+sin(0).*(obj.TickLenth(1)+.01)],...
                        'String',obj.A_TickLabelStr{mod(i-1,length(obj.TickValues))+1});
                    set(obj.B_TickLabel{i},'Position',...
                        [1/2-obj.TickValues(i)./200+cos(2*pi/3).*(obj.TickLenth(1)+.01),...
                        sqrt(3)/2-obj.TickValues(i)./200.*sqrt(3)+sin(2*pi/3).*(obj.TickLenth(1)+.01)],...
                        'String',obj.B_TickLabelStr{mod(i-1,length(obj.TickValues))+1});
                    set(obj.C_TickLabel{i},'Position',...
                        [obj.TickValues(i)./100+cos(-2*pi/3).*(obj.TickLenth(1)+.01),...
                        sin(-2*pi/3).*(obj.TickLenth(1)+.01)],...
                        'String',obj.C_TickLabelStr{mod(i-1,length(obj.TickValues))+1});
                end
            else
                if length(obj.(hdlName))>1
                    tHdl=obj.(hdlName);
                    for i=1:length(tHdl)
                        set(tHdl{i},varargin{:})
                    end
                else
                    set(obj.(hdlName),varargin{:})
                end
            end
        end
% -------------------------------------------------------------------------
        function label2Side(obj)
            set(obj.A_Label,'Position',[3/4+cos(pi/6).*obj.LabelSep.*90,sqrt(3)/4+sin(pi/6).*obj.LabelSep.*90],...
                'HorizontalAlignment','center','VerticalAlignment','bottom','Rotation',-60)
            set(obj.B_Label,'Position',[1/4+cos(5*pi/6).*obj.LabelSep.*90,sqrt(3)/4+sin(5*pi/6).*obj.LabelSep.*90],...
                'HorizontalAlignment','center','VerticalAlignment','bottom','Rotation',60)
            set(obj.C_Label,'Position',[1/2+cos(-pi/2).*obj.LabelSep.*90,0+sin(-pi/2).*obj.LabelSep.*90],...
                'HorizontalAlignment','center','VerticalAlignment','top','Rotation',0)
        end

        function scatterHdl=SScatter(obj,A,B,C,varargin)
            [X,Y]=obj.ternData(A,B,C);
            scatterHdl=scatter(obj.ax,X,Y,varargin{:});
        end
% -------------------------------------------------------------------------
        function plotHdl=SPlot(obj,A,B,C,varargin)
            [X,Y]=obj.ternData(A,B,C);
            plotHdl=plot(obj.ax,X,Y,varargin{:});
        end
% -------------------------------------------------------------------------
        function fillHdl=SFill(obj,A,B,C,varargin)
            [X,Y]=obj.ternData(A,B,C);
            fillHdl=fill(obj.ax,X,Y,varargin{:});
        end
% -------------------------------------------------------------------------
        function convhullHdl=SConvhull(obj,A,B,C,varargin)
            [X,Y]=obj.ternData(A,B,C);
            [ind,~]=convhull([X,Y]);
            convhullHdl=fill(obj.ax,X(ind),Y(ind),varargin{:});
        end
% -------------------------------------------------------------------------
        function textHdl=SText(obj,A,B,C,varargin)
            [X,Y]=obj.ternData(A,B,C);
            textHdl=text(obj.ax,X,Y,varargin{:});
        end
% -------------------------------------------------------------------------
        function bubblechartHdl=SBubblechart(obj,A,B,C,varargin)
            [X,Y]=obj.ternData(A,B,C);
            bubblechartHdl=bubblechart(obj.ax,X,Y,varargin{:});
        end
% -------------------------------------------------------------------------
        function [contourHdl,Z]=SContour(obj,A,B,C,N,varargin)
            if isempty(N),N=90;end
            [X,Y]=obj.ternData(A,B,C);
            [XX1,XX2]=meshgrid(linspace(0,1,N),linspace(0,1,N));
            F=ksdensity([X,Y],[XX1(:),XX2(:)]);
            Z=reshape(F,size(XX1));
            Z(XX2>XX1.*sqrt(3)+.03)=nan;
            Z(XX2>sqrt(3)-XX1.*sqrt(3)+.03)=nan;
            hdlSet=findobj(obj.ax,'Tag','TernaryContour');
            if isempty(hdlSet)
                T=1;
            else
                T=1;
                for i=1:length(hdlSet)
                    T=max(T,get(hdlSet(i),'UserData')+1);
                end
            end
            contour(obj.ax,XX1,XX2,Z,varargin{:},'Tag','TernaryContour','UserData',T);
            uistack(obj.TriLHdl,'top');uistack(obj.TriRHdl,'top')
            uistack(obj.A_MinorTick,'top');uistack(obj.B_MinorTick,'top');uistack(obj.C_MinorTick,'top');
            uistack(obj.A_Tick,'top');uistack(obj.B_Tick,'top');uistack(obj.C_Tick,'top');
            uistack(obj.A_Axis,'top');uistack(obj.B_Axis,'top');uistack(obj.C_Axis,'top');
            for i=1:length(obj.A_TickLabel)
                uistack(obj.A_TickLabel{i},'top');
                uistack(obj.B_TickLabel{i},'top');
                uistack(obj.C_TickLabel{i},'top');
            end
            uistack(obj.A_Label,'top');uistack(obj.B_Label,'top');uistack(obj.C_Label,'top');
            contourHdl=findobj(obj.ax,'Tag','TernaryContour','UserData',T);
        end
% -------------------------------------------------------------------------
        function [contourfHdl,Z]=SContourf(obj,A,B,C,N,varargin)
            if isempty(N),N=90;end
            [X,Y]=obj.ternData(A,B,C);
            [XX1,XX2]=meshgrid(linspace(0,1,N),linspace(0,1,N));
            F=ksdensity([X,Y],[XX1(:),XX2(:)]);
            Z=reshape(F,size(XX1));
            Z(XX2>XX1.*sqrt(3)+.03)=nan;
            Z(XX2>sqrt(3)-XX1.*sqrt(3)+.03)=nan;
            hdlSet=findobj(obj.ax,'Tag','TernaryContour');
            if isempty(hdlSet)
                T=1;
            else
                T=1;
                for i=1:length(hdlSet)
                    T=max(T,get(hdlSet(i),'UserData')+1);
                end
            end
            contourf(obj.ax,XX1,XX2,Z,varargin{:},'Tag','TernaryContour','UserData',T);
            uistack(obj.TriLHdl,'top');uistack(obj.TriRHdl,'top')
            uistack(obj.A_MinorTick,'top');uistack(obj.B_MinorTick,'top');uistack(obj.C_MinorTick,'top');
            uistack(obj.A_Tick,'top');uistack(obj.B_Tick,'top');uistack(obj.C_Tick,'top');
            uistack(obj.A_Axis,'top');uistack(obj.B_Axis,'top');uistack(obj.C_Axis,'top');
            for i=1:length(obj.A_TickLabel)
                uistack(obj.A_TickLabel{i},'top');
                uistack(obj.B_TickLabel{i},'top');
                uistack(obj.C_TickLabel{i},'top');
            end   
            uistack(obj.A_Label,'top');uistack(obj.B_Label,'top');uistack(obj.C_Label,'top');
            contourfHdl=findobj(obj.ax,'Tag','TernaryContour','UserData',T);
        end
% -------------------------------------------------------------------------
        function [X,Y]=ternData(~,A,B,C)
            ABC=[A(:),B(:),C(:)];
            ABC=ABC./sum(ABC,2);
            B=ABC(:,2);
            C=ABC(:,3);
            X=C+(1-C-B)./2;
            Y=0+sqrt(3).*(1-C-B)./2;
        end
% -------------------------------------------------------------------------
        function ABC=SNorm(~,ABC)
            ABC=ABC-min(ABC,[],1);
            ABC=ABC./max(ABC,[],1);
        end
% -------------------------------------------------------------------------
        function ABC=SNormByLim(~,ABC,Lim)
            ABC=ABC-Lim([1,3,5]);
            ABC=ABC./(Lim([2,4,6])-Lim([1,3,5]));
        end
    end
end