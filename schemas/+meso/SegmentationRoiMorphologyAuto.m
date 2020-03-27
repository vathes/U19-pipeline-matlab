%{
-> meso.SegmentationRoi
---
morphology:  enum('Doughnut', 'Blob', 'Puncta', 'Filament', 'Other', 'Noise') # shape classification
%}

classdef SegmentationRoiMorphologyAuto < dj.Part
end

% inserted by Segmentation 