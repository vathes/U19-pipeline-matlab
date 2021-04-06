%{
# Defined optogenetic protocols for training
optogenetic_protocol_id           : INT AUTO_INCREMENT
---
protocol_description=''           : varchar(256)     # string that describes stimulation protocol
->optogenetics.OptogeneticStimulationParameter       # Stimulation parameters associated with this stim protocol
-> [nullable] optogenetics.OptogeneticWaveform       # Stimulation waveform associated with protocol (if any)
%}

classdef OptogeneticProtocol < dj.Manual    
end
