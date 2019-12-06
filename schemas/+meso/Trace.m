%{
-> meso.SegmentationRoi
session_part: enum('first half', 'second half', 'full')
---
data_dff:   longblob     # delta f/f for each cell, 1 x nFrames from cnmf-dataDFF
data_bkg:   longblob     # background? of the trace
spiking:    longblob     # recovered firing rate of the trace
is_significant: boolean
is_baseline:    boolean
%}


classdef Trace < dj.Imported
end