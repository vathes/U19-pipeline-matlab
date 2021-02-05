%{
# Information of a optogenetic session
stim_parameters_set_id             : INT
---
laser_wavelength		           : DECIMAL(5,1)                    # (nm)
laser_power                        : DECIMAL(4,1)                    # (mW)
frequency			               : DECIMAL(6,2)                    # (Hz) 
pulse_width			               : DECIMAL(5,1)                    # (ms) 
%}

classdef OptogeneticStimulationParameters < dj.Lookup

end
