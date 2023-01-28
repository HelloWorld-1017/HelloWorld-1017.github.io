classdef A < handle
    properties
        a = 10;
        b = 10;
    end
    methods
        function val = get.a(obj)
            val = obj.a;
            disp('getter a called')
        end
        function val = get.b(obj)
            val = obj.b;
            disp('getter b called')
        end
    end
end
