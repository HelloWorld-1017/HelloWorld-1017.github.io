classdef Square < handle
    properties
        t = linspace(0,2,1000)';
        f
    end

    methods
        function obj = Square(Omega)
            obj.f = square(Omega*obj.t);
        end

        function Plot(obj)
            plot(obj.t, obj.f, 'k', LineWidth=1.5)
            box(gca, "on")
            grid(gca, "on")
            xlabel('t')
            ylabel('f(t)')
%             set(gca, 'DataAspectRatio', [1 1 1])
            set(gca, 'YTick', [-1,0,1])
            set(gca, 'Xtick', [-1.5,-1,-0.5,0,0.5,1,1.5])
            set(gca, 'FontName', 'Times New Roman')
            set(gca, 'FontSize', 13)
        end
    end
end