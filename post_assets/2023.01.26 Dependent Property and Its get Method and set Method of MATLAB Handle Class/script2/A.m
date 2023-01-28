classdef A < handle
    properties
        a
    end
    methods
        function set.a(obj,val)
            if val >= 0
                obj.a = val;
                disp('Right value!')
            else
                error('a must be positive')
            end
        end
    end
end
