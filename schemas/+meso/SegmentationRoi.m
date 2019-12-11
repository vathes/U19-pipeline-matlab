%{
-> meso.Segmentation
roi_idx    :       int
---
roi_spatial:       longblob 
roi_global_xy:     blob
%}


classdef SegmentationRoi < dj.Part
end