%{
-> meso.SegmentationRoi
session_part: enum('first half', 'second half', 'full')
---
data_dff:   longblob     # delta f/f for each cell, 1 x nFrames from cnmf-dataDFF
data_bkg:   longblob     # background? of the trace
spiking:    longblob     # recovered firing rate of the trace
time_constants: blob     # 2 floats per roi, estimated calcium kernel time constants
is_significant: boolean
is_baseline:    boolean
%}


classdef Trace < dj.Imported
    
    % insert by the Segmentation as well.
    % we could rejudge the decision on the session part idea for the definition, let me know.
end