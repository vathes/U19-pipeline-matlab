%{
# Information of a optogenetic session
->acquisition.SessionTest
---
->reference.BrainArea
hemisphere			               : enum('Left','Right','Bilateral')
laser_nm			               : int                             # Laser color in nm
laser_power                        : int                             # Laser power in (mW)
frequency			               : float
%}

classdef OptogeneticSession < dj.Imported
    methods(Access=protected)
        function makeTuples(self, key)
            
        end
    end
end
