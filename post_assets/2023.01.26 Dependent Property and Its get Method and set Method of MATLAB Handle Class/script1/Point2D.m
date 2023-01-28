classdef Point2D < handle
    properties
        x
        y
%         r
    end
    properties(Dependent)
        r
    end
    methods
        function obj = Point2D(x0, y0)
            obj.x = x0;
            obj.y = y0;
        end
        function r = get.r(obj)
            r = sqrt(obj.x^2+obj.y^2);
            disp('get.r called');
        end
    end
end


% classdef Point2D < handle
%     properties
%         x
%         y
%         r
%     end
%     methods
%         function obj = Point2D(x0, y0)
%             obj.x = x0;
%             obj.y = y0;
%             CalculateR(obj);
%         end
%         function CalculateR(obj)
%             obj.r = sqrt(obj.x^2+obj.y^2);
%         end
%     end
% end

