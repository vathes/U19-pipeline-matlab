%{
# Information of a optogenetic session
->acquisition.Session
---
-> optogenetics.OptogeneticProtocol
-> optogenetics.OptogeneticSoftwareParameter
%}

classdef OptogeneticSession < dj.Imported
    methods(Access=protected)
        function makeTuples(self, key)
            
        end
    end
end
