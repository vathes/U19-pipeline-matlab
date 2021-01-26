%{
# Information of a optogenetic block
->optogenetics.OptogeneticSession
block                             : int
---
lsr_epoch			              : varchar(32)	    # Which epoch of the trial laser could be on
probability_laser			      : float	        # Probability to turn on laser during block 
%}

classdef OptogeneticBlock < dj.Imported
    methods(Access=protected)
        function makeTuples(self, key)
            
        end
    end
end
