%{
-> Session
---
scan_directory      : varchar(255)
gdd=null            : float
wavelength=920      : float           # in nm
pmt_gain=null       : float
-> reference.BrainArea.proj(imaging_area='brain_area')
frame_time          : longblob
%}

classdef Scan < dj.Imported
end 
