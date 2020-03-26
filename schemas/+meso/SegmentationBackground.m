%{
-> meso.SegmentationChunks
---
background_spatial  :   longblob   # last column of cnmf spatial for cnmf, what about for other algorithms
background_temporal :   longblob   # last column of cnmf spatial for cnmf, what about for other algorithms
%}

classdef SegmentationBackground < dj.Part
end

% inserted by segmentation