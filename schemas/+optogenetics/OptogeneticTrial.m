%{
# Information of a optogenetic trial
-> optogenetics.OptogeneticSession
-> behavior.TowersBlockTrial
---
laser_epoch			              : varchar(32)	 # Which epoch of the trial laser was on
laser_on			              : tinyint	     # 1 if laser was turned on 0 otherwise
t_laser_on			              : TINYBLOB	 # times when laser was turned on
t_laser_off			              : TINYBLOB	 # times when laser was turned off
%}

stim_epoch

-reward
-cue
-cue+reward


stim instead of laser

PhotostimTrial

add -> Photostim (waverform etc for a specific event of stimulation)

+ part table of OptogeneticTrial

e.g OptogeneticTrialEvent
    Event 



classdef OptogeneticTrial < dj.Manual
    methods(Access=protected)
        function makeTuples(self, key)
            
        end
    end
end
