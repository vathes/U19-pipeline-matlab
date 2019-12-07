%{
-> meso.FieldOfView
-> meso.SegmentationParameterSet
---
region_image_size:   blob     # 
%}

classdef Segmentation < dj.Imported
    
    methods(Access=protected)
        function makeTuples(self, key)
            
            result = key;
            result.region_image_size = magic_func(key);
            self.insert1(result)
            
            rois = func(key);
            
            meso.SegmentationRoi.insert(rois)
           
            
        end
    end
end

