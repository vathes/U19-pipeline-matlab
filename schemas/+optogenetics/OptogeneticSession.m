%{
# Information of a optogenetic session
->acquisition.Session
---
laser_wavelength		           : DECIMAL(5,1)                    # (nm)
laser_power                        : DECIMAL(4,1)                    # (mW)
frequency			               : DECIMAL(6,2)                    # (Hz) 
pulse_width			               : DECIMAL(5,1)                    # (ms) 
%}

classdef OptogeneticSession < dj.Imported
    methods(Access=protected)
        function makeTuples(self, key)
            
        end
    end
end
