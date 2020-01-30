%{
% A mesoscope scanning session
-> acquisition.Session
---
scan_directory       : varchar(255)
gdd=null             : float
wavelength=920       : float                        # in nm
pmt_gain=null        : float
-> [nullable] reference.BrainArea.proj(imaging_area="brain_area")
%}


classdef Scan < dj.Imported
  % code to figure out directory where tifs live, see
  % acquisition.dataDirectory
end

% Question: how to ingest in this table?
% reconstruct the path pattern based on session data/user etc..