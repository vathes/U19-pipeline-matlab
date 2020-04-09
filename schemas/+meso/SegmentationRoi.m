%{
# metainformation and pixel masks for each ROI
-> meso.Segmentation
roi_idx            :  int       # index of the roi
---
roi_spatial        :  blob@mesoimaging      # 2d matrix with image for spatial mask for the roi
roi_global_xy      :  blob                  # roi centroid in global image coordinates
roi_is_in_chunks   :  blob                  # array with the chunk ids the roi is present in
surround_spatial   :  blob@mesoimaging      # same as roi_spatial, for the surrounding neuropil ring
%}


classdef SegmentationRoi < dj.Part
  properties(SetAccess=protected)
    master = meso.Segmentation
  end
end

% inserted by segmentation