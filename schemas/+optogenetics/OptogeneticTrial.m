%{
# Information of a optogenetic trial
->optogenetics.OptogeneticBlock
trial_idx                         : int
---
laser_epoch			              : varchar(32)	 # Which epoch of the trial laser was on
laser_on			              : boolean	     # 1 if laser was turned on 0 otherwise
t_laser_on			              : TINYBLOB	 # times when laser was turned on
t_laser_off			              : TINYBLOB	 # times when laser was turned off
%}

classdef OptogeneticTrial < dj.Imported
    methods(Access=protected)
        function makeTuples(self, key)
            
        end
    end
end
