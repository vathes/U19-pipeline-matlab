%{
-> Session
---
scan_directory:     varchar(255)
scan_filename:      varchar(64)
gdd=null:           float
wavelength=920:     float           # in nm
pmt_gain=null:      float
-> reference.BrainArea.proj(imaging_area='brain_area')
%}

classdef Scan < dj.Manual
end 
