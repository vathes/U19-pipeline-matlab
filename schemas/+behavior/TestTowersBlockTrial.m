%{
-> acquisition.SessionBlockTrial
---
%}

classdef TestTowersBlockTrial < dj.Part
    properties(SetAccess=protected)
        master = behavior.TestTowersBlock
    end
end