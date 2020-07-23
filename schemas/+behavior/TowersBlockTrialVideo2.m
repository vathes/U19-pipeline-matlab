%{
-> behavior.TowersBlockTrial
---
video_path:                 varchar(255)         # video directory + filename for each trial
video_file:                 blob@trialvideo  # 
%}

classdef TowersBlockTrialVideo2 < dj.Computed
   % properties(SetAccess=protected)
   %     master = behavior.TowersBlock
   % end
   methods(Access=protected)
        function makeTuples(self, key)
        end
   end
end