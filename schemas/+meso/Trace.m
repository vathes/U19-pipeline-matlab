%{
-> meso.SegmentationRoi
---
data_dff:   longblob     # delta f/f for each cell, 1 x nFrames from cnmf-dataDFF
data_bkg:   longblob     # background? of the trace
spiking:    longblob     # recovered firing rate of the trace
time_constants: blob     # 2 floats per roi, estimated calcium kernel time constants
is_significant: boolean
is_baseline:    boolean
%}


classdef Trace < dj.Imported

end

% inserted by segmentation