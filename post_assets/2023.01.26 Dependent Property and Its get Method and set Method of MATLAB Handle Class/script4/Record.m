classdef Record < handle
    properties
        timeStamp
    end
    properties(Dependent,Hidden)
        date
    end
    methods
        function obj = Record(date)
            obj.date = date;
            disp("date: "+obj.date)
            disp("timeStamp: "+obj.timeStamp)
        end
        function set.date(obj,val)
            obj.timeStamp = val;
            disp("set method called")
        end
        function val = get.date(obj)
            val = obj.timeStamp;
            disp("get method called")
        end
    end
end



% classdef Record < handle
%     properties
%         timeStamp
%     end
%     properties(Dependent,Hidden)
%         date
%     end
%     methods
%         function obj = Record(timeStamp)
%             obj.timeStamp = timeStamp;
%         end
%         function set.date(obj,val)
%             obj.timeStamp = val;
%         end
%         function val = get.date(obj)
%             val = obj.timeStamp;
%         end
%     end
% end



% classdef Record < handle
%     properties
%         date
%     end
%     methods
%         function obj = Record(date)
%             obj.date = date;
%         end
%     end
% end
