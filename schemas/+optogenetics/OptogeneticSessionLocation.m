%{
# Information of a optogenetic session
->optogenetics.OptogeneticSession
---
->reference.BrainLocation
hemisphere			               : enum('Left','Right','Bilateral')
%}

classdef OptogeneticSessionLocation < dj.Imported
    methods(Access=protected)
        function makeTuples(self, key)
            
        end
    end
end
