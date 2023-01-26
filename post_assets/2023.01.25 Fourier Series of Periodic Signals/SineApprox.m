classdef SineApprox < handle
    properties
        t = linspace(0,2,1000)';
        f
        times
    end

    methods
        function obj = SineApprox(Omega, times)
            obj.times = times;
            obj.f = zeros(numel(obj.t), 1);
            for i = 1:2:times
                obj.f = obj.f + 4/pi*(1/i)*sin(i*Omega*obj.t);
            end
        end

        function Plot(obj)
            hold(gca, "on")
            plot(obj.t, obj.f, 'r', LineWidth=1.5)
            title(sprintf('Sum of the first %d harmonics', obj.times))
        end

    end
end

