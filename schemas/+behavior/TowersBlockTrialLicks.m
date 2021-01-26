%{
-> behavior.TowersBlockTrial
---
lick_l_time                : blob        # lick left  times in trial
lick_r_time                : blob        # lick right times in trial
%}

classdef TowersBlockTrialLicks < dj.Part
    properties(SetAccess=protected)
        master = behavior.TowersBlock
    end
end