%{
-> meso.Segmentation
roi_idx    :       int
---
roi_spatial:       longblob     # from cnmf-
%}


classdef Roi < dj.Part
end