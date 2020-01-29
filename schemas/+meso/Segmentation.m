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
            self.insert(result)
            
            rois = func(key);
            
            insert(meso.SegmentationRoi, rois)
           
            
        end
    end
end

