%{
-> meso.SegmentationRoi
---
morphology:  enum('Doughnut', 'Blob', 'Puncta', 'Filament', 'Other', 'Noise')
%}

classdef SegmentationRoiMorphologyAuto < dj.Part
end

% insert by Segmentation automatically