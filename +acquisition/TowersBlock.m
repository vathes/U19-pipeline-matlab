%{
-> acquisition.Session
block:              tinyint     # block number
---
-> task.TaskLevelParameterSet
n_trials:           int         # number of trials in this block
first_trial:        int         # trial_idx of the first trial in this block
block_duration:     float       # in secs, duration of the block
block_start_time:   datetime    # absolute start time of the block
reward_mil:         float       # in mL, reward volume in this block
reward_scale:       tinyint     # scale of the reward in this block
block_level:        tinyint     # task level of the block
easy_block:         bool        # true if the difficulty reduces during the session
%}

classdef TowersBlock < dj.Imported
    properties
        popRel = acquisition.Session
    end
    
    methods
        function makeTuples(self, key)
            
        end
    end
end